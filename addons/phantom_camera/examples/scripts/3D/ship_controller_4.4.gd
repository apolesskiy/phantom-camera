extends CharacterBody3D

@export var ROTATION_SPEED_RADIANS: float = 1
@export var ACCELERATION: float = 5

var current_speed: float = 0

var movement_enabled: bool = true

const KEY_STRINGNAME: StringName = "Key"
const ACTION_STRINGNAME: StringName = "Action"

const INPUT_PITCH_UP_STRINGNAME: StringName = "pitch_up"
const INPUT_PITCH_DOWN_STRINGNAME: StringName = "pitch_down"
const INPUT_ROLL_LEFT_STRINGNAME: StringName = "roll_left"
const INPUT_ROLL_RIGHT_STRINGNAME: StringName = "roll_right"
const INPUT_FORWARD_STRINGAME: StringName = "forward"
const INPUT_BACK_STRINGAME: StringName = "back"

var InputMovementDic: Dictionary = {
  INPUT_PITCH_UP_STRINGNAME: {
    KEY_STRINGNAME: KEY_S,
    ACTION_STRINGNAME: INPUT_PITCH_UP_STRINGNAME
  },
  INPUT_PITCH_DOWN_STRINGNAME: {
    KEY_STRINGNAME: KEY_W,
    ACTION_STRINGNAME: INPUT_PITCH_DOWN_STRINGNAME
  },
  INPUT_ROLL_LEFT_STRINGNAME: {
    KEY_STRINGNAME: KEY_A,
    ACTION_STRINGNAME: INPUT_ROLL_LEFT_STRINGNAME
  },
  INPUT_ROLL_RIGHT_STRINGNAME: {
    KEY_STRINGNAME: KEY_D,
    ACTION_STRINGNAME: INPUT_ROLL_RIGHT_STRINGNAME
  },
  INPUT_FORWARD_STRINGAME: {
    KEY_STRINGNAME: KEY_SHIFT,
    ACTION_STRINGNAME: INPUT_FORWARD_STRINGAME
  },
  INPUT_BACK_STRINGAME: {
    KEY_STRINGNAME: KEY_CTRL,
    ACTION_STRINGNAME: INPUT_BACK_STRINGAME
  },
}


func _ready() -> void:
  for input in InputMovementDic:
    var key_val = InputMovementDic[input].get(KEY_STRINGNAME)
    var action_val = InputMovementDic[input].get(ACTION_STRINGNAME)

    var movement_input = InputEventKey.new()
    movement_input.physical_keycode = key_val
    InputMap.add_action(action_val)
    InputMap.action_add_event(action_val, movement_input)


func _physics_process(delta: float) -> void:
  
  # Apply rotation.
  var dRoll = ROTATION_SPEED_RADIANS * delta * (Input.get_action_strength(INPUT_ROLL_RIGHT_STRINGNAME) - Input.get_action_strength(INPUT_ROLL_LEFT_STRINGNAME))
  var dPitch = ROTATION_SPEED_RADIANS * delta * (Input.get_action_strength(INPUT_PITCH_UP_STRINGNAME) - Input.get_action_strength(INPUT_PITCH_DOWN_STRINGNAME))

  rotate_object_local(Vector3.FORWARD, dRoll)
  rotate_object_local(Vector3.RIGHT, dPitch)

  var dSpeed = ACCELERATION * delta * ((Input.get_action_strength(INPUT_FORWARD_STRINGAME) - Input.get_action_strength(INPUT_BACK_STRINGAME)))

  current_speed = current_speed + dSpeed

  velocity = -transform.basis.z * current_speed

  move_and_slide()
