Class {
	#name : #JbFunctionNode,
	#superclass : #Object,
	#instVars : [
		'name',
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
JbFunctionNode >> name [
	^ name
]

{ #category : #accessing }
JbFunctionNode >> name: anObject [
	name := anObject
]

{ #category : #accessing }
JbFunctionNode >> parameters [
	^ parameters
]

{ #category : #accessing }
JbFunctionNode >> parameters: anObject [
	parameters := anObject
]
