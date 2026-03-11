;; logistics domain Typed version.
;;

(define (domain logistics)
  (:requirements :strips :typing) 
  (:types truck
          airplane
          semi - vehicle ; Added new type - vehicle. Semi trucks
          package
          vehicle - physobj
          airport
          location 
          depot - place ; Added new type - place. Depots for the semis.
          city
          place 
          physobj - object)
  
  (:predicates 	(in-city ?loc - place ?city - city)
		(at ?obj - physobj ?loc - place)
		(in ?pkg - package ?veh - vehicle)
		(highway ?depot1 - depot ?depot2 - depot) ; Added predicate highway to connect depots for the semis. Similar to airports for the airplanes.
		)
  
(:action LOAD-TRUCK
   :parameters    (?pkg - package ?truck - truck ?loc - place)
   :precondition  (and (at ?truck ?loc) (at ?pkg ?loc))
   :effect        (and (not (at ?pkg ?loc)) (in ?pkg ?truck)))

(:action LOAD-AIRPLANE
  :parameters   (?pkg - package ?airplane - airplane ?loc - place)
  :precondition (and (at ?pkg ?loc) (at ?airplane ?loc))
  :effect       (and (not (at ?pkg ?loc)) (in ?pkg ?airplane)))

(:action UNLOAD-TRUCK
  :parameters   (?pkg - package ?truck - truck ?loc - place)
  :precondition (and (at ?truck ?loc) (in ?pkg ?truck))
  :effect       (and (not (in ?pkg ?truck)) (at ?pkg ?loc)))

(:action UNLOAD-AIRPLANE
  :parameters    (?pkg - package ?airplane - airplane ?loc - place)
  :precondition  (and (in ?pkg ?airplane) (at ?airplane ?loc))
  :effect        (and (not (in ?pkg ?airplane)) (at ?pkg ?loc)))

(:action DRIVE-TRUCK
  :parameters (?truck - truck ?loc-from - place ?loc-to - place ?city - city)
  :precondition
   (and (at ?truck ?loc-from) (in-city ?loc-from ?city) (in-city ?loc-to ?city))
  :effect
   (and (not (at ?truck ?loc-from)) (at ?truck ?loc-to)))

(:action FLY-AIRPLANE
  :parameters (?airplane - airplane ?loc-from - airport ?loc-to - airport)
  :precondition
   (at ?airplane ?loc-from)
  :effect
   (and (not (at ?airplane ?loc-from)) (at ?airplane ?loc-to)))

(:action DRIVE-SEMI
  :parameters (?semi - semi ?loc-from - depot ?loc-to - depot)
  :precondition
   (and (at ?semi ?loc-from) (highway ?loc-from ?loc-to))
  :effect
   (and (not (at ?semi ?loc-from)) (at ?semi ?loc-to))) ; Added action for driving the semi trucks between depots. Preconditions require that the semi is at the starting depot and that there is a highway connecting the two depots. Effects update the location of the semi truck to the new depot.

(:action LOAD-SEMI
   :parameters    (?pkg - package ?semi - semi ?loc - depot)
   :precondition  (and (at ?semi ?loc) (at ?pkg ?loc))
   :effect        (and (not (at ?pkg ?loc)) (in ?pkg ?semi))) ; Added action for loading packages onto the semi trucks at the depots. Preconditions require that the semi is at the depot and that the package is also at the same depot. Effects update the state to reflect that the package is now in the semi truck and no longer at the depot.

(:action UNLOAD-SEMI
  :parameters   (?pkg - package ?semi - semi ?loc - depot)
  :precondition (and (at ?semi ?loc) (in ?pkg ?semi))
  :effect       (and (not (in ?pkg ?semi)) (at ?pkg ?loc))) ; Added action for unloading packages from the semi trucks at the depots. Preconditions require that the semi is at the depot and that the package is currently in the semi truck. Effects update the state to reflect that the package is now at the depot and no longer in the semi truck.
)