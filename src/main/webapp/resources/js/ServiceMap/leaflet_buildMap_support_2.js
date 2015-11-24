
var leafletUtil = {};

/***  Set constructor variable for leaflet_buildMap_support */
var leaflet_buildMap_support_2 = {
    // Get a list of marker with coordinates and a url href and put the marker on the map
    initMap: function () {
        leafletUtil.initMap();
    },
    addSingleMarker: function (name, url, lat, lng,bound,popupContent) {addSingleMarker(name,url,lat,lng,bounds,popupContent);},
    pushMarkerToArrayMarker: function(nameVar,urlVar,latVar,lngVar,regionVar,provinceVar,cityVar,addressVar,phoneVar,emailVar,faxVar,ivaVar){;
        leafletUtil.initMap(); //check fast if the map is setted
        alert(1);
        pushMarkerToArrayMarker(
            nameVar,urlVar,latVar,lngVar,regionVar,provinceVar,cityVar,addressVar,phoneVar,emailVar,faxVar,ivaVar);
        alert(2);
        addMultipleMarker(leafletUtil.arrayGeoDocuments);
    },
    chooseIcon: function(code){ chooseIcon(code);},
    removeClusterMarker:leafletUtil.removeClusterMarker
};

var bingAPIKey =
        'OOGpZK9MOAwIPsVuVTlE~D7N3xRehqhr3XJxlK8eMMg~Au-bt_oExU--ISxBKFtEXgSX-_AN6VMZSpM6rfKGY4xtAho6O67ueo2iN23gfbi0';
var googleAPIKey =
        'AIzaSyDlmsdr-wCDaHNbaBM6N9JljQLIjRllCl8';
var mapBoxAPIKey =
        'pk.eyJ1IjoiNDUzNTk5MiIsImEiOiJjaWdocXltNmMwc3Zud2JrbjdycWVrZG8zIn0.22EO_bIUp_3XUpt5dYjTRg';

/** Set the Leaflet.markercluster for Leaflet. https://github.com/Leaflet/Leaflet.markercluster */
var markerClusters = new L.MarkerClusterGroup({showCoverageOnHover: false, maxClusterRadius: 50});
/** Set the Leaflet Plugin Search. https://github.com/p4535992/leaflet-search.*/
var controlSearch = new L.Control.Search({layer: markerClusters, initial: false, position:'topright'});
var geoCoderGoogle,geocoderSearchGoogle;



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



//leafletUtil.initLeaflet = function() {
    /*** On ready document  */
    jQuery( document ).ready(function() {

    /** if you have add a new marker from spring put in the map. */
    if ((!jQuery.isEmptyObject(leafletUtil.arrayGeoDocuments)) && leafletUtil.arrayGeoDocuments.length > 0) {
        addMultipleMarker(leafletUtil.arrayGeoDocuments);
    }

    //ABILITA LA RICRECA NEI MARKER CON IL PLUGIN LEAFLET-SEARCH
    jQuery('#textsearch').on('keyup', function (e) {
        controlSearch.searchText(e.target.value);
    });


    jQuery("#getMarkers").click(function () {
        getMarkers();
    });

    //Search address with google...
    //jQuery("div.leaflet-control-geosearch").appendTo(jQuery("#search-address-with-google"));
    //<div class="leaflet-control-search leaflet-control search-exp">
    jQuery("#searchMarkerWithJavascript").appendTo(jQuery("#searchMarkerWithJavascript2"));
    leafletUtil.addGeoCoderPluginWithContainer('#searchMarkerWithJavascript3');


    console.info("Loaded all JQUERY variable");
    alert("Loaded all JQUERY variable");

    });
//};

var btn;
leafletUtil.geoCoderControl ={selection:{},geoCoderControl:{},selector:{},
geocoders:{
    'Nominatim': L.Control.Geocoder.nominatim(),
    'Bing': L.Control.Geocoder.bing( bingAPIKey),
    'Mapbox': L.Control.Geocoder.mapbox( mapBoxAPIKey),
    'Google': L.Control.Geocoder.google( googleAPIKey),
    'Photon': L.Control.Geocoder.photon()
},containerSelectorId:''};

