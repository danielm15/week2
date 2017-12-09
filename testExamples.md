Create game:
	
	GIVEN:

	WHEN:
		CreateGame is emitted
	THEN:
		Emit GameCreated event
Join game:

	GIVEN:
		GameCreated event
	WHEN:
		JoinGame event is emitted
	THEN:
		Emit GameJoined event
Place move:

	GIVEN:
		Cell[0][0] is empty
	WHEN:
		Cell[0][0] is marked with 'X'
	THEN:
		Emit PlaceMove event

	GIVEN:
		It is side 'X' turn to play
	WHEN:
		PlaceMove from side 'O'
	THEN:
		Emit NotYourMove event

Illegal moves:

	GIVEN:
		Cell [1][1] is marked with 'X'
	WHEN:
		Attempted to mark cell [1][1] with 'X'
	THEN:
		Emit IllegalMove event

	GIVEN:
		It is Player 'X' turn to move
	WHEN:
		Player 'O' attemps to place a move
	THEN:
		Emit NotYourMove event

Winning scenarios:

	GIVEN:
		Two cells in row 1 are marked with 'X'
	WHEN:
		The third cell in row 1 is marked with 'X'
	THEN:
		Emit GameWon event for 'X'

	GIVEN:
		Two cells in column 1 are marked with 'O'
	WHEN:
		The third cell in column 1 is marked with 'O'
	THEN:
		Emit GameWon event for 'O'

	GIVEN:
		Two cells in the same diagonal are marked with 'X'
	WHEN:
		The third cell in that diagonal is marked with 'X'
	THEN:	
		Emit GameWon event for 'X'

Draw scenarios:

	GIVEN:
		All cells are marked except for [0][0]
	WHEN:
		Cell [0][0] is marked and there is no GameWon event emitted
	THEN:
		Emit GameDraw event
