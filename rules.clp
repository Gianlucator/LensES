					
(deffacts amateur-rules
	
	
	;Rules derived from questions

	(def-rule 
		(if ha-monopiede is no)
		(then sostegno-monopiede is no
		and stabilizzato is true
		and portabilita is alta
		and ha-treppiede is no)
	)

	(def-rule 
		(if ha-monopiede is si)
		(then ha-treppiede is si)
	)
	
	
	(def-rule 
		(if ha-treppiede is si)
		(then ha-monopiede is si)
	)
	
	
	(def-rule 
		(if ha-treppiede is no)
		(then ha-monopiede is no)
	)

	
	(def-rule 
		(if ha-treppiede is si)
		(then ha-monopiede is si)
	)
	
	(def-rule 
		(if ha-treppiede is no)
		(then sostegno-treppiede is no
		and stabilizzato is true
		and portabilita is alta
		and portabilita is media with certainty 25)
	)
	(def-rule 
		(if ha-treppiede is no)
		(then sostegno-treppiede is no
		and stabilizzato is true
		and portabilita is alta
		and portabilita is media with certainty 25)
	)
	
	(def-rule 
		(if ha-monopiede is si)
		(then sostegno-monopiede is si
		and stabilizzato is true
		and stabilizzato is false
		and portabilita is alta
		and portabilita is media
		and portabilita is bassa)
	)
	
	(def-rule 
		(if ha-treppiede is si)
		(then sostegno-treppiede is si
		and stabilizzato is true
		and portabilita is bassa
		and portabilita is media with certainty 25)
	)
	
	(def-rule 
		(if sostegno-treppiede is si)
		(then scatto-mano-libera is no)
	)
	
	(def-rule 
		(if sostegno-monopiede is si)
		(then scatto-mano-libera is no)
	)
	(def-rule 
		(if sostegno-treppiede is no)
		(then scatto-mano-libera is si)
	)
	
	(def-rule 
		(if sostegno-monopiede is no)
		(then scatto-mano-libera is si)
	)
	
	(def-rule 
		(if ha-monopiede is no and ha-treppiede is no)
		(then scatto-mano-libera is si)
	)

	(def-rule
		(if luoghi is no)
		(then categoria-focale is normale with certainty 25
		and luminosita-obiettivo is indifferente with certainty 50)
	)
	
	(def-rule
		(if persone is no)
		(then categoria-focale is grandangolo with certainty 25
		and luminosita-obiettivo is indifferente with certainty 50)
	)
	
	(def-rule 
		(if meno-di-2000 is no)
		(then fascia-prezzo is media
		and fascia-prezzo is alta
		and fascia-prezzo is bassa
		and qualita-obiettivo is alta with certainty 55
		and qualita-obiettivo is normale with certainty 75)
	)
	
	(def-rule 
		(if professionista is si)
		(then qualita-obiettivo is alta
		and qualita-obiettivo is normale with certainty 50)
	)
	
	(def-rule 
		(if professionista is no)
		(then qualita-obiettivo is normale
		and qualita-obiettivo is alta with certainty 10)
	)
	
	(def-rule
		(if sensore-aps-c is no and sensore-aps-h is no)
		(then sensore-full-frame is si)
	)
	
	(def-rule
		(if meno-di-750 is si)
		(then fascia-prezzo is bassa)
	)
	
	(def-rule
		(if meno-di-750 is no)
		(then fascia-prezzo is media and fascia-prezzo is bassa with certainty 75)
	)
	
	(def-rule 
		(if sensore-aps-c is si)
		(then serie-lente is ef-s)
	)
	
	;REGOLE AMATORE
	

	(def-rule 
		(if persone is si)
		(then categoria-focale is normale with certainty 65
		and categoria-focale is mid-tele with certainty 65
		and stabilizzato is true with certainty 35 
		and stabilizzato is false with certainty 35
		and portabilita is media with certainty 35
		and luoghi is no
		and dettagli is no)
	)
	
	
	(def-rule 
		(if animali is si)
		(then categoria-focale is mid-tele with certainty 50)
	)	

	(def-rule 
		(if luoghi is si)
		(then categoria-focale is grandangolo with certainty 50
		and categoria-focale is super-grandangolo with certainty 40
		and categoria-focale is normale with certainty 15
		and macro is false)
	)		

	(def-rule 
		(if luoghi is si)
		(then categoria-focale is grandangolo with certainty 50
		and categoria-focale is super-grandangolo with certainty 40)
	)		


	
	(def-rule 
		(if animali is si and lunga-distanza is si and sostegno-monopiede is si)
		(then categoria-focale is super-tele
		and categoria-focale is tele with certainty 70
		and peso is pesante 
		and dimensioni is grande with certainty 70
		and dimensioni is molto-grande
		and stabilizzato is false)
	)	
	
	(def-rule 
		(if animali is si and lunga-distanza is si and sostegno-treppiede is si)
		(then categoria-focale is super-tele
		and categoria-focale is tele with certainty 70
		and peso is pesante 
		and dimensioni is grande with certainty 70
		and dimensioni is molto-grande
		and stabilizzato is false)
	)	
	
	(def-rule 
		(if animali is si and lunga-distanza is si and sostegno-monopiede is no)
		(then categoria-focale is mid-tele with certainty 40
		and categoria-focale is tele with certainty 80)
	)	

	(def-rule 
		(if animali is si and lunga-distanza is si)
		(then categoria-focale is mid-tele with certainty 40
		and categoria-focale is tele with certainty 85
		and peso is pesante with certainty 35
		and dimensione is grande with certainty 60
		and dimensione is molto-grande with ccertainty 10)
	)	

	(def-rule 
		(if animali is si and lunga-distanza is no)
		(then categoria-focale is mid-tele with certainty 45
		and categoria-focale is normale with certainty 85
		and peso is pesante with certainty 40)
	)	
	
	(def-rule 
		(if animali is si and media-distanza is si)
		(then categoria-focale is mid-tele with certainty 92
		and categoria-focale is normale with certainty 68
		and peso is pesante with certainty 40)
	)	
	
	(def-rule 
		(if sport is si and sostegno-monopiede is si)
		(then categoria-focale is tele with certainty 70
		and portabilita is bassa 
		and portabilita is alta with certainty 45
		and portabilita is media with certainty 75)
	)	
	
	(def-rule 
		(if luoghi is si)
		(then categoria-focale is grandangolo with certainty 85
		and categoria-focale is super-grandangolo with certainty 75)
	)	

	(def-rule 
		(if sport is si)
		(then categoria-focale is tele 
		and categoria-focale is mid-tele with certainty 60
		and categoria-focale is normale with certainty 30
		and portabilita is media
		and portabilita is bassa with certainty 15
		and scatto-rapido is si
		and uso-autofocus is si
		and qualita-af is alta)
	)

	(def-rule 
		(if sport is no)
		(then categoria-focale is grandangolo with certainty 30
		and categoria-focale is super-grandangolo with certainty 25
		and portabilita is alta
		and portabilita is media with certainty 55)
	)	
	
	
	(def-rule 
		(if dettagli is si)
		(then macro is true with certainty 70
		and stabilizzato is false with certainty 25
		and categoria-focale is mid-tele with certainty 70
		and categoria-focale is normale with certainty 70
		and categoria-focale is tele with certainty 70
		and qualita-af is bassa and
		lunga-distanza is no
		and corta-distanza is si with certainty 5)
	)		
		
	
	(def-rule 
		(if macro is true and ha-treppiede is si)
		(then sostegno-treppiede is si)
	)		

	(def-rule 
		(if paesaggi is si and ha-treppiede is si)
		(then sostegno-treppiede is si)
	)		
	
	(def-rule 
		(if animali is si and ha-treppiede is si)
		(then sostegno-treppiede is si)
	)		
	
	(def-rule 
		(if animali is si and ha-monopiede is si)
		(then sostegno-monopiede is si)
	)		
	
	(def-rule 
		(if macrofotografie is si)
		(then macro is true
		and categoria-focale is mid-tele with certainty 70
		and categoria-focale is normale with certainty 70
		and categoria-focale is tele with certainty 70)
	)

	(def-rule 
		(if macro is true)
		(then isolamento-soggetto is si
		and qualita-af is bassa
		and qualita-af is media
		and luminosita-obiettivo is indifferente)
	)

	(def-rule 
		(if dettagli is no)
		(then macro is false)
	)	
	
	
	(def-rule
		(if macro is true and sostegno-treppiede is no)
		(then stabilizzato is false with certainty 55)
	)
	
	(def-rule
		(if macro is true and sostegno-treppiede is si)
		(then stabilizzato is false)
	)	

	(def-rule 
		(if ritrattistica is si)
		(then categoria-focale is normale with certainty 30
		and categoria-focale is mid-tele with certainty 75
		and categoria-focale is grandangolo with certainty 35
		and apertura-diaframma is ampia
		and apertura-diaframma is normale with certanty 50
		and apertura-diaframma is stretta with certainty 20
		and stabilizzato is false
		and isolamento-soggetto is si with certainty 75)
	)	
	
	(def-rule 
		(if ritrattistica is si and studio is si)
		(then luminosita-obiettivo is indifferente and categoria-focale is mid-tele
		and categoria-focale is normale with certainty 75)
	)	
	
	(def-rule 
		(if primi-piani-singoli is no)
		(then categoria-focale is normale with certainty 65 
		and categoria-focale is mid-tele with certainty 60
		and categoria-focale is grandangolo with certainty 35
		and isolamento-soggetto is no)
	)
	
	(def-rule 
		(if primi-piani-singoli is si)
		(then categoria-focale is normale  with certainty 65
		and categoria-focale is mid-tele
		and isolamento-soggetto is si)
	)

	(def-rule 
		(if lunga-distanza is si)
		(then categoria-focale is tele with certainty 80
		and categoria-focale is super-tele with certainty 65
		and categoria-focale is mid-tele with certainty 20
		and categoria-focale is normale with certainty 10)
	)

	(def-rule 
		(if media-distanza is si)
		(then categoria-focale is normale 
		and categoria-focale is mid-tele 
		and categoria-focale is grandangolo with certainty 10
		and categoria-focale is tele with certainty 10
		)
	)
	
	(def-rule 
		(if media-distanza is si and decentrabile is si)
		(then apertura-diaframma is ampia with certainty 20
		and apertura-diaframma is stretta
		and apertura-diaframma is normale
		)
	)
	(def-rule 
		(if corta-distanza is si)
		(then categoria-focale is grandangolo
		and categoria-focale is super-grandangolo with certainty 30
		and categoria-focale is normale with certainty 60)
	)
	
	(def-rule
		(if scarsa-illuminazione is no and sport is si)
		(then stabilizzato is false with certainty 45
		and stabilizzato is true with certainty 80)
	)

	
	(def-rule
		(if scarsa-illuminazione is si)
		(then luminosita-obiettivo is alta
		and stabilizzato is true with certainty 75)
	)
	
	(def-rule 
		(if luoghi is no and stop-motion is no)
		(then decentrabile is no)
	)
	
	(def-rule 
		(if decentrabile is no)
		(then serie-lente is ef with certainty 80)
	)
	
	(def-rule 
		(if decentrabile is no and sensore-aps-c is si)
		(then serie-lente is ef-s with certainty 90)
	)
	
	(def-rule
		(if scarsa-illuminazione is si)
		(then apertura-diaframma is ampia
		and apertura-diaframma is normale with certainty 50
		and apertura-diaframma is stretta with certainty 20)
	)
	
	;test paesaggi urbani e scarsa illuminazione
	(def-rule
		(if paesaggi is no)
		(then paesaggi-urbani is si)
	)
	
	(def-rule
		(if luoghi is no and dettagli is no)
		(then serie-lente is ef with certainty 70)
	)
	
	(def-rule
		(if luoghi is no and dettagli is no and sensore-aps-c is si)
		(then serie-lente is ef with certainty 20
		and serie-lente is ef-s)
	)
	
	(def-rule
		(if paesaggi-urbani is si)
		(then scarsa-illuminazione is si)
	)
	
	(def-rule
		(if paesaggi-urbani is no)
		(then apertura-diaframma is stretta)
	)

	(def-rule
		(if paesaggi is si)
		(then categoria-focale is grandangolo 
		and categoria-focale is super-grandangolo with certainty 85
		and paesaggi-urbani is no
		and lunga-distanza is no
		and corta-distanza is si)
	)
	
	(def-rule
		(if decentrabile is si)
		(then serie-lente is ts-e
		and serie-lente is ef with certainty 5
		and macro is false
		and af is no
		and stabilizzato is false with certainty 70
		and apertura-diaframma is stretta with certainty 75
		and apertura-diaframma is normale with certainty 75)
	)	
	
	(def-rule
		(if decentrabile is si and sensore-aps-c is si)
		(then serie-lente is ef-s with certainty 10)
	)	
	
	(def-rule
		(if decentrabile is si and lunga-distanza is si)
		(then categoria-focale is mid-tele
		and categoria-focale is normale with certainty 45)
	)	
	
	(def-rule
		(if decentrabile is si and media-distanza is si)
		(then categoria-focale is mid-tele with certainty 10
		and categoria-focale is normale
		and categoria-focale is grandangolo with certainty 10)
	)

	(def-rule
		(if decentrabile is si and corta-distanza is si)
		(then categoria-focale is grandangolo
		and categoria-focale is super-grandangolo
		and apertura-diaframma is stretta
		and apertura-diaframma is normale with certainty 95
		and peso is pesante)
	)		
	
	(def-rule
		(if lunga-distanza is no and corta-distanza is no)
		(then media-distanza is si)
	)	
	
	(def-rule
		(if sostegno-treppiede is no)
		(then stabilizzato is true with certainty 100
		and stabilizzato is false with certainty 35
		and peso is pesante with certainty 20
		and peso is leggero)
	)	

	(def-rule
		(if sostegno-treppiede is si)
		(then stabilizzato is false
		and stabilizzato is true with certainty 60
		and peso is pesante
		and peso is leggero)
	)
	
	(def-rule
		(if astri is si)
		(then sostegno-treppiede is si
		and apertura-diaframma is ampia
		and apertura-diaframma is media with certainty 85
		and apertura-diaframma is stretta with certainty 55)
	)	

	(def-rule
		(if tutto-cielo is si)
		(then categoria-focale is grandangolo with certainty 55
		and categoria-focale is super-grandangolo with certainty 75)
	)	

	(def-rule
		(if piccola-dimensione is si)
		(then categoria-focale is tele with certainty 75
		and categoria-focale is super-tele with certainty 75)
	)	

	(def-rule
		(if stop-motion is si)
		(then categoria-focale is grandangolo with certainty 35
		and decentrabile is si
		and isolamento-soggetto is si)
	)	

	
	(def-rule
		(if piccola-dimensione is no)
		(then categoria-focale is normale with certainty 75
		and categoria-focale is mid-tele with certainty 50
		and categoria-focale is grandangolo with certainty 50)
	)

	(def-rule
		(if piccola-dimensione is no)
		(then categoria-focale is normale with certainty 50)
	)

	(def-rule
		(if elementi-subacquei is si)
		(then categoria-focale is grandangolo with certainty 60
		and categoria-focale is super-grandangolo with certainty 60)
	)


	(def-rule
		(if flash-subacqueo is si)
		(then categoria-focale is normale with certainty 75
		and categoria-focale is mid-tele with certainty 50)
	)

	
	(def-rule
		(if flash-subacqueo is no)
		(then categoria-focale is grandangolo with certainty 85
		and categoria-focale is super-grandangolo with certainty 75)
	)

	(def-rule
		(if solo-ampi is si)
		(then categoria-focale is super-grandangolo
		and categoria-focale is grandangolo with certainty 30)
	)
	(def-rule
		(if solo-ampi is no)
		(then categoria-focale is grandangolo
		and categoria-focale is super-grandangolo with certainty 50
		and categoria-focale is normale with certainty 20
		)
	)

	(def-rule
		(if ha-treppiede is si and dettagli is si)
		(then macro-estreme is si)
	)
	
	
	(def-rule
		(if ha-treppiede is no and dettagli is si)
		(then macro-estreme is no)
	)
	
	(def-rule
		(if macro-estreme is si)
		(then serie-lente is mp-e
		and serie-lente is ef with certainty 10
		and categoria-focale is normale
		and apertura-diaframma is normale
		and apertura-diaframma is ampia with certainty 35
		and qualita-af is bassa)
	)
	
	(def-rule
		(if macro-estreme is si and sensore-aps-c is si)
		(then serie-lente is ef-s with certainty 25)
	)

	(def-rule
		(if isolamento-soggetto is si and persone is si)
		(then categoria-focale is mid-tele with certainty 60
		and categoria-focale is normale with certainty 45
		and luminosita-obiettivo is indifferente)
	)
	
	(def-rule
		(if isolamento-soggetto is si and scarsa-illuminazione is si)
		(then luminosita-obiettivo is alta)
	)

	(def-rule
		(if isolamento-soggetto is no)
		(then categoria-focale is normale with certainty 65
		and categoria-focale is grandangolo with certainty 70
		and categoria-focale is super-grandangolo with certainty 70)
	)
	
	(def-rule
		(if isolamento-soggetto is si)
		(then categoria-focale is mid-tele
		and luminosita-obiettivo is alta
		and categoria-focale is tele
		and categoria-focale is normale)
	)

	(def-rule
		(if street-photo is si)
		(then portabilita is alta
		and categoria-focale is grandangolo with certainty 25
		and categoria-focale is normale
		and scarsa-illuminazione is si)
	)

	(def-rule
		(if viaggi is si)
		(then portabilita is alta
		and categoria-focale is grandangolo with certainty 50
		and categoria-focale is normale with certainty 50
		and interni is no with certainty 25
		and luoghi is si with certainty 75
		and paesaggi is si with certainty 45
		and paesaggi-urbani is si with certainty 45)
	)
	
	(def-rule
		(if viaggi is no)
		(then portabilita is media
		portabilita is bassa with certainty 25
		and portabilita is alta with certainty 75)
	)
	
	(def-rule
		(if scatto-rapido is si)
		(then apertura-diaframma is ampia
		and apertura-diaframma is normale with certainty 27
		and stabilizzato is true with certainty 60
		and stabilizzato is false with certainty 20)
	)
	
	(def-rule
		(if scatto-rapido is no)
		(then apertura-diaframma is stretta
		and apertura-diaframma is normale with certainty 27
		and stabilizzato is true with certainty 20
		and stabilizzato is false with certainty 60)
	)

	(def-rule
		(if uso-autofocus is si and sensore-aps-c is si)
		(then qualita-af is alta with certainty 45
		and qualita-af is media)
	)
	
	(def-rule
		(if sensore-full-frame is si)
		(then serie-lente is ef)
	)
	
	(def-rule
		(if uso-autofocus is si and sensore-full-frame is si)
		(then qualita-af is alta
		and qualita-af is media with certainty 45)
	)
	
	(def-rule
		(if uso-autofocus is no)
		(then qualita-af is no)
	)
	
	(def-rule 
		(if animali is si)
		(then dom-lunga-distanza is si)
	)	

	(def-rule 
		(if sport is si)
		(then dom-lunga-distanza is si)
	)		
	
	
	(def-rule 
		(if persone-in-posa is no)
		(then street-photo is si
		and scatto-rapido is si)
	)	
	
	(def-rule 
		(if moda is si)
		(then lunga-distanza is si with certainty 75
		and ritrattistica is si with certainty 75
		and interni is si)
	)
	
	
	;REGOLE PRO
		
	(def-rule
		(if ritratti is si)
		(then ritrattistica is si)
	)
	
	(def-rule
		(if persone-in-posa is si)
		(then ritratti is si)
	)
	
	(def-rule 
		(if ritratti is si and studio is si)
		(then categoria-focale is normale with certainty 95
		and categoria-focale is mid-tele with certainty 85)
	)
	
	(def-rule
		(if ritratti is si and studio is no) 
		(then categoria-focale is mid-tele with certainty 95
		and categoria-focale is normale with certainty 80
		and apertura-diaframma is ampia with certainty 95)
	)
	(def-rule 
		(if ritratti is si)
		(then categoria-focale is normale with certainty 85
		and categoria-focale is mid-tele with certainty 85
		and stabilizzato is true
		and stabilizzato is false
		and portabilita is media)
	)
	(def-rule 
		(if concerti is si)
		(then lunga-distanza is si
		and scarsa-illuminazione is si)
	)	
	
	(def-rule 
		(if studio is no)
		(then macrofotografie is no)
	)
	(def-rule 
		(if naturalistica is no)
		(then macrofotografie is no)
	)
	(def-rule 
		(if macrofotografie is no)
		(then macro is false)
	)

	(def-rule 
		(if reporter is si)
		(then dimensione is media
		and peso is leggero
		and categoria-focale is normale
		and categoria-focale is grandangolo with certainty 65)
	)
	(def-rule 
		(if vicino is si)
		(then categoria-focale is grandangolo with certainty 95)
	)
	(def-rule 
		(if vicino is no)
		(then categoria-focale is normale with certainty 95)
	)

	(def-rule 
		(if architetture is si)
		(then decentrabile is si)
	)
	(def-rule 
		(if architetture is no)
		(then decentrabile is no
		and luminosita-obiettivo is indifferente)
	)
	
	(def-rule 
		(if immobiliari is si)
		(then decentrabile is si with certainty 65)
	)	
	(def-rule 
		(if interni is si)
		(then scarsa-illuminazione is si)
	)	
	
	(def-rule 
		(if interni is si and luoghi is si)
		(then categoria-focale is grandangolo
		and categoria-focale is super-grandangolo)
	)	
	
	(def-rule 
		(if cibo is no)
		(then macrofotografie is no)
	)	
	(def-rule 
		(if cibo is si)
		(then macro is true with certainty 85 
		and serie-lente is ts-e with certainty 60)
	)	
	(def-rule 
		(if riviste is no)
		(then reporter is no with certainty 85)
	)	
	
	(def-rule 
		(if curioso-animali is si)
		(then categoria-focale is mid-tele with certainty 45)
	)	

	(def-rule 
		(if curioso-persone is si)
		(then categoria-focale is normale with certainty 45
		and dettagli is no
		and curioso-luoghi is no)
	)	
	
	(def-rule 
		(if curioso-street-photo is no)
		(then categoria-focale is grandangolo with certainty 30
		and luminosita-obiettivo is indifferente with certainty 35)
	)	
	
	(def-rule 
		(if curioso-luoghi is no)
		(then decentrabile is no 
		and categoria-focale is normale with certainty 30
		and luminosita-obiettivo is indifferente with certainty 35)
	)	

	(def-rule 
		(if curioso-luoghi is si)
		(then categoria-focale is grandangolo with certainty 35 
		and categoria-focale is super-grandangolo with certainty 30
		and decentrabile is si with certainty 40
		and luminosita-obiettivo is indifferente with certainty 35)

	)	

	(def-rule 
		(if curioso-sport is no)
		(then categoria-focale is grandangolo with certainty 35 
		and categoria-focale is normale with certainty 35
		and luminosita-obiettivo is indifferente with certainty 35)

	)	

	(def-rule 
		(if curioso-animali is no)
		(then categoria-focale is grandangolo with certainty 35 
		and categoria-focale is normale with certainty 35
		and luminosita-obiettivo is indifferente with certainty 35)

	)		

	(def-rule 
		(if curioso-dettagli is si)
		(then macro is true with certainty 35
		and serie-lente is mp-e with certainty 25
		and serie-lente is ef with certainty 35
		and categoria-focale is mid-tele with certainty 35
		and categoria-focale is normale with certainty 35
		and categoria-focale is tele with certainty 35)
	)	
	

	(def-rule 
		(if curioso-sport is si)
		(then categoria-focale is tele with certainty 50
		and categoria-focale is mid-tele with certainty 30
		and scatto-mano-libera is si with certainty 80
		and portabilita is media with certainty 70)
	)	

	(def-rule 
		(if curioso-street-photo is si)
		(then portabilita is alta with certainty 65
		and categoria-focale is grandangolo with certainty 5
		and categoria-focale is normale with certainty 65
		and scarsa-illuminazione is si with certainty 65)
	)	

	(def-rule 
		(if curioso-viaggi is si)
		(then portabilita is alta with certainty 65
		and categoria-focale is grandangolo with certainty 65)
	)	


	(def-rule 
		(if curioso-dettagli is no)
		(then dettagli is no)
	)	

	(def-rule 
		(if ha-avuto-reflex is no)
		(then serie-l is no
		and serie-l is si with certainty 70
		and af is indefinito with certainty 25
		and af is usm with certainty 50
		and af is stm with certainty 80
		and sensore-full-frame is si)
	)	
	
	(def-rule 
		(if ex-reflex-professionista is si)
		(then professionista is si)
	)	

	(def-rule 
		(if ex-reflex-professionista is no)
		(then professionista is no)
	)	
	
	(def-rule 
		(if serie-lente is ef and sensore-aps-c is si)
		(then serie-lente is ef-s)
	)	
	
	(def-rule 
		(if ha-canon is no)
		(then sensore-full-frame is si
		and serie-lente is ef-s)
	)	
	
	(def-rule 
		(if riviste is no)
		(then categoria-focale is normale
		and categoria-focale is grandangolo with certainty 30
		and categoria-focale is super-grandangolo with certainty 25)
	)
	(def-rule 
		(if eventi is no)
		(then categoria-focale is grandangolo with certainty 30
		and categoria-focale is super-grandangolo with certainty 30)
	)
	
	
	(def-rule 
		(if eventi is si)
		(then serie-lente is ef)
	)
	
	
	(def-rule 
		(if studio is si)
		(then serie-lente is ef)
	)
	
	(def-rule 
		(if riviste is si)
		(then serie-lente is ef)
	)
	
	(def-rule 
		(if studio is no)
		(then cibo is no)
	)
	
	(def-rule 
		(if ritrattistica is si)
		(then fotoreporter is no
		and serie-lente is ef)
	)
		
	
	
	;Classi di obiettivi
	(def-rule 
		(if portabilita is alta)
		(then peso is leggero
		and peso is pesante with certainty 10
		and dimensioni is medio with certainty 75
		and dimensioni is piccolo with certainty 95
		and dimensioni is pancake)
	)
	
	(def-rule 
		(if portabilita is media)
		(then peso is leggero with certainty 85
		and peso is pesante with certainty 55
		and dimensioni is medio
		and dimensioni is piccolo with certainty 75
		and dimensioni is grande with certainty 75)
	)
	
	(def-rule 
		(if portabilita is bassa)
		(then peso is pesante
		and dimensioni is media
		and dimensioni is grande
		and dimensioni is molto-grande)
	)
	
	(def-rule 
		(if qualita-obiettivo is alta)
		(then serie-l is si
		and serie-lente is ef)
	)
	(def-rule 
		(if qualita-obiettivo is normale)
		(then serie-l is no
		and serie-l is si with certainty 35)
	)
	
	(def-rule 
		(if qualita-af is alta)
		(then af is usm
		and af is stm with certainty 85
		and af is indefinito with certainty 35)
	)

	(def-rule 
		(if qualita-af is media)
		(then af is usm with certainty 50
		and af is stm 
		and af is indefinito with certainty 50)
	)
	
	(def-rule 
		(if qualita-af is no)
		(then af is no)
	)
	
	(def-rule 
		(if luminosita-obiettivo is alta)
		(then apertura-diaframma is ampia
		and apertura-diaframma is normale with certainty 50)
	)	
	
	(def-rule 
		(if luminosita-obiettivo is indifferente)
		(then apertura-diaframma is ampia
		and apertura-diaframma is normale
		and apertura-diaframma is stretta)
	)	
	(def-rule 
		(if scatto-mano-libera is si)
		(then stabilizzato is true
		and stabilizzato is false with certainty 25
		and portabilita is alta
		and portabilita is media with certainty 75
		and qualita-af is alta)
	)	
	
	(def-rule 
		(if scatto-mano-libera is no)
		(then qualita-af is alta with certainty 25
		and qualita-af is media with certainty 25
		and qualita-af is no with certainty 25
		and stabilizzato is true
		and stabilizzato is false
		and portabilita is alta
		and portabilita is media 
		and portabilita is bassa)
	)	
	
	
	
)
