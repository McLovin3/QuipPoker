extends Node2D

const INITIAL_POINT_AMOUNT = 1000

enum Suits { HEARTS, DIAMONDS, SPADES, CLUBS }
enum Values { ACE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING }

var _deck: Array = []
var player_id_list: Array = []
var player_info: Dictionary = {}
var last_winner_id: int = 0


func change_player_order_clockwise() -> void:
	player_id_list.push_back(player_id_list.pop_front())


func get_player_names() -> Array:
	var player_names: Array = []
	for player_id in player_id_list:
		player_names.append(player_info[player_id].name)
	return player_names


func reinitialise_game_manager() -> void:
	player_info.clear()
	player_id_list = NetworkManager.players.keys()

	for id in player_id_list:
		player_info[id] = {"name": NetworkManager.players.get(id)}
		player_info[id]["chips"] = INITIAL_POINT_AMOUNT
		player_info[id]["action"] = -1
		player_info[id]["action_count"] = 0

	new_deck()


func new_deck() -> void:
	_deck.clear()
	for suit in Suits.values():
		for value in Values.values():
			_deck.append({"suit": suit, "value": value})

	randomize()
	_deck.shuffle()


func get_next_card() -> Dictionary:
	return _deck.pop_front()


func get_api_value(card_value: Dictionary) -> String:
	var suit = card_value["suit"]
	var value = card_value["value"]

	match suit:
		GameManager.Suits.HEARTS:
			match value:
				GameManager.Values.ACE:
					return "AH"
				GameManager.Values.TWO:
					return "2H"
				GameManager.Values.THREE:
					return "3H"
				GameManager.Values.FOUR:
					return "4H"
				GameManager.Values.FIVE:
					return "5H"
				GameManager.Values.SIX:
					return "6H"
				GameManager.Values.SEVEN:
					return "7H"
				GameManager.Values.EIGHT:
					return "8H"
				GameManager.Values.NINE:
					return "9H"
				GameManager.Values.TEN:
					return "10H"
				GameManager.Values.JACK:
					return "JH"
				GameManager.Values.QUEEN:
					return "QH"
				GameManager.Values.KING:
					return "KH"
		GameManager.Suits.DIAMONDS:
			match value:
				GameManager.Values.ACE:
					return "AD"
				GameManager.Values.TWO:
					return "2D"
				GameManager.Values.THREE:
					return "3D"
				GameManager.Values.FOUR:
					return "4D"
				GameManager.Values.FIVE:
					return "5D"
				GameManager.Values.SIX:
					return "6D"
				GameManager.Values.SEVEN:
					return "7D"
				GameManager.Values.EIGHT:
					return "8D"
				GameManager.Values.NINE:
					return "9D"
				GameManager.Values.TEN:
					return "10D"
				GameManager.Values.JACK:
					return "JD"
				GameManager.Values.QUEEN:
					return "QD"
				GameManager.Values.KING:
					return "KD"
		GameManager.Suits.SPADES:
			match value:
				GameManager.Values.ACE:
					return "AS"
				GameManager.Values.TWO:
					return "2S"
				GameManager.Values.THREE:
					return "3S"
				GameManager.Values.FOUR:
					return "4S"
				GameManager.Values.FIVE:
					return "5S"
				GameManager.Values.SIX:
					return "6S"
				GameManager.Values.SEVEN:
					return "7S"
				GameManager.Values.EIGHT:
					return "8S"
				GameManager.Values.NINE:
					return "9S"
				GameManager.Values.TEN:
					return "10S"
				GameManager.Values.JACK:
					return "JS"
				GameManager.Values.QUEEN:
					return "QS"
				GameManager.Values.KING:
					return "KS"
		GameManager.Suits.CLUBS:
			match value:
				GameManager.Values.ACE:
					return "AC"
				GameManager.Values.TWO:
					return "2C"
				GameManager.Values.THREE:
					return "3C"
				GameManager.Values.FOUR:
					return "4C"
				GameManager.Values.FIVE:
					return "5C"
				GameManager.Values.SIX:
					return "6C"
				GameManager.Values.SEVEN:
					return "7C"
				GameManager.Values.EIGHT:
					return "8C"
				GameManager.Values.NINE:
					return "9C"
				GameManager.Values.TEN:
					return "10C"
				GameManager.Values.JACK:
					return "JC"
				GameManager.Values.QUEEN:
					return "QC"
				GameManager.Values.KING:
					return "KC"
	return "NA"