/** Loaded on the ready DOM of the document */
leafletUtil.addGeoCoderPluginWithContainer = function(containerId){
    if (jQuery.isEmptyObject(containerId)) leafletUtil.geoCoderControl.containerSelectorId = "#searchMarkerWithJavascript3";
    else leafletUtil.geoCoderControl.containerSelectorId = containerId;
    try {
        addPluginGeoCoder(); //set the selector
        //Help css for PluginLeafletGeocoder
        //<a class="leaflet-control-geocoder-icon" href="javascript:void(0);">&nbsp;</a>
        jQuery("a").remove(jQuery(".leaflet-control-geocoder-icon"));
        //<div class="leaflet-control-geocoder leaflet-bar leaflet-control leaflet-control-geocoder-expanded">
        jQuery(".leaflet-control-geocoder").appendTo(jQuery(containerId));
        //implement select of the geocoder.
        for (var name in leafletUtil.geoCoderControl.geocoders) {
            btn = L.DomUtil.create('button', 'leaflet-bar', leafletUtil.geoCoderControl.selector);
            btn.innerHTML = name;
            //L.DomUtil.addClass(btn,name);
            (function (n) {
                L.DomEvent.addListener(btn, 'click', function () {
                    //select(leafletUtil.geoCoderControl.geocoders[n], this); //geocoder,el
                    if (leafletUtil.geoCoderControl.selection){
                        try {
                            L.DomUtil.removeClass(leafletUtil.geoCoderControl.selection, 'selected');
                        }catch(e){console.warn("Warning::addGeoCoderPluginWithContainer ->" +e.message);}
                    }

                    leafletUtil.geoCoderControl.geoCoderControl.options.geocoder = leafletUtil.geoCoderControl.geocoders[n];
                    L.DomUtil.addClass(this, 'selected');
                    leafletUtil.geoCoderControl.selection = this;
                    //convert latlng to Address
                    //geocodergoogle.reverse(e.latlng, map.options.crs.scale(map.getZoom()), function(results) {});
                    //Address to coordinates
                    //geoCoderControl.options.geocoder.geocode(address, function(results) {
                    leafletUtil.geoCoderControl.geoCoderControl.markGeocode = function(result) {
                        console.info("add Geocoder marker from event click with geocoder ["+n+"]:"
                            + result.name + "," + result.center.lat + "," + result.center.lng);
                        var bounds = L.Bounds(
                            L.point( result.bbox.getSouthEast(),result.bbox.getNorthEast() ),
                            L.point( result.bbox.getNorthWest(),result.bbox.getSouthWest())
                        );
                        //var popupContent='<div class="popup-content"><table class="table table-striped table-bordered table-condensed">';
                        //var json = JSON.stringify(eval("(" + result + ")"));
                        /*var data = JSON.parse(JSON.stringify(result,undefined,2));
                        for (var key in data) {
                            alert(key+","+data[key]);
                            try {
                                //if(title.constructor == Array || (title !== null && typeof title === 'object'))continue;
                                if(typeof data[key] == 'String') {
                                    var href = '';
                                    if (data[key].toString().indexOf('http') === 0) {
                                        href = '<a target="_blank" href="' + data[key] + '">'
                                            + data[key] + '</a>';
                                    }
                                    if (href.length > 0)popupContent += '<tr><th>' + key + '</th><td>' + href + '</td></tr>';
                                    else popupContent += '<tr><th>' + key + '</th><td>' + data[key] + '</td></tr>';
                                }
                            } catch (e) {
                                console.warn("Exception::addGeoCoderPluginWithContainer() ->"+e.message);
                            }
                        }//for
                        popupContent += "</table></div>";*/
                        var popupContent = leafletUtil.preparePopupTable(result);
                        //var popupContent = ConvertJsonToTable(result,null,"tableIdClass",null);
                        alert("Table:"+popupContent);
                        addSingleMarker(result.name,'',result.center.lat,result.center.lng,bounds,popupContent);
                    };
                    //end of select
                }, btn);
            })(name);
            if (!leafletUtil.geoCoderControl.selection){
                //select(leafletUtil.geoCoderControl.geocoders[name], btn);
                if (leafletUtil.geoCoderControl.selection){
                    L.DomUtil.removeClass(leafletUtil.geoCoderControl.selection, 'selected');
                }
                leafletUtil.geoCoderControl.geoCoderControl.options.geocoder = leafletUtil.geoCoderControl.geocoders[name];
                L.DomUtil.addClass(btn, 'selected');
                leafletUtil.geoCoderControl.selection = btn;
            }
            jQuery('#geocode-selector').append(btn);
        }// end of the for...
    }catch(e){
        console.error("Exception::addGeoCoderPluginWithContainer ->"+ e.message);
    }
};

