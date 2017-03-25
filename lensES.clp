;;*******************************
;; FACTS, TEMPLATES AND FUNCTIONS
;;*******************************
(defmodule MAIN (export ?ALL))

(deftemplate MAIN::attribute 
	(slot name)
	(slot value)
	(slot certainty (default 100) (range 0 100))
)

(deftemplate MAIN::question
   (slot attribute (default ?NONE))
   (slot text (default ?NONE))
   (multislot answers (default ?NONE))
   (slot already-asked (default FALSE))
   (slot ready-to-ask (default FALSE))
   (multislot precursors (default ?DERIVE))
   (slot priority (default LOW))
   (slot why)
)

(deftemplate MAIN::answer-list
	(slot id (default none))
	(slot question)
	(slot answer)
)

(deftemplate MAIN::qst
	(slot loop (default TRUE))
)

(deftemplate MAIN::retract
	(slot print (default FALSE))
)

(deftemplate MAIN::answered-id-list
	(multislot id)
)

(deftemplate MAIN::why-explaination
	(slot question)
	(slot explaination)
)

(deftemplate MAIN::info-explaination
	(slot question)
	(slot explaination)
)

(deftemplate MAIN::explaination
	(slot explained-question)
	(slot question)
	(slot answer)
	(slot certainty)
)

(deftemplate MAIN::precursor-trace
	(slot question)
	(multislot precursors)
	(slot retract-it (default FALSE))
)

(deftemplate MAIN::def-rule
	(multislot if)
	(multislot then)
)

(deftemplate MAIN::rule
  (slot certainty (default 100))
  (multislot if)
  (multislot then)
)

(deftemplate MAIN::lens
	(slot nome (default ?NONE))
	(slot lunghezza-focale (type INTEGER))
	(slot categoria-focale )
	(slot serie-lente (allowed-symbols ef-s ef ts-e mp-e))
	(slot af (allowed-symbols indefinito no usm stm))
	(slot apertura-diaframma (allowed-symbols stretta normale ampia))
	(slot macro (allowed-symbols true false))
	(slot peso (allowed-symbols leggero pesante))
	(slot serie-l (allowed-symbols si no))
	(slot stabilizzato (allowed-symbols true false))
	(slot dimensioni (allowed-symbols pancake piccolo medio grande molto-grande))
	(slot fascia-prezzo (allowed-symbols bassa media alta))
)

(deffunction MAIN::print-why-explaination (?q)
	(do-for-all-facts ((?p question)) (eq ?q ?p:text) (printout t ?p:why crlf))
)

(deffunction MAIN::print-how-explaination (?question)
	(do-for-all-facts ((?p precursor-trace)) (and(neq ?p:precursors nil)(eq ?p:question ?question)) (printout t "Ti poniamo questa domanda perche' sappiamo che:" crlf)) 
	(do-for-all-facts ((?p explaination)) (eq ?question ?p:explained-question) (printout t "- Alla domanda: " ?p:question ", hai risposto: " ?p:answer crlf))
)

(deffunction MAIN::print-info-explaination (?question)
	(do-for-all-facts ((?p info-explaination)) (eq ?question ?p:question) (printout t ?p:explaination crlf))
)

(deffunction MAIN::ask-initial-question (?question ?allowed-values)
   (printout t crlf "Risposte ammesse: " ?allowed-values "(WHY,HOW,INFO)" crlf ?question crlf "> ")
   (bind ?answer (read))
   (if (lexemep ?answer) then (bind ?answer (lowcase ?answer)))
   (if (eq ?answer why) then (print-why-explaination ?question))
   (if (eq ?answer how) then (print-how-explaination ?question))
   (if (eq ?answer info) then (print-info-explaination ?question))
   (while (not (member ?answer ?allowed-values)) do
      (printout t crlf "Risposte ammesse: " ?allowed-values " (WHY,HOW,INFO)" crlf ?question crlf "> ")
      (bind ?answer (read))
      (if (lexemep ?answer) then (bind ?answer (lowcase ?answer)))
	   (if (eq ?answer why) then (print-why-explaination ?question))
	   (if (eq ?answer how) then (print-how-explaination ?question))
	   (if (eq ?answer info) then (print-info-explaination ?question))
	)
   ?answer
)

