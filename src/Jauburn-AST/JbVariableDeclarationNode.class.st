Class {
	#name : #JbVariableDeclarationNode,
	#superclass : #Object,
	#instVars : [
		'identifier',
		'expression'
	],
	#category : #'Jauburn-AST'
}

{ #category : #accessing }
JbVariableDeclarationNode >> expression [
	^ expression
]

{ #category : #accessing }
JbVariableDeclarationNode >> expression: anObject [
	expression := anObject
]

{ #category : #accessing }
JbVariableDeclarationNode >> identifier [
	^ identifier
]

{ #category : #accessing }
JbVariableDeclarationNode >> identifier: anObject [
	identifier := anObject
]