leafletUtil.preparePopupTable = function(json){
    var popupContent2 = '<div class="popup-content">\n<table class="table table-striped table-bordered table-condensed">\n';
    try {
        //var json = JSON.stringify(eval("(" + result + ")"));
        var data = JSON.parse(JSON.stringify(json, undefined, 2));
        console.warn("RESULT:" + JSON.stringify(data, undefined, 2));
        var popupContent = leafletUtil.preparePopupColumn(data, '','');
        popupContent2 += popupContent;
    }catch(e){
        console.error("Exception::preparePopupTable() ->"+ e.message);
    }
    popupContent2 += "</table>\n</div>\n";
    alert(popupContent2);
    return popupContent2;
};

leafletUtil.preparePopupColumn = function(data,popupContent,nameKey){
   /* for (var i = 0; i < Object.keys(this.options.rootTag).length; i++) {
        json = json[this.options.rootTag[Object.keys(this.options.rootTag)[i]]];
    }*/
    for(var i = 0; i < Object.keys(data).length; i++){
        var json = data[Object.keys(data)[i]];
        alert("KEY:"+Object.keys(data)[i]+",VALUE:"+JSON.stringify(json,undefined,2));
        if(typeof json != 'object' && !Array.isArray(json)){
            popupContent += leafletUtil.preparePopupRow(Object.keys(data)[i], json);
        }else {
            for (var key in json) {
                if (json.hasOwnProperty(key)) {
                    console.warn("Key:" + key + "," + json[key]); //bbbox [object]
                    try {
                        if (json[key] !== null) {
                            if (typeof json[key] == 'object') {
                                nameKey = nameKey + "+" + key;
                                popupContent = leafletUtil.preparePopupColumn(json[key], popupContent, nameKey);
                            } else if (Array.isArray(json[key])) {
                                nameKey = nameKey + "+" + key;
                                popupContent = leafletUtil.preparePopupColumn(json[key], popupContent, nameKey);
                            } else {
                                //nameKey = nameKey + "+" + key;
                                popupContent += leafletUtil.preparePopupRow(nameKey, json[key]);
                            }
                        }
                    } catch (e) {
                        console.warn("Exception::preparePopupColumn() ->" + e.message);
                    }
                }//hasOwnProperty
            }//for
        }//else
    }//for
    return popupContent;
};

