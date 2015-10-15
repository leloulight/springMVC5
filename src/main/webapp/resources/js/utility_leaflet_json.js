/**
 * Created by tenti on 11/10/2015.
 */

    /*** function to request the list of markers (in JSON) for the current map viewport:
     * response from the server is like:
     * [{"name":"Tunbridge Wells, Langton Road, Burnt Cottage",
     * "lon":"0.213102",
     * "lat":"51.1429",
     * "details":"A Grade II listed five bedroom wing in need of renovation."}
     */
    function addMarkerJson(){
        var javaMarker = askForPlotsWithJQuery2();
        map.addLayer(markerClusters);
        return javaMarker;
    }//askForPLots3

    /**..if you use jquery*/
    function GETWithJQuery(URL){
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
    function GETWithAJAX(URL) {
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

    /*** For store data in GeoJSON format I use Leaflet function toGeoJSON()*/
    function convertLeafletfeatureGroupToGeoJson(data){
        var myMarkers = new L.FeatureGroup();
        map.addLayer(myMarkers);
        // get json
       return myMarkers.toGeoJSON();
    };

    //http://stackoverflow.com/questions/3199887/send-json-object-to-mysql-using-jquery-javascript-php
    function storeJsonObjectToMySQL(jsonUrl,myObj){
        $.ajax({
            url: jsonUrl,
            type: 'post',
            data: JSON.stringify(myObj),
            contentType: 'application/json',
            dataType: 'json',
            success: function(data, status, xhr)
            {
                // ...
            }
        });
    }

//third party jsonp service
function formatJSON(rawjson) {	//callback that remap fields name
    var json = {},
        key, loc, disp = [];
    for(var i in rawjson)
    {
        disp = rawjson[i].display_name.split(',');
        key = disp[0] +', '+ disp[1];

        loc = L.latLng( rawjson[i].lat, rawjson[i].lon );

        json[ key ]= loc;	//key,value format
    }

    return json;
}

function addPluginControlByJsonpFile(jsonpurl,jsonpName){
    var searchOpts = {
        url: jsonpurl,
        jsonpParam: jsonpName,
        formatData: formatJSON,
        animateLocation: false,
        markerLocation: true,
        zoom: 10,
        minLength: 2,
        autoType: false
    };

    map.addControl( new L.Control.Search(searchOpts) );
}
