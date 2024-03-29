Class {
	#name : #JbProgramNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'statements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbProgramNode >> statements [
	^ statements
]

{ #category : #accessing }
JbProgramNode >> statements: anObject [
	statements := anObject
]
