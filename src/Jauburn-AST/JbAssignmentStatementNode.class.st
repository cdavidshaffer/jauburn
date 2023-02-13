Class {
	#name : #JbAssignmentStatementNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'identifier',
		'expression'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbAssignmentStatementNode >> expression [
	^ expression
]

{ #category : #accessing }
JbAssignmentStatementNode >> expression: anObject [
	expression := anObject
]

{ #category : #accessing }
JbAssignmentStatementNode >> identifier [
	^ identifier
]

{ #category : #accessing }
JbAssignmentStatementNode >> identifier: anObject [
	identifier := anObject
]
