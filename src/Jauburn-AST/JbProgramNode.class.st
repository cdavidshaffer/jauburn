Class {
	#name : #JbProgramNode,
	#superclass : #Object,
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
