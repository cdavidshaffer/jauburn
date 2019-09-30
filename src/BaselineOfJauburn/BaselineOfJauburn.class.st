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
		spec package: 'Jauburn-Parser' with: [ spec requires: #('Jauburn-AST')].
		spec package: 'Jauburn-Interpreter' with: [ spec requires: #('Jauburn-Parser')].
		spec package: 'Jauburn-Parser-Tests' with: [ spec requires: #('Jauburn-Parser')].
		spec package: 'Jauburn-Interpreter-Tests' with: [ spec requires: #('Jauburn-Interpreter')].
		]
]

{ #category : #baselines }
BaselineOfJauburn >> petitParser: spec [

	spec 
		baseline: 'PetitParser'
		with: [ spec repository: 'github://moosetechnology/PetitParser/src' ]
]