leafletUtil.preparePopupRow = function(key,value){
    if (value.toString().indexOf('http') === 0) {
        value = '<a target="_blank" href="' + value + '">'+ value + '</a>';
    }
    console.warn('<tr><th>' + key + '</th><td>' + value + '</td></tr>')
    return '<tr>\n<th>' + key + '</th>\n<td>' + value + '</td>\n</tr>\n';
};



    /**
     * function to get the information on the marker ont he Layer to a Array to pass
     * by create a list of input to pass to a specific form.
     * */
    function getMarkers(){
        var array = [];
        console.info("compile getMarkers");
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
        console.info("...compiled 1 getMarkers");
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
        console.info("...compiled 2 getMarkers");
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
leafletUtil.initMap = function(){
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
               /* map = new L.map('map').setView([43.3555664,  11.0290384], 5);
                L.tileLayer('http://c.tiles.mapbox.com/v3/examples.map-szwdot65/{z}/{x}/{y}.png', { // NON MALE
                    attribution: 'Map data &copy; 2011 OpenStreetMap contributors, Imagery &copy; 2012 CloudMade',
                    key: 'BC9A493B41014CAABB98F0471D759707',
                    subdomains: ['otile1', 'otile2', 'otile3', 'otile4'],
                    //minZoom: 8,
                    maxZoom: 18
                }).addTo(map);*/

                // CREAZIONE MAPPA CENTRATA NEL PUNTO
                //commentato marco
                //var map = L.map('map').setView([43.3555664, 11.0290384], 8);

                // SCELTA DEL TILE LAYER ED IMPOSTAZIONE DEI PARAMETRI DI DEFAULT
                /*commentato marco
                 L.tileLayer('http://c.tiles.mapbox.com/v3/examples.map-szwdot65/{z}/{x}/{y}.png', { // NON MALE
                 //L.tileLayer('http://{s}.tile.cloudmade.com/{key}/22677/256/{z}/{x}/{y}.png', {
                 //L.tileLayer('http://a.www.toolserver.org/tiles/bw-mapnik/{z}/{x}/{y}.png', {
                 //L.tileLayer('http://a.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                 //L.tileLayer('http://tilesworld1.waze.com/tiles/{z}/{x}/{y}.png', {
                 //		L.tileLayer('http://maps.yimg.com/hx/tl?v=4.4&x={x}&y={y}&z={z}', {
                 //L.tileLayer('http://a.tiles.mapbox.com/v3/examples.map-bestlap85.h67h4hc2/{z}/{x}/{y}.png', { MAPBOX MA NON FUNZIA
                 //L.tileLayer('http://{s}.tile.cloudmade.com/1a1b06b230af4efdbb989ea99e9841af/998/256/{z}/{x}/{y}.png', {
                 //	L.tileLayer('http://{s}.tile.cloudmade.com/1a1b06b230af4efdbb989ea99e9841af/121900/256/{z}/{x}/{y}.png', {
                 attribution: 'Map data &copy; 2011 OpenStreetMap contributors, Imagery &copy; 2012 CloudMade',
                 key: 'BC9A493B41014CAABB98F0471D759707',
                 minZoom: 8
                 }).addTo(map);

                 *fine commento marco
                 */

                //codice per gestione layers
                //var osm = L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'});
                //http://otile1.mqcdn.com/tiles/1.0.0/sat/{z}/{x}/{y}.jpg
                //http://a.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png
                //http://a.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png
                //http://a.tile.thunderforest.com/outdoors/{z}/{x}/{y}.png
                //http://a.tile.stamen.com/toner/{z}/{x}/{y}.png
                //http://a.tile.thunderforest.com/landscape/{z}/{x}/{y}.png
                //var osm = L.tileLayer('http://a.tile.thunderforest.com/landscape/{z}/{x}/{y}.png', {attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'});

                var mbAttr = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
                        '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
                        'Imagery © <a href="http://mapbox.com">Mapbox</a>',
                    mbUrl = 'https://{s}.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg';
                var streets = L.tileLayer(mbUrl, {id: 'mapbox.streets', attribution: mbAttr}),
                    satellite = L.tileLayer(mbUrl, {id: 'mapbox.streets-satellite', attribution: mbAttr}),
                    grayscale = L.tileLayer(mbUrl, {id: 'pbellini.f33fdbb7', attribution: mbAttr});
                var map = L.map('map', {
                    center: [43.3555664, 11.0290384],
                    zoom: 8,
                    layers: [satellite]
                });
                var baseMaps = {
                    "Streets": streets,
                    "Satellite": satellite,
                    "Grayscale": grayscale
                };
                var toggleMap = L.control.layers(baseMaps, null, {position: 'bottomright', width: '50px', height: '50px'});
                toggleMap.addTo(map);
                if (getUrlParameter("map") == "streets") {
                    map.removeLayer(satellite);
                    map.addLayer(streets);
                }
                else if (getUrlParameter("map") == "grayscale") {
                    map.removeLayer(satellite);
                    map.addLayer(grayscale);
                }

                // DEFINIZIONE DEI CONFINI MASSIMI DELLA MAPPA
                //Set a bound window for the leaflet map for Toscany region
                var bounds = new L.LatLngBounds(new L.LatLng(41.7, 8.4), new L.LatLng(44.930222, 13.4));
                //var bounds = new L.LatLngBounds(new L.LatLng(setBounds[0],setBounds[1]), new L.LatLng(setBounds[2], setBounds[3]));
                map.setMaxBounds(bounds);

                //map.attributionControl.setPrefix(''); // Don't show the 'Powered by Leaflet' text.
                //..add many functionality
                //addPluginGPSControl();
                //addPluginCoordinatesControl();
                //addPluginLayersStamenBaseMaps();
                //addPluginLocateControl();
                //addPluginSearch(); //not necessary
                //addPluginGeoSearch();
                //addPluginGeoCoder();

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
            alert("Exception::addSingleMarker() -> "+e.message +" ,Sorry the program can't create the Marker");
        }
        console.info("...Compiled addSingleMarker()");
    }

    /*** function for remove all cluster marker on the leaflet map */
