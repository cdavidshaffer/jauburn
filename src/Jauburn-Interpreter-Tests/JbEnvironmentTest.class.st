"
This is a copy of the unit tests for the Phsyche PEnvironment class.
"
Class {
	#name : #JbEnvironmentTest,
	#superclass : #TestCase,
	#instVars : [
		'outer',
		'inner'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #tests }
JbEnvironmentTest >> setUp [
	outer := JbEnvironment new.
	inner := JbEnvironment new.
	inner outerEnvironment: outer
]

{ #category : #tests }
JbEnvironmentTest >> testLookingOuterFromInner [
	outer at: #dad put: 'donald'.
	inner at: #son put: 'riri'.
	self assert: (inner at: #dad) equals: 'donald'
]

{ #category : #tests }
JbEnvironmentTest >> testLookupAtRightLevel [
	outer at: #dad put: 'donald'.
	self assert: (outer at: #dad) equals: 'donald'.
	inner at: #son put: 'riri'.
	self assert: (inner at: #son) equals: 'riri'
]

{ #category : #tests }
JbEnvironmentTest >> testLookupInFails [
	outer at: #dad put: 'donald'.
	inner at: #son put: 'riri'.
	self should: [ outer at: #nodad ] raise: KeyNotFound.
	self should: [ outer at: #noson ] raise: KeyNotFound.
	self should: [ inner at: #nodad ] raise: KeyNotFound
]

{ #category : #tests }
JbEnvironmentTest >> testSetAtRightLevel [
	
	outer at: #dad put: 'donald'.
	inner at: #son put: 'riri'.
	self assert: (inner at: #son) = 'riri'.
	inner lookupAt: #son put: 'fifi'.
	
	self assert: (outer at: #dad) = 'donald'.
	outer lookupAt: #dad put: 'piscou'.
	self assert: (outer at: #dad) = 'piscou'.
]

{ #category : #tests }
JbEnvironmentTest >> testSetLookup [
	outer at: #dad put: 'donald'.
	inner at: #son put: 'riri'.
	self assert: (inner at: #dad) = 'donald'.
	inner lookupAt: #dad put: 'picsou'.
	self assert: (outer at: #dad) = 'picsou'.
	self assert: (inner at: #dad) = 'picsou'.
	self deny: (inner keys includes: #dad)
]
