Class {
	#name : #BaselineOfJauburn,
	#superclass : #BaselineOf,
	#category : #BaselineOfJauburn
}

{ #category : #baselines }
BaselineOfJauburn >> baseline: spec [
	<baseline>
	
	spec for: #common do: [
		self petitParser: spec.
		spec package: 'Jauburn-AST'.
		spec package: 'Jauburn-Parser'.
		spec package: 'Jauburn-Interpreter'.
		spec package: 'Jauburn-AST-Tests'.
		spec package: 'Jauburn-Parser-Tests'.
		spec package: 'Jauburn-Interpreter-Tests'.
		]
]

{ #category : #baselines }
BaselineOfJauburn >> petitParser: spec [

	spec 
		baseline: 'PetitParser'
		with: [ spec repository: 'github://moosetechnology/PetitParser/src' ]
]
