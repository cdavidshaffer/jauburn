"
I am a primitive function.  I act just like JbFunction except that when I am called I evaluate a Smalltalk block rather than a Jauburn AST.
"
Class {
	#name : #JbPrimitive,
	#superclass : #Object,
	#instVars : [
		'block'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #accessing }
JbPrimitive >> block [
	^ block
]

{ #category : #accessing }
JbPrimitive >> block: anObject [
	block := anObject
]

{ #category : #api }
JbPrimitive >> call: arguments in: callEnvironment [
	"You need to implement this method!  arguments will contain the arguments to pass to this function and callEnvironment will contain the environment in place when this function was called."
	
	self shouldBeImplemented 
]
