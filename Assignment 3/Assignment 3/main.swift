
//  main.swift
//  Assignment 3
//  Created by Shubham on 28/01/22.

import Foundation

var counter = 0

// a node class that contains all the information about the nodes of the graph.

class Node {
    let id:Int
    let nodeName:String
    let addInfo:String
    init(id : Int , nodeName: String, addInfo:String){
        self.id = id
        self.nodeName = nodeName
        self.addInfo = addInfo
    }
}

// creating a dictionary for parent to child dependency
// creating a dictionary for child to parent dependency

var parentToChild = [Int : Set<Int>]() // [ node -> (list of all it's children)]
var childToParent = [Int : Set<Int>]() // [ node -> (list of all it's parent)]

// creating a dictionary that stores all the data about node, liked with their node id.
var idtoNode = [Int : Node]()    //[Node -> Oject of Node class]


// adds a node with no dependency
func addNode(id : Int){
    var nodeName:String?
    var addInfo:String?
    print("Enter the name of the node")
    if let tempName = readLine(){
        nodeName = tempName
    }
    print("Enter the additional information about the node")
    if let tempInfo = readLine(){
        addInfo = tempInfo
    }
    if let tempName = nodeName , let tempInfo = addInfo{
        let node = Node(id: id, nodeName: tempName, addInfo: tempInfo)
        idtoNode[id] = node
    }
    childToParent[id] = [] // allocating a space for this node into the adjacency list
    parentToChild[id] = [] //   "
    
}

// prints the information of a node using the id of that node
func printNodeInfo(node : Int){
    if let currentNode = idtoNode[node]{
        print("Node ID              \(node)")
        print("Node name            \(currentNode.nodeName)")
        print("Additional info)     \(currentNode.addInfo)")
    }
}

// this checks whether a cycle is present into the tree by using dfs
var visited = [Int:Int]()
func checkCycle(id:Int)-> (Bool){
    if(visited[id] != nil){
        return true
    }
    var flag:Bool = false
    visited[id] = 1
    for elements in parentToChild[id] ?? []{
        flag = flag || checkCycle(id: elements)
    }
    return flag
}

// adds a dependency , after checking whether additition of that edge creates any cycle
func addDependency(parentId : Int , childId : Int){
    parentToChild[parentId]?.insert(childId)
    if(checkCycle(id: parentId)==true){
        print("This dependecy can not be added because it creates a cycle")
        // if cycle is formed, we remove that dependency
        parentToChild[parentId]?.remove(childId)
    }
    visited.removeAll() //  clearing the visited array
    
}

// Peforms dfs and prints all the descendants of the node
func printDescendants(node: Int){
    printNodeInfo(node: node)
    for elements in parentToChild[node] ?? []{
        printDescendants(node: elements)
    }
}

// Peform dfs and prints all the ancestors of the node
func printAncestors(node :Int){
    printNodeInfo(node: node)
    for elements in childToParent[node] ?? []{
        printAncestors(node: elements)
    }
}

// just prints the immediate children of the node by printing the adjacency list
func printImmediateChildren(node: Int){
    print("Node Id of immediate children")
    if(parentToChild[node]?.isEmpty==true){
        print("No children present")
    }
    else{
        for elements in parentToChild[node] ?? []{
            printNodeInfo(node: elements)
        }
    }
}

// just prints the immediate parent of the node by printing the adjacency list
func printImmediateParents(node : Int){
    print("Node Id of immediate Parents")
    if(childToParent[node]?.isEmpty==true){
        print("No parent present")
    }
    for elements in childToParent[node] ?? []{
        printNodeInfo(node: elements)
    }
}

// deletes dependencies
func deleteDepedencies(parentId : Int, childId : Int){
    if(parentToChild[parentId]?.contains(childId)==false){
        print("Dependency not present")
    }
    else{
        parentToChild[parentId]?.remove(childId)
        childToParent[childId]?.remove(parentId)
    }
}

// deletes the node
func deleteNode(node : Int){
    
    // go to every parent and break the dependecy between every parent and this node
    for elements in childToParent[node] ?? []{
        parentToChild[elements]?.remove(node)
    }
    // break the route from this child to all the parents.
    childToParent[node] = []
    
}

func driver(){
    var flag = 1
    while(flag==1){
        print("Enter your choices")
        print("1.Add a new node to the tree.")
        print("2.Add a new dependency to a tree, passing parent node id and child node id. ")
        print("3.Get the immediate parents of a node, passing the node id as input parameter.")
        print("4.Get the immediate children of a node, passing the node id as input parameter.")
        print("5.Get the ancestors of a node, passing the node id as input parameter.")
        print("6.Get the descendants of a node, passing the node id as input parameter.")
        print("7.Delete dependency from a tree, passing parent node id and child node id.")
        print("8.Delete a node from a tree, passing node id as input parameter.")
        print("9.Exit")
        if let choice = readLine(){
            switch(choice){
            case "1":
                addNode(id: counter)
                print("Node has been added with unique id \(counter)")
                counter+=1
            case "2":
                print("Enter the node id of the parent")
                let parentNodeId = readLine()
                print("Enter the node id of the children")
                let childNodeId = readLine()
                if let parentNodeId = parentNodeId , let childNodeId = childNodeId{
                    if let tempParent = Int(parentNodeId), let tempChild = Int(childNodeId){
                        addDependency(parentId: tempParent, childId: tempChild)
                    }
                }
            case "3":
                print("Enter the Id of the Node")
                if let temp = readLine(){
                    if let id = Int(temp){
                        printImmediateParents(node: id)
                    }
                }
            case "4":
                print("Enter the Id of the Node")
                if let temp = readLine(){
                    if let id = Int(temp){
                        printImmediateChildren(node: id)
                    }
                }
            case "5":
                print("Enter the Id of the node")
                if let temp = readLine(){
                    if let id = Int(temp){
                        printAncestors(node: id)
                    }
                }
            case "6":
                print("Enter the Id of the node")
                if let temp = readLine(){
                    if let id = Int(temp){
                        printDescendants(node: id)
                    }
                }
            case "7":
                print("Enter the node id of the parent")
                let parentNodeId = readLine()
                print("Enter the node id of the children")
                let childNodeId = readLine()
                if let parentNodeId = parentNodeId , let childNodeId = childNodeId{
                    if let tempParent = Int(parentNodeId), let tempChild = Int(childNodeId){
                        deleteDepedencies(parentId: tempParent, childId: tempChild)
                    }
                }
            case "8":
                print("Enter the Id of the node")
                if let temp = readLine(){
                    if let id = Int(temp){
                        deleteNode(node: id)
                    }
                }
            case "9":
                print("BYE")
                flag = 0
            default :
                print("Wrong choices entered")
                
                
            }
        }
    }
}

driver()