(deffunction MAIN::ask-question (?question ?allowed-values)
   (printout t crlf "Risposte ammesse: " ?allowed-values ", (ns: non lo so,WHY,HOW,INFO,[0-100]:certezza della risposta)" crlf ?question crlf "> ")
   (bind ?answer (read))
   (if (lexemep ?answer) then (bind ?answer (lowcase ?answer)))
   (if (eq ?answer why) then (print-why-explaination ?question))
   (if (eq ?answer how) then (print-how-explaination ?question))
   (if (eq ?answer info) then (print-info-explaination ?question))
   (while (not (if (lexemep ?answer) then (member ?answer ?allowed-values) else (and (>= ?answer 0)(<= ?answer 100)))) do
      (printout t crlf "Risposte ammesse: " ?allowed-values ", (ns: non lo so,WHY,HOW,INFO,[0-100]:certezza della risposta)" crlf ?question crlf "> ")
      (bind ?answer (read))
      (if (lexemep ?answer) then (bind ?answer (lowcase ?answer)))
	   (if (eq ?answer why) then (print-why-explaination ?question))
	   (if (eq ?answer how) then (print-how-explaination ?question))
	   (if (eq ?answer info) then (print-info-explaination ?question))
	)
   ?answer
)


;meno domande, non in ordine randomico - OK
	;domande sempre più specifiche - OK
;rimuovere la certainty dalle domande iniziali - OK
;aggiungere il non-lo-so - OK
;togliere java - OK
;why,how,info. l'how attuale è info, il why attuale è l'help - OK, scrivere la lista
;far visualizzare gli obiettivi prima della ritrattazione - OK
;creare funzioni custom su C - OK


;;*********************
;; The QUESTIONS module
;;*********************

(defmodule QUESTIONS (import MAIN ?ALL)(export ?ALL))

(defrule QUESTIONS::reinit-qst-loop
	?f <- (retract (print TRUE))
	?x <- (qst (loop FALSE))
	=>
	(modify ?f (print FALSE))
	(modify ?x (loop TRUE))
)

(defrule QUESTIONS::generate-trace
	(declare (salience 10))
	(question (text ?question)(precursors $?precursors))
	(not (precursor-trace (question ?question)))
	=>
	(assert (precursor-trace (question ?question)(precursors ?precursors)))
)

(defrule QUESTIONS::prevent-duplicate-questions
	(declare (salience 100))
	?x <- (question (ready-to-ask TRUE)(already-asked FALSE) (attribute ?the-attribute)(text ?question))
	?y <- (question (ready-to-ask FALSE)(already-asked FALSE)(attribute ?the-attribute)(text ?question))
	=>
	(modify ?y (ready-to-ask FALSE)(already-asked TRUE))
)

(defrule QUESTIONS::kill-questions-with-defined-attribute
	(declare (salience 100))
	?x <- (question (already-asked FALSE)(attribute ?the-attribute))
	(attribute (name ?the-attribute))
	=>
	(modify ?x (ready-to-ask FALSE)(already-asked TRUE))
)

(defrule QUESTIONS::ready-to-ask-a-question
	(declare (salience 10))
	?q <- (question (already-asked FALSE)(precursors )(ready-to-ask FALSE)(text ?t))
	=>
	(modify ?q (ready-to-ask TRUE))
)

(defrule QUESTIONS::don-t-know-attribute
	(declare (salience 10))
	?a <- (attribute (name ?name) (value ns) (certainty ?c))
	=>
	(retract ?a)
	(assert (attribute (name ?name) (value si) (certainty (/ ?c 2))))
	(assert (attribute (name ?name) (value no) (certainty (- 100 (/ ?c 2)))))
	(focus RULES QUESTIONS RULES)
)

(defrule QUESTIONS::precursor-is-satisfied
   ?q <- (question (already-asked FALSE) (precursors ?name is ?value $?rest)(text ?qst))
   (attribute (name ?name) (value ?value) (certainty ?certainty))
   =>
    (if (eq (nth 1 ?rest) and) 
		then (modify ?q (precursors (rest$ ?rest)))
		else (modify ?q (precursors ?rest)))
	(do-for-all-facts ((?v question)) (and (eq ?v:attribute ?name)(eq ?v:already-asked TRUE)) (bind ?question ?v:text))  
	(do-for-all-facts ((?z question)(?r def-rule)) (and (member ?z:attribute ?r:if)(member ?name ?r:then)) (bind ?question ?z:text))
	(assert (explaination (explained-question ?qst)(question ?question)(answer ?value)(certainty ?certainty)))
)

(defrule QUESTIONS::precursor-is-not-satisfied
   ?f <- (question (text ?qst)(already-asked FALSE)(precursors ?name is-not ?value $?rest))
   (attribute (name ?name) (value ~?value) (certainty ?certainty))
   =>
   (if (eq (nth 1 ?rest) and) 
		then (modify ?f (precursors (rest$ ?rest)))
		else (modify ?f (precursors ?rest))
	)
	(do-for-all-facts ((?v question)) (and (eq ?v:attribute ?name)(eq ?v:already-asked TRUE)) (bind ?question ?v:text)) 
	(do-for-all-facts ((?z question)(?r def-rule)) (and (member ?z:attribute ?r:if)(member ?name ?r:then)) (bind ?question ?z:text))
	(assert (explaination (explained-question ?qst)(question ?question)(answer ?value)(certainty ?certainty)))
)
 
