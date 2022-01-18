%--------------------------------------------------------------------------
% File     : MGT037+1 : TPTP v7.5.0. Released v2.0.0.
% Domain   : Management (Organisation Theory)
% Problem  : Once appeared, efficient producers do not disappear
% Version  : [PB+94] axioms : Reduced & Augmented > Complete.
% English  :

% Refs     : [PM93]  Peli & Masuch (1993), The Logic of Propogation Strateg
%          : [PM94]  Peli & Masuch (1994), The Logic of Propogation Strateg
%          : [Kam95] Kamps (1995), Email to G. Sutcliffe
% Source   : [Kam95]
% Names    :

% Status   : Theorem
% Rating   : 0.19 v7.5.0, 0.22 v7.4.0, 0.10 v7.3.0, 0.17 v7.2.0, 0.14 v7.1.0, 0.09 v7.0.0, 0.07 v6.4.0, 0.12 v6.3.0, 0.08 v6.1.0, 0.13 v6.0.0, 0.09 v5.5.0, 0.19 v5.4.0, 0.21 v5.3.0, 0.26 v5.2.0, 0.10 v5.0.0, 0.12 v4.1.0, 0.17 v3.7.0, 0.10 v3.5.0, 0.05 v3.4.0, 0.11 v3.3.0, 0.21 v3.2.0, 0.18 v3.1.0, 0.22 v2.7.0, 0.33 v2.6.0, 0.43 v2.5.0, 0.38 v2.4.0, 0.25 v2.3.0, 0.33 v2.2.1, 0.00 v2.1.0
% Syntax   : Number of formulae    :   16 (   1 unit)
%            Number of atoms       :   70 (   8 equality)
%            Maximal formula depth :   10 (   6 average)
%            Number of connectives :   62 (   8   ~;   3   |;  32   &)
%                                         (   0 <=>;  19  =>;   0  <=;   0 <~>)
%                                         (   0  ~|;   0  ~&)
%            Number of predicates  :    8 (   0 propositional; 1-3 arity)
%            Number of functors    :   11 (   4 constant; 0-2 arity)
%            Number of variables   :   35 (   0 sgn;  33   !;   2   ?)
%            Maximal term depth    :    2 (   1 average)
% SPC      : FOF_THM_RFO_SEQ

% Comments :
%--------------------------------------------------------------------------
%----Subsitution axioms
%----Problem axioms
%----MP. If the number of efficient producers is zero in the environment
%----past their appearence, then there had to be a time not before their
%----appearence when their growth rate was negative.
fof(mp_previous_negative_growth,axiom,(
    ! [E,T] :
      ( ( environment(E)
        & greater_or_equal(T,appear(efficient_producers,E))
        & cardinality_at_time(efficient_producers,T) = zero )
     => ? [To] :
          ( greater(To,appear(efficient_producers,E))
          & in_environment(E,To)
          & greater(T,To)
          & greater(zero,growth_rate(efficient_producers,To)) ) ) )).

%----MP. The number of organizations in the environment is zero until the
%----appearence of first organizations.
fof(mp_start_of_organizations,axiom,(
    ! [E,T] :
      ( ( environment(E)
        & in_environment(E,T)
        & greater(appear(an_organisation,E),T) )
     => number_of_organizations(E,T) = zero ) )).

%----MP. If the number of organizations in the environment cdoes not
%----decrease, then there is an organizational group in the environment
%----that does not decrease.
fof(mp_non_decreasing,axiom,(
    ! [E,T] :
      ( ( environment(E)
        & in_environment(E,T)
        & ~ decreases(number_of_organizations(E,T)) )
     => ? [X] :
          ( subpopulation(X,E,T)
          & greater(cardinality_at_time(X,T),zero)
          & ~ greater(zero,growth_rate(X,T)) ) ) )).

%----MP. If the sum of organizations in an environment is zero, then no
%----organizational group has members in the environment.
fof(mp_no_members,axiom,(
    ! [E,T,X] :
      ( ( environment(E)
        & in_environment(E,T)
        & number_of_organizations(E,T) = zero
        & subpopulation(X,E,T) )
     => cardinality_at_time(X,T) = zero ) )).

