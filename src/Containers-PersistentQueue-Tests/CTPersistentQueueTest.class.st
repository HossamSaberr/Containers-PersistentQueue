Class {
	#name : 'CTPersistentQueueTest',
	#superclass : 'TestCase',
	#instVars : [
		'emptyQueue'
	],
	#category : 'Containers-PersistentQueue-Tests',
	#package : 'Containers-PersistentQueue-Tests'
}

{ #category : 'running' }
CTPersistentQueueTest >> setUp [
    super setUp.
    emptyQueue := CTPersistentQueue empty.
]

{ #category : 'tests' }
CTPersistentQueueTest >> testBoundaryConditionsAndPeek [
    | q1 |
    "1. Dequeuing an empty queue should fail safely"
    self should: [ emptyQueue dequeue ] raise: Error description: 'Empty queue must raise an Error on dequeue'.
    
    "2. Peek should return the value without altering the queue"
    q1 := emptyQueue enqueue: 'Target'.
    self assert: q1 peek equals: 'Target'.
    
    "3. Ensure peek didn't drain the queue"
    self deny: q1 isEmpty.
    self assert: q1 dequeue key equals: 'Target'.
]

{ #category : 'tests' }
CTPersistentQueueTest >> testDequeueTriggersAmortizedReversal [
    | q1 q2 q3 result1 result2 newQueue |
    
    q1 := emptyQueue enqueue: 'A'.
    q2 := q1 enqueue: 'B'.
    q3 := q2 enqueue: 'C'.
    
    "Right now, frontStack is empty, rearStack has (C -> B -> A)"
    result1 := q3 dequeue.
    self assert: result1 key equals: 'A'.
    
    newQueue := result1 value.
    result2 := newQueue dequeue.
    self assert: result2 key equals: 'B'.
    
    "CRITICAL: The original q3 must remain completely intact despite the reversal!"
    self assert: q3 dequeue key equals: 'A'.
]

{ #category : 'tests' }
CTPersistentQueueTest >> testDoIteratesInFifoOrder [
    | q elements |
    q := emptyQueue enqueue: 'First'.
    q := q enqueue: 'Second'.
    q := q enqueue: 'Third'.

    elements := OrderedCollection new.
    q do: [ :each | elements add: each ].

    self assert: elements asArray equals: #('First' 'Second' 'Third').
]

{ #category : 'tests' }
CTPersistentQueueTest >> testEmptyQueueHasNoElements [
    self assert: emptyQueue isEmpty.
]

{ #category : 'tests' }
CTPersistentQueueTest >> testEmptyQueuesAreEqual [
    | anotherEmpty |
    anotherEmpty := CTPersistentQueue empty.
    
    self assert: emptyQueue equals: anotherEmpty.
    self assert: emptyQueue hash equals: anotherEmpty hash.
    self assert: emptyQueue asArray isEmpty.
]

{ #category : 'tests' }
CTPersistentQueueTest >> testEnqueuePreservesImmutability [
    | q2 |
    q2 := emptyQueue enqueue: 'A'.
    
    self assert: emptyQueue isEmpty description: 'The original queue must remain completely empty'.
    self deny: q2 isEmpty description: 'The new queue state should contain the enqueued element'.
]

{ #category : 'tests' }
CTPersistentQueueTest >> testEquality [
    | q1 q2 q3 |
    q1 := emptyQueue enqueue: 'A'.
    q1 := q1 enqueue: 'B'.
    
    q2 := emptyQueue enqueue: 'A'.
    q2 := q2 enqueue: 'B'.
    
    q3 := emptyQueue enqueue: 'A'.
    q3 := q3 enqueue: 'C'.
    
    self assert: q1 equals: q2.
    self deny: q1 = q3.
]

{ #category : 'tests' }
CTPersistentQueueTest >> testHash [
    | q1 q2 q3 |
    q1 := emptyQueue enqueue: 'A'.
    q1 := q1 enqueue: 'B'.
    
    q2 := emptyQueue enqueue: 'A'.
    q2 := q2 enqueue: 'B'.
    
    q3 := emptyQueue enqueue: 'A'.
    q3 := q3 enqueue: 'C'.
    
    self assert: q1 hash equals: q2 hash.
    self deny: q1 = q3.
]

{ #category : 'tests' }
CTPersistentQueueTest >> testInterleavedOperations [
    | q1 q2 q3 q4 q5 result |
    q1 := emptyQueue enqueue: 'A'.
    q2 := q1 enqueue: 'B'.
    
    "Pop 'A'. The queue (q3) now functionally contains only 'B'."
    result := q2 dequeue.
    self assert: result key equals: 'A'.
    q3 := result value.
    
    "Push 'C' onto the queue. FrontStack has 'B', RearStack has 'C'."
    q4 := q3 enqueue: 'C'.
    self assert: q4 peek equals: 'B'.
    
    "Pop 'B'. This should force a structural merge."
    result := q4 dequeue.
    self assert: result key equals: 'B'.
    q5 := result value.
    
    self assert: q5 asArray equals: #('C').
]

{ #category : 'tests' }
CTPersistentQueueTest >> testMultipleDequeuesFromSameHistoricalState [
    | base result1 result2 |
    base := emptyQueue enqueue: 'A'.
    base := base enqueue: 'B'.
    base := base enqueue: 'C'.
    
    "Branch 1 pops A"
    result1 := base dequeue.
    
    "Branch 2 also pops A from the exact same historical base"
    result2 := base dequeue.
    
    self assert: result1 key equals: 'A'.
    self assert: result2 key equals: 'A'.
    
    self assert: result1 value asArray equals: #('B' 'C').
    self assert: result2 value asArray equals: #('B' 'C').
    
    "They should be structurally identical, but technically different queue instances"
    self deny: result1 value identicalTo: result2 value.
]

{ #category : 'tests' }
CTPersistentQueueTest >> testPersistenceBranching [
    | base branchA branchB |
    base := emptyQueue enqueue: 'Root'.
    
    "Thread 1 pushes A, Thread 2 pushes B from the exact same point in time"
    branchA := base enqueue: 'A'.
    branchB := base enqueue: 'B'.
    
    self assert: branchA asArray equals: #('Root' 'A').
    self assert: branchB asArray equals: #('Root' 'B').
    self assert: base asArray equals: #('Root').
]

{ #category : 'tests' }
CTPersistentQueueTest >> testPop [
    | q1 q2 q3 |
    q1 := emptyQueue enqueue: 'A'.
    q2 := q1 enqueue: 'B'.
    
    "Pop should return the new queue state directly, not an Association"
    q3 := q2 pop.
    
    self assert: q3 class equals: CTPersistentQueue.
    self assert: q3 size equals: 1.
    self assert: q3 peek equals: 'B'.
    
    "Ensure we safely error if trying to pop an empty queue"
    self should: [ emptyQueue pop ] raise: Error description: 'Cannot pop from an empty queue'.
]

{ #category : 'tests' }
CTPersistentQueueTest >> testPrintOn [
    | q string |
    q := emptyQueue enqueue: 1.
    q := q enqueue: 2.
    
    string := String streamContents: [ :str |
        q printOn: str ].
    
    self assert: (string includesSubstring: '1').
    self assert: (string includesSubstring: '2').
]

{ #category : 'tests' }
CTPersistentQueueTest >> testStructuralSharingIdentity [
    | q1 q2 front1 front2 |
    q1 := emptyQueue enqueue: 'A'.
    q2 := q1 enqueue: 'B'.
    
    front1 := q1 instVarNamed: 'frontStack'.
    front2 := q2 instVarNamed: 'frontStack'.
    
    "Because enqueueing only modifies the rear, both versions MUST share the exact same front stack in memory."
    self assert: front1 identicalTo: front2.
]

{ #category : 'tests' }
CTPersistentQueueTest >> testTimeTravelUndoStack [
    | history current |
    history := OrderedCollection new.
    current := emptyQueue.
    
    "Generate 10 historical states"
    1 to: 10 do: [ :i |
        current := current enqueue: i.
        history add: current ].
        
    "Verify the extremes"
    self assert: (history at: 5) size equals: 5.
    self assert: (history at: 5) peek equals: 1.
    self assert: history last size equals: 10.
    
    "Time travel back to state 5 and branch off into a new reality"
    current := history at: 5.
    current := current enqueue: 99.
    
    self assert: current size equals: 6.
    self assert: current asArray equals: #(1 2 3 4 5 99).
    
    "Verify the original future (state 10) was not destroyed by altering the past"
    self assert: history last asArray equals: #(1 2 3 4 5 6 7 8 9 10).
]
