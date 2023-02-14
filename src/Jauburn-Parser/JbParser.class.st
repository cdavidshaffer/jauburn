"
I am a parser for the Jauburn language.

EBNF


<program> ::=
   <statement>*

<statement> ::=
   <variable-declaration-statement>
   | <assignment-statement>
   | <if-else-statement>
   | <if-statement>

<variable-declaration-statement> ::=
   var <identifier> = <expression> ;

<assignment-statement> ::=
   <identifier> = <expression> ;

<if-statement> ::=
   if '(' <expression> ')' <statement-block>

<if-else-statement> ::=
   if '(' <expression> ')' <statement-block> else <statement-block>

/* Cannot be in <keyword> */
<identifier> ::=
   <letter> <letter-or-digit-or-underscore>*

<keyword> ::=
   if
   | var
   | function

<expression> ::=
   <function-definition-expression>
   | <function-call-expression>
   | <arithmetic-expression>
   | <comparison-expression>

<function-definition-expression> ::=
   function '(' <identifier-list> ')' <statement-block>

<statement-block> ::=
   '{' <statement>* '}'

<identifier-list> ::=
   <identifier>
   | <identifier> , <identifier-list>
   | epsilon    /* the empty expression */

<function-call-expression> ::=
   <identifier> '(' <expression-list> ')'

<expression-list> ::=
   <expression>
   | <expression> , <expression-list>
   | epsilon


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

/*
 * Expression grammar.  Note: this grammar isn't used directly by this paser.
 * Instead we are using a PPExpressionParser which takes care of precedence etc.
 * However, this grammar is correct for BNF purposes.
 */

<arithmetic-expression> ::=
   <arithmetic-expression> '+' <term>
   | <arithmetic-expression> '-' <term>
   | <term>

<term> ::=
   <term> '*' <factor>
   | <term> '/' <factor>
   | <factor>

<factor> ::=
   '(' <arithmetic-expression> ')'
   | <number>
   | <idenfitier>


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
		'identifier',
		'expression',
		'assignmentStatement',
		'anonymousFunctionExpression',
		'returnStatement',
		'identifierExpression',
		'comparisonExpression',
		'arithmeticExpression',
		'expressionList',
		'functionCallExpression',
		'identifierExpressionList',
		'statementBlock',
		'statement',
		'variableDeclarationStatement',
		'program',
		'stringExpression',
		'stringComparisonExpression',
		'booleanExpression',
		'functionCallStatement'
	],
	#category : #'Jauburn-Parser-Core'
}

