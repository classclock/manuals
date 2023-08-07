FILES=$(find * -type f -name '*.tex')


VERSION=$GITHUB_REF_NAME

# if VERSION variable has a length of 0
if [ ! -n $VERSION ];
then
	VERSION=${GITHUB_SHA:0:7}
fi 

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