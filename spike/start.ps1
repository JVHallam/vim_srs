
function setup([string]$template, [string]$outputPath){
    echo "running setup"
    cp $template $outputPath
}

function main([string]$file){
    echo "before";
    cat $file

    vim $file -c "source main.vim" -c "wq";
    echo "after"
    cat $file
}

function teardown([string]$file){
    echo "running teardown"
    rm $file
}

# Create the template
$templatePath = "template.txt";
$outputPath = "output.txt";

setup -template $templatePath -output $outputPath;
main -file $outputPath;
teardown -file $outputPath;
