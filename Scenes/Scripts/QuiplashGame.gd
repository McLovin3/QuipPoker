extends CanvasLayer
const WIN_AMOUNT: int = 300

var QUIPS: Array = [
	"What is the REAL debate?",
	"What's a programmer's biggest fear?",
	"___, what the hell is even that?",
	"The newest Lays chip flavor is...",
	"I swear, ___ is good for you",
	"The most tragic event in history was...",
	"Morty, I turned myself into a ___ Morty",
	"The best role model is...",
	"The worst thing to do during a zombie apocalypse is...",
	"We have to go now! ___ is coming!",
	"I can't stand people who...",
	"I knew I should have never...",
	"The ___, the ___ is real!",
	"I was late for school because...",
]
var _players: Array
var _quip: String
var _sent_answer: bool = false
mastersync var _player_answers: Dictionary = {}
onready var _popup_text: PopupText = $PopupText
onready var _quip_label: Label = $QuipLabel
onready var _guesser_label: Label = $GuesserLabel
onready var _input: ShakingInput = $Input
onready var _turn_timer: Timer = $TurnTimer
onready var _confirm_button: Button = $ConfirmButton
onready var _quip_list: ItemList = $QuipList


func _ready():
	if get_tree().is_network_server():
		_players = GameManager.player_id_list
		randomize()
		_quip = QUIPS[randi() % QUIPS.size()]
		for id in _players:
			if id == GameManager.last_winner_id:
				rpc_id(id, "_set_as_judge", _quip)
			else:
				rpc_id(
					id, "_set_quip", _quip, GameManager.player_info.get(GameManager.last_winner_id).get("name")
				)


# Master functions
mastersync func send_player_answer(answer: String) -> void:
	var id = get_tree().get_rpc_sender_id()

	_player_answers[id] = {}
	_player_answers[id]["answer"] = answer
	_player_answers[id]["name"] = GameManager.player_info.get(id).get("name")

	if _player_answers.keys().size() == _players.size() - 1:
		rpc_id(GameManager.last_winner_id, "_set_judge_time", _player_answers)

		for player_id in _player_answers.keys():
			rpc_id(player_id, "_set_turn_over", _player_answers)

mastersync func _set_winner(id : int) -> void:
	if GameManager.player_info.get(id).get("chips") > 0:
		GameManager.player_info.get(id)["chips"] += WIN_AMOUNT

	rpc("_show_end_message", _player_answers.get(id).get("answer") + " - " \
		+ _player_answers.get(id).get("name"))

	

# Puppet functions
puppetsync func _set_quip(quip: String, judge: String) -> void:
	_quip_label.text = quip
	_guesser_label.text = judge + " will be judging!"
	_turn_timer.start()

puppetsync func _set_as_judge(quip: String) -> void:
	_quip_label.text = quip
	_guesser_label.text = "You are the judge!"
	_input.visible = false
	_confirm_button.visible = false

puppetsync func _show_end_message(message: String) -> void:
	_popup_text.set_ttl(12)
	_popup_text.display_text(message)

	_quip_list.visible = false

	yield(get_tree().create_timer(10), "timeout")
	get_tree().change_scene("res://Scenes/PokerGame.tscn")

puppetsync func _set_judge_time(player_answers: Dictionary) -> void:
	_quip_list.visible = true
	_player_answers = player_answers

	for id in player_answers.keys():
		_quip_list.add_item(
			player_answers.get(id).get("answer") + " - " + player_answers.get(id).get("name"), null, true
		)

puppetsync func _set_turn_over(player_answers: Dictionary) -> void:
	_input.visible = false
	_confirm_button.visible = false
	_quip_list.visible = true

	for id in player_answers.keys():
		_quip_list.add_item(
			player_answers.get(id).get("answer") + " - " + player_answers.get(id).get("name"), null, false
		)


func _on_TurnTimer_timeout() -> void:
	if not _sent_answer:
		rpc("send_player_answer", "No answer")
		_sent_answer = true


func _on_ConfirmButton_pressed() -> void:
	if _input.text == "":
		_input.shake()
		return

	_sent_answer = true
	_input.visible = false
	_confirm_button.visible = false
	rpc_id(1, "send_player_answer", _input.text)


func _on_QuipList_item_selected(index:int):
	var winner_id = _player_answers.keys()[index]
	rpc_id(1, "_set_winner", winner_id)