leafletUtil.removeClusterMarker = function(){
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
};

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
                console.log("... add multiple marker (" + j + "):"
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

        leafletUtil.geoDocument.name = nameVar;
        leafletUtil.geoDocument.url = urlVar;
        leafletUtil.geoDocument.lat = latVar;
        leafletUtil.geoDocument.lng = lngVar;
        leafletUtil.geoDocument.region = regionVar;
        leafletUtil.geoDocument.province=provinceVar;
        leafletUtil.geoDocument.city=cityVar;
        leafletUtil.geoDocument.address=addressVar;
        leafletUtil.geoDocument.phone=phoneVar;
        leafletUtil.geoDocument.email=emailVar;
        leafletUtil.geoDocument.fax=faxVar;
        leafletUtil.geoDocument.iva=ivaVar;

        leafletUtil.arrayGeoDocuments.push(leafletUtil.geoDocument);
        for (var j = 0 ; j < leafletUtil.arrayGeoDocuments.length; j++){
            console.info("(" + j + ") titles:"+Object.keys(leafletUtil.geoDocument).toString()+",Length:"+leafletUtil.arrayGeoDocuments.length);
            var titles = Object.keys(leafletUtil.geoDocument).toString().split(",");
            console.info("... prepare marker (" + j + "):"
                + leafletUtil.arrayGeoDocuments[j].name + ',' + leafletUtil.arrayGeoDocuments[j].url +
                ',' + leafletUtil.arrayGeoDocuments[j].lat + ',' + leafletUtil.arrayGeoDocuments[j].lng);
            var  content = '<div class="popup-content"><table class="table table-striped table-bordered table-condensed">';
            for (var title, i = 0; title = titles[i++];) {
                try {
                    //if(title.constructor == Array || (title !== null && typeof title === 'object'))continue;
                    if(typeof title !== 'String' || title == 'popupContent') continue;
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
            addSingleMarker( leafletUtil.arrayGeoDocuments[j].name,  leafletUtil.arrayGeoDocuments[j].url,
                leafletUtil.arrayGeoDocuments[j].lat,  leafletUtil.arrayGeoDocuments[j].lng,'',
                leafletUtil.arrayGeoDocuments[j].popupContent);
        }
        console.info("....pushed a marker to the array on javascript side:"+ leafletUtil.geoDocument.toString());
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

    /**
     * Add the Leaflet leaflet-control-geocoder.
     * https://github.com/perliedman/leaflet-control-geocoder
     * https://github.com/patrickarlt/leaflet-control-geocoder
     */
    function addPluginGeoCoder() {
        console.info("Compile addPluginGeoCoder...");
        try {
            if (jQuery.isEmptyObject(leafletUtil.geoCoderControl.geoCoderControl)) {
                leafletUtil.geoCoderControl.selector = L.DomUtil.get('geocode-selector');
                leafletUtil.geoCoderControl.geoCoderControl = new L.Control.Geocoder({ geocoder: null },{collapsed: false});
                leafletUtil.geoCoderControl.geoCoderControl.addTo(map);
            } else {
                map.addControl(leafletUtil.geoCoderControl.geoCoderControl);
            }
            /*leafletUtil.geoCoderControl.geoCoderControl.markGeocode = function(result) {
                alert("add Geocoder marker:" + result.name + "," + result.center.lat + "," + result.center.lng +
                    "," + result.bbox.toString()+","+result.html);
                var bounds = L.Bounds(
                    L.point( result.bbox.getSouthEast(),result.bbox.getNorthEast() ),
                    L.point( result.bbox.getNorthWest(),result.bbox.getSouthWest())
                );
                addSingleMarker(result.name,result.name,result.center.lat,result.center.lng,bounds,'');
            };*/
            console.info("...compiled addPluginGeoCoder");
        }catch(e){
            console.error("Exception:addPluginGeoCoder->"+e.message);
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

        L.Control.fileLayerLoad({layerOptions: geoJsonOptions, }).addTo(map);
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


/**
 * JavaScript format string function
 *
 */
String.prototype.format = function()
{
    var args = arguments;

    return this.replace(/{(\d+)}/g, function(match, number)
    {
        return typeof args[number] != 'undefined' ? args[number] :
        '{' + number + '}';
    });
};


/**
 * Convert a Javascript Oject array or String array to an HTML table
 * JSON parsing has to be made before function call
 * It allows use of other JSON parsing methods like jQuery.parseJSON
 * http(s)://, ftp://, file:// and javascript:; links are automatically computed
 *
 * JSON data samples that should be parsed and then can be converted to an HTML table
 *     var objectArray = '[{"Total":"34","Version":"1.0.4","Office":"New York"},{"Total":"67","Version":"1.1.0","Office":"Paris"}]';
 *     var stringArray = '["New York","Berlin","Paris","Marrakech","Moscow"]';
 *     var nestedTable = '[{ key1: "val1", key2: "val2", key3: { tableId: "tblIdNested1", tableClassName: "clsNested", linkText: "Download", data: [{ subkey1: "subval1", subkey2: "subval2", subkey3: "subval3" }] } }]';
 *
 * Code sample to create a HTML table Javascript String
 *     var jsonHtmlTable = ConvertJsonToTable(eval(dataString), 'jsonTable', null, 'Download');
 *
 * Code sample explaned
 *  - eval is used to parse a JSON dataString
 *  - table HTML id attribute will be 'jsonTable'
 *  - table HTML class attribute will not be added
 *  - 'Download' text will be displayed instead of the link itself
 *
 * @author Afshin Mehrabani <afshin dot meh at gmail dot com>
 *
 * @class ConvertJsonToTable
 *
 * @method ConvertJsonToTable
 *
 * @param parsedJson object Parsed JSON data
 * @param tableId string Optional table id
 * @param tableClassName string Optional table css class name
 * @param linkText string Optional text replacement for link pattern
 *
 * @return string Converted JSON to HTML table
 */
function ConvertJsonToTable(parsedJson, tableId, tableClassName, linkText)
{
    //Patterns for links and NULL value
    var italic = '<i>{0}</i>';
    var link = linkText ? '<a href="{0}">' + linkText + '</a>' :
        '<a href="{0}">{0}</a>';

    //Pattern for table
    var idMarkup = tableId ? ' id="' + tableId + '"' :
        '';

    var classMarkup = tableClassName ? ' class="' + tableClassName + '"' :
        '';

    var tbl = '<table border="1" cellpadding="1" cellspacing="1"' + idMarkup + classMarkup + '>{0}{1}</table>';

    //Patterns for table content
    var th = '<thead>{0}</thead>';
    var tb = '<tbody>{0}</tbody>';
    var tr = '<tr>{0}</tr>';
    var thRow = '<th>{0}</th>';
    var tdRow = '<td>{0}</td>';
    var thCon = '';
    var tbCon = '';
    var trCon = '';

    if (parsedJson)
    {
        var isStringArray = typeof(parsedJson[0]) == 'string';
        var headers;

        // Create table headers from JSON data
        // If JSON data is a simple string array we create a single table header
        if(isStringArray)
            thCon += thRow.format('value');
        else
        {
            // If JSON data is an object array, headers are automatically computed
            if(typeof(parsedJson[0]) == 'object')
            {
                headers = array_keys(parsedJson[0]);

                for (i = 0; i < headers.length; i++)
                    thCon += thRow.format(headers[i]);
            }
        }
        th = th.format(tr.format(thCon));

        // Create table rows from Json data
        if(isStringArray)
        {
            for (i = 0; i < parsedJson.length; i++)
            {
                tbCon += tdRow.format(parsedJson[i]);
                trCon += tr.format(tbCon);
                tbCon = '';
            }
        }
        else
        {
            if(headers)
            {
                var urlRegExp = new RegExp(/(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig);
                var javascriptRegExp = new RegExp(/(^javascript:[\s\S]*;$)/ig);

                for (i = 0; i < parsedJson.length; i++)
                {
                    for (j = 0; j < headers.length; j++)
                    {
                        var value = parsedJson[i][headers[j]];
                        var isUrl = urlRegExp.test(value) || javascriptRegExp.test(value);

                        if(isUrl)   // If value is URL we auto-create a link
                            tbCon += tdRow.format(link.format(value));
                        else
                        {
                            if(value){
                                if(typeof(value) == 'object'){
                                    //for supporting nested tables
                                    tbCon += tdRow.format(ConvertJsonToTable(eval(value.data), value.tableId, value.tableClassName, value.linkText));
                                } else {
                                    tbCon += tdRow.format(value);
                                }

                            } else {    // If value == null we format it like PhpMyAdmin NULL values
                                tbCon += tdRow.format(italic.format(value).toUpperCase());
                            }
                        }
                    }
                    trCon += tr.format(tbCon);
                    tbCon = '';
                }
            }
        }
        tb = tb.format(trCon);
        tbl = tbl.format(th, tb);

        return tbl;
    }
    return null;
}


/**
 * Return just the keys from the input array, optionally only for the specified search_value
 * version: 1109.2015
 *  discuss at: http://phpjs.org/functions/array_keys
 *  +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
 *  +      input by: Brett Zamir (http://brett-zamir.me)
 *  +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
 *  +   improved by: jd
 *  +   improved by: Brett Zamir (http://brett-zamir.me)
 *  +   input by: P
 *  +   bugfixed by: Brett Zamir (http://brett-zamir.me)
 *  *     example 1: array_keys( {firstname: 'Kevin', surname: 'van Zonneveld'} );
 *  *     returns 1: {0: 'firstname', 1: 'surname'}
 */
function array_keys(input, search_value, argStrict)
{
    var search = typeof search_value !== 'undefined', tmp_arr = [], strict = !!argStrict, include = true, key = '';

    if (input && typeof input === 'object' && input.change_key_case) { // Duck-type check for our own array()-created PHPJS_Array
        return input.keys(search_value, argStrict);
    }

    for (key in input)
    {
        if (input.hasOwnProperty(key))
        {
            include = true;
            if (search)
            {
                if (strict && input[key] !== search_value)
                    include = false;
                else if (input[key] != search_value)
                    include = false;
            }
            if (include)
                tmp_arr[tmp_arr.length] = key;
        }
    }
    return tmp_arr;
}


function CreateTableView(objArray, theme, enableHeader) {
    // set optional theme parameter
    if (theme === undefined) {
        theme = 'mediumTable'; //default theme
    }

    if (enableHeader === undefined) {
        enableHeader = true; //default enable headers
    }

    // If the returned data is an object do nothing, else try to parse
    var array = typeof objArray != 'object' ? JSON.parse(objArray) : objArray;

    var str = '<table class="' + theme + '">';

    // table head
    if (enableHeader) {
        str += '<thead><tr>';
        for (var index in array[0]) {
            str += '<th scope="col">' + index + '</th>';
        }
        str += '</tr></thead>';
    }

    // table body
    str += '<tbody>';
    for (var i = 0; i < array.length; i++) {
        str += (i % 2 == 0) ? '<tr class="alt">' : '<tr>';
        for (var index in array[i]) {
            str += '<td>' + array[i][index] + '</td>';
        }
        str += '</tr>';
    }
    str += '</tbody>'
    str += '</table>';
    return str;
}

function CreateDetailView(objArray, theme, enableHeader) {
    // set optional theme parameter
    if (theme === undefined) {
        theme = 'mediumTable';  //default theme
    }

    if (enableHeader === undefined) {
        enableHeader = true; //default enable headers
    }

    var array = JSON.parse(objArray);

    var str = '<table class="' + theme + '">';
    str += '<tbody>';


    for (var i = 0; i < array.length; i++) {
        var row = 0;
        for (var index in array[i]) {
            str += (row % 2 == 0) ? '<tr class="alt">' : '<tr>';

            if (enableHeader) {
                str += '<th scope="row">' + index + '</th>';
            }

            str += '<td>' + array[i][index] + '</td>';
            str += '</tr>';
            row++;
        }
    }
    str += '</tbody>'
    str += '</table>';
    return str;
}












