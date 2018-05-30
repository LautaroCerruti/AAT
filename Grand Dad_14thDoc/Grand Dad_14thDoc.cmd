; The CMD file.
;
; Two parts: 1. Command definition and  2. State entry
; (state entry is after the commands def section)
;
; 1. Command definition
; ---------------------
; Note: The commands are CASE-SENSITIVE, and so are the command names.
; The eight directions are:
;   B, DB, D, DF, F, UF, U, UB     (all CAPS)
;   corresponding to back, down-back, down, downforward, etc.
; The six buttons are:
;   a, b, c, x, y, z               (all lower case)
;   In default key config, abc are are the bottom, and xyz are on the
;   top row. For 2 button characters, we recommend you use a and b.
;   For 6 button characters, use abc for kicks and xyz for punches.
;
; Each [Command] section defines a command that you can use for
; state entry, as well as in the CNS file.
; The command section should look like:
;
;   [Command]
;   name = some_name
;   command = the_command
;   time = time (optional)
;   buffer.time = time (optional)
;
; - some_name
;   A name to give that command. You'll use this name to refer to
;   that command in the state entry, as well as the CNS. It is case-
;   sensitive (QCB_a is NOT the same as Qcb_a or QCB_A).
;
; - command
;   list of buttons or directions, separated by commas. Each of these
;   buttons or directions is referred to as a "symbol".
;   Directions and buttons can be preceded by special characters:
;   slash (/) - means the key must be held down
;          egs. command = /D       ;hold the down direction
;               command = /DB, a   ;hold down-back while you press a
;   tilde (~) - to detect key releases
;          egs. command = ~a       ;release the a button
;               command = ~D, F, a ;release down, press fwd, then a
;          If you want to detect "charge moves", you can specify
;          the time the key must be held down for (in game-ticks)
;          egs. command = ~30a     ;hold a for at least 30 ticks, then release
;   dollar ($) - Direction-only: detect as 4-way
;          egs. command = $D       ;will detect if D, DB or DF is held
;               command = $B       ;will detect if B, DB or UB is held
;   plus (+) - Buttons only: simultaneous press
;          egs. command = a+b      ;press a and b at the same time
;               command = x+y+z    ;press x, y and z at the same time
;   greater-than (>) - means there must be no other keys pressed or released
;                      between the previous and the current symbol.
;          egs. command = a, >~a   ;press a and release it without having hit
;                                  ;or released any other keys in between
;   You can combine the symbols:
;     eg. command = ~30$D, a+b     ;hold D, DB or DF for 30 ticks, release,
;                                  ;then press a and b together
;
;   Note: Successive direction symbols are always expanded in a manner similar
;         to this example:
;           command = F, F
;         is expanded when MUGEN reads it, to become equivalent to:
;           command = F, >~F, >F
;
;   It is recommended that for most "motion" commads, eg. quarter-circle-fwd,
;   you start off with a "release direction". This makes the command easier
;   to do.
;
; - time (optional)
;   Time allowed to do the command, given in game-ticks. The default
;   value for this is set in the [Defaults] section below. A typical
;   value is 15.
;
; - buffer.time (optional)
;   Time that the command will be buffered for. If the command is done
;   successfully, then it will be valid for this time. The simplest
;   case is to set this to 1. That means that the command is valid
;   only in the same tick it is performed. With a higher value, such
;   as 3 or 4, you can get a "looser" feel to the command. The result
;   is that combos can become easier to do because you can perform
;   the command early. Attacks just as you regain control (eg. from
;   getting up) also become easier to do. The side effect of this is
;   that the command is continuously asserted, so it will seem as if
;   you had performed the move rapidly in succession during the valid
;   time. To understand this, try setting buffer.time to 30 and hit
;   a fast attack, such as KFM's light punch.
;   The default value for this is set in the [Defaults] section below. 
;   This parameter does not affect hold-only commands (eg. /F). It
;   will be assumed to be 1 for those commands.
;
; If you have two or more commands with the same name, all of them will
; work. You can use it to allow multiple motions for the same move.
;
; Some common commands examples are given below.
;
; [Command] ;Quarter circle forward + x
; name = "QCF_x"
; command = ~D, DF, F, x
;
; [Command] ;Half circle back + a
; name = "HCB_a"
; command = ~F, DF, D, DB, B, a
;
; [Command] ;Two quarter circles forward + y
; name = "2QCF_y"
; command = ~D, DF, F, D, DF, F, y
;
; [Command] ;Tap b rapidly
; name = "5b"
; command = b, b, b, b, b
; time = 30
;
; [Command] ;Charge back, then forward + z
; name = "charge_B_F_z"
; command = ~60$B, F, z
; time = 10
;
; [Command] ;Charge down, then up + c
; name = "charge_D_U_c"
; command = ~60$D, U, c
; time = 10


