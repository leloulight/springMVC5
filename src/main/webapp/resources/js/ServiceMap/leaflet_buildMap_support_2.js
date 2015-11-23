
var leafletUtil = {};

/***  Set constructor variable for leaflet_buildMap_support */
var leaflet_buildMap_support_2 = {
    // Get a list of marker with coordinates and a url href and put the marker on the map
    initMap: function () { if(map==null){ initMap(); } },
    addSingleMarker: function (name, url, lat, lng) {addSingleMarker(name,url,lat,lng);},
    pushMarkerToArrayMarker: function(nameVar,urlVar,latVar,lngVar,regionVar,provinceVar,cityVar,addressVar,phoneVar,emailVar,faxVar,ivaVar){
        alert(1);
        pushMarkerToArrayMarker(
            nameVar,urlVar,latVar,lngVar,regionVar,provinceVar,cityVar,addressVar,phoneVar,emailVar,faxVar,ivaVar);
        alert(2);
        addMultipleMarker(leafletUtil.arrayGeoDocuments);
    },
    loadCSVFromURL: function(url){

    },
    chooseIcon: function(code){ chooseIcon(code);},
    initLeaflet: leafletUtil.initLeaflet,
    removeClusterMarker:removeClusterMarker
};

leafletUtil.bingAPIKey =
        'OOGpZK9MOAwIPsVuVTlE~D7N3xRehqhr3XJxlK8eMMg~Au-bt_oExU--ISxBKFtEXgSX-_AN6VMZSpM6rfKGY4xtAho6O67ueo2iN23gfbi0';
leafletUtil.googleAPIKey =
        'AIzaSyDlmsdr-wCDaHNbaBM6N9JljQLIjRllCl8';
leafletUtil.mapBoxAPIKey =
        'pk.eyJ1IjoiNDUzNTk5MiIsImEiOiJjaWdocXltNmMwc3Zud2JrbjdycWVrZG8zIn0.22EO_bIUp_3XUpt5dYjTRg';

    /** Set the Leaflet.markercluster for Leaflet. https://github.com/Leaflet/Leaflet.markercluster */
    markerClusters = new L.MarkerClusterGroup({showCoverageOnHover: false, maxClusterRadius: 50});
    /** Set the Leaflet Plugin Search. https://github.com/p4535992/leaflet-search.*/
    controlSearch = new L.Control.Search({layer: markerClusters, initial: false, position:'topright'});

    // VARIABILI PER LA FUNZIONALITA' DI RICERCA SERVIZI
    //var GPSControl = new L.Control.Gps({maxZoom: 16,style: null}); // AGGIUNTA DEL PLUGIN PER LA GEOLOCALIZZAZIONE

  /*  var geoCoderGoogle = L.Control.Geocoder.Google();
    var geoCoderControl = L.Control.geocoder({geocoder: geoCoderGoogle});*/
    var geoCoderGoogle,geoCoderControl,geocoderSearchGoogle;


leafletUtil.geocoders = {
        'Nominatim': L.Control.Geocoder.nominatim(),
        'Bing': L.Control.Geocoder.bing( leafletUtil.bingAPIKey),
        'Mapbox': L.Control.Geocoder.mapbox( leafletUtil.mapBoxAPIKey),
        'Google': L.Control.Geocoder.google( leafletUtil.googleAPIKey),
        'Photon': L.Control.Geocoder.photon()
    };

    //Variabili suppport java SPRING
leafletUtil.geoDocument = {name:'',url:'',lat:'',lng:'',region:'',province:'',city:'',
    address:'',phone:'',email:'',fax:'',iva:'',popupContent:'',other:'',marker:{}};

leafletUtil.arrayGeoDocuments =[]; // array support of makers

    /*** Set a personal icon marker */
leafletUtil.deathIcon = L.icon({
        iconUrl: '../leaflet/images/marker-shadow.png',
        //iconRetinaUrl: myURL + 'img/me.png',
        iconSize: [36, 36], iconAnchor: [18, 18],popupAnchor: [0, -18],labelAnchor: [14, 0]
    });

    /*** Set the src of the javascript file*/
    //var mySRC = jQuery('script[src$="resources/js_utility/leaflet_buildMap_support.js"]').attr('src').replace('js_utility/leaflet_buildMap_support.js', '');


