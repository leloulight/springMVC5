/**
 * Created by 4535992 on 15/06/2015.
 */
/*** GET a CSV file on the web and load on the java script*/
function loadCSV(file) {
    var request;
    if (window.XMLHttpRequest) {
        // IE7+, Firefox, Chrome, Opera, Safari
        request = new XMLHttpRequest();
    } else {
        // code for IE6, IE5
        request = new ActiveXObject('Microsoft.XMLHTTP');
    }
    // load
    request.open('GET', file, false);
    request.send();
    parseCSV(request.responseText);
}
/*** And another method which will parse data: */
function parseCSV(data){
    //replace UNIX new lines
    data = data.replace (/\r\n/g, "\n");
    //replace MAC new lines
    data = data.replace (/\r/g, "\n");
    //split into rows
    var rows = data.split("\n");
    // loop through all rows
    for (var i = 0; i < rows.length; i++) {
        // this line helps to skip empty rows
        if (rows[i]) {
            // our columns are separated by comma
            var column = rows[i].split(",");

            // column is array now
            // first item is date
            var date = column[0];
            // second item is value of the second column
            var value = column[1];

            // create object which contains all these items:
            var dataObject = {
                date: date,
                visits: value
            };
            // add object to chartData array
            chartData.push(dataObject);
        }
    }
    chart.validateData();
}

/***
 * Convert a csv to a json file.
 * http://stackoverflow.com/questions/4811844/csv-to-json-with-php
 */
$json = csvToJson($csv);

function csvToJson($csv) {
    var $rows = explode("\n", trim($csv));
    var $data = array_slice($rows, 1);
    var $keys = array_fill(0, count($data), $rows[0]);
    var $json = array_map(function ($row, $key) {
        return array_combine(str_getcsv($key), str_getcsv($row));
    }, $data, $keys);

    return json_encode($json);
}

/*
 * None of these answers work with multiline cells, because they all assume a row ends with '\n'.
 * The builtin fgetcsv function understands that multiline cells are enclosed in " so it doesn't run
 * into the same problem. The code below instead of relying on '\n' to find each row of a csv lets
 * fgetcsv go row by row and prep our output.
 * @param $file file csv to convert
 * @returns {*} return value
 */
/*
function csv_to_json($file){

    $columns = fgetcsv($file); // first lets get the keys.
    $output = array(); // we will build out an array of arrays here.

    while(!feof($file)){ // until we get to the end of file, we'll pull in a new line
        $line = fgetcsv($file); // gets the next line
        $lineObject = array(); // we build out each line with our $columns keys
        foreach($columns as $key => $value){
            $lineObject[$value] = $line[$key];
        }
        array_push($output, $lineObject);
    }
    return json_encode($output); // encode it as json before sending it back
}*/
