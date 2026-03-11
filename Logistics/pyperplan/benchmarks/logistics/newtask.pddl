; Built over task17.pddl
(define (problem logistics-10-0)
(:domain logistics)
(:objects
  ; apn1 apn2 - airplane
  semi1 semi2 semi3 semi4 - semi ; Added new semi trucks
  apt1 apt2 apt3 apt4 - airport
  depot1 depot2 depot3 depot4 - depot ; Added new depots for the semis
  pos4 pos3 pos2 pos1 - location
  cit4 cit3 cit2 cit1 - city 
  tru4 tru3 tru2 tru1 - truck 
  obj43 obj42 obj41 obj33 obj32 obj31 obj23 obj22 obj21 obj13 obj12 obj11 - package)

(:init 
 ; Vehicles
 ; (at apn1 apt1) (at apn2 apt3)
 (at tru1 pos1) (at tru2 pos2) (at tru3 pos3) (at tru4 pos4)
 ; Packages
 (at obj11 pos1) (at obj12 pos1) (at obj13 pos1)
 (at obj21 pos2) (at obj22 pos2) (at obj23 pos2)
 (at obj31 pos3) (at obj32 pos3) (at obj33 pos3)
 (at obj41 pos4) (at obj42 pos4) (at obj43 pos4)
 ; City mappings
 (in-city pos1 cit1) (in-city apt1 cit1) (in-city depot1 cit1)
 (in-city pos2 cit2) (in-city apt2 cit2) (in-city depot2 cit2)
 (in-city pos3 cit3) (in-city apt3 cit3) (in-city depot3 cit3)
 (in-city pos4 cit4) (in-city apt4 cit4) (in-city depot4 cit4)
 ; Added initial states for 4 depots
 (in-city depot1 cit1) (in-city depot2 cit2) (in-city depot3 cit3) (in-city depot4 cit4)
 ; Added initial states for 2 semi trucks at their respective depots
 (at semi1 depot1) (at semi2 depot2) (at semi3 depot3) (at semi4 depot4)
 ; Added highway connections between depots for the semis (bidirectional)
 (highway depot1 depot2) (highway depot2 depot1)
 (highway depot2 depot3) (highway depot3 depot2)
 (highway depot3 depot4) (highway depot4 depot3)
 )


(:goal (and 
  ; Within-city (trucks only)
  (at obj13 apt1) (at obj43 depot4)
  ; Airport-based inter-city (trucks + airplanes)
  (at obj11 apt3) (at obj31 apt1)
  ; Depot-based inter-city (trucks + semis via highway)
  (at obj21 depot3) (at obj32 depot2)
  ;(trucks + airplanes/semis + trucks)
  (at obj12 pos4) (at obj41 pos1) (at obj22 pos3)
  ))
)