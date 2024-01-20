all:
# this points to a separate file mainly because make uses sh, not bash to run scripts. 
	./scripts/build.sh

clean:
	find . -name '*.aux' -delete
	find . -name '*.lof' -delete
	find . -name '*.log' -delete
	find . -name '*.lot' -delete
	find . -name '*.fls' -delete
	find . -name '*.out' -delete
	find . -name '*.toc' -delete
	find . -name '*.fmt' -delete
	find . -name '*.fot' -delete
	find . -name '*.cb' -delete
	find . -name '*.cb2' -delete
	find . -name '.*.lb' -delete
	find . -name '*.p' -delete
	find . -name '*.mtc*' -delete
	find . -name '*.maf' -delete
	find . -name '*.maf' -delete
	find . -name '*.pdf' -delete
	find . -name '*.stc*' -delete
	find . -name '*.bcf' -delete
	find . -name '*.fdb_latexmk' -delete
	find . -name '*.run.xml' -delete