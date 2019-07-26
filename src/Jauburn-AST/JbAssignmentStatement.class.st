Class {
	#name : #JbAssignmentStatement,
	#superclass : #Object,
	#instVars : [
		'identifier',
		'expression'
	],
	#category : #'Jauburn-AST'
}

{ #category : #accessing }
JbAssignmentStatement >> expression [
	^ expression
]

{ #category : #accessing }
JbAssignmentStatement >> expression: anObject [
	expression := anObject
]

{ #category : #accessing }
JbAssignmentStatement >> identifier [
	^ identifier
]

{ #category : #accessing }
JbAssignmentStatement >> identifier: anObject [
	identifier := anObject
]
