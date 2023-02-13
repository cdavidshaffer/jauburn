Class {
	#name : #JbArity1OperatorNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'operator',
		'operand'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbArity1OperatorNode >> operand [
	^ operand
]

{ #category : #accessing }
JbArity1OperatorNode >> operand: anObject [
	operand := anObject
]

{ #category : #accessing }
JbArity1OperatorNode >> operator [
	^ operator
]

{ #category : #accessing }
JbArity1OperatorNode >> operator: anObject [
	operator := anObject
]
