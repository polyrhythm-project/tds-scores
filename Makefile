

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
humdrum: utf8
	for i in musicxml/*.xml; \
	do \
		musicxml2hum $$i | extractxx --no-rest | \
		   $(RDSBIN)/adddummymetadata | \
		   $(RDSBIN)/removedoublebarline | \
		   grep -v "break:original" | \
		   egrep -v "^\!\!\!(YEM|YEC)" > \
		   kern/$$(basename $$i .xml).krn; \
	done
	echo "ADDING *MM LINES (BEFORE RUNNING POLYMETA)"
	(cd kern; ../$(RDSBIN)/addmmline *.krn)
	echo "ADDING METADATA INFORMATION TO SCORES"
	(cd kern; ../$(RDSBIN)/polymeta *.krn >& /dev/null)

xml: utf8
utf16: utf8
utf8:
	(cd musicxml && ../$(RDSBIN)/utf16toutf8 *.xml)


tempo:
	$(RDSBIN)/insertTempoRecords kern/*.krn