leafletUtil.initLeaflet = function() {
    /*** On ready document  */
    //jQuery( document ).ready(function() {

    /** if you have add a new marker from spring put in the map. */
    if ((!jQuery.isEmptyObject(leafletUtil.arrayGeoDocuments)) && leafletUtil.arrayGeoDocuments.length > 0) {
        addMultipleMarker(leafletUtil.arrayGeoDocuments);
    }

    //ABILITA LA RICRECA NEI MARKER CON IL PLUGIN LEAFLET-SEARCH
    jQuery('#textsearch').on('keyup', function (e) {
        controlSearch.searchText(e.target.value);
    });


    $("#getMarkers").click(function () {
        getMarkers();
    });

    //Search address with google...
    //jQuery("div.leaflet-control-geosearch").appendTo(jQuery("#search-address-with-google"));
    //<div class="leaflet-control-search leaflet-control search-exp">
    jQuery("#searchMarkerWithJavascript").appendTo(jQuery("#searchMarkerWithJavascript2"));

    leafletUtil.addGeoCoderPluginWithContainer('#searchMarkerWithJavascript3');

    console.info("Loaded all JQUERY variable");
    alert("Loaded all JQUERY variable");

    //});
};

var btn,selection;
var selector = 'geocode-selector';
leafletUtil.addGeoCoderPluginWithContainer = function(containerId){

    if(jQuery.isEmptyObject(containerId)) containerId = "#searchMarkerWithJavascript3";

    //Help css for PluginLeafletGeocoder
    //<a class="leaflet-control-geocoder-icon" href="javascript:void(0);">&nbsp;</a>
    jQuery("a").remove(jQuery(".leaflet-control-geocoder-icon"));
    //<div class="leaflet-control-geocoder leaflet-bar leaflet-control leaflet-control-geocoder-expanded">
    jQuery(".leaflet-control-geocoder").appendTo(jQuery(containerId));
    //implement select of the geocoder.
    for (var name in leafletUtil.geocoders) {
        btn = L.DomUtil.create('button', 'leaflet-bar', selector);
        btn.innerHTML = name;
        (function (n) {
            L.DomEvent.addListener(btn, 'click', function () {
                select(leafletUtil.geocoders[n], this);
            }, btn);
        })(name);
        if (!selection) select(leafletUtil.geocoders[name], btn);
        $('#geocode-selector').append(btn);
    }// end of the for...

};

    /**
     * function to get the information on the marker ont he Layer to a Array to pass
     * by create a list of input to pass to a specific form.
     * */
    function getMarkers(){
        var array = [];
        console.log("compile getMarkers");
        try{
            if(!$.isEmptyObject(markerClusters)) {
                console.warn("Marker cluster is not empty go to check the Marker.");
                markerClusters.eachLayer(function (layer) {
                    try {
                        var lat = layer.getLatLng().lat;
                        var lng = layer.getLatLng().lng;
                        var label;
                        //label = layer.getLabel()._content;
                        if(lat!=0 && lng !=0) {
                            label = layer.label._content;
                            /*var location = layer.getLocation();*/
                            var popupContent = layer.getPopup().getContent();
                            //alert("marker number():" + lat + "," + lng + "," + label + "," + popupContent);
                            array.push({name: label, lat: lat, lng: lng, description: popupContent});
                        }
                        //i++;
                    }catch(e){
                        console.error("Exception:getMarkers -> "+e.message);
                    }
                });
            }
        }catch(e){console.error("Exception:getMarkers -> "+e.message);}
        console.log("...compiled getMarkers");
        //var array = getMarkers();
        for (var i = 0; i < array.length; i++) {
            try {
                addInput('nameForm' + i, array[i].name, i);
                addInput('latForm' + i, array[i].lat, i);
                addInput('lngForm' + i, array[i].lng, i);
                addInput('descriptionForm' + i, array[i].description, i);
            }catch(e){console.error('Exception::getMarkers() ->'+e.message);}
        }
        //alert(document.getElementById('uploader').value);
        //<input type="submit" name="GetMarkersParam" value="getMarkers" />
        var input = document.createElement('input');
        input.setAttribute('id', 'supportUploaderForm');
        input.setAttribute('type', 'hidden');
        input.setAttribute('value', document.getElementById('uploader').value);
        input.setAttribute('name',"supportUploaderParam");
        document.getElementById('loadMarker').appendChild(input);
        console.log("...compiled 2 getMarkers");
    }

    function addInput(input_id,val,index) {
        var input = document.createElement('input');
        input.setAttribute('id', input_id);
        input.setAttribute('type', 'hidden');
        input.setAttribute('value', val);
        input.setAttribute('name', input_id.replace(index,'').replace('Form','Param1'));
        //document.body.appendChild(input);
        document.getElementById('loadMarker').appendChild(input);
        //setInputValue(input_id,val);
    }

    /***
     *  Set the map and zoom on the specific location
     */
    function initMap() {
        if(jQuery.isEmptyObject(map)) {
            console.log("Init Map...");
            try {
                if (jQuery.isEmptyObject(markerClusters)) {
                    markerClusters = new L.MarkerClusterGroup();
                }
                //Make all popup remain open.
                L.Map = L.Map.extend({
                    openPopup: function(popup) {
                        //this.closePopup();  // just comment this
                        this._popup = popup;
                        return this.addLayer(popup).fire('popupopen', {
                            popup: this._popup
                        });
                    }
                });
                //map = new L.map('map', {attributionControl:false}).setView([latitude, longitude], 5);
                map = new L.map('map').setView([43.3555664,  11.0290384], 5);
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
                //map.attributionControl.setPrefix(''); // Don't show the 'Powered by Leaflet' text.
                //..add many functionality
                //addPluginGPSControl();
                //addPluginCoordinatesControl();
                //addPluginLayersStamenBaseMaps();
                //addPluginLocateControl();
                addPluginSearch(); //not necessary
                //addPluginGeoSearch();
                addPluginGeoCoder();

                //..add other functionality
                //map.on('click', onMapClick);
                //Fired when the view of the map stops changing
                map.on('moveend', onMapMove);
                /*map.on('viewreset', function() { resetShapes(); //resetStops();});*/
                //other function form Service Map
                console.log("MAP IS SETTED");
                //$('#caricamento').delay(500).fadeOut('slow');
            } catch (e) {
               console.error('Exception::initMap() -> ' + e.message);
            }
        }
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
    }

    /*** function for add a marker to the leaflet map */
    function addSingleMarker(name, url, lat, lng, bounds, popupContent) {
        console.info("... add single marker:" + name + ',' + url + ',' + lat + ',' + lng + ',' + popupContent);
        var markerVar;
        try {
            if (jQuery.isEmptyObject(markerClusters)) {
                markerClusters = new L.MarkerClusterGroup();
            }
            if(!jQuery.isEmptyObject(bounds)){
                map.setBounds(bounds);
            }
            //var marker = L.marker([lat, lng]).bindPopup(popupClick).addTo(map);
            //var cc = L.latLng(43.7778535, 11.2593572);
            var text;
            if(!$.isEmptyObject(url)) text = '<a class="linkToMarkerInfo" href="' + url + '" target="_blank">' + name + '</a>';
            else  text = name;
            var loc;
            try {
                /*marker = new L.marker([parseFloat(lat), parseFloat(lng)], {draggable:false}, { icon: deathIcon},{title: name} )
                    .bindLabel(text, { noHide: true }).addTo(map);
                */
                loc = [parseFloat(lat), parseFloat(lng)];		//position found
                markerVar = new L.Marker(new L.latLng(loc), {title: name} ).bindLabel(text, { noHide: true });//se property searched
                //marker.bindPopup('title: '+ title );
            }catch(e){
                try{
                    /*marker = new L.marker([lat, lng], {draggable:false}, { icon: deathIcon},{title: name})
                        .bindLabel(text, { noHide: true }).addTo(map);*/
                    loc = [lat,lng];	//position found
                    markerVar = new L.Marker(new L.latLng(loc), {title: name} ).bindLabel(text, { noHide: true });//se property searched
                }catch(e){
                    console.error("addSingleMarker"+e.message);
                    console.error("Sorry the program can't find Geographical coordinates for this Web address,check if the Web address is valid");
                }
            }
            //...set the popup on mouse over
            //var latlngOver = L.latLng(latVar, lngVar);
            //...set the popup on mouse click
            //var popupClick = new L.popup().setContent(text);
            var popupOver = new L.popup().setContent(popupContent);
            //marker.bindPopup(popupClick);
            markerVar.bindPopup(popupOver);
            //..set some action for the marker
            //evt.target is the marker where set the action
            //marker.on('mouseover', function (e) {e.target.bindPopup(popupOver).openPopup();});
            //marker.on('mouseout', function (e) { e.target.closePopup();});
            markerVar.on('click', function (e) { e.target.bindPopup(popupOver).openPopup();});
           //marker.on('dblclick',function (e) { map.removeLayer(e.target)});
            /*marker.on('click', onMarkerClick(), this);*/
            //..add marker to the array of cluster marker
            markerClusters.addLayer(markerVar);
            //...set to a Global variable for use with different javascript function
            //map.addLayer(markerClusters);
            markerClusters.addTo(map);
            map.setView([lat, lng], 8);
            //return {name: name, url: url, latitudine: lat, longitudine: lng};
        }catch(e) {
            alert("Exception::addSingleMarker() -> "+e.message);
            alert("Sorry the program can't create the Marker");
        }
    }

    /*** function for remove all cluster marker on the leaflet map */
    function removeClusterMarker(){
        console.log("compile removeClusterMarker...");
        if(leafletUtil.arrayGeoDocuments.length > 0) {
            for (var i = 0; i < leafletUtil.arrayGeoDocuments.length; i++) {
                map.removeLayer(leafletUtil.arrayGeoDocuments[i]);//...remove every single marker
            }
            leafletUtil.arrayGeoDocuments.length = 0; //...reset array
        }
        markerClusters.eachLayer(function (layer) {
            layer.closePopup();
            map.removeLayer(layer);
        });
        map.closePopup();
        map.removeLayer(markerClusters);//....remove layer
        points.clearLayers();
        console.log("...compiled removeClusterMarker");
    }

    function chooseIcon(category){
        console.log("chooseIcon");
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

    /**
     * function to add for every single object marker a Leaflet Marker on the Leaflet Map.
     */
    function addMultipleMarker(markers){
        console.log("add multiple marker "+markers.length+"...");
        try {
            //var titles = Object.keys(markers[0]).split(",");
            for (var marker,j = 0; marker = markers[j++];){
                console.log("... add single marker (" + j + "):"
                    + markers[j].name + ',' + markers[j].url + ',' + markers[j].lat + ',' + markers[j].lng);
                addSingleMarker(markers[j].name, markers[j].url, markers[j].lat, markers[j].lng,'',markers[j].popupContent);
            }
            console.log("... added multiple marker");
        }catch(e){
            console.error(e.message);
        }
    }

    /**
     * function to add every single company from java object in JSP page to a javascript array
     */
    function pushMarkerToArrayMarker(nameVar,urlVar,latVar,lngVar,regionVar,provinceVar,cityVar,addressVar,phoneVar,emailVar,faxVar,ivaVar){
        /*nameVar = document.getElementById('nameForm').value;*/
        console.info("pushing the element =>Name:" + nameVar + ',URL:' + urlVar + ',LAT:' + latVar + ',LNG:' + lngVar+"...");
        var geoDoc = leafletUtil.geoDocument;
        geoDoc.name = nameVar;
        geoDoc.url = urlVar;
        geoDoc.lat = latVar;
        geoDoc.lng = lngVar;
        geoDoc.region = regionVar;
        geoDoc.province=provinceVar;
        geoDoc.city=cityVar;
        geoDoc.address=addressVar;
        geoDoc.phone=phoneVar;
        geoDoc.email=emailVar;
        geoDoc.fax=faxVar;
        geoDoc.iva=ivaVar;

        leafletUtil.arrayGeoDocuments.push(geoDoc);
        for (var j = 0 ; j < leafletUtil.arrayGeoDocuments.length; j++){
            alert(leafletUtil.arrayGeoDocuments[j].toString());
            console.info("(" + j + ") titles:"+Object.keys(leafletUtil.geoDocument).toString()+",Length:"+leafletUtil.arrayGeoDocuments.length);
            var titles = Object.keys(leafletUtil.geoDocument).toString().split(",");
            alert(8+leafletUtil.arrayGeoDocuments[j].toString());
            console.info("... prepare marker (" + j + "):"
                + leafletUtil.arrayGeoDocuments[j].name + ',' + leafletUtil.arrayGeoDocuments[j].url +
                ',' + leafletUtil.arrayGeoDocuments[j].lat + ',' + leafletUtil.arrayGeoDocuments[j].lng);
            var  content = '<div class="popup-content"><table class="table table-striped table-bordered table-condensed">';
            for (var title, i = 0; title = titles[i++];) {
                try {
                    if(title == 'popupContent') continue;
                    var href = '';
                    if (leafletUtil.arrayGeoDocuments[j][title].toString().indexOf('http') === 0) {
                        href = '<a target="_blank" href="' + leafletUtil.arrayGeoDocuments[j][title] + '">'
                            + leafletUtil.arrayGeoDocuments[j][title] + '</a>';
                    }
                    if (href.length > 0)content += '<tr><th>' + title + '</th><td>' + href + '</td></tr>';
                    else content += '<tr><th>' + title + '</th><td>' + leafletUtil.arrayGeoDocuments[j][title] + '</td></tr>';
                } catch (e) {
                    console.warn("Exception::pushMarkerToArrayMarker ->"+e.message);
                }
            }//for
            content += "</table></div>";
            leafletUtil.arrayGeoDocuments[j].popupContent = content;
            alert(4);
            addSingleMarker( leafletUtil.arrayGeoDocuments[j].name,  leafletUtil.arrayGeoDocuments[j].url,
                leafletUtil.arrayGeoDocuments[j].lat,  leafletUtil.arrayGeoDocuments[j].lng,'',
                leafletUtil.arrayGeoDocuments[j].popupContent);
        }
        console.info("....pushed a marker tot he array on javascript side:"+ leafletUtil.geoDocument.toString());
    }

    /**
     * Add the Leaflet Plugin Search.
     * https://github.com/p4535992/leaflet-search.
     */
    function addPluginSearch(){
        try{
            geocoderSearchGoogle = new google.maps.Geocoder();
        }catch(e){
            alert("Warning:addPluginSearch->"+e.message)
            geocoderSearchGoogle = null;
        }
        alert("compile addPluginSearch...");
        try {
            if (!jQuery.isEmptyObject(markerClusters)) {
                /* controlSearch = new L.Control.Search({layer: markerClusters, initial: false,collapsed: false});*/
                if (jQuery.isEmptyObject(geocoderSearchGoogle)) {
                    alert("21");
                    controlSearch = new L.Control.Search({
                        container: "searchMarkerWithJavascript", layer: markerClusters, initial: false, collapsed: false
                    });
                } else {
                    controlSearch = new L.Control.Search({
                        container: "searchMarkerWithJavascript",
                        layer: markerClusters,initial: false,collapsed: false,
                        sourceData: googleGeocoding,formatData: formatJSON,
                        markerLocation: true,autoType: false,autoCollapse: true, minLength: 2,zoom: 10
                    });
                }
                map.addControl(controlSearch);
            }
            alert("...compiled addPluginSearch");
        }catch(e){
            alert("Exception:addPluginSearch->"+e.message);
        }
    }

    function googleGeocoding(text, callResponse){
        geocoderSearchGoogle.geocode({address: text}, callResponse);
    }

    function formatJSON(rawjson) {
        var json = {}, key, loc, disp = [];
        for(var i in rawjson){
            key = rawjson[i].formatted_address;
            loc = L.latLng( rawjson[i].geometry.location.lat(), rawjson[i].geometry.location.lng() );
            json[ key ]= loc;	//key,value format
        }
        return json;
    }

    /**
     * Add the Leaflet leaflet-control-geocoder.
     * https://github.com/perliedman/leaflet-control-geocoder
     * https://github.com/patrickarlt/leaflet-control-geocoder
     */
    function addPluginGeoCoder() {
        alert("Compile addPluginGeoCoder...");
        try {
            if (jQuery.isEmptyObject(geoCoderControl)) {
                selector = L.DomUtil.get('geocode-selector');
                geoCoderControl = new L.Control.Geocoder({ geocoder: null },{collapsed: false});
                geoCoderControl.addTo(map);
            } else {
                map.addControl(geoCoderControl);
            }
            alert("...compiled addPluginGeoCoder");
        }catch(e){
            alert("Exception:addPluginGeoCoder->"+e.message);
        }
    }

    function addPluginFileLayer(){
        // line style
        var style = {color:'red', fillColor: "#ff7800", opacity: 1.0, fillOpacity: 0.8, weight: 2, clickable: false};
        L.Control.FileLayerLoad.LABEL = '<i class="fa fa-folder-open"></i>';

        var geoJsonOptions = {
            onEachFeature: function (feature, layer) {
                layer.bindPopup(feature.properties.description);},

            style: style,
            pointToLayer: function (data, latlng) {
                // setup popup, icons...
                return L.marker(latlng, {icon: myIcon});
            }
        };

        L.Control.fileLayerLoad({
            layerOptions: geoJsonOptions,
        }).addTo(map);
    }

    function select(geocoder, el) {
        if (selection) L.DomUtil.removeClass(selection, 'selected');
        geoCoderControl.options.geocoder = geocoder;
        L.DomUtil.addClass(el, 'selected');
        selection = el;
    }

    function invokePluginGeoCoderGoogle(geoCoderControl){
        //convert latlng to Address
        //geocodergoogle.reverse(e.latlng, map.options.crs.scale(map.getZoom()), function(results) {});
        try {
           geoCoderControl.options.geocoder.markGeocode = function (result) {
                alert("88:" + result.toSource());
                //var marker = new L.Marker(result.center).bindPopup(result.html || result.name);
                addressVar = jQuery("#").val();
                otherVar = result.html;
                alert("add marker:" + result.name + "," + result.center.lat + "," + result.center.lng + "," + otherVar);
                pushMarkerToArrayMarker(result.name, null, result.center.lat, result.center.lng,
                    null,null,null,addressVar,null,null,null,null);
                /*var bbox = result.bbox;
                 L.polygon([
                 bbox.getSouthEast(),
                 bbox.getNorthEast(),
                 bbox.getNorthWest(),
                 bbox.getSouthWest()
                 ]).addTo(map);*/
             /* geoCoderControl.options.geocoder.geocode(address, function(results) {
                    var latLng= new L.LatLng(results[0].center.lat, results[0].center.lng);
                    marker = new L.Marker (latLng);
                    map.addlayer(marker);
                    addressVar = address;
                    otherVar = result.html;
                    alert("add marker:" + result.name + "," + result.center.lat + "," + result.center.lng + "," + otherVar);
                    pushMarkerToArrayMarker(result.name, null, result.center.lat, result.center.lng,
                        null,null,null,addressVar,null,null,null,null);
                    });*/
               /* geoCoderControl.options.geocoder.geocode(address, function(results) {
                    var latLng= new L.LatLng(results[0].center.lat, results[0].center.lng);
                    marker = new L.Marker (latLng);
                    map.addlayer(marker);
                });*/
            };

           /* Then you can use the following code to 'geocode' your address into latitude / longitude. This function will
            return the latitude / longitude of the address. You can save the latitude / longitude in an variable so you
            can use it later for your marker. Then you only have to add the marker to the map.*/
           /*
            var yourQuery = '(Addres of person)';
            geocoder.geocode(yourQuery, function(results) {
                //latLng= new L.LatLng(results[0].center.lat, results[0].center.lng);
                //marker = new L.Marker (latLng);
                //map.addlayer(marker);
                pushMarkerToArrayMarker(nameVar,urlVar,latVar,lngVar,regionVar,provinceVar,cityVar,addressVar,phoneVar,emailVar,faxVar,ivaVar)
             });
            */
            alert("g marker:" + g.name + "," + g.center.lat + "," + g.center.lng + "," + otherVar);
        }catch(e){alert("Exception:invokePluginGeoCoder->"+ e.message)}

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
        $('#info-aggiuntive').find('.content').html('');
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












