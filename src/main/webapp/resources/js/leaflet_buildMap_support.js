    /**
    * Created by 4535992 on 11/06/2015.
    */
    //support variables
    /*var basemap = new L.TileLayer(baseUrl, {
     maxZoom: 17,
     attribution: 'Data, imagery and map information provided by <a href="http://open.mapquest.co.uk" target="_blank">MapQuest</a>,' +
     ' <a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a> and contributors,' +
     ' <a href="http://creativecommons.org/licenses/by-sa/2.0/" target="_blank">CC-BY-SA</a>',
     subdomains: '1234',
     opacity: 1.0
     });*/
    var map;
    var clickLayer = new L.LayerGroup();
    var GPSLayer = new L.LayerGroup();
    var markerClusters = new L.MarkerClusterGroup({showCoverageOnHover: false, maxClusterRadius: 50});

    // VARIABILI PER LA FUNZIONALITA' DI RICERCA SERVIZI
    var GPSControl;
    var selezione;

    //Variabili suppport java SPRING
    var nameVar,urlVar,latVar,lngVar; //basic info
    var regionVar,provinceVar,cityVar,addressVar,phoneVar,emailVar,faxVar,ivaVar; //other info
    var arrayMarkerVar =[]; // array support of makers

    //VARAIABILI SUPPORTO CSV
    var fieldSeparatorCSV = "|";
    var lineSeparatorCSV ='\n';
    var titleMarker1 = "Name";
    var titleMarker2 = "";

    /*** Set a personal icon marker */
    var deathIcon = L.icon({
        iconUrl: '../leaflet/images/marker-shadow.png',
        //iconRetinaUrl: myURL + 'img/me.png',
        iconSize: [36, 36],
        iconAnchor: [18, 18],
        popupAnchor: [0, -18],
        labelAnchor: [14, 0] // as I want the label to appear 2px past the icon (18 + 2 - 6)
    });

    /*** Set the src of the javascript file*/
    //var mySRC = jQuery('script[src$="resources/js_utility/leaflet_buildMap_support.js"]').attr('src').replace('js_utility/leaflet_buildMap_support.js', '');

    /*** On ready document  */
    $( document ).ready(function() {
        //oppure $( window ).load(function(){
        //loading map...
        //$('#caricamento').delay(500).fadeOut('slow');
        // all'apertura della pagina CREO LE TABS JQUERY UI NEL MENU IN ALTO
        $( "#tabs" ).tabs();
        initMap();
        //set a listener on the uploader button
        $("#uploader").on('change',handleFilesCSV);
        var uploader = document.getElementById("#uploader");
        uploader.addEventListener("change", handleFilesCSV, false);

        //Localize all Location near you
        $('#localizeName2').click(function(e) {
            map.locate();
            $('#localizeName2').text('Localization...');
            map.on('locationfound', function(e) {
                map.setView(e.latlng, 15);
                $('#localizeName2').text('Finding...');
            });
        });

        $("#clear").click(function(evt){
            evt.preventDefault();
            $("#filter-string").val("").focus();
            addCsvMarkers();
        });

        /*** remove all cluster marker with a click on the reset button */
        $('#pulsante-reset').click(function(evt) {
            evt.preventDefault();
            removeClusterMarker();
        });

        //if you have add a new marker from spring put in the map.
        if((!$.isEmptyObject(arrayMarkerVar)) && arrayMarkerVar.length > 0){
            addMultipleMarker(arrayMarkerVar);
        }
    });

    /** Method that checks that the browser supports the HTML5 File API*/
    function browserSupportFileUpload() {
        var isCompatible = false;
        if (window.File && window.FileReader && window.FileList && window.Blob) {
            isCompatible = true;
        }else{
            alert('The File APIs are not fully supported in this browser.');
        }
        return isCompatible;
    }

    var dataCsv;
    function handleFilesCSV(evt){
        //var nameCSVFile = handleFileSelect(evt);
        var fileName = evt.target.files[0].name;
        var dataUrl = 'resources/file/'+fileName;
        alert("nameCSVFile:"+dataUrl);
        //loadCSVFromURL(dataUrl);
        $.ajax ({
            type:'GET',
            dataType:'text',
            url: dataUrl,
            contentType: "text/csv; charset=utf-8",
            error: function() {
                alert('Error retrieving csv file');
            },
            success: function(csv) {
                dataCsv = csv;
                populateTypeAhead(csv, fieldSeparatorCSV);
                typeAheadSource = ArrayToSet(typeAheadSource);
                $('#filter-string').typeahead({source: typeAheadSource});
                loadCSVFromURL(dataUrl);
                alert("points:"+points);
                addCsvMarkers();
                map.fitBounds(cluster.getBounds());
            }
        });
    }

    /** function utility for select multiple file
     *  http://www.html5rocks.com/en/tutorials/file/dndfiles/
     */
    function handleFileSelect(evt) {
        if (!browserSupportFileUpload()) {
            alert('The File APIs are not fully supported in this browser!');
        } else {
            var files = evt.target.files; // FileList object
            //var file = evt.target.files[0]; // singleFile
            // files is a FileList of File objects. List some properties.
            //var output = [];
            for (var i = 0, f; f = files[i]; i++) {
                /* output.push('<li><strong>', escape(f.name), '</strong> (', f.type || 'n/a', ') - ',
                 f.size, ' bytes, last modified: ',
                 f.lastModifiedDate ? f.lastModifiedDate.toLocaleDateString() : 'n/a',
                 '</li>');*/
                // Only process csv files.
                if (!f.type.match('.+(\.csv)$'))  continue;
                var reader = new FileReader();
                alert("csv 3");
                // Read in the image file as a data URL.
                //reader.readAsDataURL(f); //for image...
                reader.readAsText(f); // fir file text.
                alert("csv 4");
                // Closure to capture the file information.
                /*reader.onload = (function(theFile) {
                 return function(e) {
                 // Render thumbnail.
                 var span = document.createElement('span');
                 /!*span.innerHTML = ['<img class="thumb" src="', e.target.result,
                 '" title="', escape(theFile.name), '"/>'].join('');*!/
                 document.getElementById('list').insertBefore(span, null);
                 };
                 })(f);*/
                //for CSV...
                reader.onload = (function (event) {
                    //var csvData = event.target.result;
                    var data = $.csv.toArrays(event.target.result);
                    if (data && data.length > 0) {
                        alert('Imported -' + data.length + '- rows successfully!');
                        return data;
                    } else {
                        alert('No data to import!');
                    }
                });
                reader.onerror = function (event) {
                    alert('Unable to read ' + event.target.name);
                };

            }
        }//else
        //document.getElementById('list').innerHTML = '<ul>' + output.join('') + '</ul>';
    }

    /** function for get the content of a file e.g. readTextFile("file:///C:/your/path/to/file.txt");*/
    function readTextFile(file) {
        var rawFile = new XMLHttpRequest();
        try {
            rawFile.open("GET", file, false);
        }catch(e){
            rawFile.open("GET", "file:///"+file, false);
        }
        rawFile.onreadystatechange = function ()
        {
            if(rawFile.readyState === 4)
            {
                if(rawFile.status === 200 || rawFile.status == 0)
                {
                    var allText = rawFile.responseText;
                    alert(allText);
                }
            }
        }
        rawFile.send(null);
    }
    /***
     *  Set the map and zoom on the specific location
     */
    function initMap() {
        alert("Init Map...");
        if(map==null) {
            //valori fissi per il settaggio iniziale della mappa....
            var latitude = 43.3555664; //43.3555664 40.46
            var longitude = 11.0290384; //11.0290384  -3.75
            try {
                if ($.isEmptyObject(markerClusters)) {
                    markerClusters = new L.MarkerClusterGroup();
                }
                L.Map = L.Map.extend({
                    openPopup: function(popup) {
                        //        this.closePopup();  // just comment this
                        this._popup = popup;

                        return this.addLayer(popup).fire('popupopen', {
                            popup: this._popup
                        });
                    }
                });
                //Set map with leave all popup open...
                map = new L.map('map', {attributionControl:false}).setView([latitude, longitude], 5);
                //map = new L.map('map', {center: center, zoom: 2, maxZoom: 9, layers: [basemap],attributionControl:false})
                // .setView([latitude, longitude], 5);
                //Make all popup remain open.

                //Build your map
                L.tileLayer('http://c.tiles.mapbox.com/v3/examples.map-szwdot65/{z}/{x}/{y}.png', { // NON MALE
                    attribution: 'Map data &copy; 2011 OpenStreetMap contributors, Imagery &copy; 2012 CloudMade',
                    key: 'BC9A493B41014CAABB98F0471D759707',
                    subdomains: ['otile1', 'otile2', 'otile3', 'otile4'],
                    //minZoom: 8,
                    maxZoom: 18
                }).addTo(map);
                /*var url = 'http://otile{s}.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.jpeg',
                 attr ='Tiles Courtesy of <a href="http://www.mapquest.com/">MapQuest</a> &mdash; Map data {attribution.OpenStreetMap}',
                 service = new L.TileLayer(url, {subdomains:"1234",attribution: attr});
                 map.addLayer(service).fitBounds(bounds);
                 */
                //Set a bound window for the leaflet map
                //var bounds = new L.LatLngBounds(new L.LatLng(setBounds[0],setBounds[1]), new L.LatLng(setBounds[2], setBounds[3]));
                //map.setMaxBounds(new L.LatLngBounds(new L.LatLng(41.7, 8.4), new L.LatLng(44.930222, 13.4)));
                //..add many functionality
                addPluginGPSControl();
                addPluginCoordinatesControl();
                addPluginLayersStamenBaseMaps();
                addPluginLocateControl();
                //..add other functionality
                map.on('click', onMapClick);
                //Fired when the view of the map stops changing
                map.on('moveend', onMapMove);
                alert("MAP IS SETTED");
                //$('#caricamento').delay(500).fadeOut('slow');
            } catch (e) {
                alert('Exception:' + e.message);
            }
        }
    }

    /***
     * Set plugin for gps on the leaflet
     * https://github.com/stefanocudini/leaflet-gps
     */
    function addPluginGPSControl() {
        GPSControl = new L.Control.Gps({maxZoom: 16,style: null});
        map.addControl(GPSControl);
    }

    /***
     * Set the coordinates plugin on leaflet, add a window with the value of coordinates
     * https://github.com/MrMufflon/Leaflet.Coordinates
     */
    function addPluginCoordinatesControl() {
        //add standard controls
        L.control.coordinates({
            position:"bottomleft", //optional default "bootomright"
            decimals:2, //optional default 4
            decimalSeperator:".", //optional default "."
            labelTemplateLat:"Latitude: {y}", //optional default "Lat: {y}"
            labelTemplateLng:"Longitude: {x}", //optional default "Lng: {x}"
            enableUserInput:true, //optional default true
            useDMS:false, //optional default false
            useLatLngOrder: true, //ordering of labels, default false-> lng-lat
            markerType: L.marker, //optional default L.marker
            markerProps: {} //optional default {}
        }).addTo(map);

        L.control.coordinates({
            useDMS: true,
            labelTemplateLat: "N {y}",
            labelTemplateLng: "E {x}",
            useLatLngOrder: true
        }).addTo(map);

    }

    /*** function to request the list of markers (in JSON) for the current map viewport:
     * response from the server is like:
     * [{"name":"Tunbridge Wells, Langton Road, Burnt Cottage",
     * "lon":"0.213102",
     * "lat":"51.1429",
     * "details":"A Grade II listed five bedroom wing in need of renovation."}
     */
    function askForPlots(){
        var javaMarker = askForPlotsWithJQuery2();
        map.addLayer(markerClusters);
        return javaMarker;
    }//askForPLots3

    /**..if you use jquery */
    function askForPlotsWithJQuery(URL){
        if(arrayMarkerVar.length >0 ) {
            //alert("exists a marker on the array!!")
            removeClusterMarker();
        }
        $.getJSON(URL, function(jsonData) {
            //alert( "Data Loaded from url:"+ URL + " = "+ data );
            //alert( "Data Loaded 2: " + jsonData);
        }).done(function(data) {
            //$('#div4').append('getJSON request succeeded! </li>');
            try {
                //...test with response from google api
                var jsonString = JSON.stringify(data);
                alert( "JSON STRING: " + jsonString );
                if ($.isEmptyObject(data.results))
                {
                    alert("Json array is empty: " + data.results[0]);
                }
                //http://stackoverflow.com/questions/13382364/jquery-and-json-array-how-to-check-if-array-is-empty-or-undefined
                else if (data.results == undefined || data.results == null || data.results.length == 0
                    || (data.results.length == 1 && data.results[0] == "")){
                    alert("Json array is empty 2: " + data.results[0]);
                }
                else {
                    //alert("Data Loaded: " + data.results[0]);
                }
                var name = data.results[0].address_components[0].long_name;
                var lat = data.results[0].geometry.location.lat;
                var lng = data.results[0].geometry.location.lng;
                //alert("NAME:"+ name +",COORDINATES:["+ lat +","+ lng +"]");
                addSingleMarker(name,URL,lat,lng);
                alert("getJSON request succeeded!");
            }catch(e){
                alert( "getJSON request failed:"+e.message );
                //jsonData = $.parseJSON(data);
            }
        })
        .fail(function() {
            //$('#div4').append('getJSON request failed! </li>');
            alert( "getJSON request failed!");
        })
        .always(function() {
            //$('#div4').append('getJSON request ended! </li></li>');
            alert( "getJSON request ended!" );
        });
    }//...askForPlotsWith JQUERY

    /**..if you use jquery*/
    function askForPlotsWithJQuery2(URL){
        var javaMarker;
        if(arrayMarkerVar.length >0 ) {
            //alert("exists a marker on the array!!")
            removeClusterMarker();
        }
        $.getJSON(URL, function(jsonData) {
            //alert( "Data Loaded from url:"+ URL + " = "+ data );
            alert( "Data Loaded 2: " + jsonData);
            /*
             var sayingsList = [];
             $.each(data, function(key, val) {
             sayingsList.push('<li>' + val + '</li>');
             });
             $('<ul/>', {
             html: sayingsList.join('')
             }).appendTo('#div4');*/
        }).done(function(data) {
                //$('#div4').append('getJSON request succeeded! </li>');
                try {
                    //...test with response from google api
                    var jsonString = JSON.stringify(data);
                    alert( "JSON STRING: " + jsonString );
                    if ($.isEmptyObject(data.results))
                    {
                        alert("Json array is empty: " + data.results[0]);
                    }
                    //http://stackoverflow.com/questions/13382364/jquery-and-json-array-how-to-check-if-array-is-empty-or-undefined
                    else if (data.results == undefined || data.results == null || data.results.length == 0
                        || (data.results.length == 1 && data.results[0] == "")){
                        alert("Json array is empty 2: " + data.results[0]);
                    }
                    else {
                        //alert("Data Loaded: " + data.results[0]);
                    }
                    var name = data.results[0].address_components[0].long_name;
                    var lat = data.results[0].geometry.location.lat;
                    var lng = data.results[0].geometry.location.lng;
                    //alert("NAME:"+ name +",COORDINATES:["+ lat +","+ lng +"]");
                    javaMarker = addSingleMarker(name,URL,lat,lng);
                    alert("getJSON request succeeded!");
                    return javaMarker;
                }catch(e){
                    alert(e.message );
                    alert( "getJSON request failed!");
                    //jsonData = $.parseJSON(data);
                }
                return javaMarker = {name:null, url:null, latitudine:null,longitudine:null};
            })
            .fail(function() {
                //$('#div4').append('getJSON request failed! </li>');
                alert( "getJSON request failed!");
                return javaMarker = {name:null, url:null, latitudine:null,longitudine:null};
            })
            .always(function() {
                //$('#div4').append('getJSON request ended! </li></li>');
                alert( "getJSON request ended!" );
            });

    }//...askForPlotsWith JQUERY 2

    /** if you use AJAX */
    function askForPlotsWithAJAX(URL) {

        function AjaxRequest() {
            var activeXmodes = ["Msxml2.XMLHTTP", "Microsoft.XMLHTTP"]; //activeX versions to check for in IE
            if (window.ActiveXObject) { //Test for support for ActiveXObject in IE first (as XMLHttpRequest in IE7 is broken)
                for (var i = 0; i <  activeXmodes.length; i++) {
                     try {
                        return new ActiveXObject( activeXmodes[i]);
                    }
                    catch (e) {
                        //suppress error
                    }
                }
            }
            else if (window.XMLHttpRequest) // if Mozilla, Safari etc
                 return new XMLHttpRequest();
            else
                return false;
         }//..end ajaxrequest

         var mygetrequest = new AjaxRequest();
         mygetrequest.onreadystatechange = function () {
             if (mygetrequest.readyState == 4) {
                if (mygetrequest.status == 200 || window.location.href.indexOf("http") == -1) {
                    var jsondata = eval("(" + mygetrequest.responseText + ")"); //retrieve result as an JavaScript object
                    //window.alert("sondata:"+jsondata);
                    if (jsondata.meta.code == 200) {
                         var info = jsondata.response.groups[0];
                        //window.alert("INFO:"+info);
                        //..check if exists a correct json reaponse
                        if (typeof info != 'undefined') {
                            //...response json standard di Foursquare
                        } else {
                            //una risposta json con differente struttura da parte di Foursquare
                            alert("Errore in fase di elaborazione della risposta JSON");
                        }
                    } else {
                        alert("Errore nella risposta del server");
                    }//...if meta code request 200
                }
                else {
                    alert("Errore nella richiesta al server");
                }//...if code request 200
             }//...if code request 4
         };//... end ajaxrequest
         //mygetrequest.open("GET", "javascriptkit.json", true)
         mygetrequest.open("GET", URL, true);
         mygetrequest.send(null);
         window.alert("compiled askForPlots2 with arguments");
    }//...askForPlotsWith AJAX

    /***
     * Set the Leaflet.markercluster for Leaflet
     * https://github.com/Leaflet/Leaflet.markercluster
     */


    /*** Example how add a json object like a layer on leaflet*/
    /*function addMarkerFromGeoJsonObject() {
        L.mapbox.featureLayer({
            // this feature is in the GeoJSON format: see geojson.org
            // for the full specification
            type: 'Feature',
            geometry: {
                type: 'Point',
                // coordinates here are in longitude, latitude order because
                // x, y is the standard for GeoJSON and many formats
                coordinates: [39.53833, -8.64106]
            },
            properties: {
                title: 'A Single Marker',
                description: 'Just one of me',
                // one can customize markers by adding simplestyle properties
                // http://mapbox.com/developers/simplestyle/
                'marker-size': 'large',
                'marker-color': '#f0a'
            }
        }).addTo(map);
    }*/

    /***
     * When the response json from the server arrive
     * we’ll clear the existing markers and display the new ones, creating a rudimentary pop-up window for each one
     * */
    /*function stateChanged() {
        // if AJAX returned a list of markers, add them to the map
        if (ajaxRequest.readyState == 4) {
            //use the info here that was returned
            if (ajaxRequest.status == 200) {
                var resp=ajaxRequest.responseText.replace("[^\u000A\u0020-\u007E]", "");
                plotlist = eval("(" + resp + ")");
                removeMarkers();
                for (var i = 0; i < plotlist.length; i++) {
                    var plotll = new L.LatLng(plotlist[i].lat, plotlist[i].lon, true);
                    var plotmark = new L.Marker(plotll);
                    plotmark.data = plotlist[i];
                    map.addLayer(plotmark);
                    plotmark.bindPopup("<h3>" + plotlist[i].name + "</h3>" + plotlist[i].details);
                    plotlayers.push(plotmark);
                }
            }else{
                window.alert("server response is not 200");
            }
        }
    }*/

    /*** function to Remove all marker on the plotLayer level */
    function removeMarkers() {
        /*for (var i = 0; i < markerClusters.length; i++) {
            map.removeLayer(markerClusters[i]);
        }
        */
        map.removeLayer(markerClusters);
    }

    /*** function for remove all cluster when the map is move */
    function onMapMove() {
        //Se muovi la mappa rimuove tutti i marker funziona!!.
        //removeClusterMarker();
    }


    /*** function Set a popup when you click on the map*/
    var popupGlobal = L.popup();
    function onMapClick(e) {
        popupGlobal.setLatLng(e.latlng).setContent("You clicked the map at " + e.latlng.toString()).openOn(map);
    }


    /*** function for add a marker to the leaflet map */
    var marker;
    function addSingleMarker(name, url, lat, lng) {
        //alert("... add single marker:" + name + ',' + url + ',' + lat + ',' + lng);
        try {
            if ($.isEmptyObject(markerClusters)) {
                markerClusters = new L.MarkerClusterGroup();
            }
            /*var marker = L.marker([lat, lng]).addTo(map);
             //...set the popup on mouse click
             marker.bindPopup('<a href="' + url + '" target="_blank">' + name + '</a>').openPopup();*/
            var text = '<a class="linkToMarkerInfo" href="' + url + '" target="_blank">' + name + '</a>';
            var popupClick = new L.popup().setContent(text);
            //var marker = L.marker([lat, lng]).bindPopup(popupClick).addTo(map);
            //var cc = L.latLng(43.7778535, 11.2593572);
            //var marker = new L.marker([parseFloat(lat), parseFloat(lng)]).addTo(map);
            try {
                marker = new L.marker([parseFloat(lat), parseFloat(lng)], {draggable:false}, { icon: deathIcon})
                    .bindLabel(text, { noHide: true }).addTo(map);
            }catch(e){
                try{
                    marker = new L.marker([lat, lng], {draggable:false}, { icon: deathIcon})
                        .bindLabel(text, { noHide: true }).addTo(map);
                }catch(e){
                    alert("Sorry the program can't find Geographical coordinates for this Web address,check if the Web address is valid");
                }
            }
            //...set the popup on mouse over
            //var latlngOver = L.latLng(latVar, lngVar);
            var popupContent = '<div class="popup-content"><table class="table table-striped table-bordered table-condensed">';
            popupContent += attr = '<a target="_blank" href="' + url + '">'+ name + '</a>';
            popupContent += '<tr><th>'+title+'</th><td>'+ attr +'</td></tr>'+
                            '<tr><th>Regione:</th><td>'+regionVar+'</td></tr>'+
                            '<tr><th>Provincia:</th><td>'+provinceVar+'</td></tr>'+
                            '<tr><th>Città:</th><td>'+cityVar+'</td></tr>'+
                            '<tr><th>Indirizzo:</th><td>'+addressVar+'</td></tr>'+
                            '<tr><th>Telefono/Cellulare:</th><td>'+phoneVar+'</td></tr>'+
                            '<tr><th>Fax:</th><td>'+faxVar+'</td></tr>'+
                            '<tr><th>Email:</th><td>'+emailVar +'</td></tr>'+
                            '<tr><th>IVA:</th><td>'+ivaVar+'</td></tr>';
            popupContent += "</table></popup-content>";
            var popupOver = new L.popup().setContent(popupContent);
            //marker.bindPopup(popupClick);
            marker.bindPopup(popupOver);
            //..set some action for the marker
            //evt.target is the marker where set the action
            marker.on('mouseover', function (e) {e.target.bindPopup(popupOver).openPopup();});
            marker.on('mouseout', function (e) { e.target.closePopup();});
            marker.on('click', function (e) { e.target.bindPopup(popupClick).openPopup();});
            marker.on('dblclick',function (e) { map.removeLayer(e.target)});
            /*marker.on('click', onMarkerClick(), this);*/

            //..add marker to the array of cluster marker
            markerClusters.addLayer(marker);
            //...set to a Global variable for use with different javascript function
            //map.addLayer(markerClusters);
            markerClusters.addTo(map);
            map.setView([lat, lng], 8);
            //return {name: name, url: url, latitudine: lat, longitudine: lng};
        }catch(e) {
            alert("Sorry the program can't create the Marker for this Web address, check if the Web address is valid");
        }
    }

    /*** function for remove all cluster marker on the leaflet map */
    function removeClusterMarker(){
        alert("compile removeClusterMarker");
        if(arrayMarkerVar.length > 0) {
            for (var i = 0; i < arrayMarkerVar.length; i++) {
                map.removeLayer(arrayMarkerVar[i]);//...remove every single marker
            }
            arrayMarkerVar.length = 0; //...reset array
        }
        map.removeLayer(markerClusters);//....remove layer
        points.clearLayers();
        alert("compiled removeClusterMarker");
    }



    /***  Set constructor variable for leaflet_buildMap_support */
    var leaflet_buildMap_support = {
        // Get a list of marker with coordinates and a url href and put the marker on the map
        initMap: function () {
            if(map==null){
                initMap();
            }
        },
        addSingleMarker: function (name, url, lat, lng) {
           addSingleMarker(name,url,lat,lng);
        },
        pushMarkerToArrayMarker: function(nameVar,urlVar,latVar,lngVar,regionVar,provinceVar,cityVar,addressVar,phoneVar,emailVar,faxVar,ivaVar){
            //pushMarkerToArrayMarker();
            pushMarkerToArrayMarker(nameVar,urlVar,latVar,lngVar,regionVar,provinceVar,cityVar,addressVar,phoneVar,emailVar,faxVar,ivaVar);
        },
        loadCSVFromURL: function(url){
            loadCSVFromURL(url);
        }
    };


    /*** CLICCANDO SUL PULSANTE GPS VENGONO SALVATE LE COORDINATE ATTUALI PER LA RICERCA DI SERVIZI */
    $('.gps-button').click(function () {
        if (GPSControl._isActive == true) {
            selezione = 'Posizione Attuale';
            $('#selezione').html(selezione);
            coordinateSelezione = "Posizione Attuale";
            $('#raggioricerca').prop('disabled', false);
            $('#numerorisultati').prop('disabled', false);
        }
    });

    /*** AL CLICK SUL PULSANTE DI SELEZIONE PUNTO SU MAPPA IN ALTO
     * A SX ATTIVO O DISATTIVO LA FUNZIONALITA' DI RICERCA*/
    $('#info').find('img').click(function () {
        if ($( this ).hasClass("active") == false) {
            $( this ).addClass("active");
            selezioneAttiva = true;
        }
        else {
            $( this ).removeClass("active");
            selezioneAttiva = false;
        }
    });


   /*** function to open a URL with javascript without jquery */
   function openURL(url){
       // similar behavior as an HTTP redirect
       window.location.replace(url);
        // similar behavior as clicking on a link
       window.location.href = url;
   }

    /** function to add for every single object marker a Leaflet Marker on the Leaflet Map  */
    function addMultipleMarker(markers){
       alert("add multiple marker "+markers.length+"...");
       // Define an array. This could be done in a seperate js file.
       // This tidy formatted section could even be generated by a server-side script
       // or fetched seperately as a jsonp request.
       //Loop through the markers array
        try {
            for (var i = 0; i < markers.length; i++) {
                alert("... add single marker (" + i + "):"
                    + markers[i].name + ',' + markers[i].url + ',' + markers[i].lat + ',' + markers[i].lng);
                regionVar = markers[i].region;
                provinceVar = markers[i].province;
                cityVar =  markers[i].city;
                addressVar =  markers[i].address;
                phoneVar =  markers[i].phone;
                emailVar =  markers[i].email;
                faxVar =  markers[i].fax;
                ivaVar =  markers[i].iva;
                addSingleMarker(markers[i].name, markers[i].url, markers[i].lat, markers[i].lng)
            }
            alert("... addeed multiple marker");
        }catch(e){
            alert(e.message);
        }
    }


    /** function to add every single company from java object in JSP page to a javascript array*/
    function pushMarkerToArrayMarker(nameVar,urlVar,latVar,lngVar,regionVar,provinceVar,cityVar,addressVar,phoneVar,emailVar,faxVar,ivaVar){
        /*nameVar = document.getElementById('nameForm').value;*/
        //alert("pushing the element =>Name:" + nameVar + ',URL:' + urlVar + ',LAT:' + latVar + ',LNG:' + lngVar+"...");
        var markerVar = { name:nameVar,url:urlVar,lat:latVar,lng:lngVar,
            region:regionVar,province:provinceVar,city:cityVar,address:addressVar,phone:phoneVar,email:emailVar,
            fax:faxVar, iva:ivaVar};
        //alert("....pushed a marker tot he array on javascript side:"+ markerVar.toString());
        arrayMarkerVar.push(markerVar);
    }

    /**
     * Add the leaflet plugin Stamen Layer.
     * https://github.com/stamen/maps.stamen.com
     */
    function addPluginLayersStamenBaseMaps() {
        if (map != null) {
            //var layers = ["terrain", "watercolor","toner"];
            //http://c.tiles.mapbox.com/v3/examples.map-szwdot65/{z}/{x}/{y}.png
            var bases = {
                "Watercolor": new L.StamenTileLayer("watercolor"),
                "Terrain": new L.StamenTileLayer("terrain"),
                "Toner": new L.StamenTileLayer("toner"),
                "Disit": new L.StamenTileLayer("disit")
            };
            L.control.layers(bases).addTo(map);
        }
    }

    /** Add the leaflet plugin  locateControl.
     *  https://github.com/domoritz/leaflet-locatecontrol
     */
    function addPluginLocateControl() {
        if (map != null) {
            /*L.Control.MyLocate = L.Control.Locate.extend({
                drawMarker: function () {
                    // override to customize the marker
                }
            });*/
            // add location control to global name space for testing only
            // on a production site, omit the "lc = "!
            //var lc = new L.Control.MyLocate();
            //var lc = new L.Control.Locate();
            // create control and add to map
            var lc = new L.control.locate({
                position: 'topleft',  // set the location of the control
                layer: new L.LayerGroup(),  // use your own layer for the location marker
                drawCircle: true,  // controls whether a circle is drawn that shows the uncertainty about the location
                follow: false,  // follow the user's location
                setView: true, // automatically sets the map view to the user's location, enabled if `follow` is true
                keepCurrentZoomLevel: false, // keep the current map zoom level when displaying the user's location. (if `false`, use maxZoom)
                stopFollowingOnDrag: false, // stop following when the map is dragged if `follow` is true (deprecated, see below)
                remainActive: false, // if true locate control remains active on click even if the user's location is in view.
                markerClass: L.circleMarker, // L.circleMarker or L.marker
                circleStyle: {},  // change the style of the circle around the user's location
                markerStyle: {},
                followCircleStyle: {},  // set difference for the style of the circle around the user's location while following
                followMarkerStyle: {},
                icon: 'fa fa-map-marker',  // class for icon, fa-location-arrow or fa-map-marker
                iconLoading: 'fa fa-spinner fa-spin',  // class for loading icon
                circlePadding: [0, 0], // padding around accuracy circle, value is passed to setBounds
                metric: true,  // use metric or imperial units
                onLocationError: function (err) {
                    alert(err.message)
                },  // define an error callback function
                onLocationOutsideMapBounds: function (context) { // called when outside map boundaries
                    alert(context.options.strings.outsideMapBoundsMsg);
                },
                showPopup: true, // display a popup when the user click on the inner marker
                strings: {
                    title: "Show me where I am",  // title of the locate control
                    metersUnit: "meters", // string for metric units
                    feetUnit: "feet", // string for imperial units
                    popup: "You are within {distance} {unit} from this point",  // text to appear if user clicks on circle
                    outsideMapBoundsMsg: "You seem located outside the boundaries of the map" // default message for onLocationOutsideMapBounds
                },
                locateOptions: {}  // define location options e.g enableHighAccuracy: true or maxZoom: 10
            });
            lc.addTo(map);
            // request location update and set location (e.g. onLoad page)
            //lc.start();

            map.on('startfollowing', function() {
                map.on('dragstart', lc._stopFollowing, lc);
            }).on('stopfollowing', function() {
                map.off('dragstart', lc._stopFollowing, lc);
            });
        }
    }


    /** Move marker to confirm that label moves when marker moves (first click)
     * Remove marker on click so we can check that the label is also removed (second click)
     */
   /* function onMarkerClick() {
        var clicks = 0;
        clicks++;
        if (clicks === 1) {
            marker.setLatLng(map.getCenter());
        } else {
            marker.off('click', onMarkerClick);
            map.removeLayer(m);
            if(clicks > 1) clicks = 0;
        }
    }*/

    //------------------------------------------------------
    // LOAD JSON
    //------------------------------------------------------

    function addMarkerFromJSONFile(urlToJson){

        /*var popmaps = function(feature,layer){
            var popUp = feature.properties.name;
            layer.bindPopup(String(popUp));
        };
        L.geoJson(fileJSON, {
            pointToLayer:function (feature, latlng) {
                return L.marker(latlng, {
                    fillColor: "#000000",
                    color: "green",
                    opacity: 1
                });
            },
            onEachFeature:popmaps
        }).addTo(map);*/

        // grab the processed & scrambled GeoJSON through an ajax call
        var geojsonFeature = (function() {
            var json = null;
            $.ajax({
                'async': false,
                'global': false,
                'url': urlToJson, //"/data/test_random.json"
                'dataType': "json",
                'success': function (data) {
                    json = data;
                }
            });
            return json;
        })();

        // grab original GeoJSON
        /*var geojsonOriginal = (function() {
            var json = null;
            $.ajax({
                'url': urlToJson, //"/data/test_random.json"
                'dataType': "json",
                'jsonpCallback': 'getJson',
                'success': function (data) {
                    json = data;
                }
            });
            return json;
        })();*/
        // create an object to store marker style properties
        /*var geojsonMarkerOptions = {
            radius: 10,
            fillColor: "rgb(255,0,195)",
            color: "#fff",
            weight: 2,
            opacity: 1,
            fillOpacity: 1
        };*/

        // load the geojson to the map with marker styling
        L.geoJson(geojsonFeature, {
            style: function (feature) {
                return feature.properties && feature.properties.style;
            },
            onEachFeature:  function onEachFeature(feature, layer) {
                // on each feature use feature data to create a pop-up
                var popupContent = feature.properties.t;
                // create a new variable to store Date in
                var time = new Date(0);
                // create a date by passing it the Unix UTC epoch
                time.setUTCSeconds(popupContent);
                popupContent = time;
                //console.log(popupContent);
                //return time;
                layer.bindPopup(popupContent);
            }
        }).addTo(map);
    }

    //------------------------------------------------------
    //LOAD CSV
    //-----------------------------------------------------
    /**
     * function for parse a url given on the HTML code.
     * e.g. <a href="?csv=48.8566;;2.3522;;París, capital de Francia||40.4168;;-3.7038;;</a>
     */
    function getFromURL(urlCSV) {
        //The methods your tried don't take an URL as argument, but parse the current URL parameters
        //var csv = window.location.href.slice(window.location.href.indexOf('?') + 1);
        var csv = urlCSV.slice(urlCSV.indexOf('?') + 1);
        csv = csv.split('csv=');
        if (csv.length != 2) {
            csv = '';
        } else {
            csv = csv[1];
        }
        return decodeURIComponent(csv);
    }

    /**configuración del GeoCSV, cambiamos el separador de líneas y el de campos por otros más apropiados para las URL*/
    function loadCSVFromHTML(){
        var capaGeoCSV = L.geoCsv (getFromURL(), {
            onEachFeature:function(f,l) {
                var popup = f.properties.popup;
                l.bindPopup(popup);
            },
            lineSeparator: '||',
            fieldSeparator: fieldSeparatorCSV
        });
    }

    function ArrayToSet(a) {
        var temp = {};
        for (var i = 0; i < a.length; i++)
            temp[a[i]] = true;
        var r = [];
        for (var k in temp)
            r.push(k);
        return r;
    }

    var typeAheadSource = [];
    function populateTypeAhead(csv, delimiter) {
        var lines = csv.split("\n");
        for (var i = lines.length - 1; i >= 1; i--) {
            var items = lines[i].split(delimiter);
            for (var j = items.length - 1; j >= 0; j--) {
                var item = items[j].strip();
                item = item.replace(/"/g,'');
                if (item.indexOf("http") !== 0 && isNaN(parseFloat(item))) {
                    typeAheadSource.push(item);
                    var words = item.split(/\W+/);
                    for (var k = words.length - 1; k >= 0; k--) {
                        typeAheadSource.push(words[k]);
                    }
                }
            }
        }
    }

    if(typeof(String.prototype.strip) === "undefined") {
        String.prototype.strip = function() {
            return String(this).replace(/^\s+|\s+$/g, '');
        };
    }

    var points;
    var hits = 0;
    var total = 0;
    var filterString;
    function loadCSVFromURL(urlCSV){
        try {
            //var scripts = document.getElementById('uploader');
            //urlCSV = scripts[scripts.length-1].src;
            alert("compile loadCSVFromURL:"+urlCSV.toString());
            //------------------------------------------------------------------
            var popupOpts = {autoPanPadding: new L.Point(5, 50,true),autoPan: true};
            //load local file CSV on Leaflet map.
            points = L.geoCsv(null, {
                firstLineTitles: true, fieldSeparator: fieldSeparatorCSV,lineSeparator: lineSeparatorCSV,
                onEachFeature: function (feature, layer) {
                    //alert("onEachFeature 1");
                    var popupContent = '<div class="popup-content"><table class="table table-striped table-bordered table-condensed">';
                    for (var clave in feature.properties) {
                        //alert("onEachFeature 2");
                        //optional
                        //layer = new L.marker({draggable:false}, { icon: deathIcon});
                        var title = points.getPropertyTitle(clave).strip();
                        var attr = feature.properties[clave];
                        if (title === "Name" || title === "name") {
                            layer.bindLabel(feature.properties[clave], {className: 'map-label',noHide: true});
                        }
                        if (attr.indexOf('http') === 0) {
                            attr = '<a target="_blank" href="' + attr + '">'+ attr + '</a>';
                        }
                        if (attr) {
                            popupContent += '<tr><th>'+title+'</th><td>'+ attr +'</td></tr>';
                        }
                    }
                    popupContent += "</table></popup-content>";
                    layer.bindPopup(popupContent,popupOpts);
                },
                pointToLayer: function (feature, latlng) {
                    return L.marker(latlng, {
                        icon: L.icon({
                            iconUrl: 'resources/js/leaflet/images/marcador-bankia.png',
                            shadowUrl: 'resources/js/leaflet/images/marker-shadow.png',
                            iconSize: [25, 41],
                            shadowSize: [41, 41],
                            shadowAnchor: [13, 20]
                        })
                    });
                },
                filter: function(feature, layer) {
                    //alert("filter");
                    total += 1;
                    if (!filterString) {
                        hits += 1;
                        return true;
                    }
                    var hit = false;
                    var lowerFilterString = filterString.toLowerCase().strip();
                    $.each(feature.properties, function(k, v) {
                        var value = v.toLowerCase();
                        if (value.indexOf(lowerFilterString) !== -1) {
                            hit = true;
                            hits += 1;
                            return false;
                        }
                    });
                    return hit;
                }
            });
            //load csv with AJAX
            /*$.ajax({
                type: 'GET',
                dataType: 'text',
                url: urlCSV,
                error: function () {
                    alert('Can\'t GET the data maybe the url:' + urlCSV + ' not exists.');
                },
                success: function (csv) {
                    csvUrlFile.addData(csv);
                    markerClusters.addLayer(csvUrlFile);
                    map.addLayer(markerClusters);
                    map.fitBounds(markerClusters.getBounds());
                },
                complete: function () {
                    $('#caricamento').delay(500).fadeOut('slow');
                }
            });*/
            //------------------------------------------------------------------
            alert("... compiled loadCSVFromURL")
        }catch(e){alert(e.message());}
    }

    var addCsvMarkers = function() {
        if ($.isEmptyObject(points)) {alert("You can't do a research because there are no markers.");}
        alert("compile addCsvMarkers...");
        hits = 0;
        total = 0;
        filterString = document.getElementById('filter-string').value;
        if (filterString) {
            $("#clear").fadeIn();
        } else {
            $("#clear").fadeOut();
        }
        map.removeLayer(markerClusters);
        points.clearLayers();
        if ($.isEmptyObject(markerClusters)) {
            markerClusters = new L.MarkerClusterGroup({showCoverageOnHover: false, maxClusterRadius: 50});
        }
        //markers = new L.MarkerClusterGroup(clusterOptions);
        if($.isEmptyObject(points)){
            alert("The variable point of the CSV file is empty!");
        }else {
            points.addData(dataCsv);
            markerClusters.addLayer(points);
            map.addLayer(markerClusters);
            try {
                var bounds = markerClusters.getBounds();
                if (bounds) {
                    map.fitBounds(bounds);
                }
            } catch (err) {
                // pass
                alert(err.message);
            }
            if (total > 0) {
                $('#search-results').html("Showing " + hits + " of " + total);
            }
            alert("...compiled addCsvMarkers");
            return false;
        }
    };

    function loadCSV(){
        var hits = 0;
        var total = 0;
        var filterString;
        var points = L.geoCsv (null, {
            firstLineTitles: true,
            fieldSeparator: fieldSeparator,
            onEachFeature: function (feature, layer) {
                var popup = '<div class="popup-content"><table class="table table-striped table-bordered table-condensed">';
                for (var clave in feature.properties) {
                    var title = points.getPropertyTitle(clave).strip();
                    var attr = feature.properties[clave];
                    if (title == labelColumn) {
                        layer.bindLabel(feature.properties[clave], {className: 'map-label'});
                    }
                    if (attr.indexOf('http') === 0) {
                        attr = '<a target="_blank" href="' + attr + '">'+ attr + '</a>';
                    }
                    if (attr) {
                        popup += '<tr><th>'+title+'</th><td>'+ attr +'</td></tr>';
                    }
                }
                popup += "</table></popup-content>";
                layer.bindPopup(popup, popupOpts);
            },
            filter: function(feature, layer) {
                total += 1;
                if (!filterString) {
                    hits += 1;
                    return true;
                }
                var hit = false;
                var lowerFilterString = filterString.toLowerCase().strip();
                $.each(feature.properties, function(k, v) {
                    var value = v.toLowerCase();
                    if (value.indexOf(lowerFilterString) !== -1) {
                        hit = true;
                        hits += 1;
                        return false;
                    }
                });
                return hit;
            }
        });
    }