(defrule QUESTIONS::ask-initial-question
	(declare (salience -10))
    ?f <- (question 
				   (ready-to-ask TRUE)
                   (text ?question)
                   (attribute ?the-attribute)
                   (answers $?valid-answers)
				   (priority HIGH)
			)
	?x <- (answered-id-list (id $?id-list))
    =>
	(modify ?f (already-asked TRUE)(ready-to-ask FALSE))
	(bind ?answer (ask-initial-question ?question ?valid-answers))
	(bind ?y (fact-index (assert (attribute (name ?the-attribute) (value ?answer)))))
	(assert (answer-list (id ?y)(question ?question)(answer ?answer)))
	(modify ?x (id (create$ ?id-list ?y)))
	(focus RULES QUESTIONS)
)

(defrule QUESTIONS::ask-a-question
	(declare (salience -100))
    ?f <- (question 
				   (ready-to-ask TRUE)
                   (text ?question)
                   (attribute ?the-attribute)
                   (answers $?valid-answers)
				   (priority LOW)
			)
	?x <- (answered-id-list (id $?id-list))
    =>
	(modify ?f (already-asked TRUE)(ready-to-ask FALSE))
	(bind ?answer (ask-question ?question ?valid-answers))
	(if (lexemep ?answer)
	then (bind ?y (fact-index (assert (attribute (name ?the-attribute) (value ?answer)))))
	else (if (> ?answer 30) 
			then (bind ?y (fact-index (assert (attribute (name ?the-attribute) (value si) (certainty ?answer)))))
			else (bind ?y (fact-index (assert (attribute (name ?the-attribute) (value ns) (certainty (* ?answer 2))))))
		  )
	)
	(assert (answer-list (id ?y)(question ?question)(answer ?answer)))
	(modify ?x (id (create$ ?id-list ?y)))
	(focus RULES QUESTIONS)
)

(defrule QUESTIONS::depth-strategy
	(not (question (ready-to-ask TRUE) (priority HIGH)))
	=>
	(set-strategy lex)
)

(defrule QUESTIONS::questions-finished
	(declare (salience -100))
	?f <- (qst (loop TRUE))
	(not (question (ready-to-ask TRUE)))
	(answer-list )
	=>
	(modify ?f (loop FALSE))
	(focus MAIN)
)

;;******************
;; The RULES module
;;******************

(defmodule RULES (import MAIN ?ALL) (import QUESTIONS ?ALL)(export ?ALL))

(defrule RULES::throw-away-ands-in-antecedent
  ?f <- (rule (if and $?rest))
  =>
  (modify ?f (if ?rest))
)

(defrule RULES::throw-away-ands-in-consequent
  ?f <- (rule (then and $?rest))
  =>
  (modify ?f (then ?rest))
)

(defrule RULES::remove-is-condition-when-satisfied
  ?f <- (rule (certainty ?c1) 
              (if ?attribute is ?value $?rest))
  (attribute (name ?attribute) 
             (value ?value) 
             (certainty ?c2))
  => 
  (modify ?f (certainty (min ?c1 ?c2)) (if ?rest))
)

(defrule RULES::perform-rule-consequent-with-certainty
  ?f <- (rule (certainty ?c1) 
              (if) 
              (then ?attribute is ?value with certainty ?c2 $?rest))
  =>
   (modify ?f (then ?rest))
   (assert (attribute (name ?attribute) 
                     (value ?value)
                     (certainty (/ (* ?c1 ?c2) 100))))  
)

(defrule RULES::perform-rule-consequent-without-certainty
  ?f <- (rule (certainty ?c1)
              (if)
              (then ?attribute is ?value $?rest))
  (test (or (eq (length$ ?rest) 0)
            (neq (nth 1 ?rest) with)))
  =>
  (modify ?f (then ?rest))
  (assert (attribute (name ?attribute) (value ?value) (certainty ?c1)))
)

(defrule RULES::combine-certainties
  ?rem1 <- (attribute (name ?rel) (value ?val) (certainty ?per1))
  ?rem2 <- (attribute (name ?rel) (value ?val) (certainty ?per2))
  (test (neq ?rem1 ?rem2))
  =>
  (retract ?rem1)
  (modify ?rem2 (certainty (/ (+ (/ (- (* 100 (+ ?per1 ?per2)) (* ?per1 ?per2)) 100) (/ (+ ?per1 ?per2) 2)) 2)))
;  (modify ?rem2 (certainty (/ (+ ?per1 ?per2) 2)))

)

