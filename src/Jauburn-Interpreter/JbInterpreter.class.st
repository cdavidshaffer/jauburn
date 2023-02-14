"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	super initialize.
	environment := JbEnvironment new
]

{ #category : #api }
JbInterpreter >> interpret: programString [

	| ast |
	ast := self parse: programString.
	self interpretAst: ast
]

{ #category : #api }
JbInterpreter >> interpretAst: ast [

	^ ast executeIn: environment
]

{ #category : #api }
JbInterpreter >> parse: programString [

	| parser |
	parser := JbParser new.
	^(parser parse: programString)
]

{ #category : #api }
JbInterpreter >> run: programString [

	"Just an alias for #interpret:"

	self interpret: programString
]
