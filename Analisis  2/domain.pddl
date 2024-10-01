(define (domain concordia)
(:requirements ::typing )
(:fluents :equality :conditional-effects)
(:types
    recurso carta ciudad colono  - object
)
(:constants
    Madrid Paris  -ciudad
    Seda Jarron Ladrillo Trigo Metal - recurso
    Tribuno Arquitecto Colonizador Senador Consul Mercader Especialista Prefecto - carta
    Colono1
)
(:functions
    (dinero_j ?d) ;puede sobrar ?d
    (coste_casa ?r - recurso ?coste dinero_j)
    (tiene_recurso ?r - recurso) ;preguntar lo de la cantidad

)
(:predicates
    (mano ?carta - carta)
    (tiene_casa_en_c ?ciudad - ciudad)
    (colono_en_c ?ciudad - ciudad ?colono - colono);que hacer con colono
    (c_adyacente_a_c ?ciudad1 ?ciudad2 - ciudad)
    (carta_en_tienda ?carta - carta)
    (tipo_carta ?carta - carta ?tipo)
    (coste_colono ?r - recurso)
    (coste_carta ?r - recurso)
    (ciudad_produccion ?ciudad - ciudad ?r - recurso)
    (ciudad_explotada ?ciudad - ciudad)
    (ciudad_ocupada_co ?ciudad - ciudad)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;colonizador
(:action colonizador_recibir
    :parameters (?c - carta )
    :precondition (and
                    (= ?c Colonizador) 
                    (mano ?c)
                )
    :effect (and
                (increase (dinero_j ?d) 5)
                (not(mano ?c))
            )
)

(:action colonizador_comprar
    :parameters (?c - carta )
    :precondition (and
                    (= ?c Colonizador) 
                    (mano ?c)
                )
    :effect (and
                (increase (dinero_j ?d) 5)
                (not(mano ?c))
            )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;prefecto
(:action prefecto_explotar
    :parameters (?c - carta ?ciudad - ciudad ?r - recurso)
    :precondition (and
                    (= ?c Prefecto)
                    (mano ?c)
                    (not(ciudad_explotada ?ciudad))
                )
    :effect (and
            (ciudad_produccion ?ciudad ?r)
            (ciudad_explotada ?ciudad)
            (not(mano ?c))
            (tiene_recurso ?r)
            )
)

(:action prefecto_anular
    :parameters (?c - carta ?ciudad - ciudad)
    :precondition (and
                    (= ?c Prefecto)
                    (mano ?c)
                    (ciudad_explotada ?ciudad)
                )
    :effect (and
            (not(ciudad_explotada ?ciudad))
            (not(mano ?c))
            (increase (dinero_j ?d) 1)
            )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;tribuno

(:action tribuno
    :parameters (?c - carta)
    :precondition (and
                
                )
    :effect (and 
            
            )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;arquitecto

(:action arquitecto_mover
    :parameters (?c - carta ?colono - colono ?ciudad1 ?ciudad2 - ciudad)
    :precondition (and
                    (= ?c Arquitecto)
                    (mano ?c)
                    (colono_en_c ?ciudad1 ?colono)
                    (c_adyacente_a_c ?ciudad1 ?ciudad2)
                    (not(ciudad_ocupada_co ?ciudad2))
                )
    :effect (and
            (colono_en_c ?ciudad2 ?colono)
            (not(colono_en_c ?ciudad1 ?colono))
            (not(ciudad_ocupada_co ?ciudad1))
            (ciudad_ocupada_co ?ciudad2)
            (not(mano ?c))
            )
)

(:action arquitecto_construir ;falta coste
    :parameters (?c - carta ?ciudad - ciudad ?colono - colono)
    :precondition (and
                    (= ?c Arquitecto)
                    (mano ?c)
                    (colono_en_c ?ciudad ?colono)
                    )
    :effect (and
            
            (tiene_casa_en_c ?ciudad)
            (not(mano ?c))
            )
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;especialista

(:action especialista
    :parameters (?c - carta ?ciudad - ciudad ?r -recurso)
    :precondition (and
                    (= ?c Especialista)
                    (mano ?c)
                    (tiene_casa_en_c ?ciudad)
                    (ciudad_produccion ?ciudad ?r);dudas con esto
                    )
    :effect (and
            (tiene_recurso ?r)
            (not(mano ?c))
            )
)

)