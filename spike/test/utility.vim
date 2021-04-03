function PrintErrors()
    for error in v:errors
        echo ""
        echo " ------------------------- "
        echo ""

        let lines = split(error, "\\.")

        let messages = filter(lines, {ind, val -> val != "" })

        for line in lines
            echo "-> " . line
        endfor
    endfor
endfunction
