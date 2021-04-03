
function setup([string]$outputPath){
    echo "running setup"

    if(test-path $outputPath){
        rm $outputPath;
    }
}

function main([string]$outputFile){
    vim file.txt `
            -c "let outputFile='$($outputFile)'" `
            -c "source test/main.vim" `
            -c "q!" | out-null;
}

function teardown([string]$outputFile){
    echo "running teardown";

    $fileExists = test-path $outputFile
    if($fileExists){
        cat $outputFile
        Remove-Item -force $outputFile
    }
    else{
        echo "output file doesn't exist"
    }

}

# Create the template
$exOutputPath = "ex_output.txt"

setup -outputPath $exOutputPath;
main -outputFile $exOutputPath;
teardown -outputFile $exOutputPath;
