"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestJauburnParser,
	#superclass : #PackageManifest,
	#category : #'Jauburn-Parser-Manifest'
}

{ #category : #'code-critics' }
ManifestJauburnParser class >> ruleGRIvarNeitherReadNorWrittenRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#JbParser)) #'2019-07-26T13:18:08.679171-04:00') )
]

{ #category : #'code-critics' }
ManifestJauburnParser class >> ruleRBStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#JbParser)) #'2019-07-26T14:49:32.296069-04:00') )
]
