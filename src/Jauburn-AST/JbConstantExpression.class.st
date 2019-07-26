Class {
	#name : #JbConstantExpression,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'Jauburn-AST'
}

{ #category : #accessing }
JbConstantExpression >> value [
	^ value
]

{ #category : #accessing }
JbConstantExpression >> value: anObject [
	value := anObject
]
