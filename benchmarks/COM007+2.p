%------------------------------------------------------------------------------
% File     : COM007+2 : TPTP v7.5.0. Released v3.2.0.
% Domain   : Computing Theory
% Problem  : Preservation of the Diamond Property under reflexive closure
% Version  : Especial.
% English  :

% Refs     : [Bez05] Bezem (2005), Email to Geoff Sutcliffe
% Source   : [Bez05]
% Names    : dpe [Bez05]

% Status   : Theorem
% Rating   : 0.19 v7.5.0, 0.22 v7.4.0, 0.13 v7.3.0, 0.14 v7.2.0, 0.10 v7.1.0, 0.09 v7.0.0, 0.10 v6.4.0, 0.15 v6.3.0, 0.04 v6.2.0, 0.12 v6.1.0, 0.17 v5.5.0, 0.15 v5.4.0, 0.14 v5.3.0, 0.22 v5.2.0, 0.05 v5.0.0, 0.08 v4.1.0, 0.09 v4.0.0, 0.08 v3.7.0, 0.14 v3.5.0, 0.00 v3.4.0, 0.08 v3.3.0, 0.00 v3.2.0

% Syntax   : Number of formulae    :    7 (   1 unit)
%            Number of atoms       :   17 (   2 equality)
%            Maximal formula depth :    7 (   4 average)
%            Number of connectives :   10 (   0   ~;   1   |;   4   &)
%                                         (   0 <=>;   5  =>;   0  <=;   0 <~>)
%                                         (   0  ~|;   0  ~&)
%            Number of predicates  :    4 (   1 propositional; 0-2 arity)
%            Number of functors    :    3 (   3 constant; 0-0 arity)
%            Number of variables   :   11 (   0 sgn;  10   !;   1   ?)
%            Maximal term depth    :    1 (   1 average)
% SPC      : FOF_THM_RFO_SEQ

% Comments :
%------------------------------------------------------------------------------
fof(assumption,axiom,
    ( reflexive_rewrite(a,b)
    & reflexive_rewrite(a,c) )).

fof(goal_ax,axiom,(
    ! [A] :
      ( ( reflexive_rewrite(b,A)
        & reflexive_rewrite(c,A) )
     => goal ) )).

fof(equal_in_reflexive_rewrite,axiom,(
    ! [A,B] :
      ( A = B
     => reflexive_rewrite(A,B) ) )).

fof(rewrite_in_reflexive_rewrite,axiom,(
    ! [A,B] :
      ( rewrite(A,B)
     => reflexive_rewrite(A,B) ) )).

fof(equal_or_rewrite,axiom,(
    ! [A,B] :
      ( reflexive_rewrite(A,B)
     => ( A = B
        | rewrite(A,B) ) ) )).

fof(rewrite_diamond,axiom,(
    ! [A,B,C] :
      ( ( rewrite(A,B)
        & rewrite(A,C) )
     => ? [D] :
          ( rewrite(B,D)
          & rewrite(C,D) ) ) )).

fof(goal_to_be_proved,conjecture,(
    goal )).

%------------------------------------------------------------------------------
