
(** The abstract type of values representing adventures. *)
type bidask = {
  trade_type : string;
  bid: int;
  ask: int;
  spread: int;
}

(* keeps track of market maker's holdings *)
type orderbook = {
  outstanding_shares: int;
}

(* Holds market maker type *)
type t = {
  currbidask: bidask;
  bid_ask_history: bidask list;
  timestamp: int;
  curr_profit: int;
  orderbook: orderbook
}

(* Trade variant.  To be sent to engine *)

type send_market = {
  timestamp : int;
  transaction: bidask;
}

type receive_transaction =  {
  timestamp : int;
  trade_type : string; (* hit the bid or lifted offer *)
  transaction : bidask;
}

val init_market : string -> t
val get_timestamp : t -> int
val transaction : receive_transaction -> t -> t
val generate_receive_transaction : int -> string -> int -> int -> 
  receive_transaction
val stringify_bid_ask : t -> string
val get_outstandingshares : t -> int
val increment_timestep : t -> t
val display_data : t -> unit
val stringify_bidask_history : t -> unit
val exchange_mm_excess : t -> int -> t