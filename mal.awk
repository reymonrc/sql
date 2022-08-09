BEGIN { FS = "," }

{
    # Keep count of the fields in second column
    count[$1]++;

    # Save the line the first time we encounter a unique field
    if (count[$1] == 1)
        first[$1] = $0;

    # If we encounter the field for the second time, print the
    # previously saved line
    # if (count[$1] == 2 )
    #    print first[$1];

    # From the second time onward. always print because the field is
    # duplicated
    if (count[$1] > 1 && $13 == "INSCRITO")
        print
}
