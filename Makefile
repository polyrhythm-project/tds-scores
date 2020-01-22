

RDSBIN = ../rds-scores/bin

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

kern:	humdrum
krn:	humdrum
hum:	humdrum
humdrum:
	for i in musicxml/*.xml; \
	do \
		musicxml2hum $$i | extractx --no-rest | \
		   $(RDSBIN)/adddummymetadata | \
		   $(RDSBIN)/removedoublebarline | \
		   grep -v "break:original" > \
		   kern/$$(basename $$i .xml).krn; \
	done
	echo "ADDING *MM LINES (BEFORE RUNNING POLYMETA)"
	(cd kern; ../$(RDSBIN)/addmmline *.krn)
	echo "ADDING METADATA INFORMATION TO SCORES"
	(cd kern; ../$(RDSBIN)/polymeta *.krn >& /dev/null)



