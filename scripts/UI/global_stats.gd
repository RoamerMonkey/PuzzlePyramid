extends Control

#DEFAULTS UNTIL OVERRRIDEN
##GAME
var location : String = "dialogue" #Current scene of the game.
var timeleftmin : int = 12 #The number of minutes left.
var timeleftsec : int = 0 #The number of seconds left.
##PROGRESS
var firsttime : bool = true #Is this the player's first time?
var mg1 : bool = false #Did player beat MG1?
var mg2 : bool = false #Did player beat MG2?
var mg3 : bool = false #Did player beat MG3?
var ho1 : bool = false #Did player beat HO1?
var ho2 : bool = false #Did player beat HO2?
var ho3 : bool = false #Did player beat HO3?
var itemlist : PackedStringArray #What items does the player have left?
##SETTINGS
var bgm : float = 1.0 #Music volume
var sfx : float = 1.0 #Sound effects volume
var window : bool = false #Is game in windowed mode?
var cursor : bool = true #Is custom cursor used?
##DIFFICULTY
var itemnum : int = 12 #How many items does the player need to find?
var mode : bool = true #Are we on timed mode?
var maxtime : int = 12 #Maximum time for each side (in minutes)
var hint : int = 60 #Hint recharge time (in seconds)
var skip : int = 60 #Skip recharge time (in seconds)

#MISC
var is_dragging = false
var zindex = 0
