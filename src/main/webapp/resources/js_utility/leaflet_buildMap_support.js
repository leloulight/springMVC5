    /**
    * Created by 4535992 on 11/06/2015.
    */
    //support variables
    var map;
    //var ajaxRequest, plotlist;
    var clickLayer = new L.LayerGroup();
    var GPSLayer = new L.LayerGroup();
    var markerClusters = new L.MarkerClusterGroup();


    /*** Set a personal icon marker */
    /*var myIcon = L.icon({
        iconUrl: myURL + 'img/cluster.png',
        iconRetinaUrl: myURL + 'img/me.png',
        iconSize: [29, 24],
        iconAnchor: [9, 21],
        popupAnchor: [0, -14]
     L.marker( [marker.lat, marker.lng], {icon: myIcon} )
     .bindPopup( '<a href="' + marker.url + '" target="_blank">' + marker.name + '</a>' )
     .addTo( map );
    });*/

    /*** Set the src of the javascript file*/
    //var mySRC = jQuery('script[src$="resources/js_utility/leaflet_buildMap_support.js"]').attr('src').replace('js_utility/leaflet_buildMap_support.js', '');

    /*** Set marker variables */
    var nameVar,urlVar,latVar,lngVar; //basic info
    var regionVar,provinceVar,cityVar,addressVar,phoneVar,emailVar,faxVar,ivaVar; //other info
    $( document ).ready(function() {
        //oppure $( window ).load(function(){
        //variables get from leafletMap_buildMap_support.jsp
       /* if ((!$.isEmptyObject(document.getElementById('arrayMarkerForm'))) && document.getElementById('arrayMarkerForm')>0) {
            nameVar = document.getElementById('nameForm').value;
            urlVar = document.getElementById('urlForm').value;
            latVar = document.getElementById('latForm').value;
            lngVar = document.getElementById('lngForm').value;
            regionVar = document.getElementById('regionForm').value;
            provinceVar = document.getElementById('provinceForm').value;
            cityVar = document.getElementById('cityForm').value;
            addressVar = document.getElementById('addressForm').value;
            phoneVar = document.getElementById('phoneForm').value;
            emailVar = document.getElementById('emailForm').value;
            faxVar = document.getElementById('faxForm').value;
            ivaVar = document.getElementById('ivaForm').value;
            alert("count element count is:"+document.getElementById('arrayMarkerForm').childElementCount);
            var arrayMarkerVar = document.getElementById('arrayMarkerForm');
            alert("load markerForm not empty =>Name:" + nameVar + ',URL:' + urlVar + ',LAT:' + latVar + ',LNG:' + lngVar);
            var markerVar = {name:nameVar,url:urlVar,lat:latVar,lng:lngVar,region:regionVar,province:provinceVar,
                city:cityVar,address:addressVar,phone:phoneVar,email:emailVar,fax:faxVar,iva:ivaVar};
            arrayMarkerVar.push(markerVar);
        }*/
        initMap();
        if((!$.isEmptyObject(arrayMarkerVar)) && arrayMarkerVar.length > 0){
            //alert('Click markerFormParam MARKER:'+nameVar+','+urlVar+','+latVar+','+lngVar);
            //TEST URL
            //URL = 'https://maps.googleapis.com/maps/api/geocode/json?bounds=34.172684,-118.604794|34.236144,-118.500938';
            //addSingleMarker(nameVar,urlVar,latVar,lngVar);
            addMultipleMarker(arrayMarkerVar);
        }
    });


    /***  codice per mantenere aperto più di un popup per volta ***/
    /*function addMantainOpenMultiplePopup() {
       map.extend({
            openPopup: function (popup) {
                //this.closePopup();  // just comment this
                this._popup = popup;

                return this.addLayer(popup).fire('popupopen', {
                    popup: this._popup
                });
            }
        }).addTo(map);
    }*/



    /***
     *  Set the map and zoom on the specific location
     *  window.onload = function () {initMap22();};
     *
     */
    function initMap() {
        if(map==null) {
            //valori fissi per il settaggio iniziale della mappa....
            var latitude = 43.3555664; //43.3555664
            var longitude = 11.0290384; //11.0290384
            try {
                if ($.isEmptyObject(markerClusters)) {
                    markerClusters = new L.MarkerClusterGroup();
                }
                alert("Init Map with:" + nameVar + ',' + urlVar + ',' + latVar + ',' + lngVar);
                // set up AJAX request
                /*   ajaxRequest = getXmlHttpObject();
                 if (ajaxRequest == null) {
                 alert("This browser does not support HTTP Request");
                 return;
                 }*/
                //var setBounds = [41.7, 8.4, 44.930222, 13.4];
                // set up the map
                alert("Set Initial Map with:" + latitude + ',' + longitude);
                //map = new L.map('map').setView([43.3555664, 11.0290384], 8);
                //map = L.map( 'map', {center: [10.0, 5.0],minZoom: 2,zoom: 2});

                //Set map with leave all popup open...
                map = new L.map('map').setView([latitude, longitude], 8);

                /* .extend({
                 openPopup: function (popup) {
                 //this.closePopup();  // just comment this
                 this._popup = popup;

                 return this.addLayer(popup).fire('popupopen', {
                 popup: this._popup
                 });
                 }
                 }).addTo(map);*/

                //Build your map
                L.tileLayer('http://c.tiles.mapbox.com/v3/examples.map-szwdot65/{z}/{x}/{y}.png', { // NON MALE
                    attribution: 'Map data &copy; 2011 OpenStreetMap contributors, Imagery &copy; 2012 CloudMade',
                    key: 'BC9A493B41014CAABB98F0471D759707',
                    subdomains: ['otile1', 'otile2', 'otile3', 'otile4'],
                    minZoom: 8
                }).addTo(map);
                /*var url = 'http://otile{s}.mqcdn.com/tiles/1.0.0/map/{z}/{x}/{y}.jpeg',
                 attr ='Tiles Courtesy of <a href="http://www.mapquest.com/">MapQuest</a> &mdash; Map data {attribution.OpenStreetMap}',
                 service = new L.TileLayer(url, {subdomains:"1234",attribution: attr});
                 map.addLayer(service).fitBounds(bounds);
                 */

                //Set a bound window for the leaflet map
                var bounds = new L.LatLngBounds(new L.LatLng(41.7, 8.4), new L.LatLng(44.930222, 13.4));
                //var bounds = new L.LatLngBounds(new L.LatLng(setBounds[0],setBounds[1]), new L.LatLng(setBounds[2], setBounds[3]));
                map.setMaxBounds(bounds);
                alert("MAP IS SETTED");
                //..add many functionality
                addPluginGPSControl();
                addPluginCoordinatesControl();
                //..add other functionality
                //addMantainOpenMultiplePopup(); //not work
                //addMarkerClusterPlugin();
                //askForPlots3(-1, 51, 2, 53);
                map.on('click', onMapClick);
                //Fired when the view of the map stops changing
                //map.on('moveend', onMapMove);

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
        var GPSControl = new L.Control.Gps({
            maxZoom: 16,
            style: null
        });
        map.addControl(GPSControl);
    }

    /***
     * Set the coordinates plugin on leaflet, add a window with the value of coordinates
     * https://github.com/MrMufflon/Leaflet.Coordinates
     */
    function addPluginCoordinatesControl() {
        //add standard controls
        /*L.control.coordinates().addTo(map);*/
        //add configured controls
        /*L.control.coordinates({
            position: "bottomleft",
            decimals: 2,
            decimalSeperator: ",",
            labelTemplateLat: "Latitude: {y}",
            labelTemplateLng: "Longitude: {x}"
        }).addTo(map);*/
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
    var jsonData,name,lat,lng,URL;

    function askForPlots(name,URL,lat,lng){
        var javaMarker;
        alert('MARKER TEST 1:'+name+','+URL+','+lat+','+lng);
        /*-1,51,2,53*/
        window.alert("compile askForPlots3 with arguments");
        URL = 'https://maps.googleapis.com/maps/api/geocode/json?bounds=34.172684,-118.604794|34.236144,-118.500938';
        //var URL = 'https://maps.googleapis.com/maps/api/geocode/json?bounds==' + latitude1 + ',' + longitude1 + '|' + latitude2 + ',' + longitude2;
        javaMarker = askForPlotsWithJQuery2();
        map.addLayer(markerClusters);
        return javaMarker;
    }//askForPLots3

    /**..if you use jquery */
    function askForPlotsWithJQuery(){
        if(plotlayers.length >0 ) {
            alert("exists a marker on the array!!")
            removeClusterMarker();
        }

        $.getJSON(URL, function(data) {
            //alert( "Data Loaded from url:"+ URL + " = "+ data );
            jsonData = data;
            alert( "Data Loaded 2: " + jsonData);

            /*
             var sayingsList = [];
             $.each(data, function(key, val) {
             sayingsList.push('<li>' + val + '</li>');
             });
             $('<ul/>', {
             html: sayingsList.join('')
             }).appendTo('#div4');*/
        })
        .done(function(data) {
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
                name = data.results[0].address_components[0].long_name;
                lat = data.results[0].geometry.location.lat;
                lng = data.results[0].geometry.location.lng;
                //alert("NAME:"+ name +",COORDINATES:["+ lat +","+ lng +"]");
                addMarker22(name,URL,lat,lng);
                alert("getJSON request succeeded!");
            }catch(e){
                alert(e.message );
                alert( "getJSON request failed!");
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
    function askForPlotsWithJQuery2(){
        var javaMarker;
        if(plotlayers.length >0 ) {
            alert("exists a marker on the array!!")
            removeClusterMarker();
        }
        $.getJSON(URL, function(data) {
            //alert( "Data Loaded from url:"+ URL + " = "+ data );
            jsonData = data;
            alert( "Data Loaded 2: " + jsonData);

            /*
             var sayingsList = [];
             $.each(data, function(key, val) {
             sayingsList.push('<li>' + val + '</li>');
             });
             $('<ul/>', {
             html: sayingsList.join('')
             }).appendTo('#div4');*/
        })
            .done(function(data) {
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
                    name = data.results[0].address_components[0].long_name;
                    lat = data.results[0].geometry.location.lat;
                    lng = data.results[0].geometry.location.lng;
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
    function askForPlotsWithAJAX() {
         function ajaxRequest() {
            var activexmodes = ["Msxml2.XMLHTTP", "Microsoft.XMLHTTP"] //activeX versions to check for in IE
            if (window.ActiveXObject) { //Test for support for ActiveXObject in IE first (as XMLHttpRequest in IE7 is broken)
                for (var i = 0; i < activexmodes.length; i++) {
                     try {
                        return new ActiveXObject(activexmodes[i])
                    }
                    catch (e) {
                        //suppress error
                    }
                }
            }
            else if (window.XMLHttpRequest) // if Mozilla, Safari etc
                 return new XMLHttpRequest()
            else
                return false
         }//..end ajaxrequest

         var mygetrequest = new ajaxRequest();
         mygetrequest.onreadystatechange = function () {
             if (mygetrequest.readyState == 4) {
                if (mygetrequest.status == 200 || window.location.href.indexOf("http") == -1) {
                    var jsondata = eval("(" + mygetrequest.responseText + ")") //retrieve result as an JavaScript object
                    window.alert("sondata:"+jsondata);
                    if (jsondata.meta.code == 200) {
                         var info = jsondata.response.groups[0];
                        window.alert("INFO:"+info);
                        //..check if exists a correct json reaponse
                        if (typeof info != 'undefined') {
                            //...response json standard di Foursquare
                             var infox = info;
                        } else {
                            //una risposta json con differente struttura da parte di Foursquare
                             var info2 = jsondata.response.groups[0];
                             window.alert(info2.toString());
                            //window.alert("info2");
                            if (typeof info2 != 'undefined') {
                                infox = info2;
                            }
                            else {
                                 alert("Errore in fase di elaborazione della risposta JSON di Foursquare");
                             }
                             /* for(var i = 0; i <= infox.length; i += 1) {
                             }*/
                        }
                    } else {
                        alert("Errore nella risposta del server Foursquare");
                    }//...if meta code request 200
                }
                else {
                    alert("Errore nella richiesta al server Foursquare");
                }//...if code request 200
             }//...if code request 4
         }//... end ajaxrequest
         //mygetrequest.open("GET", "javascriptkit.json", true)
         mygetrequest.open("GET", URL, true);
         mygetrequest.send(null);
         window.alert("compiled askForPlots2 with arguments");
    }//...askForPlotsWith AJAX

/*The list of markers in json format*/
/*
 var markers = [
 {
 "name": "Canada",
 "url": "https://en.wikipedia.org/wiki/Canada",
 "lat": 56.130366,
 "lng": -106.346771
 },
 {
 "name": "Anguilla",
 "url": "https://en.wikipedia.org/wiki/Anguilla",
 "lat": 18.220554,
 "lng": -63.068615
 },
 {
 "name": "Japan",
 "url": "https://en.wikipedia.org/wiki/Japan",
 "lat": 36.204824,
 "lng": 138.252924
 }
 ];
 */

    /***
     * Set the Leaflet.markercluster for Leaflet
     * https://github.com/Leaflet/Leaflet.markercluster
     */
    /*
    function addMarkerClusterPlugin() {
        var markerClusters = new L.MarkerClusterGroup();
        if (markers.length > 0) {
            //window.alert("markers not empty");
            for (var i = 0; i < markers.length; ++i) {
                var popup = markers[i].name +
                    '<br/>' + markers[i].city +
                    '<br/><b>IATA/FAA:</b> ' + markers[i].iata_faa +
                    '<br/><b>ICAO:</b> ' + markers[i].icao +
                    '<br/><b>Altitude:</b> ' + Math.round(markers[i].alt * 0.3048) + ' m' +
                    '<br/><b>Timezone:</b> ' + markers[i].tz;

                var m = L.marker([markers[i].lat, markers[i].lng], {icon: myIcon})
                    .bindPopup(popup);
                markerClusters.addLayer(m);
            }
        }else {
            //window.alert("markers empty");
        }
        //window.alert("compiled addMarkerClusterPlugin");
        map.addLayer(markerClusters);
    }
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
    function onMapMove(e) {
        window.alert("compile onMapMove");
        removeClusterMarker();
        window.alert("compiled onMapMove");
    }


    /*** function Set a popup when you click on the map*/
    var popupGlobal = L.popup();
    function onMapClick(e) {
        popupGlobal.setLatLng(e.latlng).setContent("You clicked the map at " + e.latlng.toString()).openOn(map);
    }


    /*** function for add a marker to the leaflet map */
    function addSingleMarker(name, url, lat, lng) {
        alert("... add single marker:" + name + ',' + url + ',' + lat + ',' + lng);
        try {
            if ($.isEmptyObject(markerClusters)) {
                markerClusters = new L.MarkerClusterGroup();
            }
            /*var marker = L.marker([lat, lng]).addTo(map);
             //...set the popup on mouse click
             marker.bindPopup('<a href="' + url + '" target="_blank">' + name + '</a>').openPopup();*/
            var popupClick = new L.popup().setContent(
                '<a class="linkToMarkerInfo" href="' + url + '" target="_blank">' + name + '</a>');
            //var marker = L.marker([lat, lng]).bindPopup(popupClick).addTo(map);
            alert("COORD:-"+parseFloat(lat) + '-,-' + parseFloat(lng)+'-');
            //43.7778535 - 11.2593572
            //var cc = L.latLng(43.7778535, 11.2593572);
            //var marker = new L.marker([parseFloat(lat), parseFloat(lng)]).addTo(map);
            var marker;
            try {
                marker = new L.marker([parseFloat(lat), parseFloat(lng)]).addTo(map);
            }catch(e){
                try{
                    marker = new L.marker([lat, lng]).addTo(map);
                }catch(e){
                    alert("SOME PROBLEM WITH LATLNG:"+ e.message());
                }
            }
            marker.bindPopup(popupClick);
            //...set the popup on mouse over
            //var latlngOver = L.latLng(latVar, lngVar);
            var textOver =
                '<ul>' +
                '<li>Regione:' + regionVar + '</li>' +
                '<li>Provincia:' + provinceVar + '</li>' +
                '<li>Città:' + cityVar + '</li>' +
                '<li>Indirizzo:' + addressVar + '</li>' +
                '<li>Telefono/Cellulare:' + phoneVar + '</li>' +
                '<li>Fax:' + faxVar + '</li>' +
                '<li>Email:' + emailVar + '</li>' +
                '<li>IVA:' + ivaVar + '</li>' +
                '</ul>';
            var popupOver = new L.popup().setContent(textOver);
            //..set some action for the marker
            marker.on('mouseover', function (e) {
                //evt.target is the marker that is being moused over
                //bindPopup() does not need to be called here if it was already called
                //somewhere else for this marker.
                e.target.bindPopup(popupOver).openPopup();
            });

            /*marker.on('mouseout', function (e) {
             e.target.closePopup();
             });*/

            marker.on('click', function (e) {
                //again, evt.target will contain the marker that was clicked
                //e.target.bindPopup(popupClick);
                e.target.bindPopup(popupClick).openPopup();
            });
            //..add marker to the array of cluster marker
            markerClusters.addLayer(marker);
            //...set to a Global variable for use with different javascript function
            //map.addLayer(markerClusters);
            markerClusters.addTo(map);
            map.setView([lat, lng], 8);
            //return {name: name, url: url, latitudine: lat, longitudine: lng};
        }catch(e){alert('Exception:' + e.message);}
    }

    /*** function for remove all cluster marker on the leaflet map */
    function removeClusterMarker(){
        alert("compile removeClusterMarker");
        if(plotlayers.length > 0) {
            for (var i = 0; i < plotlayers.length; i++) {
                map.removeLayer(plotlayers[i]);//...remove eevery single marker
            }
        }
        plotlayers.length = 0; //...reset array
        map.removeLayer(markerClusters);//....remove layer
        alert("compiled removeClusterMarker");
    }

    /*** function fro remove all cluster marker with a click on the reset button */
    $('#pulsante-reset').click(function() {
        removeClusterMarker();
    });

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
        }

    }


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
    $('#info img').click(function () {
        if ($("#info").hasClass("active") == false) {
            $('#info').addClass("active");
            selezioneAttiva = true;
        }
        else {
            $('#info').removeClass("active");
            selezioneAttiva = false;
        }
    });

    /*** function open a new Popup of information when you click on the name of the bussiness entity*/
    /*$('a.linkToMarkerInfo').mouseover(function(){
        alert('MOUSE OVER LINK...');
        var latlng = L.latLng(latVar, lngVar);
        var text =
            '<ul>' +
            '<li>Regione:'+regionVar+'</li>' +
            '<li>Provincia:'+provinceVar+'</li>' +
            '<li>Città:'+cityVar+'</li>' +
            '<li>Indirizzo:'+addressVar+'</li>' +
            '<li>Telefono/Cellulare:'+phoneVar+'</li>' +
            '<li>Fax:'+faxVar+'</li>' +
            '<li>Email:'+emailVar+'</li>' +
            '<li>IVA:'+ivaVar+'</li>' +
            '</ul>';
    });*/

   /*** function to open a URL with javascript without jquery */
   function openURL(url){
       // similar behavior as an HTTP redirect
       window.location.replace(url);
        // similar behavior as clicking on a link
       window.location.href = url;
   }

    /*** function to open a new popup when mouse is over a specific element*/
    /*function leafletPopupMouseOver(marker,content,latlng){
        L.popup()
            .setLatLng(latlng)
            .setContent(content)
            .openOn(map);
        marker.bindPopup(content);
        marker.on('mouseover', function (e) {
            this.openPopup();
        });
        marker.on('mouseout', function (e) {
            this.closePopup();
        });
    }*/


    function addMultipleMarker(markers){
       alert("add multiple marker "+markers.length+"...");
       // Define an array. This could be done in a seperate js file.
       // This tidy formatted section could even be generated by a server-side script
       // or fetched seperately as a jsonp request.
       /*var markers = [
           [ -0.1244324, 51.5006728, "Big Ben" ],
           [ -0.119623, 51.503308, "London Eye" ],
           [ -0.1279688, 51.5077286, "Nelson's Column<br><a href=\"https://en.wikipedia.org/wiki/Nelson's_Column\">wp</a>" ]
       ];*/
       //for (var i = 0; i < markers.length; ++i) {
           /* L.marker( [markers[i].lat, markers[i].lng], {icon: myIcon} )
            .bindPopup( '<a href="' + markers[i].url + '" target="_blank">' + markers[i].name + '</a>' )
            .addTo( map );*/

           /*L.marker([markers[i].lat, markers[i].lng])
            .bindPopup('<a href="' + markers[i].url + '" target="_blank">' + markers[i].name + '</a>')
            .addTo(map);*/
       //}
       //Loop through the markers array
        try {
            for (var i = 0; i < markers.length; i++) {
                alert("... add single marker (" + i + "):"
                    + markers[i].name + ',' + markers[i].url + ',' + markers[i].lat + ',' + markers[i].lng);
                /*var nameVar = getFields(markers[i], "name");
                var urlVar = getFields(markers[i], "url");
                var latVar = getFields(markers[i], "lat");
                var lngVar = getFields(markers[i], "lng");
                regionVar = getFields(markers[i], "region");
                provinceVar = getFields(markers[i], "province");
                cityVar = getFields(markers[i], "city");
                addressVar = getFields(markers[i], "address");
                phoneVar = getFields(markers[i], "phone");
                emailVar = getFields(markers[i], "email");
                faxVar = getFields(markers[i], "fax");
                ivaVar = getFields(markers[i], "iva");*/
                regionVar = markers[i].region;
                provinceVar = markers[i].province;
                cityVar =  markers[i].city;
                addressVar =  markers[i].address;
                phoneVar =  markers[i].phone;
                emailVar =  markers[i].email;
                faxVar =  markers[i].fax;
                ivaVar =  markers[i].iva;

                /*var popupText = markers[i][2];
                 var markerLocation = new L.LatLng(lat, lon);
                 var marker = new L.Marker(markerLocation);*/
                //name,url,lat,lon
                addSingleMarker(markers[i].name, markers[i].url, markers[i].lat, markers[i].lng)
                /*map.addLayer(marker);
                 marker.bindPopup(popupText);*/
            }
            alert("... addeed multiple marker");
        }catch(e){
            alert(e.message);
        }
    }

    function getMarkerCluster(){
        return markerClusters;
    }

    var  arrayMarkerVar =[];
    function pushMarkerToArrayMarker(nameVar,urlVar,latVar,lngVar,regionVar,provinceVar,cityVar,addressVar,phoneVar,emailVar,faxVar,ivaVar){
        /*nameVar = document.getElementById('nameForm').value;
        urlVar = document.getElementById('urlForm').value;
        latVar = document.getElementById('latForm').value;
        lngVar = document.getElementById('lngForm').value;
        regionVar = document.getElementById('regionForm').value;
        provinceVar = document.getElementById('provinceForm').value;
        cityVar = document.getElementById('cityForm').value;
        addressVar = document.getElementById('addressForm').value;
        phoneVar = document.getElementById('phoneForm').value;
        emailVar = document.getElementById('emailForm').value;
        faxVar = document.getElementById('faxForm').value;
        ivaVar = document.getElementById('ivaForm').value;*/
        alert("count element count is:"+document.getElementById('arrayMarkerForm').childElementCount);
        alert("pushing the element =>Name:" + nameVar + ',URL:' + urlVar + ',LAT:' + latVar + ',LNG:' + lngVar+"...");
        var markerVar = { name:nameVar,url:urlVar,lat:latVar,lng:lngVar,
            region:regionVar,province:provinceVar,city:cityVar,address:addressVar,phone:phoneVar,email:emailVar,
            fax:faxVar, iva:ivaVar};
        alert("....pushed a marker tot he array on javascript side:"+ markerVar.toString());
        arrayMarkerVar.push(markerVar);
    }

    /** Function for search a specfici value of a key in a array of objects */
    function search(name, myArray){
        /*var array = [
            { name:"string 1", value:"this", other: "that" },
            { name:"string 2", value:"this", other: "that" }
        ];
        for (var i=0; i < myArray.length; i++) {
            if (myArray[i].name === id) {
                return myArray[i];
            }
        }
        */
       /* var lookup = {};
        for (var i = 0, len = myArray.length; i < len; i++) {
            lookup[myArray[i].name] = myArray[i];
        }
        return lookup[id];*/
        return myArray.map(function(a) {return a.name;});
    }

    function searchWithJQuery(name,myArray){
        return $.grep(myArray, function(e){ return e.id === name; });
    }


    function getFields(input, field) {
        return input.map(function(o) {
            return o[field];
        });
    }