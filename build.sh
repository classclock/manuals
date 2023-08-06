FILES=$(find * -type f -name '*.tex')

SAVEIFS=$IFS   # Save current IFS (Internal Field Separator)
IFS=$'\n'      # Change IFS to newline char
FILES=($FILES) # split the `names` string into an array by the same name
IFS=$SAVEIFS   # Restore original IFS

for f in "${FILES[@]}";
do 
	latexmk -cd -pdf -nobibtex -aux-directory=out/ -outdir=.. -emulate-aux-dir "$f"
done
# mv "**/*.pdf" .