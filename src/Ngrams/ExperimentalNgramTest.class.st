Class {
	#name : #ExperimentalNgramTest,
	#superclass : #TestCase,
	#instVars : [
		'data',
		'ngrams',
		'model'
	],
	#category : #'Ngrams-Tests'
}

{ #category : #running }
ExperimentalNgramTest >> setUp [
	| text text2 |
	super setUp.
	data := BigramExperimental new bigrams.
	model := NgramModel order: 2.
	text := 'lorem ipsum lorem ipsum ipsum dolor lorem ipsum lorem lorem'.
	model trainOnSentence: text.
	text2 := 'lorem dolor ipsum lorem dolor'.
	model trainOnSentence: text2

]

{ #category : #tests }
ExperimentalNgramTest >> testMostLikelyContinuations [
	| expected actual word |
	word := 'lorem'.
	actual := model mostLikelyContinuations: word asNgram top: 3.
	expected := #('ipsum' 'dolor' 'lorem').
	self assert: actual equals: expected
]

{ #category : #tests }
ExperimentalNgramTest >> testProbabilityOfNgram [
	| expected actual |
	actual := model probabilityOfNgram: #(lorem ipsum) asNgram.
	expected := 3/7 asFloat.
	self assert: actual equals: expected
]

{ #category : #tests }
ExperimentalNgramTest >> testSelectionByPrefixInSecondWord [
	| assoc selection |
	assoc := data associations collect: [ :each | each key substrings -> each value ].
	selection := assoc select: [ :each | (each key first = 'super') and:
		(each key second beginsWith: 'ini')].
	self assert: selection size equals: 4
]