;-| Button Remapping |-----------------------------------------------------
; This section lets you remap the player's buttons (to easily change the
; button configuration). The format is:
;   old_button = new_button
; If new_button is left blank, the button cannot be pressed.
[Remap]
x = x
y = y
z = z
a = a
b = b
c = c
s = s

;-| Default Values |-------------------------------------------------------
[Defaults]
; Default value for the "time" parameter of a Command. Minimum 1.
command.time = 15

; Default value for the "buffer.time" parameter of a Command. Minimum 1,
; maximum 30.
command.buffer.time = 1

;-| Super Motions |--------------------------------------------------------

[Command]
name = "GrandSpinDash"
command = ~D, DB, B, D, DB, B, a+b
time = 30

[Command]
name = "SmolNozomiA"
command = ~D, DF, F, D, DB, B, a
time = 30

[Command]
name = "SmolNozomiB"
command = ~D, DF, F, D, DB, B, b
time = 30

[Command]
name = "SmolNozomiC"
command = ~D, DF, F, D, DB, B, c
time = 30

[Command]
name = "TheGrandOldFinal"
command = ~D, DB, B, D, DF, F, a+b+c
time = 25

[Command]
name = "TheGrandOldFinal"
command = ~D, DB, B, D, DF, F, y
time = 25

;-| Special Motions |------------------------------------------------------

[Command]
name = "AxeThrowA"
command = ~D, DB, B, a
time = 20

[Command]
name = "AxeThrowB"
command = ~D, DB, B, b
time = 20

[Command]
name = "AxeThrowC"
command = ~D, DB, B, c
time = 20

[Command]
name = "EggThrowA"
command = ~D, DF, F, a
time = 20

[Command]
name = "EggThrowB"
command = ~D, DF, F, b
time = 20

[Command]
name = "EggThrowC"
command = ~D, DF, F, c
time = 20

[Command]
name = "SlingshotFireX"
command = ~D, DF, F, x
time = 20

[Command]
name = "SlingshotFireY"
command = ~D, DF, F, y
time = 20

[Command]
name = "SlingshotFireZ"
command = ~D, DF, F, z
time = 20

[Command]
name = "BoomerangThrowX"
command = ~D, DB, B, x
time = 20

[Command]
name = "BoomerangThrowZ"
command = ~D, DB, B, z
time = 20

[Command]
name = "SimbaSummonA"
command = ~D, D, a
time = 20

[Command]
name = "SimbaSummonB"
command = ~D, D, b
time = 20

[Command]
name = "SimbaSummonC"
command = ~D, D, c
time = 20

[Command]
name = "SimbaSummonX"
command = ~D, D, x
time = 20

[Command]
name = "SimbaSummonY"
command = ~D, D, y
time = 20

[Command]
name = "SimbaSummonZ"
command = ~D, D, z
time = 20

;-| Double Tap |-----------------------------------------------------------
[Command]
name = "FF"     ;Required (do not remove)
command = F, F
time = 10

[Command]
name = "BB"     ;Required (do not remove)
command = B, B
time = 10

;-| 2/3 Button Combination |-----------------------------------------------
[Command]
name = "recovery";Required (do not remove)
command = x+y
time = 1

;-| Dir + Button |---------------------------------------------------------
[Command]
name = "down_a"
command = /$D,a
time = 1

[Command]
name = "down_b"
command = /$D,b
time = 1

;-| Single Button |---------------------------------------------------------
[Command]
name = "a"
command = a
time = 1

[Command]
name = "b"
command = b
time = 1

[Command]
name = "c"
command = c
time = 1

[Command]
name = "x"
command = x
time = 1

[Command]
name = "y"
command = y
time = 1

[Command]
name = "z"
command = z
time = 1

[Command]
name = "start"
command = s
time = 1

[Command]
name = "up"
command = U
time = 1

;-| Hold Dir |--------------------------------------------------------------
[Command]
name = "holdfwd";Required (do not remove)
command = /$F
time = 1