(defrule RULES::aps-c
	(declare (salience 10))
	(attribute (name sensore-aps-c) (value si))
	(qst (loop TRUE))
	=>
	(do-for-all-facts ((?l lens)) (eq ?l:categoria-focale nil) (modify ?l (categoria-focale (focalength ?l:lunghezza-focale "aps-c"))))
)

(defrule RULES::aps-h
	(declare (salience 10))
	(attribute (name sensore-aps-h) (value si))
	(qst (loop TRUE))
	=>
	(do-for-all-facts ((?l lens)) (eq ?l:categoria-focale nil) (modify ?l (categoria-focale (focalength ?l:lunghezza-focale "aps-h"))))
)

(defrule RULES::full-frame
	(declare (salience 10))
	(attribute (name sensore-full-frame) (value si))
	(qst (loop TRUE))
	=>
	(do-for-all-facts ((?l lens)) (eq ?l:categoria-focale nil) (modify ?l (categoria-focale (focalength ?l:lunghezza-focale "full-frame"))))
)

(defrule RULES::alternate
	(rule )
	=>
	(focus RULES QUESTIONS RULES)
)

;;******************
;; The RETRACT module
;;******************

(defmodule RETRACT (import MAIN ?ALL)(export ?ALL))

(deffunction RETRACT::question-retract-chaining
	(?attribute)
	(do-for-all-facts ((?q question)(?p precursor-trace)) (and (member$ ?attribute ?p:precursors)(eq ?p:question ?q:text)(eq ?q:already-asked TRUE))
	(modify ?p (retract-it TRUE))(question-retract-chaining ?q:attribute))
)

(deffunction RETRACT::print-retract-process ()
   (printout t crlf)
   (printout t "****************************************************************************************"crlf)
   (printout t "*                                CRONOLOGIA RISPOSTE                                   *"crlf)
   (printout t "****************************************************************************************"crlf) 
   (do-for-all-facts ((?p answer-list)) TRUE (printout t ?p:id ". Domanda:  " ?p:question " -> " ?p:answer crlf))
   (printout t "Indica la domanda da ritrattare tramite il relativo id o esci dal programma (exit): " crlf ">")
   (bind ?answer (read))
   (if (lexemep ?answer) then (bind ?answer (lowcase ?answer)))
   (while (not (member$ ?answer (fact-slot-value (nth 1 (find-fact ((?p answered-id-list)) TRUE)) id))) do
	  (printout t crlf)
	  (printout t "****************************************************************************************"crlf)
	  (printout t "*                                CRONOLOGIA RISPOSTE                                   *"crlf)
	  (printout t "****************************************************************************************"crlf) 
	  (do-for-all-facts ((?p answer-list)) TRUE (printout t ?p:id ". Domanda:  " ?p:question " -> " ?p:answer crlf))
	  (printout t "Indica la domanda da ritrattare tramite il relativo id o esci dal programma (exit): " crlf ">")
      (bind ?answer (read))
      (if (lexemep ?answer) then (bind ?answer (lowcase ?answer)))
	)
   ?answer
)

(defrule RETRACT::begin-retract-process
	?r <- (retract (print TRUE))
	=>
	(bind ?answer (print-retract-process ))
	(if (eq ?answer exit) 
	then (focus LENS)
	else (do-for-all-facts ((?p precursor-trace)(?q answer-list)) (and (eq ?answer ?q:id) (eq ?p:question ?q:question)) (modify ?p (retract-it TRUE)))
			(do-for-all-facts ((?l lens)) (neq ?l:categoria-focale nil) (modify ?l (categoria-focale nil)))
			(do-for-all-facts ((?r rule)) TRUE (retract ?r))
			(do-for-all-facts ((?d def-rule)) TRUE (assert (rule (certainty 100) (if ?d:if) (then ?d:then))))
			(do-for-all-facts ((?a attribute)) (or (eq ?a:name categoria-focale)(eq ?a:name serie-lente)(eq ?a:name af)(eq ?a:name apertura-diaframma)(eq ?a:name macro)(eq ?a:name peso)(eq ?a:name serie-l)(eq ?a:name stabilizzato)(eq ?a:name dimensioni)(eq ?a:name fascia-prezzo)) (retract ?a))
	)
)

(deffunction restore-precursors-in-non-asked-questions
	(?attribute)
	(do-for-all-facts ((?qq question)(?pp precursor-trace)) (and(member ?attribute ?pp:precursors)(eq ?qq:text ?pp:question)(neq ?qq:precursors ?pp:precursors)) 
		(modify ?qq (precursors ?pp:precursors)))
	
)