{ #category : #accessing }
JbParser class >> dependencies [

	^ { 
	
		  JbArithmeticExpressionParser }
]

{ #category : #expressions }
JbParser >> anonymousFunctionExpression [

	^ ('function' asParser , $( asParser trim , identifierExpressionList
		, $) asParser trim , statementBlock)
		==> [ :t | 
			JbFunctionDefinitionNode new
				parameters: t third;
				body: t fifth;
				yourself ]
]

{ #category : #expressions }
JbParser >> arithmeticExpression [

	^(self dependencyAt: JbArithmeticExpressionParser) arithmeticExpression
]

{ #category : #statements }
JbParser >> assignmentStatement [

	^ (identifier trim , $= asParser trim , expression , $; asParser)
		==> [ :arr | 
			JbAssignmentStatementNode new
				identifier: arr first;
				expression: arr third;
				yourself ]
]

{ #category : #expressions }
JbParser >> booleanExpression [

	^'true' asParser / 'false' asParser ==> [ :str | JbConstantExpressionNode new value: str = 'true'; yourself ]
]

{ #category : #expressions }
JbParser >> comparisonExpression [

	^ arithmeticExpression , '==' asParser trim , arithmeticExpression
	  / (arithmeticExpression , '<' asParser trim , arithmeticExpression)
	  /
	  (arithmeticExpression , '<=' asParser trim , arithmeticExpression)
	  / (arithmeticExpression , '>' asParser trim , arithmeticExpression)
	  /
	  (arithmeticExpression , '>=' asParser trim , arithmeticExpression)
	  /
	  (arithmeticExpression , '!=' asParser trim , arithmeticExpression)
	  ==> [ :arr | 
		  JbNumericComparisonNode new
			  lhs: arr first;
			  operator: arr second;
			  rhs: arr third;
			  yourself ]
]

{ #category : #expressions }
JbParser >> expression [ 

	^anonymousFunctionExpression 
	/ comparisonExpression
	/ stringComparisonExpression
	/ stringExpression
	/ booleanExpression
	/ functionCallExpression 
	/ arithmeticExpression 

]

{ #category : #expressions }
JbParser >> expressionList [

	^ (expression , $, asParser not)
		/ (expression , $, asParser trim , expressionList) / nil asParser
		==> [ :arr | 
			| result |
			result := OrderedCollection new.
			arr
				ifNotNil: [ result add: arr first.
					arr size = 3
						ifTrue: [ result addAll: arr third ] ].
			result ]
]

{ #category : #expressions }
JbParser >> functionCallExpression [

	^ (identifier , $( asParser trim , expressionList , $) asParser trim)
		==> [ :arr | 
			JbFunctionCallNode new
				identifier: arr first;
				arguments: arr third;
				yourself ]
]

{ #category : #statements }
JbParser >> functionCallStatement [

	^ (identifier , $( asParser trim , expressionList , $) asParser trim) , $; asParser trim
		==> [ :arr | 
			JbFunctionCallNode new
				identifier: arr first;
				arguments: arr third;
				yourself ]
]

{ #category : #expressions }
JbParser >> identifier [

	^ (self dependencyAt: JbArithmeticExpressionParser)
		  identifier
]

{ #category : #expressions }
JbParser >> identifierExpression [

	^  (self dependencyAt: JbArithmeticExpressionParser)
		  identifierExpression
]

{ #category : #expressions }
JbParser >> identifierExpressionList [

	^ (identifierExpression , $, asParser not)
		/ (identifierExpression , $, asParser trim , identifierExpressionList)
		/ nil asParser
		==> [ :arrOrNil | 
			arrOrNil
				ifNil: [ #() ]
				ifNotNil: [ | result |
					result := OrderedCollection new.
					result add: arrOrNil first.
					arrOrNil size = 3
						ifTrue: [ result addAll: arrOrNil third ].
					result ] ]
]

{ #category : #'low-level' }
JbParser >> keyword [ 

	^'if' asParser
	/ 'else' asParser
	/ 'function' asParser
]

{ #category : #statements }
JbParser >> program [

	^ statement trim star
		==> [ :stmts | 
			JbProgramNode new
				statements: stmts;
				yourself ]
]

{ #category : #statements }
JbParser >> returnStatement [

	^'return' asParser trim , expression, $; asParser trim ==> [ :arr |
			JbReturnStatementNode new
				expression: arr second;
				yourself ]
]

{ #category : #accessing }
JbParser >> start [ 

	^program
]

{ #category : #statements }
JbParser >> statement [

	^ variableDeclarationStatement / assignmentStatement
	   / returnStatement
	  / functionCallStatement
]

{ #category : #statements }
JbParser >> statementBlock [ 

	^${ asParser trim,
	statement trim star 
	, $} asParser trim
	  ==> [ :arr | arr second ]
]

{ #category : #expressions }
JbParser >> stringComparisonExpression [

	^ stringExpression , '==' asParser trim , stringExpression
	  / (stringExpression , '!=' asParser trim , stringExpression)
	  ==> [ :arr | 
		  JbNumericComparisonNode new
			  lhs: arr first;
			  operator: arr second;
			  rhs: arr third;
			  yourself ]
]

{ #category : #expressions }
JbParser >> stringExpression [

	^ ($" asParser , $" asParser negate star , $" asParser) flatten trim 
		==> [ :str | 
			JbConstantExpressionNode new
				value: str allButFirst allButLast;
				yourself ]
]

{ #category : #statements }
JbParser >> variableDeclarationStatement [

	^ 'var' asParser , #space asParser , identifier , $= asParser trim
	  , expression , $; asParser trim ==> [ :arr | 
	  JbVariableDeclarationStatementNode new
		  identifier: arr third;
		  expression: arr fifth;
		  yourself ]
]
