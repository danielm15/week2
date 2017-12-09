Illegal moves:

	GIVEN:
		Cell [1][1] is marked
	WHEN:
		Attempted to mark cell [1][1]
	THEN:
		Emit IllegalMove event

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