(deffunction retract-post-rule-questions 
	(?attribute)
	(do-for-all-facts ((?qq question)(?a attribute)) (and(eq ?qq:attribute ?attribute)(eq ?a:name ?attribute)) 
		(modify ?qq (already-asked FALSE)(ready-to-ask FALSE))(restore-precursors-in-non-asked-questions ?a:name)(retract ?a))
	?attribute
)


(defrule RETRACT::retract-question
	(declare (salience 10))
	?p <- (precursor-trace (question ?question)(precursors $?precursors)(retract-it TRUE))
	?x <- (question (text ?question)(attribute ?the-attribute))
	?a <- (answer-list (id ?id)(question ?question))
	?l  <- (answered-id-list (id $?id-list))
	;?attr <- (attribute (name ?the-attribute))
	=>	
	(progn$ (?field ?id-list) (if (eq ?field ?id) then (delete$ ?id-list ?field-index ?field-index)))
	(retract ?a)
	(modify ?x (precursors ?precursors)(already-asked FALSE)(ready-to-ask FALSE))
	(modify ?p (retract-it FALSE))
	(question-retract-chaining ?the-attribute)
	(do-for-all-facts ((?r def-rule)(?a attribute)) (and(member ?the-attribute ?r:if)(member ?a:name ?r:then)(member ?a:value ?r:then))
		(question-retract-chaining (retract-post-rule-questions ?a:name))(retract ?a))
	(do-for-all-facts ((?a attribute)) (eq ?a:name ?the-attribute) (retract ?a))
)

(defrule RETRACT::trigger-questions
	(declare (salience -10))
	?p <- (precursor-trace (retract-it TRUE))
	=>
	(modify ?p (retract-it FALSE))
)

(defrule RETRACT::restart-questions
	(declare (salience -10))
	(not (precursor-trace (retract-it TRUE)))
	=>
	(focus RULES QUESTIONS RULES)
)

;;******************
;; The LENS module
;;******************

(defmodule LENS (import MAIN ?ALL)(export ?ALL))

(defrule LENS::assert-best-matches
	(declare (salience 10))
	(lens 
		(nome ?name)
		(categoria-focale ?cf)
		(serie-lente ?sl)
		(af ?af)
		(apertura-diaframma ?ad)
		(macro ?m)
		(peso ?p)
		(serie-l ?s)
		(stabilizzato ?st)
		(dimensioni ?d)
		(fascia-prezzo ?fp)
	)
	(attribute (name categoria-focale) (value ?cf) (certainty ?c1))
	(attribute (name serie-lente) (value ?sl) (certainty ?c2))
	(attribute (name af) (value ?af) (certainty ?c3))
	(attribute (name apertura-diaframma) (value ?ad) (certainty ?c4))
	(attribute (name macro) (value ?m) (certainty ?c5))
	(attribute (name peso) (value ?p) (certainty ?c6))
	(attribute (name serie-l) (value ?s) (certainty ?c7))
	(attribute (name stabilizzato) (value ?st) (certainty ?c8))
	(attribute (name dimensioni) (value ?d) (certainty ?c9))
	(attribute (name fascia-prezzo) (value ?fp) (certainty ?c10))
	=>
	(assert (attribute (name best-lens) (value ?name) (certainty (min ?c1 ?c2 ?c3 ?c4 ?c5 ?c6 ?c7 ?c8 ?c9 ?c10))))
)

(deffunction LENS::print-lenses ()
	(do-for-all-facts ((?q attribute)) (eq ?q:name best-lens)
	 (if (> ?q:certainty 0)
		 then 
			(printout t "*************************************************"crlf)
			(format t "OBIETTIVO: %-24s %2.2f%%%n" ?q:value ?q:certainty)
	 )
	)
)

(deffunction LENS::ask-retract
	()
	(printout t crlf "Vuoi visualizzare o modificare le domande a cui hai precedentemente risposto? (Y/N)")
	(bind ?answ (read))
	(if (lexemep ?answ) then (bind ?answ (lowcase ?answ)))
	(while (not (or (eq ?answ y)(eq ?answ n)))
		(printout t crlf "Vuoi visualizzare o modificare le domande a cui hai precedentemente risposto? (Y/N)")
		(bind ?answ (read))
		(if (lexemep ?answ) then (bind ?answ (lowcase ?answ)))
	)
	?answ
)

(defrule LENS::print-best-lens 
	(declare (salience 10))
	(exists (attribute (name best-lens)))
	(retract (print TRUE))
	=>
	(printout t crlf)
	(printout t "*************************************************"crlf)
	(printout t "*                  RISULTATI                    *"crlf)
	(printout t "*************************************************"crlf)
)

