; Domain file for blocksworld problem. Defines the types, predicates, functions and actions.

(define (domain blocksworld)

;remove requirements that are not needed
(:requirements :typing
    :negative-preconditions
)

(:types block ; No need to define table type since we use special ontable predicate
)

(:predicates
    (on ?x ?y - block) ; block x is on block y
    (ontable ?x - block) ; block x is on the table
    (clear ?x - block) ; block x has nothing on top of it
    (holding ?x - block) ; the robot arm is holding block x
    (handempty) ; the robot arm is empty
)

(:action pickup ; pick block from table
    :parameters (?x - block)
    :precondition (and (ontable ?x) (clear ?x) (handempty))
    :effect (and (not (ontable ?x)) (not (clear ?x)) (not (handempty)) (holding ?x))
)

(:action putdown ; put block on table
    :parameters (?x - block)
    :precondition (holding ?x)
    :effect (and (ontable ?x) (clear ?x) (handempty) (not (holding ?x)))
)

(:action stack ; stack block on another block
    :parameters (?x - block ?y - block)
    :precondition (and (holding ?x) (clear ?y))
    :effect (and (on ?x ?y) (clear ?x) (handempty) (not (holding ?x)) (not (clear ?y)))
)

(:action unstack ; unstack block from another block
    :parameters (?x - block ?y - block)
    :precondition (and (on ?x ?y) (clear ?x) (handempty))
    :effect (and (holding ?x) (clear ?y) (not (on ?x ?y)) (not (clear ?x)) (not (handempty)))
)
)