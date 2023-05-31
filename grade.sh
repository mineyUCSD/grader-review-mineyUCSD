
if [[ `uname` == "MINGW64_NT-10.0-22621" ]]
then
    echo `uname`
    CPATH='.;hamcrest-core-1.3.jar;junit-4.13.2.jar'
else
    echo `uname`
    CPATH='.:hamcrest-core-1.3.jar:junit-4.13.2.jar'
fi



rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

files=`find ./student-submission`

a=0
tests=8

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

javac -cp $CPATH *.java

if [[ $? == "0" ]]
then 
    echo "compiled JUNIT, Student Files, and Tests"
else
    echo "compilation failed, check for errors in submitted file or test file"
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > JUnitOutput.txt

echo "Output redirected to ./grading-area/grade.sh"

echo "Analyzing JUnitOutput..."

success=`grep -o "OK" JUnitOutput.txt`

if [[ $success == "OK" ]]
then
    echo "All Tests Passed"
    echo "Total Tests: $tests"
    echo "Score: $tests/$tests"
    exit
fi

echo "Looks like some tests failed! Bozo Clown Baby!"

grep -i "Tests run:" JUnitOutput.txt | grep -Eo '[0-9]{1,4}' > ScoreReport.txt

testsRan=`sed -n 1p ScoreReport.txt`
testsFailed=`sed -n 2p ScoreReport.txt`
let "testsPassed = $testsRan - $testsFailed"

echo "Total Tests: $tests"
echo "Tests Ran: $testsRan"
echo "Tests Failed: $testsFailed"
echo "Tests Passed: $testsPassed"
echo "Score: $testsPassed/$tests"
exit


 








# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
