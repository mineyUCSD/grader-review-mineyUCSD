
CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

files=`find ./student-submission`

a=0

for file in $files
do
    if [[ -f $file ]] && [[ $file == *ListExamples.java* ]]
    then
        let "a = $a + 1"
    fi
done

if [[ $a == "1" ]]
then
    echo "Found ListExamples.java"
else 
    echo "Could not locate ListExamples.java in your submission"
    exit
fi

echo "copying stage"

cp ./student-submission/ListExamples.java grading-area
cp TestListExamples.java grading-area
cp ./lib/hamcrest-core-1.3.jar grading-area
cp ./lib/junit-4.13.2.jar grading-area

cd ./grading-area

javac -cp ".;hamcrest-core-1.3.jar;junit-4.13.2.jar" *.java

if [[ $? == "0" ]]
then 
    echo "compiled JUNIT, Student Files, and Tests"
else
    echo "compilation failed, check for errors in submitted file or test file"
    exit
fi

java -cp ".;hamcrest-core-1.3.jar;junit-4.13.2.jar" org.junit.runner.JUnitCore TestListExamples > ScoreReport.txt

echo "Output redirected to ./grading-area/grade.sh"

cat ScoreReport.txt


echo "Analyzing ScoreReport"

grep -i "OK" ScoreReport.txt > Grader.txt

grep -i "Ok" ScoreReport.txt

tests=1




# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
