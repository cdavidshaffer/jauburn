"
I am a parser for the Jauburn language.

<program> ::=
   <statement>*

<statement> ::=
   <decl-statement>
   | <assignment-statement>
   | <if-statement>

<decl-statement> ::=
   var <identifier> = <expression> ;

<assignment-statement> ::=
   <identifier> = <expression> ;

<if-statement> ::=
   if '(' <expression> ')' <statement-block>

<statement-block> ::=
   '{' <statement>* '}'

/* Cannot be in <keyword> */
<identifier> ::=
   <letter> <letter-or-digit-or-underscore>*

<keyword> ::=
   if
   | var

<function-definition-expression> ::=
   function '(' <parameter-list> ')' <statement-block>

<parameter-list> ::=
   <identifier>
   | <identifier> , <parameter-list>

<function-call-expression> ::=
   <identifier> '(' <expression-list> ')'

<expression-list> ::=
   <expression>
   | <expression> , <expression-list>

<expression> ::=
   <function-definition-expression>
   | <function-call-expression>
   | <arithmetic-expression>
   | <comparison-expression>

/*
 * A very simple grammar for comparison expressions.
 */
<comparison-expression> ::=
   <arithmetic-expression> == <arithmetic-expression>
   | <arithmetic-expression> < <arithmetic-expression>
   | <arithmetic-expression> <= <arithmetic-expression>
   | <arithmetic-expression> > <arithmetic-expression>
   | <arithmetic-expression> >= <arithmetic-expression>
   | <arithmetic-expression> != <arithmetic-expression>

/* The dis-ambiguated expression grammar from slides with identifier
 * added as an option for factors and including division and subtraction.
 */
<arithmetic-expression> ::= 
   <arithmetic-expression> + <term> 
   | <arithmetic-expression> - <term>
   | <term>

<term> ::= 
   <term> * <factor>
   | <term> / <factor>
   | <factor>

<factor> ::=
   '(' <arithmetic-expression> ')'
   | <integer>
   | <identifier>


/* integer grammar from slides */
digit_not_zero> ::=
   1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
<digit> ::= 
   0 
   | <digit_not_zero>
<integer> ::=
   '-'? <digit_not_zero><digit>* 
   | 0

/* we can use #word asParser here */
<letter> ::=
   /  a character in set a-z or set 	A-Z   /

<letter-or-digit-or-underscore> ::=
   <digit>
   | <letter>
   | '_'

"
Class {
	#name : #JbParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'function',
		'identifier',
		'functionSequence',
		'expression',
		'statementSequence',
		'statement',
		'assignmentStatement',
		'numberExpression',
		'anonymousFunction',
		'variableDeclaration',
		'returnStatement',
		'ifStatement',
		'identifierExpression',
		'comparisonExpression',
		'arithmeticExpression'
	],
	#category : #'Jauburn-Parser-Core'
}

{ #category : #accessing }
JbParser class >> dependencies [

	^{JbNumberParser}
]

{ #category : #functions }
JbParser >> anonymousFunction [

	^('function' asParser trim 
	, $( asParser trim , $) asParser trim
	, ${ asParser trim 
	, statement star
	, $} asParser trim) ==> 
					[:t | JbFunctionNode new name: nil; body: t fifth; yourself]
]

{ #category : #expressions }
JbParser >> arithmeticExpression [
	| exp parens |
	exp := PPExpressionParser new.
	parens := ($( asParser trim , exp , $) asParser trim)
		==> [ :nodes | nodes second ].
	exp term: parens / numberExpression / identifierExpression.
	exp
		group: [ :g | g prefix: $- asParser trim do: [ :op :a | a negated ] ];
		group: [ :g | 
			g
				left: $* asParser trim
				do: [ :a :op :b | 
					JbArity2OperatorNode new
						operator: op;
						lhs: a;
						rhs: b;
						yourself ].
			g
				left: $/ asParser trim
				do: [ :a :op :b | 
					JbArity2OperatorNode new
						operator: op;
						lhs: a;
						rhs: b;
						yourself ] ];
		group: [ :g | 
			g
				left: $+ asParser trim
				do: [ :a :op :b | 
					JbArity2OperatorNode new
						operator: op;
						lhs: a;
						rhs: b;
						yourself ].
			g
				left: $- asParser trim
				do: [ :a :op :b | 
					JbArity2OperatorNode new
						operator: op;
						lhs: a;
						rhs: b;
						yourself ] ].
	^ exp
]

{ #category : #statements }
JbParser >> assignmentStatement [

	^(identifier trim , $= asParser trim , 
		expression)  ==> 
			[ :arr | JbAssignmentStatementNode new 
									identifier: arr first; 
									expression: arr third;
									yourself ]
]

{ #category : #expressions }
JbParser >> comparisonExpression [
	"placeholder!"
	
	^arithmeticExpression , '==' asParser , arithmeticExpression
	/ arithmeticExpression , '<' asParser , arithmeticExpression
	/ arithmeticExpression , '<=' asParser , arithmeticExpression
	/ arithmeticExpression , '>' asParser , arithmeticExpression
	/ arithmeticExpression , '>=' asParser , arithmeticExpression
	/ expression , '!=' asParser , expression
]

{ #category : #expressions }
JbParser >> expression [ 

	^arithmeticExpression

]

{ #category : #functions }
JbParser >> function [

	^('function' asParser trim 
	, identifier , $( asParser , $) asParser trim
	, ${ asParser trim 
	, statement star
	, $} asParser trim) ==> 
					[:t | JbFunctionNode new name: t second asSymbol; body: t sixth; yourself]
]

{ #category : #functions }
JbParser >> functionSequence [

	^function plus ==> [:t | t first ]
]

{ #category : #accessing }
JbParser >> identifier [ 

	^(#letter asParser , (#letter asParser / #digit asParser / 
			$_ asParser ) star) flatten trim
]

{ #category : #expressions }
JbParser >> identifierExpression [
	^ identifier
		==> [ :arr | 
			JbIdentifierExpressionNode new
				identifier: arr;
				yourself ]
]

{ #category : #statements }
JbParser >> ifStatement [

	^'if' asParser trim
	, $( asParser trim
	, expression
	, $) asParser trim 
	, ${ asParser trim 
	, statementSequence
	, $} asParser trim ==>
		[ :arr |
			JbIfNode new
				condition: arr third;
				trueStatements: arr sixth;
				yourself ]
]

{ #category : #expressions }
JbParser >> numberExpression [

	^(self dependencyAt: JbNumberParser) integer
		==> [ :n | JbConstantExpressionNode new value: n; yourself ]
]

{ #category : #statements }
JbParser >> returnStatement [

	^'return' asParser trim , expression ==> [ :arr |
			JbReturnStatementNode new
				expression: arr second;
				yourself ]
]

{ #category : #accessing }
JbParser >> start [ 

	^functionSequence / statementSequence
]

{ #category : #statements }
JbParser >> statement [

	^(assignmentStatement / variableDeclaration / returnStatement / ifStatement) trim
	, $; asParser 
		==> [ :arr | arr first ]
]

{ #category : #statements }
JbParser >> statementSequence [
	^ (statement trim , statementSequence trim star)
		==> [ :arr | arr flattened ]
]

{ #category : #statements }
JbParser >> variableDeclaration [

	^'var' asParser trim
	, identifier
	, $= asParser trim
	, expression ==> 
				[ :arr | JbVariableDeclarationNode new 
										identifier: arr second; 
										expression: arr fourth; 
										yourself ]
]
