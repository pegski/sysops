FILENAME=./environment.local

if [[ "$OSTYPE" == *"darwin"* ]]; then
    FILENAME='./environment.osx'
fi

for line in $( cat ${FILENAME} ); do
    export $line;
    echo $line;
done
