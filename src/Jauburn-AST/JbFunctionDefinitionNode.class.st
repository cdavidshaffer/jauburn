Class {
	#name : #JbFunctionDefinitionNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'body',
		'parameters'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbFunctionDefinitionNode >> body [
	^ body
]

{ #category : #accessing }
JbFunctionDefinitionNode >> body: anObject [
	body := anObject
]

{ #category : #accessing }
JbFunctionDefinitionNode >> parameters [
	^ parameters
]

{ #category : #accessing }
JbFunctionDefinitionNode >> parameters: anObject [
	parameters := anObject
]
