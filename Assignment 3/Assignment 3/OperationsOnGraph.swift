//
//  OperationsOnGraph.swift
//  Assignment 3
//
//  Created by Shubham on 01/02/22.
//

import Foundation

// this class conforms to the protocol.
class Operations: Queries{

    func nodeExists(id : Int)->(Bool){
        if parentToChild[id] == nil{
            return false
        }
        return true
    }
   
    
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
    
    if(!nodeExists(id: parentId)){
        print("Parent Node Does Not Exist")
        return
    }
    else if(!nodeExists(id: childId)){
        print("Child Id Does Not Exist")
        return
    }
    
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
    
    if(!nodeExists(id: node)){
        print("Node Does Not Exist")
        return
    }
    
    printNodeInfo(node: node)
    for elements in parentToChild[node] ?? []{
        printDescendants(node: elements)
    }
}

// Peform dfs and prints all the ancestors of the node
func printAncestors(node :Int){
    
    if(!nodeExists(id: node)){
        print("Node Does Not Exist")
        return
    }
    
    printNodeInfo(node: node)
    for elements in childToParent[node] ?? []{
        printAncestors(node: elements)
    }
}

// just prints the immediate children of the node by printing the adjacency list
func printImmediateChildren(node: Int){
    
    if(!nodeExists(id: node)){
        print("Node Does Not Exist")
        return
    }
    
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
    if(!nodeExists(id: node)){
        print("Node Does Not Exist")
        return
    }
    
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
    
    if(!nodeExists(id: parentId)){
        print("Parent Node Does Not Exist")
        return
    }
    else if(!nodeExists(id: childId)){
        print("Child Id Does Not Exist")
        return
    }
    
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
    if(!nodeExists(id: node)){
        print("Node Does Not Exist")
        return
    }
    
    // go to every parent and break the dependecy between every parent and this node
    for elements in childToParent[node] ?? []{
        parentToChild[elements]?.remove(node)
    }
    // break the route from this child to all the parents.
    childToParent[node] = []
    
}
    
}
