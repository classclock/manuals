FILES=$(find * -type f -name '*.tex')

# Determine the most appropriate version to add to the filenames of individual files
# This determines the name from the following sources, using the highest available one on the list:
# - The first argument to this program
# - GITHUB_SHA environment variable - used for when the CI build job is triggered by a push
# - the git sha calculated from the current directory - used as a crude fallback

VERSION=${GITHUB_SHA:0:7}

if [ ! -n $VERSION ];
then
	VERSION=$(git rev-parse --short HEAD)
fi

if [ ! -z ${1} ];
then
	VERSION="$1"	
fi


SAVEIFS=$IFS   # Save current IFS (Internal Field Separator)
IFS=$'\n'      # Change IFS to newline char
FILES=($FILES) # split the `names` string into an array by the same name
IFS=$SAVEIFS   # Restore original IFS

for f in "${FILES[@]}";
do 
	latexmk -cd -pdf -nobibtex -aux-directory=out/ -outdir=.. -emulate-aux-dir "$f"
done

echo "$VERSION"

for i in *.pdf;
do
	name=${i%.*}
	echo "$name"

	# if VERSION variable has nonzero length, prepend the dash as we have a version to include in the filename
	if [ -n $VERSION ];
	then
		VERSION="-$VERSION"
	fi

	mv "$i" "$name$VERSION.pdf";
done