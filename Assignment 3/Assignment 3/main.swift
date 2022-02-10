
//  main.swift
//  Assignment 3
//  Created by Shubham on 28/01/22.

import Foundation

var counter = 0

// a node class that contains all the information about the nodes of the graph.



// creating a dictionary for parent to child dependency
// creating a dictionary for child to parent dependency

var parentToChild = [Int : Set<Int>]() // [ node -> (list of all it's children)]
var childToParent = [Int : Set<Int>]() // [ node -> (list of all it's parent)]


// creating a dictionary that stores all the data about node, liked with their node id.
var idtoNode = [Int : Node]()    //[Node id -> Oject of Node class]


protocol Queries{
    func addNode(id:Int)
    func printNodeInfo(node:Int)
    func addDependency(parentId: Int, childId:Int)
    func printDescendants(node:Int)
    func printAncestors(node:Int)
    func printImmediateChildren(node:Int)
    func printImmediateParents(node:Int)
    func deleteDepedencies(parentId:Int,childId:Int)
    func deleteNode(node:Int)
}
// adds a node with no dependency

// using singleton class

class GraphManager{
    static let graph = Operations()
    private init(){
        
    }
}

//let graph = Operations()

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
                GraphManager.graph.addNode(id: counter)
                print("Node has been added with unique id \(counter)")
                counter+=1
            case "2":
                print("Enter the node id of the parent")
                let parentNodeId = readLine()
                print("Enter the node id of the children")
                let childNodeId = readLine()
                if let parentNodeId = parentNodeId , let childNodeId = childNodeId{
                    if let tempParent = Int(parentNodeId), let tempChild = Int(childNodeId){
                        GraphManager.graph.addDependency(parentId: tempParent, childId: tempChild)
                    }
                }
            case "3":
                print("Enter the Id of the Node")
                if let temp = readLine(){
                    if let id = Int(temp){
                        GraphManager.graph.printImmediateParents(node: id)
                    }
                }
            case "4":
                print("Enter the Id of the Node")
                if let temp = readLine(){
                    if let id = Int(temp){
                        GraphManager.graph.printImmediateChildren(node: id)
                    }
                }
            case "5":
                print("Enter the Id of the node")
                if let temp = readLine(){
                    if let id = Int(temp){
                        GraphManager.graph.printAncestors(node: id)
                    }
                }
            case "6":
                print("Enter the Id of the node")
                if let temp = readLine(){
                    if let id = Int(temp){
                        GraphManager.graph.printDescendants(node: id)
                    }
                }
            case "7":
                print("Enter the node id of the parent")
                let parentNodeId = readLine()
                print("Enter the node id of the children")
                let childNodeId = readLine()
                if let parentNodeId = parentNodeId , let childNodeId = childNodeId{
                    if let tempParent = Int(parentNodeId), let tempChild = Int(childNodeId){
                        GraphManager.graph.deleteDepedencies(parentId: tempParent, childId: tempChild)
                    }
                }
            case "8":
                print("Enter the Id of the node")
                if let temp = readLine(){
                    if let id = Int(temp){
                        GraphManager.graph.deleteNode(node: id)
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