[Command]
name = "holdback";Required (do not remove)
command = /$B
time = 1

[Command]
name = "holdup" ;Required (do not remove)
command = /$U
time = 1

[Command]
name = "holddown";Required (do not remove)
command = /$D
time = 1
;---------------------------------------------------------------------------
; 2. State entry
; --------------
; This is where you define what commands bring you to what states.
;
; Each state entry block looks like:
;   [State -1, Label]           ;Change Label to any name you want to use to
;                               ;identify the state with.
;   type = ChangeState          ;Don't change this
;   value = new_state_number
;   trigger1 = command = command_name
;   . . .  (any additional triggers)
;
; - new_state_number is the number of the state to change to
; - command_name is the name of the command (from the section above)
; - Useful triggers to know:
;   - statetype
;       S, C or A : current state-type of player (stand, crouch, air)
;   - ctrl
;       0 or 1 : 1 if player has control. Unless "interrupting" another
;                move, you'll want ctrl = 1
;   - stateno
;       number of state player is in - useful for "move interrupts"
;   - movecontact
;       0 or 1 : 1 if player's last attack touched the opponent
;                useful for "move interrupts"
;
; Note: The order of state entry is important.
;   State entry with a certain command must come before another state
;   entry with a command that is the subset of the first.
;   For example, command "fwd_a" must be listed before "a", and
;   "fwd_ab" should come before both of the others.
;
; For reference on triggers, see CNS documentation.
;
; Just for your information (skip if you're not interested):
; This part is an extension of the CNS. "State -1" is a special state
; that is executed once every game-tick, regardless of what other state
; you are in.


; Don't remove the following line. It's required by the CMD standard.
[Statedef -1]
;===========================================================================
;Grand Spin Dash
[State -1, Grand Spin Dash]
type = ChangeState
value = 2040
triggerall = Power >= 1000
triggerall = command = "GrandSpinDash"
trigger1 = statetype != A
trigger1 = ctrl
;---------------------------------------------------------------------------
;Smol Nozomi (A)
[State -1, Smol Nozomi (A)]
type = ChangeState
value = 3000
triggerall = Power >= 2000
triggerall = command = "SmolNozomiA"
trigger1 = statetype != A
trigger1 = numhelper(3000) = 0 && numhelper(3001) = 0 
trigger1 = ctrl
;---------------------------------------------------------------------------
;Smol Nozomi (B)
[State -1, Smol Nozomi (B)]
type = ChangeState
value = 3010
triggerall = Power >= 2000
triggerall = command = "SmolNozomiB"
trigger1 = statetype != A
trigger1 = numhelper(3000) = 0 && numhelper(3001) = 0 
trigger1 = ctrl
;---------------------------------------------------------------------------
;Smol Nozomi (C)
[State -1, Smol Nozomi (C)]
type = ChangeState
value = 3020
triggerall = Power >= 2000
triggerall = command = "SmolNozomiC"
trigger1 = statetype != A
trigger1 = numhelper(3000) = 0 && numhelper(3001) = 0  
trigger1 = ctrl
;---------------------------------------------------------------------------
;The Grand old final
[State -1, The Grand old final]
type = ChangeState
value = 4000
triggerall = Power >= 3000
triggerall = command = "TheGrandOldFinal"
trigger1 = statetype != A
trigger1 = ctrl
;---------------------------------------------------------------------------
;Axe Throw (A)
[State -1, Axe Throw (A)]
type = ChangeState
value = 1030
triggerall = command = "AxeThrowA"
trigger1 = statetype = S
trigger1 = NumProjID(1020) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Axe Throw Air (A)
[State -1, Axe Throw Air (A)]
type = ChangeState
value = 1031
triggerall = command = "AxeThrowA"
trigger1 = statetype = A
trigger1 = NumProjID(1020) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Axe Throw (B)
[State -1, Axe Throw (B)]
type = ChangeState
value = 1040
triggerall = command = "AxeThrowB"
trigger1 = statetype = S
trigger1 = NumProjID(1020) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Axe Throw Air (B)
[State -1, Axe Throw Air (B)]
type = ChangeState
value = 1041
triggerall = command = "AxeThrowB"
trigger1 = statetype = A
trigger1 = NumProjID(1020) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Axe Throw (C)
[State -1, Axe Throw (C)]
type = ChangeState
value = 1050
triggerall = command = "AxeThrowC"
trigger1 = statetype = S
trigger1 = NumProjID(1020) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Axe Throw Air (C)
[State -1, Axe Throw Air (C)]
type = ChangeState
value = 1051
triggerall = command = "AxeThrowC"
trigger1 = statetype = A
trigger1 = NumProjID(1020) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Egg Throw (A)
[State -1, Egg Throw (A)]
type = ChangeState
value = 1000
triggerall = command = "EggThrowA"
trigger1 = statetype = S
trigger1 = numhelper(1001) = 0 && numhelper(1010) = 0 
trigger1 = ctrl
;---------------------------------------------------------------------------
;Egg Throw Air (A)
[State -1, Egg Throw Air (A)]
type = ChangeState
value = 1001
triggerall = command = "EggThrowA"
trigger1 = statetype = A
trigger1 = numhelper(1001) = 0 && numhelper(1010) = 0 
trigger1 = ctrl
;---------------------------------------------------------------------------
;Egg Throw (B)
[State -1, Egg Throw (B)]
type = ChangeState
value = 1010
triggerall = command = "EggThrowB"
trigger1 = statetype = S
trigger1 = numhelper(1010) = 0 && numhelper(1001) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Egg Throw Air (B)
[State -1, Egg Throw Air (B)]
type = ChangeState
value = 1011
triggerall = command = "EggThrowB"
trigger1 = statetype = A
trigger1 = numhelper(1010) = 0 && numhelper(1001) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Egg Throw (C)
[State -1, Egg Throw (C)]
type = ChangeState
value = 1020
triggerall = command = "EggThrowC"
trigger1 = statetype = S
trigger1 = numhelper(1010) = 0 && numhelper(1001) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Egg Throw Air (C)
[State -1, Egg Throw Air (C)]
type = ChangeState
value = 1021
triggerall = command = "EggThrowC"
trigger1 = statetype = A
trigger1 = numhelper(1010) = 0 && numhelper(1001) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Slingshot Fire (X)
[State -1, Slingshot Fire (X)]
type = ChangeState
value = 1060
triggerall = command = "SlingshotFireX"
trigger1 = statetype = S
trigger1 = numhelper(1060) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Slingshot Fire Air (X)
[State -1, Slingshot Fire Air (X)]
type = ChangeState
value = 1061
triggerall = command = "SlingshotFireX"
trigger1 = statetype = A
trigger1 = numhelper(1060) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Slingshot Fire (Y)
[State -1, Slingshot Fire (Y)]
type = ChangeState
value = 1064
triggerall = command = "SlingshotFireY"
trigger1 = statetype = S
trigger1 = numhelper(1060) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Slingshot Fire Air (Y)
[State -1, Slingshot Fire Air (Y)]
type = ChangeState
value = 1065
triggerall = command = "SlingshotFireY"
trigger1 = statetype = A
trigger1 = numhelper(1060) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Slingshot Fire (Z)
[State -1, Slingshot Fire (Z)]
type = ChangeState
value = 1067
triggerall = command = "SlingshotFireZ"
triggerall = Power >= 500
trigger1 = statetype = S
trigger1 = numhelper(1060) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Slingshot Fire Air (Z)
[State -1, Slingshot Fire Air (Z)]
type = ChangeState
value = 1068
triggerall = command = "SlingshotFireZ"
triggerall = Power >= 500
trigger1 = statetype = A
trigger1 = numhelper(1060) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Boomerang Throw (X)
[State -1, Boomerang Throw (X)]
type = ChangeState
value = 1071
triggerall = command = "BoomerangThrowX"
trigger1 = statetype = S
trigger1 = numhelper(1070) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Boomerang Throw Air (X)
[State -1, Boomerang Throw Air (X)]
type = ChangeState
value = 1072
triggerall = command = "BoomerangThrowX"
trigger1 = statetype = A
trigger1 = numhelper(1070) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Boomerang Throw (Z)
[State -1, Boomerang Throw (Z)]
type = ChangeState
value = 1090
triggerall = command = "BoomerangThrowZ"
trigger1 = statetype = S
trigger1 = numhelper(1070) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Boomerang Throw Air (Z)
[State -1, Boomerang Throw Air (Z)]
type = ChangeState
value = 1091
triggerall = command = "BoomerangThrowZ"
trigger1 = statetype = A
trigger1 = numhelper(1070) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Simba Summon (A/X)
[State -1, Simba Summon (A/X)]
type = ChangeState
value = 2000
triggerall = command = "SimbaSummonA" || command = "SimbaSummonX"
trigger1 = statetype = S
trigger1 = numhelper(2001) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Simba Summon (B/Y)
[State -1, Simba Summon (B/Y)]
type = ChangeState
value = 2010
triggerall = command = "SimbaSummonB" || command = "SimbaSummonY"
trigger1 = statetype = S
trigger1 = numhelper(2001) = 0
trigger1 = ctrl
;---------------------------------------------------------------------------
;Simba Summon (C/Z)
[State -1, Simba Summon (C/Z)]
type = ChangeState
value = 2020
triggerall = command = "SimbaSummonC" || command = "SimbaSummonZ"
trigger1 = statetype = S
trigger1 = numhelper(2001) = 0
trigger1 = ctrl
;===========================================================================
;---------------------------------------------------------------------------
; Run Fwd
[State -1, Run Fwd]
type = ChangeState
value = 100
trigger1 = command = "FF"
trigger1 = statetype = S
trigger1 = ctrl
;---------------------------------------------------------------------------
; Run Back
[State -1, Run Back]
type = ChangeState
value = 105
trigger1 = command = "BB"
trigger1 = statetype = S
trigger1 = ctrl
;---------------------------------------------------------------------------
; Throw
[State -1, Throw]
type = ChangeState
value = 800
triggerall = command = "y" || command = "z"  || command = "b"  || command = "c"
triggerall = statetype = S
triggerall = ctrl
triggerall = stateno != 100
trigger1 = command = "holdfwd"
trigger1 = p2bodydist X < 10
trigger1 = (p2statetype = S) || (p2statetype = C)
trigger1 = p2movetype != H
trigger2 = command = "holdback"
trigger2 = p2bodydist X < 10
trigger2 = (p2statetype = S) || (p2statetype = C)
trigger2 = p2movetype != H
;===========================================================================
;---------------------------------------------------------------------------
;Taunt
[State -1, Taunt]
type = ChangeState
value = 195
triggerall = command = "start"
trigger1 = statetype != A
trigger1 = ctrl
;---------------------------------------------------------------------------
;Standing Light Club Swing
[State -1, Standing Light Club Swing]
type = ChangeState
value = 200
triggerall = command = "a" || command = "x"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = (stateno = 200) && movecontact
;---------------------------------------------------------------------------
;Standing Medium Club Swing
[State -1, Standing Medium Club Swing]
type = ChangeState
value = 210
triggerall = command = "b" || command = "y"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = (stateno = 200) && movecontact
;---------------------------------------------------------------------------
;Standing Strong Club Swing
[State -1, Standing Strong Club Swing]
type = ChangeState
value = 220
triggerall = command = "c" || command = "z"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = (stateno = 200) && movecontact
trigger3 = (stateno = 210) && movecontact
;---------------------------------------------------------------------------
;Crouching Light Club Swing
[State -1, Crouching Club Swing]
type = ChangeState
value = 400
triggerall = command = "a" || command = "x"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = (stateno = 400) && movecontact
;---------------------------------------------------------------------------
;Crouching Medium Club Swing
[State -1, Crouching Medium Club Swing]
type = ChangeState
value = 410
triggerall = command = "b" || command = "y"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = (stateno = 400) && movecontact
;---------------------------------------------------------------------------
;Crouching Strong Club Swing
[State -1, Crouching Strong Club Swing]
type = ChangeState
value = 420
triggerall = command = "c" || command = "z"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = (stateno = 400) && movecontact
trigger3 = (stateno = 410) && movecontact
;---------------------------------------------------------------------------
;Jump Light Club Swing
[State -1, Jump Light Club Swing]
type = ChangeState
value = 600
triggerall = command = "a" || command = "x"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = (stateno = 600) && movecontact
;---------------------------------------------------------------------------
;Jump Medium Club Swing
[State -1, Jump Medium Club Swing]
type = ChangeState
value = 610
triggerall = command = "b" || command = "y"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = (stateno = 600) && movecontact
;---------------------------------------------------------------------------
;Jump Strong Club Swing
[State -1, Jump Strong Club Swing]
type = ChangeState
value = 620
triggerall = command = "c" || command = "z"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = (stateno = 600) && movecontact
trigger3 = (stateno = 610) && movecontact