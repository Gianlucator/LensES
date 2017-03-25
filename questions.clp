;;******************
;; AMATEUR QUESTIONS
;;******************
					
(deffacts question-list
	
	;INIZIALI
	; spiegazioni con domande, risposte. 
	; ritrattazione finale
	; nella risposta inserire il livello di certezza
	; profilazione
	
	(question 
		(attribute ha-canon)  
		(text "Possiedi gia' una fotocamera reflex canon? ")
		(why "Sapere se sei in possesso di una reflex Canon mi aiutera a capire che tipo di utente sei")
		(answers si no)
		(priority HIGH)
	)
	(question 
		(attribute ha-avuto-reflex)  
		(text "Possiedi o hai posseduto una reflex di un altro marchio?")
		(answers si no)
		(precursors ha-canon is no)
		(priority HIGH)
		(why "Sapere se hai gia' avuto una reflex in passato mi aiutera' a comprendere il tuo livello di esperienza")
	)
	(question 
		(attribute professionista)  
		(text "Sei un professionista? ")
		(answers si no)
		(precursors ha-canon is si)
		(priority HIGH)
		(why "Comprendere se sei un professionista mi aiutera' a filtrare i risultati prediligendo lenti di maggiore qualita'")

	)
	(question 
		(attribute ex-reflex-professionista)  
		(text "Sei un professionista?  ")
		(answers si no)
		(precursors ha-avuto-reflex is si)
		(priority HIGH)
		(why "Comprendere se sei un professionista mi aiutera' a filtrare i risultati prediligendo lenti di maggiore qualita'")

	)
	(question 
		(attribute sensore-aps-c)  
		(text "Il sensore della tua fotocamera e' aps-c? ")
		(answers si no)
		(precursors ha-canon is si)
		(priority HIGH)
		(why "La dimensione del sensore aps-c modifica la lunghezza focale dell'obiettivo percepita dal sensore del 160%")
	)
	(question 
		(attribute sensore-aps-h)
		(text "Il sensore della tua fotocamera e' aps-h? ")
		(precursors sensore-aps-c is no)
		(answers si no)
		(priority HIGH)
		(why "La dimensione del sensore aps-c modifica la lunghezza focale dell'obiettivo percepita dal sensore del 124%")
	)
	(question
		(attribute meno-di-2000)
		(text "Preferiresti spendere sicuramente meno di 2000 euro? ")
		(answers si no)
		(priority HIGH)
		(why "Pongo questa domanda per filtrare i risultati in relazione al budget che hai a disposizione")
	)
	(question
		(attribute meno-di-750)
		(text "Preferiresti spendere sicuramente meno di 750 euro? ")
		(precursors meno-di-2000 is si)
		(answers si no)
		(priority HIGH)
		(why "Pongo questa domanda per filtrare i risultati in relazione al budget che hai a disposizione")

	)
	(question 
		(attribute ha-monopiede)  
		(text "Intendi usare un monopiede o un treppiede? ")
		(answers si no)
		(priority HIGH)
		(why "Sapere se hai intenzione di usare un monopiede includera' tra i risultati anche obiettivi di dimensione maggiore")
	)
	
	
	;CURIOUS
	
	(question
		(attribute curioso-persone)
		(text "Ti piacerebbe scattare foto ai tuoi amici? ")
		(answers si no ns)
		(precursors ha-avuto-reflex is no and curioso-street-photo is si)
		(why "Verranno preferiti obiettivi per fotografare prevalentemente persone")

	)
	(question
		(attribute curioso-animali)
		(text "Ti piacerebbe scattare foto agli animali? ")
		(answers si no ns)
		(precursors ha-avuto-reflex is no)
		(why "Verranno preferiti teleobiettivi per fotografare prevalentemente animali")

	)
	(question
		(attribute curioso-luoghi)
		(text "Ti piacerebbe scattare foto a paesaggi e luoghi? ")
		(answers si no ns)
		(precursors ha-avuto-reflex is no and curioso-persone is no)
		(why "Verranno preferiti obiettivi grandangolari per fotografare prevalentemente luoghi")
	)
	(question
		(attribute curioso-dettagli)
		(text "Ti piacerebbe scattare foto ai piccoli dettagli? ")
		(answers si no ns)
		(precursors ha-avuto-reflex is no and curioso-street-photo is no)
		(why "Verranno preferiti obiettivi macro per fotografare dettagli di piccole cose")

	)
	(question
		(attribute curioso-sport)
		(text "Ti piacerebbe scattare foto durante gli eventi sportivi? ")
		(answers si no ns)
		(precursors ha-avuto-reflex is no and curioso-animali is no)
		(why "Verranno preferiti teleobiettivi per realizzare foto velocemente e a lunga distanza")
	)
	(question
		(attribute curioso-street-photo)
		(text "Intendi usare il tuo obiettivo per fotografare i momenti di tutti i giorni? ")
		(answers si no ns)
		(precursors ha-avuto-reflex is no)
		(why "Verranno preferiti obiettivi leggeri e luminosi per scattare velocemente e a distanza ravvicinata")
	)
	(question
		(attribute curioso-viaggi)
		(text "intendi utilizzare il tuo obiettivo durante i viaggi? ")
		(answers si no ns)
		(precursors ha-avuto-reflex is no)
		(why "Verranno preferiti obiettivi semplici da trasportare")
	)
	
	
	;AMATORE
	
	(question
		(attribute persone)
		(text "Hai intenzione di fotografare persone? ")
		(answers si no ns)
		(precursors professionista is no)
		(why "Verranno preferiti obiettivi per fotografare prevalentemente persone")

	)
	(question
		(attribute animali)
		(text "Hai intenzione di fotografare animali? ")
		(answers si no ns)
		(precursors professionista is no and persone is no and luoghi is no)
		(why "Verranno preferiti teleobiettivi per fotografare prevalentemente animali")
	)
	(question
		(attribute luoghi)
		(text "Hai intenzione di fotografare luoghi? ")
		(answers si no ns)
		(precursors professionista is no and persone is no)
		(why "Verranno preferiti obiettivi grandangolari per fotografare prevalentemente luoghi")
	)
	(question
		(attribute dettagli)
		(text "Hai intenzione di fotografare dettagli? ")
		(answers si no ns)
		(precursors professionista is no and luoghi is no and persone is no)
		(why "Verranno preferiti obiettivi macro per fotografare dettagli di piccole cose")
	)
	
	(question
		(attribute stop-motion)
		(text "Hai intenzione di girare video in stop-motion? ")
		(answers si no ns)
		(precursors dettagli is si)
		(why "Verranno preferiti obiettivi basculabili per realizzare foto con effetto miniatura da utilizzare in video stop-motion")
	)
	
	(question
		(attribute sport)
		(text "Hai intenzione di fotografare sport? ")
		(answers si no ns)
		(precursors professionista is no and persone-in-posa is no)
		(why "Verranno preferiti teleobiettivi per realizzare foto velocemente e a lunga distanza")
	)
	
	(question
		(attribute street-photo)
		(text "Hai intenzione di scattare foto della vita quotidiana? ")
		(answers si no ns)
		(precursors professionista is no and dettagli is no)
		(why "Verranno preferiti obiettivi leggeri per scatti di tutti i giorni")
	)
	
	(question 
		(attribute scatto-rapido)  
		(text "Hai intenzione di scattare velocemente? ")
		(answers si no ns)
		(precursors street-photo is si)
		(why "Verranno preferiti obiettivi luminosi e con stabilizzatore per scatti veloci")
	)
	
	(question 
		(attribute uso-autofocus)  
		(text "Userai l'autofocus? ")
		(answers si no ns)
		(precursors scatto-rapido is si)
		(why "Verranno preferiti obiettivi con autofocus di maggiore qualita")
	)
	
	(question
		(attribute viaggi)
		(text "Scatterai spesso durante i viaggi? ")
		(answers si no ns)
		(precursors professionista is no)
		(why "Verranno preferiti obiettivi semplici da trasportare")
	)
	
	(question 
		(attribute persone-in-posa)
		(text "Ti troveresti a fotografare persone in posa? ")
		(answers si no ns )
		(precursors persone is si)
		(why "Verranno preferiti obiettivi adatti a ritrattistica di tutti i tipi")
	)
	
	(question 
		(attribute primi-piani-singoli)  
		(text "Scatterai primi piani singoli? ")
		(answers si no ns )
		(precursors persone-in-posa is si)
		(why "Verranno preferiti obiettivi mid-tele per i primi piani nei ritratti")
	)
	(question 
		(attribute lunga-distanza)
		(text "Ti troveresti a scattare dalla lunga distanza? ")
		(answers si no ns )
		(precursors dom-lunga-distanza is si)
		(why "Verranno preferiti teleobiettivi e superteleobiettivi per foto realizzate a lunga e lunghissima distanza")
	)
	
	(question
		(attribute corta-distanza)
		(text "Ti troveresti a scattare dalla corta distanza? ")
		(answers si no ns )
		(precursors lunga-distanza is no)
		(why "Verranno preferiti obiettivi grandangolari e supergrandangolari per foto realizzate a lunga e lunghissima distanza")
	)
	(question
		(attribute interni)
		(text "Fotograferai in ambienti interni? ")
		(answers si no ns )
		(precursors sport is si)
		(why "Verranno preferiti obiettivi luminosi adatti per la fotografia in ambienti interni")
	)

	(question
		(attribute interni)
		(text "Fotograferai in ambienti interni? ")
		(answers si no ns )
		(precursors persone is si)
		(why "Verranno preferiti obiettivi luminosi adatti per la fotografia in ambienti interni")
	)

	(question
		(attribute paesaggi)
		(text "Fotograferai paesaggi naturali? ")
		(answers si no ns )
		(precursors luoghi is si)
		(why "Verranno preferiti obiettivi grandangolari e supergrandangolari per foto realizzate a lunga e lunghissima distanza")
	)
	
	(question
		(attribute architetture)
		(text "Fotograferai architetture? ")
		(answers si no ns )
		(precursors luoghi is si)
		(why "Verranno preferiti obiettivi decentrabili per permettere la correzione prospettica di edifici e architetture")
	)
	(question
		(attribute interni)
		(text "Fotograferai in ambienti interni? ")
		(answers si no ns )
		(precursors luoghi is si and paesaggi is no)
		(why "Verranno preferiti obiettivi luminosi adatti per la fotografia in ambienti interni")
	)
	
	(question
		(attribute astri)
		(text "Fotografarai astri e oggetti celesti? ")
		(answers si no ns )
		(precursors luoghi is si and ha-treppiede is si and paesaggi is no and interni is no)
		(why "Verranno preferiti obiettivi luminosi per catturare immagini di corpi celesti")
	)
	
	(question
		(attribute astri)
		(text "Fotografarai per riviste di astronomia?  ")
		(answers si no ns )
		(precursors riviste is si and ha-treppiede is si)
		(why "Verranno preferiti obiettivi luminosi per catturare immagini di corpi celesti")
	)
	
	(question
		(attribute tutto-cielo)
		(text "Effettuerai fotografie a tutto-cielo? ")
		(answers si no ns )
		(precursors astri is si)
		(why "Verranno preferiti obiettivi grandangolari e supergrandangolari per catturare immagini a tutto cielo")
	)
	
	(question
		(attribute piccola-dimensione)
		(text "Effettuerai fotografie a oggetti celesti di piccola dimensione? ")
		(answers si no ns )
		(precursors tutto-cielo is no)
		(why "Verranno preferiti teleobiettivi e superteleobiettivi per catturare immagini ingrandite di porzioni di cielo")
	)
	
	(question
		(attribute elementi-subacquei)
		(text "Effettuerai fotografie subacquee? ")
		(answers si no ns )
		(precursors luoghi is si and viaggi is si)
		(why "Verranno preferiti obiettivi grandangolari e supergrandangolari che permettono una messa a fuoco piu chiusa per ridurre la perdita cromatica dovuta alla distanza")
	)
	
	(question
		(attribute flash-subacqueo)
		(text "Hai a disposizione un flash subacqueo? ")
		(answers si no ns)
		(precursors elementi-subacquei is si)
		(why "Avere a disposizione un flash subacqueo permette di scattare da distanze più elevate riducendo la perdita cromatica")
	)
	
	
	(question 
		(attribute solo-ampi)  
		(text "Fotograferai ampie panoramiche? ")
		(answers si no ns )
		(precursors paesaggi is si)
		(why "Verranno preferiti obiettivi supergrandangolari ai grandangolari")
	)
	
	(question 
		(attribute solo-ampi)  
		(text "Fotograferai ampie panoramiche? ")
		(answers si no ns )
		(precursors paesaggi-urbani is si)
		(why "Verranno preferiti obiettivi supergrandangolari ai grandangolari")
	)
	
	(question 
		(attribute macro-estreme)  
		(text "Vuoi effettuare macro estreme? ")
		(answers si no ns )
		(precursors dettagli is si and meno-di-2000 is no)
		(why "Verranno preferiti macro con ingrandimento estremo per cogliere dettagli ancora piu' minuscoli")
	)

	
	;DOMANDE PRO
	;; ******************
	;; **DOMANDE STUDIO**
	;; ******************

	(question
		(attribute studio)
		(text "Necessiti di un obiettivo per scattare foto principalmente in studio? ")
		(answers si no)
		(precursors professionista is si)
		(why "Verranno preferiti obiettivi adatti a fotografie in studio, trascurando problemi di mobilita'")
	)
	
	
	(question
		(attribute macrofotografie)
		(text "Scatterai macrofotografie o still life in studio? ")
		(answers si no)
		(precursors studio is si and ritrattistica is no)
		(why "Verranno preferiti obiettivi macro per fotografare dettagli di piccole cose")
	)
	
	(question
		(attribute stop-motion)
		(text "Hai intenzione di girare video in stop-motion? ")
		(answers si no )
		(precursors studio is si and ritrattistica is no)
		(why "Verranno preferiti obiettivi basculabili per realizzare foto con effetto miniatura da utilizzare in video stop-motion")
	)
	
	(question 
		(attribute macro-estreme)  
		(text "Vuoi effettuare macro estreme? ")
		(answers si no )
		(precursors macrofotografie is si)
		(why "Verranno preferiti macro con ingrandimento estremo per cogliere dettagli ancora piu' minuscoli")
	)
	
	
	;; *********************
	;; **DOMANDE RITRATTI***
	;; *********************
		(question
			(attribute ritratti)
			(text "Effettuerai ritrattistica? ")
			(answers si no)
			(precursors professionista is si and cibo is no)
			(why "Verranno preferiti obiettivi adatti a ritrattistica per professionisti")
		)
	
	;; ******************
	;; **DOMANDE EVENTI**
	;; ******************
		(question
			(attribute eventi)
			(text "Scatterai foto ad eventi o cerimonie? ")
			(answers si no)
			(precursors professionista is si and ritratti is no)
			(why "Mi interessa comprendere se vuoi scattare a qualche evento in particolare o foto generiche")
		)
		
		(question
			(attribute matrimoni)
			(text "Effettuerai foto a matrimoni? ")
			(answers si no)
			(precursors eventi is si)
			(why "Prediligerò obiettivi dalla focale normale e mid-tele per catturare i momenti migliori della cerimonia ")
		)
		
		(question
			(attribute sport)
			(text "Fotograferai ad eventi sportivi? ")
			(answers si no)
			(precursors eventi is si)
			(why "Verranno preferiti teleobiettivi per realizzare foto velocemente e a lunga distanza")
		)
		
		(question
			(attribute concerti)
			(text "Effettuerai foto a concerti? ")
			(answers si no)
			(precursors eventi is si)
			(why "Verranno preferiti teleobiettivi molto luminosi per realizzare foto velocemente e a lunga distanza")
		)
		
		(question
			(attribute moda)
			(text "Effettuerai foto a sfilate di moda? ")
			(answers si no)
			(precursors eventi is si)
			(why "Verranno preferiti teleobiettivi molto luminosi per realizzare ritratti a lunga distanza su una passerella")
		)
		
	
	;; *************************
	;; *****DOMANDE RIVISTE*****
	;; *************************
	

		
		(question
			(attribute riviste)
			(text "Hai intenzione di vendere le tue foto a giornali o riviste? ")
			(answers si no)
			(precursors professionista is si)
			(why "In caso di risposta affermativa indaghero' sul tipo di giornale o di rivista a cui hai intenzione di vendere")
		)
		
	;; ************************
	;; ****DOMANDE REPORTER****
	;; ************************
		
		(question
			(attribute reporter)
			(text "Sei un fotoreporter? ")
			(answers si no)
			(precursors riviste is si)
			(why "Per un fotoreporter e' importante avere degli obiettivi con buona trasportabilita'")
		)		
		(question
			(attribute vicino)
			(text "Scatterai vicino all'azione? ")
			(answers si no)
			(precursors reporter is si)
			(why "In caso di risposta affermativa prediligero' obiettivi grandangolari per permetterti di rimanere vicino all'azione al momento dello scatto")
		)	

	;; *************************
	;; **DOMANDE NATURALISTICA**
	;; *************************
		
		(question
			(attribute naturalistica)
			(text "Venderai le tue foto ad una rivista naturalistica? ")
			(answers si no)
			(precursors reporter is no and riviste is si)
			(why "In caso di risposta affermativa mi interessa sapere che genere di fotografia naturalistica ti interessa scattare per consigliare con piu' precisione")
		)
		
		(question
			(attribute macrofotografie)
			(text "Scatterai macrofotografie? ")
			(answers si no )
			(precursors naturalistica is si)
			(why "Verranno preferiti obiettivi macro per fotografare dettagli di piccole cose")
		)
		
		(question
			(attribute paesaggi)
			(text "Scatterai foto a paesaggi? ")
			(answers si no)
			(precursors naturalistica is si)
			(why "Verranno preferiti obiettivi grandangolari e supergrandangolari per foto realizzate a lunga e lunghissima distanza")
		)
		
		(question
			(attribute animali)
			(text "Scatterai foto ad animali? ")
			(answers si no)
			(precursors naturalistica is si)
			(why "Verranno preferiti teleobiettivi per fotografare prevalentemente animali")
			
		)


	;; *************************
	;; **DOMANDE ARCHITETTURA**
	;; *************************
		
		(question
			(attribute architetture)
			(text "Effettuerai foto per architetture? ")
			(answers si no)
			(precursors professionista is si and ritratti is no and eventi is no and catalogo is no and studio is no)
			(why "Verranno preferiti obiettivi decentrabili per permettere la correzione prospettica di edifici e architetture")
		)

		
	;; *************************
	;; **DOMANDE CATALOGO**
	;; *************************
		(question
			(attribute catalogo)
			(text "Le tue foto verranno inserite in cataloghi o menu? ")
			(answers si no)
			(precursors riviste is no and ritratti is no)
			(why "In caso di risposta affermativa mi interessa sapere in che genere di cataloghi naturalistica verranno inseriti i tuoi scatti per consigliare con piu' precisione")
			
		)
		(question
			(attribute immobiliari)
			(text "Le tue foto verranno inserite in cataloghi immobiliari? ")
			(answers si no)
			(precursors catalogo is si and ha-treppiede is si)
			(why "Verranno preferiti obiettivi decentrabili per permettere la correzione prospettica di edifici e immobili")
		)		
		(question
			(attribute interni)
			(text "Fotograferai interni? ")
			(answers si no)
			(precursors catalogo is si and professionista is si)
			(why "Verranno preferiti obiettivi luminosi adatti per la fotografia in ambienti interni")
		)
		(question
			(attribute cibo)
			(text "Fotograferai cibo o altri oggetti? ")
			(answers si no)
			(precursors studio is si)
			(why "Verranno preferiti obiettivi basculabili per realizzare foto con effetto miniatura e obiettivi macro per enfatizzare dettagli degli oggetti o del cibo")
		)
)