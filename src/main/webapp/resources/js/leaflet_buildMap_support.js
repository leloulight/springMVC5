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
    var isGTFS;

    //DEFINE DIFFERNET MARKER WITH DIFFERNET COLOR
    var markerAccommodation = L.AwesomeMarkers.icon({markerColor: 'red'});
    var markerCulturalActivity = L.AwesomeMarkers.icon({markerColor: 'orange'});
    var markerEducation = L.AwesomeMarkers.icon({markerColor: 'green'});
    var markerEmergency = L.AwesomeMarkers.icon({markerColor: 'blue'});
    var markerEntertainment = L.AwesomeMarkers.icon({markerColor: 'purple'});
    var markerFinancialService = L.AwesomeMarkers.icon({markerColor: 'darkred'});
    var markerGovernmentOffice = L.AwesomeMarkers.icon({markerColor: 'darkblue'});
    var markerHealthCare = L.AwesomeMarkers.icon({markerColor: 'darkgreen'});
    var markerShopping = L.AwesomeMarkers.icon({markerColor: 'darkpurple'});
    var markerTourismService = L.AwesomeMarkers.icon({markerColor: 'cadetblue'});
    var markerTransferService = L.AwesomeMarkers.icon({markerColor: 'yellow'});
    var markerWineAndFood = L.AwesomeMarkers.icon({markerColor: 'black'});
    var markerBusStops = L.AwesomeMarkers.icon({markerColor: 'pink'});

    // DIFFERENTI LAYERS PER LE DIFFERENTI CATEGORIE
    var layerAccommodation = L.layerGroup();
    var layerCulturalActivity = L.layerGroup();
    var layerEducation = L.layerGroup();
    var layerEmergency = L.layerGroup();
    var layerEntertainment = L.layerGroup();
    var layerFinancialService = L.layerGroup();
    var layerGovernmentOffice = L.layerGroup();
    var layerHealthCare = L.layerGroup();
    var layerShopping = L.layerGroup();
    var layerTourismService = L.layerGroup();
    var layerTransferService = L.layerGroup();
    var layerWineAndFood = L.layerGroup();

    //Service Map
    // GENERAZIONE DEI LAYER PRINCIPALI
    var busStopsLayer = new L.LayerGroup();
    var servicesLayer = new L.LayerGroup();
    var clickLayer = new L.LayerGroup();
    var GPSLayer = new L.LayerGroup();
    var layerMarker = new L.FeatureGroup();

    // VARIABILI PER LA FUNZIONALITA' DI RICERCA INDIRIZZO APPROSSIMATIVO
    var selezioneAttiva = false;
    var ricercaInCorso = false;

    // VARIABILI PER LA FUNZIONALITA' DI RICERCA SERVIZI
    var selezione;
    var coordinateSelezione;
    var numeroRisultati;

    /** Set the Leaflet.markercluster for Leaflet. https://github.com/Leaflet/Leaflet.markercluster */
    var markerClusters = new L.MarkerClusterGroup({showCoverageOnHover: false, maxClusterRadius: 50});
    /** Set the Leaflet Plugin Search. https://github.com/p4535992/leaflet-search.*/
    var controlSearch = new L.Control.Search({layer: markerClusters, initial: false, position:'topright'});

    // VARIABILI PER LA FUNZIONALITA' DI RICERCA SERVIZI
    var GPSControl = new L.Control.Gps({maxZoom: 16,style: null}); // AGGIUNTA DEL PLUGIN PER LA GEOLOCALIZZAZIONE


    //Variabili suppport java SPRING
    var nameVar,urlVar,latVar,lngVar; //basic info
    var regionVar,provinceVar,cityVar,addressVar,phoneVar,emailVar,faxVar,ivaVar; //other info
    var arrayMarkerVar =[]; // array support of makers


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
        initMap();

        /*** remove all cluster marker with a click on the reset button */
        $('#pulsante-reset').click(function() {
            removeClusterMarker();
        });
        /**
         * If work with different csv you can specify the FieldSeparator,
         * LineSeparator and the tilte or Name column for the marker.
         */
        $("#fieldSeparator").bind("change paste keyup", function() {
            setFieldSeparatorCSV($(this).val());
        });
        $("#lineSeparator").bind("change paste keyup", function() {
            setLineSeparatorCSV($(this).val());
        });
        $("#nameSeparator").on('',function(){
            setTitleFieldCSV($(this).val());
        });

       /* $('#gtfs').on('change', function() {
            alert($('input[name=gtfs]:checked', '#gtfs').val());
        });*/


        //oppure $( window ).load(function(){
        //loading map...
        //$('#caricamento').delay(500).fadeOut('slow');
        /**all'apertura della pagina CREO LE TABS JQUERY UI NEL MENU IN ALTO */
        $( "#tabs" ).tabs();


        /** if you have add a new marker from spring put in the map. */
        if((!$.isEmptyObject(arrayMarkerVar)) && arrayMarkerVar.length > 0){
            addMultipleMarker(arrayMarkerVar);
        }

        $('#textsearch').on('keyup', function(e) {
            controlSearch.searchText( e.target.value );
        });

        //set a listener on the uploader button
        $("#uploader").on('change',function(e) {
            try {
               /* if ($('#gtfs').is(':checked')) {
                    alert("GTFS it's checked");
                    //this.files[0]
                    initMap();
                    handleFilesGTFS(e);
                } else {*/
                    handleFiles2(e);
            }catch(e){
                alert("34");
                alert(e.message);}
        });


        //var uploader = document.getElementById("#uploader");
        //uploader.addEventListener("change", handleFilesCSV, false);

        //Localize all Location near you
        $('#localizeName2').click(function() {
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

        $("#getMarkers").click(function(evt){
            getMarkers();
        });

        $('#filter-string').typeahead({source: typeAheadSource});

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
         * A SX ATTIVO O DISATTIVO LA FUNZIONALITA' DI RICERCA */
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

        //FUNZIONE PER MOSTRARE/NASCONDERE LE SUB CATEGORY
        $(".toggle-subcategory").click(function () {
            $tsc = $(this);
            //getting the next element
            $content = $tsc.next();
            if (!$content.is(":visible")){
                $('.subcategory-content').hide();
                $('.toggle-subcategory').html('+');
            }
            //open up the content needed - toggle the slide- if visible, slide up, if not slidedown.
            $content.slideToggle(200, function () {
                //execute this after slideToggle is done
                //change text of header based on visibility of content div
                $tsc.text(function () {
                    //change text based on condition
                    return $content.is(":visible") ? "-" : "+";
                });
            });
        });

        //CHECKBOX SELECT/DESELECT ALL
        $('#macro-select-all').change(function (){
            if($('#macro-select-all').prop('checked')){
                $('.macrocategory').prop('checked', 'checked');
                $('.macrocategory').trigger( "change" );
            }
            else{
                $('.macrocategory').prop('checked', false);
                $('.macrocategory').trigger( "change" );
            }

        });

        //FUNZIONE PER MOSTRARE/NASCONDERE I MENU
        $(".header").click(function () {
            $header = $(this);
            //getting the next element
            $content = $header.next();
            //open up the content needed - toggle the slide- if visible, slide up, if not slidedown.
            $content.slideToggle(200, function () {
                //execute this after slideToggle is done
                //change text of header based on visibility of content div
                $header.text(function () {
                    //change text based on condition
                    return $content.is(":visible") ? "- Nascondi Menu" : "+ Mostra Menu";
                });
            });
        });

        // SELEZIONA/DESELEZIONA TUTTE LE CATEGORIE - SOTTOCATEGORIE
        $('.macrocategory').change(function (){
            $cat = $(this).next().attr('class');
            $cat = $cat.replace(" macrocategory-label","");
            //console.log($cat);
            if($(this).prop('checked')){$('.sub_' + $cat).prop('checked', 'checked');}
            else{$('.sub_' + $cat).prop('checked', false);}
        });

        // AL CLICK SUL PULSANTE DI SELEZIONE PUNTO SU MAPPA IN ALTO A SX ATTIVO O DISATTIVO LA FUNZIONALITA' DI RICERCA
        $('#info img').click(function(){
            if ($("#info").hasClass("active") == false){
                $('#info').addClass("active");
                selezioneAttiva = true;
            }
            else{
                $('#info').removeClass("active");
                selezioneAttiva = false;
            }
        });

        /*if(!$.isEmptyObject(contentdata)) {
            alert("invoke AJAX");
            $.ajax({
                url: '/fileupload',
                data: contentdata,
                // THIS MUST BE DONE FOR FILE UPLOADING
                processData: false,
                contentType: false,
                type: 'POST',
                success: function (data) {
                    alert('Success: ' + data);
                },
                error: function (xhr, status, error) {
                    alert('ERROR: ' + error);
                    var err = eval("(" + xhr.responseText + ")");
                    //var err = JSON.parse(xhr.responseText)
                    alert('ERROR: ' + err.Message);
                }
            });
        }*/

        alert("Loaded all JQUERY variable");
    });

    /**
     * function to get the information on the marker ont he Layer to a Array to pass
     * by create a list of input to pass to a specific form.
     * */
    function getMarkers(){
        var array = [];
        alert("compile getMarkers");
        try{
            if(!$.isEmptyObject(markerClusters)) {
                alert("Marker cluster is not empty go to check the Marker.");
                markerClusters.eachLayer(function (layer) {
                    try {
                        //alert("marker number(n):");
                        var lat = layer.getLatLng().lat;
                        //alert("marker number(n):" + lat);
                        var lng = layer.getLatLng().lng;
                        //alert("marker number(n):" + lat + "," + lng);
                        var label = layer.getLabel()._content;
                        //alert("marker number(n):" + lat + "," + lng + "," + label);
                        /*var location = layer.getLocation();*/
                        var popupContent = layer.getPopup().getContent();
                        //alert("marker number(" + i + "):" + lat + "," + lng + "," + label + "," + popupContent);
                        array.push({name: label, lat: lat, lng: lng, description: popupContent});
                        //i++;
                    }catch(e){
                        //do nothing
                    }
                });
            }
        }catch(e){alert(e.message);}
        alert("...compiled getMarkers");
        //var array = getMarkers();
        for (var i = 0; i < array.length; i++) {
            try {
                addInput('nameForm' + i, array[i].name, i);
                addInput('latForm' + i, array[i].lat, i);
                addInput('lngForm' + i, array[i].lng, i);
                addInput('descriptionForm' + i, array[i].description, i);
            }catch(e){alert(e.message);}
        }
        //alert(document.getElementById('uploader').value);
        //<input type="submit" name="GetMarkersParam" value="getMarkers" />
        var input = document.createElement('input');
        input.setAttribute('id', 'supportUploaderForm');
        input.setAttribute('type', 'hidden');
        input.setAttribute('value', document.getElementById('uploader').value);
        input.setAttribute('name',"supportUploaderParam");
        document.getElementById('loadMarker').appendChild(input);

        alert("...compiled 2 getMarkers");
    }

    function addInput(input_id,val,index) {
        //alert("compile addInput..."+input_id+","+val);
        var input = document.createElement('input');
        input.setAttribute('id', input_id);
        input.setAttribute('type', 'hidden');
        input.setAttribute('value', val);
        input.setAttribute('name', input_id.replace(index,'').replace('Form','Param1'));
        //document.body.appendChild(input);
        document.getElementById('loadMarker').appendChild(input);
        //setInputValue(input_id,val);
        //alert("compiled addInput...");
    }

    /*function setInputValue(input_id, val) {
        document.getElementById(input_id).value = val;
        //document.getElementById(input_id).setAttribute('value', val);
    }*/

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

    /***
     *  Set the map and zoom on the specific location
     */
    function initMap() {
        if(map==null || $.isEmptyObject(map)) {
            alert("Init Map...");
            //valori fissi per il settaggio iniziale della mappa....
            // CREAZIONE MAPPA CENTRATA NEL PUNTO
            try {
                if ($.isEmptyObject(markerClusters)) {
                    markerClusters = new L.MarkerClusterGroup();
                }
                //Make all popup remain open.
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
                var latitude = 43.3555664; //43.3555664 40.46
                var longitude = 11.0290384; //11.0290384  -3.75
                map = new L.map('map', {attributionControl:false}).setView([latitude, longitude], 5);
                //map = new L.map('map', {center: center, zoom: 2, maxZoom: 9, layers: [basemap],attributionControl:false})
                // .setView([latitude, longitude], 5);
                //var map = L.map('map').setView([43.3555664, 11.0290384], 8);

                //Build your map
                L.tileLayer('http://c.tiles.mapbox.com/v3/examples.map-szwdot65/{z}/{x}/{y}.png', { // NON MALE
                    attribution: 'Map data &copy; 2011 OpenStreetMap contributors, Imagery &copy; 2012 CloudMade',
                    key: 'BC9A493B41014CAABB98F0471D759707',
                    subdomains: ['otile1', 'otile2', 'otile3', 'otile4'],
                    //minZoom: 8,
                    maxZoom: 18
                }).addTo(map);
                //Set a bound window for the leaflet map for Toscany region
                //var bounds = new L.LatLngBounds(new L.LatLng(setBounds[0],setBounds[1]), new L.LatLng(setBounds[2], setBounds[3]));
                /*map.setMaxBounds(new L.LatLngBounds(new L.LatLng(41.7, 8.4), new L.LatLng(44.930222, 13.4)));*/
                //..add many functionality
                addPluginGPSControl();
                addPluginCoordinatesControl();
                addPluginLayersStamenBaseMaps();
                addPluginLocateControl();
                addPluginSearch();
                //..add other functionality
                //map.on('click', onMapClick);
                //Fired when the view of the map stops changing
                map.on('moveend', onMapMove);
                /*map.on('viewreset', function() {
                    resetShapes();
                    //resetStops();
                });*/
                //other function form Service Map
                // ASSOCIA FUNZIONI AGGIUNTIVE ALL'APERTURA DI UN POPUP SU PARTICOLARI TIPI DI DATI
                map.on('popupopen', function(e) {

                    $('#raggioricerca').prop('disabled', false);
                    $('#numerorisultati').prop('disabled', false);

                    var markerPopup = e.popup._source;
                    var tipoServizio = markerPopup.feature.properties.tipo;
                    var nome = markerPopup.feature.properties.nome;

                    selezione = 'Servizio: ' + markerPopup.feature.properties.nome;
                    coordinateSelezione = markerPopup.feature.geometry.coordinates[1] + ";" + markerPopup.feature.geometry.coordinates[0];
                    $('#selezione').html(selezione);
                    if (tipoServizio == 'fermata'){

                        // SE IL SERVIZIO E' UNA FERMATA MOSTRA GLI AVM NEL MENU CONTESTUALE
                        selezione = 'Fermata Bus: ' + markerPopup.feature.properties.nome;
                        coordinateSelezione = markerPopup.feature.geometry.coordinates[1] + ";" + markerPopup.feature.geometry.coordinates[0];
                        $('#selezione').html(selezione);
                        mostraAVMAJAX(nome);
                    }
                    if (tipoServizio == 'parcheggio_auto'){
                        // SE IL SERVIZIO E' UN PARCHEGGIO MOSTRA LO STATO DI OCCUPAZIONE NEL MENU CONTESTUALE
                        mostraParcheggioAJAX(nome);
                    }
                });
                alert("MAP IS SETTED");
                //$('#caricamento').delay(500).fadeOut('slow');
            } catch (e) {
                alert('Exception initMap():' + e.message);
            }
        }
    }

    /***
     * Set plugin for gps on the leaflet
     * https://github.com/stefanocudini/leaflet-gps
     */
    function addPluginGPSControl() {
        //Simple point
        //map.addControl( new L.Control.Gps({autoActive:true}) );//inizialize control
        //Custom marker
        //map.addControl( new L.Control.Gps({marker: new L.Marker([0,0])}) );//inizialize control
        //Custom a style (circle,ecc.)
        //var newStyle = {radius: 25, weight:4, color: '#f0c', fill: true, opacity:0.8};
        //map.addControl( new L.Control.Gps({style: newStyle }) );//inizialize control
        if($.isEmptyObject(GPSControl)){
            GPSControl = new L.Control.Gps({maxZoom: 16,style: null});
        }
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

    /*** function for remove all cluster when the map is move */
    function onMapMove() {
        //Se muovi la mappa rimuove tutti i marker funziona!!.
        //removeClusterMarker();
    }

    /*** function Set a popup when you click on the map*/
    //var popupGlobal = L.popup();
    function onMapClick(e) {
        //popupGlobal.setLatLng(e.latlng).setContent("You clicked the map at " + e.latlng.toString()).openOn(map);
        // AL CLICK CERCO L'INDIRIZZO APPROSSIMATIVO
        if (selezioneAttiva == true){

            if (ricercaInCorso == false){
                $('#raggioricerca').prop('disabled', false);
                $('#numerorisultati').prop('disabled', false);

                ricercaInCorso = true;
                $('#info-aggiuntive .content').html("Indirizzo Approssimativo: <img src=\"resources/img/ajax-loader.gif\" width=\"16\" />");
                clickLayer.clearLayers();
                //clickLayer = new L.LatLng(e.latlng);
                clickLayer = L.layerGroup([new L.marker(e.latlng)]).addTo(map);
                var latLngPunto = e.latlng;
                coordinateSelezione = latLngPunto.lat + ";" + latLngPunto.lng;
                var latPunto = new String(latLngPunto.lat);
                var lngPunto = new String(latLngPunto.lng);

                selezione = 'Coord: ' + latPunto.substring(0,7) + "," + lngPunto.substring(0,7);
                $('#selezione').html(selezione);
                $.ajax({
                    url : "${pageContext.request.contextPath}/resources/ajax/get-address.jsp",
                    type : "GET",
                    async: true,
                    //dataType: 'json',
                    data : {
                        lat: latPunto,
                        lng: lngPunto
                    },
                    success : function(msg) {
                        $('#info-aggiuntive .content').html(msg);
                        ricercaInCorso = false;
                    }
                });
            }
        }
    }

    /*** function for add a marker to the leaflet map */
    var marker;
    function addSingleMarker(name, url, lat, lng) {
        //alert("... add single marker:" + name + ',' + url + ',' + lat + ',' + lng);
        try {
            if ($.isEmptyObject(markerClusters)) {
                markerClusters = new L.MarkerClusterGroup();
            }
            //var marker = L.marker([lat, lng]).bindPopup(popupClick).addTo(map);
            //var cc = L.latLng(43.7778535, 11.2593572);
            var text = '<a class="linkToMarkerInfo" href="' + url + '" target="_blank">' + name + '</a>';
            try {
                /*marker = new L.marker([parseFloat(lat), parseFloat(lng)], {draggable:false}, { icon: deathIcon},{title: name} )
                    .bindLabel(text, { noHide: true }).addTo(map);
                */
                var title = name,	//value searched
                    loc = [parseFloat(lat), parseFloat(lng)],		//position found
                    marker = new L.Marker(new L.latLng(loc), {title: title} ).bindLabel(text, { noHide: true });//se property searched
                    //marker.bindPopup('title: '+ title );
            }catch(e){
                try{
                    /*marker = new L.marker([lat, lng], {draggable:false}, { icon: deathIcon},{title: name})
                        .bindLabel(text, { noHide: true }).addTo(map);*/
                    var title = name,	//value searched
                        loc = [lat,lng],		//position found
                        marker = new L.Marker(new L.latLng(loc), {title: title} ).bindLabel(text, { noHide: true });//se property searched
                }catch(e){
                    alert(e.message);
                    alert("Sorry the program can't find Geographical coordinates for this Web address,check if the Web address is valid");
                }
            }
            //...set the popup on mouse over
            //var latlngOver = L.latLng(latVar, lngVar);
            //...set the popup on mouse click

            //var popupClick = new L.popup().setContent(text);
            var popupContent = '<div class="popup-content"><table class="table table-striped table-bordered table-condensed">';
            var  attr = '<a target="_blank" href="' + url + '">'+ name + '</a>';
            popupContent += '<tr><th>title</th><td>'+ title +'</td></tr>'+
                            '<tr><th>Site</th><td>'+ attr +'</td></tr>'+
                            '<tr><th>Regione:</th><td>'+regionVar+'</td></tr>'+
                            '<tr><th>Provincia:</th><td>'+provinceVar+'</td></tr>'+
                            '<tr><th>Città:</th><td>'+cityVar+'</td></tr>'+
                            '<tr><th>Indirizzo:</th><td>'+addressVar+'</td></tr>'+
                            '<tr><th>Telefono/Cellulare:</th><td>'+phoneVar+'</td></tr>'+
                            '<tr><th>Fax:</th><td>'+faxVar+'</td></tr>'+
                            '<tr><th>Email:</th><td>'+emailVar +'</td></tr>'+
                            '<tr><th>IVA:</th><td>'+ivaVar+'</td></tr>';
            popupContent += "</table></div>";
            var popupOver = new L.popup().setContent(popupContent);
            //marker.bindPopup(popupClick);
            marker.bindPopup(popupOver);
            //..set some action for the marker
            //evt.target is the marker where set the action
            //marker.on('mouseover', function (e) {e.target.bindPopup(popupOver).openPopup();});
            //marker.on('mouseout', function (e) { e.target.closePopup();});
            marker.on('click', function (e) { e.target.bindPopup(popupOver).openPopup();});
           //marker.on('dblclick',function (e) { map.removeLayer(e.target)});
            /*marker.on('click', onMarkerClick(), this);*/
            //..add marker to the array of cluster marker
            markerClusters.addLayer(marker);
            //...set to a Global variable for use with different javascript function
            //map.addLayer(markerClusters);
            markerClusters.addTo(map);
            map.setView([lat, lng], 8);
            //return {name: name, url: url, latitudine: lat, longitudine: lng};
        }catch(e) {
            alert(e.message);
            alert("Sorry the program can't create the Marker");
        }
    }

    /*** function for remove all cluster marker on the leaflet map */
    function removeClusterMarker(){
        alert("compile removeClusterMarker...");
        if(arrayMarkerVar.length > 0) {
            for (var i = 0; i < arrayMarkerVar.length; i++) {

                map.removeLayer(arrayMarkerVar[i]);//...remove every single marker
            }
            arrayMarkerVar.length = 0; //...reset array
        }
        markerClusters.eachLayer(function (layer) {
            layer.closePopup();
            map.removeLayer(layer);
        });

        map.closePopup();
        map.removeLayer(markerClusters);//....remove layer
        points.clearLayers();
        alert("...compiled removeClusterMarker");
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
            utility_leaflet_csv.loadCSVFromURL(url);
        },
        chooseIcon: function(code){
            chooseIcon(code);
        }
    };


    function chooseIcon(category){
        alert("chooseIcon");
        var url;
        if(category == "") {url = 'resources/js/leaflet/images/marker-icon.png';}
        else if(category == "Bank") {url = "resources/js/leaflet/images/marcador-bankia.png";}
        else{ url = 'resources/js/leaflet/images/marker-icon.png';}

        return L.icon({
            iconUrl: url,
            //iconUrl: 'http://www.megalithic.co.uk/images/mapic/' + feature.properties.Icon + '.gif',//from a field Icon data.
            shadowUrl: 'resources/js/leaflet/images/marker-shadow.png',
            iconSize: [25, 41],
            shadowSize: [41, 41],
            shadowAnchor: [13, 20]
        })
    }





   /*** function to open a URL with javascript without jquery. */
   function openURL(url){
       // similar behavior as an HTTP redirect
       window.location.replace(url);
        // similar behavior as clicking on a link
       window.location.href = url;
   }

    /** function to add for every single object marker a Leaflet Marker on the Leaflet Map.  */
    function addMultipleMarker(markers){
        alert("add multiple marker "+markers.length+"...");
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

    /** function to add every single company from java object in JSP page to a javascript array */
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
     * https://github.com/stamen/maps.stamen.com.
     */
    function addPluginLayersStamenBaseMaps() {
        if (map != null) {
            //var layers = ["terrain", "watercolor","toner"];
            //http://c.tiles.mapbox.com/v3/examples.map-szwdot65/{z}/{x}/{y}.png
            var bases = {
                "Watercolor": new L.StamenTileLayer("watercolor"),
                "Terrain": new L.StamenTileLayer("terrain"),
                "Toner": new L.StamenTileLayer("toner"),
                "Disit": new L.StamenTileLayer("disit"),
                "Disit2": new L.stamenTileLayer("disit2")
            };
            L.control.layers(bases).addTo(map);
        }
    }

    /**
     *  Add the Leaflet plugin  locateControl.
     *  https://github.com/domoritz/leaflet-locatecontrol.
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
            // create control and add to map
            var lc = new L.control.locate({
                position: 'topleft',  // set the location of the control
                layer: new L.LayerGroup(),  // use your own layer for the location marker
                //layer: markerClusters,  // use your own layer for the location marker
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
            //var lc = L.control.locate({follow: true,strings: {title: "Show me where I am"}});
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

    /**
     * Add the Leaflet Plugin Search.
     * https://github.com/p4535992/leaflet-search.
     */
    function addPluginSearch(){
        alert("compile addPluginSearch...");
        if (!$.isEmptyObject(markerClusters)) {
            controlSearch = new L.Control.Search({layer: markerClusters, initial: false, position:'topleft'});
            map.addControl( controlSearch );
            //map.addControl( new L.Control.Search({layer: markerClusters}) );
            //searchLayer is a L.LayerGroup contains searched markers
            //Short way:
            //L.map('map', { searchControl: {layer: searchLayer} });
        }
        alert("...compiled addPluginSearch");
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

    //-------------------------------------------------
    //OLD METHODS Service-Map
    //-------------------------------------------------
    // RESET DI TUTTI I LAYERS SULLA MAPPA
    function svuotaLayers(){
        //clickLayer.clearLayers();
        busStopsLayer.clearLayers();
        servicesLayer.clearLayers();
        GPSLayer.clearLayers();
    }

    // CANCELLAZIONE DEL CONTENUTO DEL BOX INFO AGGIUNTIVE
    function svuotaInfoAggiuntive(){
        $('#info-aggiuntive .content').html('');
    }

    function cancellaSelezione(){
        $('#selezione').html('Nessun punto selezionato');
        selezione = null;
        coordinateSelezione = null;
    }


    // FUNZIONE DI RESET GENERALE
    function resetTotale(){
        clickLayer.clearLayers();
        svuotaInfoAggiuntive();
        svuotaLayers();
        cancellaSelezione();
        $('#macro-select-all').prop('checked', false);
        $('.macrocategory').prop('checked', false);
        $('.macrocategory').trigger( "change" );
        $('#raggioricerca')[0].options.selectedIndex = 0;
        $('#raggioricerca').prop('disabled', false);
        $('#numerorisultati')[0].options.selectedIndex = 0;
        $('#numerorisultati').prop('disabled', false);
        $('#elencolinee')[0].options.selectedIndex = 0;
        $('#elencoprovince')[0].options.selectedIndex = 0;
        $('#elencofermate').html('<option value=""> - Seleziona una Fermata - </option>');
        $('#elencocomuni').html('<option value=""> - Seleziona un Comune - </option>');
        $('#info').removeClass("active");
        selezioneAttiva = false;
    }


    // MOSTRA ELENCO FERMATE DI UNA LINEA
    function mostraElencoFermate(selectOption) {
        if (selectOption.options.selectedIndex != 0){
            $('#elencoprovince')[0].options.selectedIndex = 0;
            $('#elencocomuni').html('<option value=""> - Seleziona un Comune - </option>');
            $('#loading').show();
            $.ajax({
                url : "${pageContext.request.contextPath}/ajax/bus-stops-list.jsp",
                type : "GET",
                async: true,
                //dataType: 'json',
                data : {
                    nomeLinea: selectOption.options[selectOption.options.selectedIndex].value
                },
                success : function(msg) {
                    $('#elencofermate').html(msg);
                    $('#loading').hide();
                }
            });
        }
    }












