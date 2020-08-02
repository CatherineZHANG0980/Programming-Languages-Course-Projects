(* /*
∗ CSCI3180 Principles of Programming Languages ∗
∗ --- Declaration --- ∗
∗ I declare that the assignment here submitted is original except for source
∗ material explicitly acknowledged. I also acknowledge that I am aware of
∗ University policy and regulations on honesty in academic work, and of the
∗ disciplinary guidelines and procedures applicable to breaches of such policy
∗ and regulations, as contained in the website
∗ http://www.cuhk.edu.hk/policy/academichonesty/ ∗
∗ Assignment 4
∗ Name : Zhang Xin Yu
∗ Student ID : 1155091989
∗ Email Addr : xyzhang7@cse.cuhk.edu.hk 
*/ *)

datatype suit = Clubs | Diamonds | Hearts | Spades;
datatype hand = Nothing | Pair | Two_Pairs | Three_of_a_Kind | Full_House | Four_of_a_Kind | Flush | Straight;
(* datatype hand = Four_of_a_Kind | Full_House | Three_of_a_Kind | Two_Pairs | Pair | Nothing | Flush | Straight; *)
type card = suit * int;

fun check_asc (cards: card list) : bool= 
    case cards of 
        nil => true
        |[_] => true
        |((_, x) :: (tail as (_, y) :: t)) =>
            if x = y+1 andalso check_asc(tail) then true
            else false;

fun last (cards: card list) : int = 
    case cards of 
        nil => raise Fail("empty list")
        |[(_, rank)] => rank
        |(h::t) => last(t);

fun prev (cards: card list) = 
    case cards of 
        nil => raise Fail("empty list")
        |(x::[]) => []
        |(x::t) => x::prev(t);

fun reformat (cards: card list) : (int * int) list = 
    case cards of 
        nil => nil
        |[(_, rank:int)] => [(rank, 1)]
        |((_, rank) :: t) => (rank , 1) :: reformat(t);

fun cnt_dup (x : (int*int), []) = x : (int * int)
    |cnt_dup ((x:int, cnt:int), (y:int, _)::t : (int * int) list) = 
        if x = y then cnt_dup((x, cnt+1), t)
        else cnt_dup((x, cnt), t);

fun remov_x (x : (int * int), []) = []
    |remov_x ((item1 as (x:int, _)), (item2 as (y:int, _))::t : (int * int) list) = 
        if x = y then remov_x(item1, t)
        else item2::remov_x(item1, t);

fun remov_dup (l: (int * int) list) : (int * int) list = 
    case l of
        nil => nil
        |(h::t) =>  
            let    
                val newh = cnt_dup(h, t)
                val newt = remov_x(h, t)
            in 
                newh::remov_dup(newt)
            end;

fun check_sort (l : (int * int) list) : bool = 
    case l of 
        [] => true
        |[a] => true
        |((a as (_, x:int)) :: (b as (_, y:int)) :: t) =>
            x>=y andalso check_sort(b::t);

fun bubblesort (l : (int * int) list) : (int * int) list =
    case l of 
        [] => []
        |[a] => [a]
        |((a as (_, x:int)) :: (b as (_, y:int)) :: t) =>
            if x<y then b::bubblesort(a::t)
            else a::bubblesort(b::t);

fun sort [] = []
    |sort (l : (int * int) list) : (int * int) list = 
        if check_sort(l) then l 
        else sort (bubblesort l);

fun rank_hands(Hand: hand):int = 
    case Hand of 
    Nothing => 0
    |Pair => 1
    |Two_Pairs => 2
    |Three_of_a_Kind => 3
    |Full_House => 4
    |Four_of_a_Kind =>5
    |_ => ~1;

fun cmp (l : (int * int) list * (int * int) list) : string = 
    case l of
        (nil, nil) => "This is a tie"
        |((rank1, _)::t1, (rank2, _)::t2) => 
            if rank1>rank2 then "Hand 1 wins"
            else if rank1<rank2 then "Hand 2 wins"
            else cmp(t1, t2)
        |(_, nil) => "ERROR"
        |(nil, _) => "ERROR";


(* 3(1) *)
fun check_flush (cards: card list):bool = 
    case cards of 
        nil => true
        |[_] => true
        |((s1:suit, _) :: (tail as (s2:suit, _) :: t)) => 
            if s1 = s2 andalso check_flush(tail) then true
            else false;

(* 3(2) *)
fun compare_flush (nil, nil) = "This is a tie"
    |compare_flush ((_, rank1)::t1 : card list, (_, rank2)::t2 : card list) : string = 
        if rank1>rank2 then "Hand 1 wins"
        else if rank1<rank2 then "Hand 2 wins"
        else compare_flush(t1, t2)
    |compare_flush(_, nil) = "ERROR"
    |compare_flush(nil, _) = "ERROR";

(* 3(3) *)
fun check_straight nil = false
    |check_straight ([_] : card list):bool = false
    |check_straight (cards as (_, rank)::t) =
        if rank < 5 then false
        else if last(cards) = 1 andalso rank = 13 then check_asc(prev(cards))
        else check_asc(cards);

(* 3(4) *)
fun compare_straight ((cards1 as (_, rank1)::t1):card list, (cards2 as (_, rank2)::t2):card list) : string = 
    let 
        val last1 = last(cards1)
        val last2 = last(cards2)
    in 
        if (last1 = 1 andalso rank1 = 13) andalso (last2 = 1 andalso rank2 = 13)
            then "This is a tie"
        else if last1 = 1 andalso rank1 = 13
            then "Hand 1 wins"
        else if last2 = 1 andalso rank2 = 13
            then "Hand 2 wins"
        else if rank1 = rank2 then "This is a tie"
        else if rank1 > rank2 then "Hand 1 wins"
        else "Hand 2 wins"
    end
    |compare_straight (_, nil) = "ERROR"
    |compare_straight (nil, _) = "ERROR";

(* 3(5) *)
fun count_patterns(cards: card list) : hand * (int * int) list = 
    let 
        val temp = remov_dup(reformat(cards))
        val newcards = sort(temp)
    in
        case newcards of
        [(_, 4), (_, 1)] => (Four_of_a_Kind, newcards)
        |[(_, 3), (_, 2)] => (Full_House, newcards)
        |[(_, 3), (_, 1), (_, 1)] => (Three_of_a_Kind, newcards)
        |[(_, 2), (_, 2), (_, 1)] => (Two_Pairs, newcards)
        |[(_, 2), (_, 1), (_, 1), (_, 1)] => (Pair, newcards)
        |[(_, 1), (_, 1), (_, 1), (_, 1), (_, 1)] => (Nothing, newcards)
        |_=> raise Fail("Wrong list")
    end;

(* 3(6) *)
fun compare_count(cards1: card list, cards2: card list) : string= 
    let 
        val (Hand1, newcards1) = count_patterns(cards1)
        val (Hand2, newcards2) = count_patterns(cards2)
        val rh1 = rank_hands(Hand1)
        val rh2 = rank_hands(Hand2)
    in 
        if rh1 > rh2 then "Hand 1 wins"
        else if rh2 > rh1 then "Hand 2 wins"
        else cmp(newcards1, newcards2)
    end;

