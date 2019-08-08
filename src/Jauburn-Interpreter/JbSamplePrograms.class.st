Class {
	#name : #JbSamplePrograms,
	#superclass : #Object,
	#category : #'Jauburn-Interpreter-SamplePrograms'
}

{ #category : #'sample programs' }
JbSamplePrograms class >> noFunctions [

	^'
var x = 1;
var y = 10 * x - 1;
if (y == 9) { 
   x = 16;
}
'
]