(defrule LENS::print-result
	?r <- (attribute (name best-lens) (value ?v) (certainty ?c))
	(not (attribute (name best-lens) (certainty ?c1&:(> ?c1 ?c))))
	=>
	(if (> ?c 0)
		 then 
			(format t "OBIETTIVO: %-24s %2.2f%%%n" ?v ?c)
			(printout t "*************************************************"crlf)
	 )
	 (retract ?r)
)

(defrule LENS::finish
	(declare (salience -10))
	(not (attribute (name best-lens)))
	(retract (print TRUE))
	=>
	;(do-for-all-facts ((?a attribute)) TRUE (printout t ?a:name " " ?a:value " " ?a:certainty " " crlf))
	(if (eq y (ask-retract))
		then (focus RETRACT MAIN)
		else (printout t crlf crlf "Vuoi avviare una nuova sessione (N) o terminare il programma? (any other key)" crlf "> ")
			 (bind ?ans (read))
			 (if (lexemep ?ans) then (bind ?ans (lowcase ?ans)))
			 (if (eq ?ans n) then (reset)(run) else (exit))
	)
)
  
;;******************
;; INITIAL FACTS
;;******************
					
(deffacts initial-facts
	(qst (loop TRUE))
	(retract (print FALSE))
	(answered-id-list (id create$ exit))
)

(deffacts info-explainations
	(info-explaination (question "Il sensore della tua fotocamera e' aps-c? ")
	(explaination "Collegarsi all'URL: http://www.canon.it/support/
	     - Immetti nella barra di ricerca il modello della tua fotocamera.
	     - Aperta la scheda del prodotto, selezionare 'informazioni piu' dettagliate sul prodotto'.
	     - Visitare la sezione 'benefici' e verificare il tipo di sensore.
	     - I tipi di sensore sono: APS-C, APS-H e Full-Frame."
	))
	(info-explaination (question "Il sensore della tua fotocamera e' aps-h? ")
	(explaination "Collegarsi all'URL: http://www.canon.it/support/
	     - Immetti nella barra di ricerca il modello della tua fotocamera.
	     - Aperta la scheda del prodotto, selezionare 'informazioni piu' dettagliate sul prodotto'.
	     - Visitare la sezione 'benefici' e verificare il tipo di sensore.
	     - I tipi di sensore sono: APS-C, APS-H e Full-Frame."
	))
)
	
;;**************
;; The LENS LIST
;;**************

