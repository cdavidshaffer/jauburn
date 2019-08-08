"
I handle the parsing of numbers is Jauburn.  I'm basically the CPIntegerParser introduced in the class videos.
"
Class {
	#name : #JbNumberParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'digitNotZero',
		'digit',
		'integer'
	],
	#category : #'Jauburn-Parser-Core'
}

{ #category : #'factory-chars' }
JbNumberParser >> digit [

	^$0 asParser / digitNotZero
]

{ #category : #'factory-chars' }
JbNumberParser >> digitNotZero [

	^$1 asParser / $2 asParser / $3 asParser 
								/ $4 asParser / $5 asParser / $6 asParser
								/ $7 asParser / $8 asParser / $9 asParser
]

{ #category : #'factory-chars' }
JbNumberParser >> integer [

	^($- asParser optional , digitNotZero , digit star / $0 asParser) flatten 
			==> [ :str | str asNumber ]
]

{ #category : #'factory-chars' }
JbNumberParser >> start [
	"Answer the production to start this parser with."

	^integer
]
