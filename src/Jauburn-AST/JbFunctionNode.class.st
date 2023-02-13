Class {
	#name : #JbFunctionNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'body',
		'parameters'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbFunctionNode >> body [
	^ body
]

{ #category : #accessing }
JbFunctionNode >> body: anObject [
	body := anObject
]

{ #category : #accessing }
JbFunctionNode >> parameters [
	^ parameters
]

{ #category : #accessing }
JbFunctionNode >> parameters: anObject [
	parameters := anObject
]