(deffacts lens-list
	(lens (nome "EF-S 24mm f/2.8 STM") (lunghezza-focale 24) (serie-lente ef-s) (af stm) (apertura-diaframma normale) (macro false) (peso leggero) (serie-l no) (stabilizzato false) (dimensioni pancake) (fascia-prezzo bassa))
	(lens (nome "EF-S 60mm f/2.8 Macro USM") (lunghezza-focale 60) (serie-lente ef-s) (af usm) (apertura-diaframma normale) (macro true) (peso leggero) (serie-l no) (stabilizzato false) (dimensioni piccolo) (fascia-prezzo bassa))
	(lens (nome "EF 14mm f/2.8L II USM") (lunghezza-focale 14) (serie-lente ef) (af usm) (apertura-diaframma normale) (macro false) (peso leggero) (serie-l si) (stabilizzato false) (dimensioni piccolo) (fascia-prezzo alta))
	(lens (nome "EF 20mm f/2.8 USM") (lunghezza-focale 20) (serie-lente ef) (af usm) (apertura-diaframma normale) (macro false) (peso leggero) (serie-l no) (stabilizzato false) (dimensioni piccolo) (fascia-prezzo bassa))
	(lens (nome "EF 24mm f/1.4L II USM") (lunghezza-focale 24) (serie-lente ef) (af usm) (apertura-diaframma ampia) (macro false) (peso leggero) (serie-l si) (stabilizzato true) (dimensioni piccolo) (fascia-prezzo media))
	(lens (nome "EF 24mm f/2.8 IS USM") (lunghezza-focale 24) (serie-lente ef) (af usm) (apertura-diaframma normale) (macro false) (peso leggero) (serie-l no) (stabilizzato true) (dimensioni piccolo) (fascia-prezzo bassa))
	(lens (nome "EF 28mm f/1.8 USM") (lunghezza-focale 28) (serie-lente ef) (af usm) (apertura-diaframma ampia) (macro false) (peso leggero) (serie-l no) (stabilizzato false) (dimensioni piccolo) (fascia-prezzo bassa))
	(lens (nome "EF 28mm f/2.8 IS USM") (lunghezza-focale 28) (serie-lente ef) (af usm) (apertura-diaframma normale) (macro false) (peso leggero) (serie-l no) (stabilizzato true) (dimensioni piccolo) (fascia-prezzo bassa))
	(lens (nome "EF 35mm f/1.4L II USM") (lunghezza-focale 35) (serie-lente ef) (af usm) (apertura-diaframma ampia) (macro false) (peso leggero) (serie-l si) (stabilizzato false) (dimensioni medio) (fascia-prezzo alta))
	(lens (nome "EF 35mm f/2.0 IS USM") (lunghezza-focale 35) (serie-lente ef) (af usm) (apertura-diaframma normale) (macro false) (peso leggero) (serie-l no) (stabilizzato false) (dimensioni piccolo) (fascia-prezzo bassa))
	(lens (nome "EF 40mm f/2.8 STM") (lunghezza-focale 40) (serie-lente ef) (af stm) (apertura-diaframma normale) (macro false) (peso leggero) (serie-l no) (stabilizzato false) (dimensioni pancake) (fascia-prezzo bassa))
	(lens (nome "EF 50mm f/1.8 STM") (lunghezza-focale 50) (serie-lente ef) (af stm) (apertura-diaframma ampia) (macro false) (peso leggero) (serie-l no) (stabilizzato false) (dimensioni piccolo) (fascia-prezzo bassa))
	(lens (nome "EF 50mm f/1.4 USM") (lunghezza-focale 50) (serie-lente ef) (af usm) (apertura-diaframma ampia) (macro false) (peso leggero) (serie-l no) (stabilizzato false) (dimensioni piccolo) (fascia-prezzo bassa))
	(lens (nome "EF 50mm f/1.2L USM") (lunghezza-focale 50) (serie-lente ef) (af usm) (apertura-diaframma ampia) (macro false) (peso leggero) (serie-l si) (stabilizzato false) (dimensioni piccolo) (fascia-prezzo media))
	(lens (nome "EF 85mm f/1.8 USM") (lunghezza-focale 85) (serie-lente ef) (af usm) (apertura-diaframma ampia) (macro false) (peso leggero) (serie-l no) (stabilizzato false) (dimensioni piccolo) (fascia-prezzo bassa))
	(lens (nome "EF 85mm f/1.2L II USM") (lunghezza-focale 85) (serie-lente ef) (af usm) (apertura-diaframma ampia) (macro false) (peso pesante) (serie-l no) (stabilizzato false) (dimensioni medio) (fascia-prezzo alta))
	(lens (nome "EF 100mm f/2.0 USM") (lunghezza-focale 100) (serie-lente ef) (af usm) (apertura-diaframma normale) (macro false) (peso leggero) (serie-l no) (stabilizzato false) (dimensioni piccolo) (fascia-prezzo bassa))
	(lens (nome "EF 100mm f/2.8 Macro USM") (lunghezza-focale 100) (serie-lente ef) (af usm) (apertura-diaframma normale) (macro true) (peso leggero) (serie-l no) (stabilizzato false) (dimensioni medio) (fascia-prezzo bassa))
	(lens (nome "EF 100mm f/2.8L Macro IS USM") (lunghezza-focale 100) (serie-lente ef) (af usm) (apertura-diaframma normale) (macro true) (peso leggero) (serie-l si) (stabilizzato true) (dimensioni medio) (fascia-prezzo media))
	(lens (nome "EF 135mm f/2.0L USM") (lunghezza-focale 135) (serie-lente ef) (af usm) (apertura-diaframma ampia) (macro false) (peso leggero) (serie-l si) (stabilizzato false) (dimensioni medio) (fascia-prezzo media))
	(lens (nome "EF 200mm f/2.0L IS USM") (lunghezza-focale 200) (serie-lente ef) (af usm) (apertura-diaframma ampia) (macro false) (peso pesante) (serie-l si) (stabilizzato true) (dimensioni grande) (fascia-prezzo alta))
	(lens (nome "EF 200mm f/2.8L II USM") (lunghezza-focale 200) (serie-lente ef) (af usm) (apertura-diaframma ampia) (macro false) (peso leggero) (serie-l si) (stabilizzato false) (dimensioni medio) (fascia-prezzo media))
	(lens (nome "EF 300mm f/2.8L IS II USM") (lunghezza-focale 300) (serie-lente ef) (af usm) (apertura-diaframma ampia) (macro false) (peso pesante) (serie-l si) (stabilizzato true) (dimensioni grande) (fascia-prezzo alta))
	(lens (nome "EF 300mm f/4.0L IS USM") (lunghezza-focale 300) (serie-lente ef) (af usm) (apertura-diaframma normale) (macro false) (peso pesante) (serie-l si) (stabilizzato true) (dimensioni grande) (fascia-prezzo media))
	(lens (nome "EF 400mm f/2.8L IS II USM") (lunghezza-focale 400) (serie-lente ef) (af usm) (apertura-diaframma ampia) (macro false) (peso pesante) (serie-l si) (stabilizzato true) (dimensioni molto-grande) (fascia-prezzo alta))
	(lens (nome "EF 400mm f/4.0 DO IS II USM") (lunghezza-focale 400) (serie-lente ef) (af usm) (apertura-diaframma normale) (macro false) (peso pesante) (serie-l no) (stabilizzato true) (dimensioni grande) (fascia-prezzo alta))
	(lens (nome "EF 400mm f/5.6L USM") (lunghezza-focale 400) (serie-lente ef) (af usm) (apertura-diaframma stretta) (macro false) (peso pesante) (serie-l si) (stabilizzato false) (dimensioni grande) (fascia-prezzo media))
	(lens (nome "EF 500mm f/4.0L IS II USM") (lunghezza-focale 500) (serie-lente ef) (af usm) (apertura-diaframma normale) (macro false) (peso pesante) (serie-l si) (stabilizzato true) (dimensioni molto-grande) (fascia-prezzo alta))
	(lens (nome "EF 600mm f/4.0L IS II USM") (lunghezza-focale 600) (serie-lente ef) (af usm) (apertura-diaframma normale) (macro false) (peso pesante) (serie-l si) (stabilizzato true) (dimensioni molto-grande) (fascia-prezzo alta))
	(lens (nome "EF 800mm f/5.6L IS USM") (lunghezza-focale 800) (serie-lente ef) (af usm) (apertura-diaframma stretta) (macro false) (peso pesante) (serie-l si) (stabilizzato true) (dimensioni molto-grande) (fascia-prezzo alta))
	(lens (nome "EF 50mm f/2.5 Compact Macro") (lunghezza-focale 50) (serie-lente ef) (af indefinito) (apertura-diaframma normale) (macro true) (peso leggero) (serie-l no) (stabilizzato false) (dimensioni piccolo) (fascia-prezzo bassa))
	(lens (nome "EF 180mm f/3.5L Macro USM") (lunghezza-focale 180) (serie-lente ef) (af usm) (apertura-diaframma normale) (macro true) (peso pesante) (serie-l si) (stabilizzato false) (dimensioni medio) (fascia-prezzo media))
	(lens (nome "MP-E 65mm f/2.8 1-5x Macro Photo") (lunghezza-focale 65) (serie-lente mp-e) (af no) (apertura-diaframma normale) (macro true) (peso leggero) (serie-l no) (stabilizzato false) (dimensioni piccolo) (fascia-prezzo media))
	(lens (nome "TS-E 17mm f/4L") (lunghezza-focale 17) (serie-lente ts-e) (af no) (apertura-diaframma stretta) (macro false) (peso pesante) (serie-l si) (stabilizzato false) (dimensioni medio) (fascia-prezzo alta))
	(lens (nome "TS-E 24mm f/3.5L II") (lunghezza-focale 24) (serie-lente ts-e) (af no) (apertura-diaframma stretta) (macro false) (peso leggero) (serie-l si) (stabilizzato false) (dimensioni medio) (fascia-prezzo media))
	(lens (nome "TS-E 45mm f/2.8") (lunghezza-focale 45) (serie-lente ts-e) (af no) (apertura-diaframma normale) (macro false) (peso leggero) (serie-l no) (stabilizzato false) (dimensioni piccolo) (fascia-prezzo media))
	(lens (nome "TS-E 90mm f/2.8") (lunghezza-focale 90) (serie-lente ts-e) (af no) (apertura-diaframma normale) (macro false) (peso leggero) (serie-l no) (stabilizzato false) (dimensioni piccolo) (fascia-prezzo media))	
)

(defrule MAIN::gen-rules
	(declare (salience 10))
	(def-rule (if $?if) (then $?then))
	=>
	(assert (rule (certainty 100) (if ?if) (then ?then)))
)

(defrule MAIN::focus-r
(declare (salience 10))
	(qst (loop FALSE))
	?x <- (retract (print FALSE))
	=>
	(modify ?x (print TRUE))
	(focus LENS RULES)
)

(defrule MAIN::start
	=>
	(focus QUESTIONS RULES)
	(set-strategy random)
	(printout t "****************************************************************************************"crlf)
	(printout t "*                                 LENS Expert System                                   *"crlf)
	(printout t "****************************************************************************************"crlf) 
)