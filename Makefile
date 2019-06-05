


check: check-sibelius check-musicxml check-pdf check-kern

check-sibelius:
	-(cd sibelius; ../bin/renamefile -c *.sib)
check-musicxml:
	-(cd musicxml; ../bin/renamefile -c *.xml)
check-pdf:
	-(cd pdf; ../bin/renamefile -c *.pdf)
check-kern:
	-(cd kern; ../bin/renamefile -c *.krn)


rename: rename-sibelius rename-musicxml rename-pdf rename-kern

rename-sibelius:
	-(cd sibelius; ../bin/renamefile -wg *.sib)
rename-musicxml:
	-(cd musicxml; ../bin/renamefile -wg *.xml)
rename-pdf:
	-(cd pdf; ../bin/renamefile -wg *.pdf)
rename-kern:
	-(cd kern; ../bin/renamefile -wg *.krn)


krn:	humdrum
kern:	humdrum
hum:	humdrum
humdrum:
	for i in musicxml/*.xml; \
	do \
		musicxml2hum $$i > kern/$$(basename $$i .xml).krn; \
		echo "!!!ONB: Converted from MusicXML on $$(date +'%Y/%m/%d')" >> kern/$$(basename $$i .xml).krn; \
	done
	

