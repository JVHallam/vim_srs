
function setup([string]$template, [string]$outputPath){
    echo "running setup"
}

function main([string]$file){
    vim output.txt -c "source main.vim" -c "wq";
}

function checkState(){
    $result = test-path "temp"
    echo "does temp exist? : $($result)"
}

function teardown([string]$file){
    echo "running teardown"
    Remove-Item -force "temp"
}

# Create the template
$templatePath = "template.txt";
$outputPath = "output.txt";

setup -template $templatePath -output $outputPath;
main
checkState;
# teardown -file $outputPath;
