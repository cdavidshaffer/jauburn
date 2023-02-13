Class {
	#name : #JbConstantExpressionNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'value'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbConstantExpressionNode >> value [
	^ value
]

{ #category : #accessing }
JbConstantExpressionNode >> value: anObject [
	value := anObject
]