%----MP. First movers and efficient producers are subpopulations.
fof(mp_subpopulations,axiom,(
    ! [E,T] :
      ( ( environment(E)
        & in_environment(E,T) )
     => ( subpopulation(first_movers,E,T)
        & subpopulation(efficient_producers,E,T) ) ) )).

%----MP. An empty group of objects does not decrease in number.
fof(mp_empty_not_decreasing,axiom,(
    ! [S,T] :
      ( cardinality_at_time(S,T) = zero
     => ~ greater(zero,growth_rate(S,T)) ) )).

%----MP. The number of efficient producers is non-negative.
fof(mp_efficient_producers_exist,axiom,(
    ! [E,T] :
      ( ( environment(E)
        & in_environment(E,T) )
     => ( cardinality_at_time(efficient_producers,T) = zero
        | greater(cardinality_at_time(efficient_producers,T),zero) ) ) )).

%----MP. If something is constant, then it does not decreases.
fof(mp_constant_not_decrease,axiom,(
    ! [X] :
      ( constant(X)
     => ~ decreases(X) ) )).

%----MP. on inquality
fof(mp_environment_inequality,axiom,(
    ! [E,T] :
      ( ( environment(E)
        & in_environment(E,T) )
     => ( greater_or_equal(T,appear(an_organisation,E))
        | greater(appear(an_organisation,E),T) ) ) )).

%----A3. Resource availability decreases until equilibrium is reached.
fof(a3,hypothesis,(
    ! [E,T] :
      ( ( environment(E)
        & in_environment(E,T)
        & greater(number_of_organizations(E,T),zero) )
     => ( ( greater(equilibrium(E),T)
         => decreases(resources(E,T)) )
        & ( ~ greater(equilibrium(E),T)
         => constant(resources(E,T)) ) ) ) )).

%----A1. The environment has a positive carrying capacity
fof(a1,hypothesis,(
    ! [E,T] :
      ( ( environment(E)
        & in_environment(E,T)
        & greater_or_equal(T,appear(an_organisation,E)) )
     => greater(number_of_organizations(E,T),zero) ) )).

%----A6. If resource availability decreases, then the number of
%----organizations increases or constant.
fof(a6,hypothesis,(
    ! [E,T] :
      ( ( environment(E)
        & in_environment(E,T) )
     => ( ( decreases(resources(E,T))
         => ~ decreases(number_of_organizations(E,T)) )
        & ( constant(resources(E,T))
         => constant(number_of_organizations(E,T)) ) ) ) )).

%----A12. If a subpopulation does not decrease in members, then a more
%----resilient subpopulation does not decrease either.
fof(a12,hypothesis,(
    ! [E,S1,S2,T] :
      ( ( environment(E)
        & in_environment(E,T)
        & ~ greater(zero,growth_rate(S1,T))
        & greater(resilience(S2),resilience(S1)) )
     => ~ greater(zero,growth_rate(S2,T)) ) )).

%----A2. Efficient producers are more resilient than first movers.
fof(a2,hypothesis,(
    greater(resilience(efficient_producers),resilience(first_movers)) )).

%----A9. The population contains only first movers and efficient producers.
fof(a9,hypothesis,(
    ! [E,X,T] :
      ( ( environment(E)
        & subpopulation(X,E,T)
        & greater(cardinality_at_time(X,T),zero) )
     => ( X = efficient_producers
        | X = first_movers ) ) )).

%----GOAL: T6. Once appeared in an environment, efficient producers do not
%----disappear.
fof(prove_t6,conjecture,(
    ! [E,T] :
      ( ( environment(E)
        & in_environment(E,T)
        & greater_or_equal(T,appear(efficient_producers,E)) )
     => greater(cardinality_at_time(efficient_producers,T),zero) ) )).

%--------------------------------------------------------------------------
