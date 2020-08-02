val cards1: card list = [(Clubs, 13), (Clubs, 11), (Spades, 7), (Spades, 3), (Hearts, 2)];
val cards2: card list = [(Spades, 11), (Spades, 9), (Hearts, 8), (Diamonds, 8), (Diamonds, 3)];
val cards3: card list = [(Clubs, 13), (Spades, 13), (Hearts, 6), (Spades, 1), (Diamonds, 1)];
val cards4: card list = [(Clubs, 10), (Clubs, 9), (Hearts, 9), (Spades, 9), (Spades, 3)] ;
val cards5: card list = [(Diamonds, 6), (Clubs, 6), (Spades, 6), (Spades, 4), (Diamonds, 4)];
val cards6: card list = [(Diamonds, 11), (Spades, 11), (Clubs, 11), (Hearts, 11), (Hearts, 10)];

(* check for same hand *)
val same1: card list = [(Clubs, 13), (Spades, 13), (Hearts, 6), (Spades, 1), (Diamonds, 1)];
val same2: card list = [(Spades, 13), (Clubs, 13), (Hearts, 6), (Spades, 1), (Diamonds, 1)];
val same3: card list = [(Clubs, 13), (Spades, 13), (Hearts, 6), (Diamonds, 1), (Spades, 1)];
val same4: card list = [(Spades, 13), (Clubs, 13), (Hearts, 6), (Diamonds, 1), (Spades, 1)];

(* check_flush *)
val flush: card list = [(Clubs, 5), (Clubs, 4), (Clubs, 3), (Clubs, 3), (Clubs, 3)];

(* compare_flush *)
val flush1: card list = [(Clubs, 13), (Clubs, 10), (Clubs, 4), (Clubs, 3), (Clubs, 2)];
val flush2: card list = [(Hearts, 10), (Hearts, 6), (Hearts, 5), (Hearts, 2), (Hearts, 1)];

(* check_straight *)
(* false *)
val straight1: card list = [(Clubs, 6), (Diamonds, 5), (Hearts, 4), (Spades, 3), (Clubs, 1)]; 
(* true *)
val straight2: card list = [(Clubs, 6), (Diamonds, 5), (Hearts, 4), (Spades, 3), (Clubs, 2)];
(* true *)
val straight3: card list = [(Clubs, 13), (Diamonds, 12), (Hearts, 11), (Spades, 10), (Clubs, 1)];
(* true *)
val straight4: card list = [(Clubs, 5), (Diamonds, 4), (Hearts, 3), (Spades, 2), (Clubs, 1)];
(* false *)
val straight5: card list = [(Clubs, 13), (Diamonds, 12), (Hearts, 11), (Spades, 2), (Clubs, 1)];

(* compare_straight *)
val straight6: card list = [(Clubs, 6), (Diamonds, 5), (Hearts, 4), (Spades, 3), (Clubs, 2)];

(* count_patterns *)
val pattern1: card list = [(Spades, 11), (Spades, 9), (Hearts, 8), (Diamonds, 8), (Diamonds, 3)];
val pattern2: card list = [(Clubs, 13), (Clubs, 11), (Spades, 7), (Spades, 3), (Hearts, 2)];
val pattern3: card list = [(Diamonds, 6), (Clubs, 6), (Spades, 6), (Spades, 4), (Diamonds, 4)];

(* compare_count *)
val cmpcnt1: card list = [(Diamonds, 11), (Spades, 11), (Clubs, 11), (Hearts, 11), (Hearts, 10)];
val cmpcnt2: card list = [(Diamonds, 6), (Clubs, 6), (Spades, 6), (Spades, 4), (Diamonds, 4)];





