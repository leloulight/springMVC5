
var leafletUtil = {};

/***  Set constructor variable for leaflet_buildMap_support */
var leaflet_buildMap_support_2 = {
    // Get a list of marker with coordinates and a url href and put the marker on the map
    initLeaflet: leafletUtil.initLeaflet,
    initMap: function () {
        leafletUtil.initMap();
    },
    addSingleMarker: function (name, url, lat, lng,bound,popupContent) {addSingleMarker(name,url,lat,lng,bounds,popupContent);},
    pushMarkerToArrayMarker:
        function(nameVar,urlVar,latVar,lngVar,regionVar,provinceVar,
                 cityVar,addressVar,phoneVar,emailVar,faxVar,ivaVar,popupContentVar){
        leafletUtil.initMap(); //check fast if the map is setted
        pushMarkerToArrayMarker(
            nameVar,urlVar,latVar,lngVar,regionVar,provinceVar,cityVar,
            addressVar,phoneVar,emailVar,faxVar,ivaVar,popupContentVar);
    },
    chooseIcon: function(code){ chooseIcon(code);},
    removeClusterMarker:leafletUtil.removeClusterMarker,
    getMarkers: leafletUtil.getMarkers
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
        leafletUtil.getMarkers();
    });

    //Search address with google...
    //jQuery("div.leaflet-control-geosearch").appendTo(jQuery("#search-address-with-google"));
    //<div class="leaflet-control-search leaflet-control search-exp">
    jQuery("#searchMarkerWithJavascript").appendTo(jQuery("#searchMarkerWithJavascript2"));
    leafletUtil.addGeoCoderPluginWithContainer('#searchMarkerWithJavascript3');


    console.info("Loaded all JQUERY variable");

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
            if(leafletUtil.geoCoderControl.geocoders.hasOwnProperty(name)) {
                btn = L.DomUtil.create('button', 'leaflet-bar', leafletUtil.geoCoderControl.selector);
                btn.innerHTML = name;
                //L.DomUtil.addClass(btn,name);
                (function (n) {
                    L.DomEvent.addListener(btn, 'click', function () {
                        //select(leafletUtil.geoCoderControl.geocoders[n], this); //geocoder,el
                        if (leafletUtil.geoCoderControl.selection) {
                            try {
                                L.DomUtil.removeClass(leafletUtil.geoCoderControl.selection, 'selected');
                            } catch (e) {
                                console.warn("Warning::addGeoCoderPluginWithContainer ->" + e.message);
                            }
                        }
                        leafletUtil.geoCoderControl.geoCoderControl.options.geocoder = leafletUtil.geoCoderControl.geocoders[n];
                        L.DomUtil.addClass(this, 'selected');
                        leafletUtil.geoCoderControl.selection = this;
                        //convert latlng to Address
                        //geocodergoogle.reverse(e.latlng, map.options.crs.scale(map.getZoom()), function(results) {});
                        //Address to coordinates
                        //geoCoderControl.options.geocoder.geocode(address, function(results) {
                        leafletUtil.geoCoderControl.geoCoderControl.markGeocode = function (result) {
                            console.info("add Geocoder marker from event click with geocoder [" + n + "]:"
                                + result.name + "," + result.center.lat + "," + result.center.lng);
                            var bounds = L.Bounds(
                                L.point(result.bbox.getSouthEast(), result.bbox.getNorthEast()),
                                L.point(result.bbox.getNorthWest(), result.bbox.getSouthWest())
                            );
                            var popupContent = leafletUtil.preparePopupTable(result);
                            var name = result.name.replaceAll(',',' ');
                            addSingleMarker(name, '', result.center.lat, result.center.lng, bounds, popupContent);
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
            }//hasOwnProperty
            jQuery('#geocode-selector').append(btn);
        }// end of the for...
    }catch(e){
        console.error("Exception::addGeoCoderPluginWithContainer ->"+ e.message);
    }
};

leafletUtil.preparePopupTable = function(json){
    var popupContent2 = '<div class="popup-content">\n<table class="table table-striped table-bordered table-condensed">\n';
    try {
        var data = JSON.parse(JSON.stringify(json, 2));
        console.warn("RESULT:" + JSON.stringify(data, 2));
        popupContent2 += leafletUtil.preparePopupColumn(data, '','');
    }catch(e){
        console.error("Exception::preparePopupTable() ->"+ e.message);
    }
    popupContent2 += "</table>\n</div>\n";
    return popupContent2;
};

leafletUtil.preparePopupColumn = function(data,popupContent,nameKey){
    for(var i = 0; i < Object.keys(data).length; i++){
        var json = data[Object.keys(data)[i]];
        if(typeof json != 'object' && !Array.isArray(json)){
            //console.warn("Key 1:" + nameKey + "+" + Object.keys(data)[i] + "," + JSON.stringify(json,undefined,2));
            popupContent +=
                leafletUtil.preparePopupRow(
                    nameKey + "+" + Object.keys(data)[i], JSON.stringify(json,2));
        }else {
            for (var key in json) {
                if (json.hasOwnProperty(key)) {
                    try {
                        if (json[key] !== null) {
                            if (typeof json[key] == 'object') {
                                //console.warn("Key 3:" +nameKey + "+" + Object.keys(data)[i] + "+" + key + "," + JSON.stringify(json[key],undefined,2));
                                popupContent =
                                    leafletUtil.preparePopupColumn(
                                        json[key], popupContent, nameKey + "+" + Object.keys(data)[i] + "+" + key);
                            } else if (Array.isArray(json[key])) {
                                //console.warn("Key 4:" + nameKey + "+" + Object.keys(data)[i] + "+" + key + "," + JSON.stringify(json[key],undefined,2));
                                popupContent =
                                    leafletUtil.preparePopupColumn(
                                        json[key], popupContent, nameKey + "+" + Object.keys(data)[i] + "+" + key);
                            } else {
                                //console.warn("Key 5:" + nameKey + "+" + Object.keys(data)[i] + "+" + key  + "," + JSON.stringify(json[key],undefined,2));
                                popupContent +=
                                    leafletUtil.preparePopupRow(
                                        nameKey + "+" + Object.keys(data)[i] + "+" + key, json[key]);
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
    key = key.indexOf('+') == 0 ? key.substring(1) : key;
    value = value.replaceAll(',',' '); //need for clean the result send to the SpringFramework project
    if (value.toString().indexOf('http') === 0) {
        value = '<a target="_blank" href="' + value + '">'+ value + '</a>';
    }
    //console.warn('<tr><th>' + key + '</th><td>' + value + '</td></tr>\n')
    return '<tr><th>' + key + '</th><td>' + value + '</td></tr>';
};

/**
 * function to get the information on the marker ont he Layer to a Array to pass
 * by create a list of input to pass to a specific form.
 */
/*leafletUtil.getMarkers = function(){

};*/

function getMarkers(containerId){
    var array = [];
    console.log("compile getMarkers");
    try{
        if(!$.isEmptyObject(markerClusters)) {
            console.log("Marker cluster is not empty go to check the Marker.");
            markerClusters.eachLayer(function (layer) {
                try {
                    var lat = layer.getLatLng().lat;
                    var lng = layer.getLatLng().lng;
                    var label;
                    //label = layer.getLabel()._content;
                    if(lat!=0 && lng !=0) {
                        label = layer.label._content; //get name with Leaflet.Label
                        /*var location = layer.getLocation();*/
                        var popupContent = layer.getPopup().getContent();
                        console.info("marker number():" + lat + "," + lng + "," + label);
                        array.push({name: label, lat: lat, lng: lng, description: popupContent});
                    }
                    //i++;
                }catch(e){
                    console.error("Exception:getMarkers -> "+e.message);
                }
            });
        }
    }catch(e){console.error("Exception:getMarkers -> "+e.message);}
    console.info("...compiled getMarkers");
    //var array = getMarkers();
    for (var i = 0; i < array.length; i++) {
        try {
            console.info("marker number("+i+"):" + array[i].lat + "," + array[i].lng + "," + array[i].name);
            addInput('nameForm' + i, array[i].name, i,containerId);
            addInput('latForm' + i, array[i].lat, i,containerId);
            addInput('lngForm' + i, array[i].lng, i,containerId);
            addInput('descriptionForm' + i, array[i].description, i,containerId);
        }catch(e){console.error(e.message);}
    }
    leafletUtil.removeClusterMarker();
}

function addInput(input_id,val,index,containerId) {
    var input = document.createElement('input');
    input.setAttribute('id', input_id);
    input.setAttribute('type', 'hidden');
    input.setAttribute('value', val);
    input.setAttribute('name', input_id.replace(index,'').replace('Form','Param1'));
    //document.body.appendChild(input);
    document.getElementById(containerId).appendChild(input);
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
            var mbAttr = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
                    '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
                    'Imagery © <a href="http://mapbox.com">Mapbox</a>',
                mbUrl = 'https://{s}.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg';
            var streets = L.tileLayer(mbUrl, {id: 'mapbox.streets', attribution: mbAttr}),
                satellite = L.tileLayer(mbUrl, {id: 'mapbox.streets-satellite', attribution: mbAttr}),
                grayscale = L.tileLayer(mbUrl, {id: 'pbellini.f33fdbb7', attribution: mbAttr});
            map = L.map('map', {
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
};


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
        if(jQuery.isEmptyObject(map)) {leafletUtil.initMap();}
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
            if(!$.isEmptyObject(url) && url.toString().indexOf('http') === 0) text = '<a class="linkToMarkerInfo" href="' + url + '" target="_blank">' + name + '</a>';
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
                    console.error("addSingleMarker"+e.message+ " Sorry the program can't find Geographical coordinates for this Web address,check if the Web address is valid");
                }
            }
            //...set the popup on mouse over
            //var latlngOver = L.latLng(latVar, lngVar);
            //...set the popup on mouse click
            //var popupClick = new L.popup().setContent(text);
            var popupOver = new L.popup({maxWidth:100,minWidth:50,maxHeight:200}).setContent(popupContent);
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
            console.error("Exception::addSingleMarker() -> "+e.message +" ,Sorry the program can't create the Marker");
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
    //points.clearLayers();
    console.log("...compiled removeClusterMarker");
};
/*** function for choose a specific type of icon for a specific type of layer */
leafletUtil.chooseIcon = function(category){
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
};

    /**
     * function to add for every single object marker a Leaflet Marker on the Leaflet Map.
     */
    function addMultipleMarker(markers){
        console.log("add multiple marker "+markers.length+"...");
        try {
            //var titles = Object.keys(markers[0]).split(",");
            for (var j = 0; j < markers.length; j++){
                try {
                    console.log("... add multiple marker (" + j + "):"
                        + markers[j].name + ',' + markers[j].url + ',' + markers[j].lat + ',' + markers[j].lng);
                    addSingleMarker(markers[j].name, markers[j].url, markers[j].lat, markers[j].lng, null,
                        markers[j].popupContent);
                }catch(e){
                    console.warn(e.message);
                }
            }
            console.log("... added multiple marker");
        }catch(e){
            console.error(e.message);
        }
    }

    /**
     * function to add every single company from java object in JSP page to a javascript array
     */
    var specialj =0;
    function pushMarkerToArrayMarker(nameVar,urlVar,latVar,lngVar,regionVar,provinceVar,cityVar,addressVar,
                                     phoneVar,emailVar,faxVar,ivaVar,popupContentVar){
        try {
            /*nameVar = document.getElementById('nameForm').value;*/
          /*  console.log("pushing the element =>" +
                "Name:" + nameVar + ',URL:' + urlVar + ',LAT:' + latVar + ',LNG:' + lngVar + "\n" +
                "Regione:" + regionVar + ', Province:' + provinceVar + ',City:' + cityVar + ', Address:' + addressVar + "\n" +
                "Phone:" + phoneVar + ', Email:' + emailVar + ', Fax:' + faxVar + ', Iva:' + ivaVar + "\n"
            );*/
            leafletUtil.geoDocument = {};
            leafletUtil.geoDocument.name = nameVar;
            leafletUtil.geoDocument.url = urlVar;
            leafletUtil.geoDocument.lat = latVar;
            leafletUtil.geoDocument.lng = lngVar;
            leafletUtil.geoDocument.region = regionVar;
            leafletUtil.geoDocument.province = provinceVar;
            leafletUtil.geoDocument.city = cityVar;
            leafletUtil.geoDocument.address = addressVar;
            leafletUtil.geoDocument.phone = phoneVar;
            leafletUtil.geoDocument.email = emailVar;
            leafletUtil.geoDocument.fax = faxVar;
            leafletUtil.geoDocument.iva = ivaVar;
            leafletUtil.geoDocument.popupContent = popupContentVar;

            var titles = Object.keys(leafletUtil.geoDocument).toString().split(",");
            if(leafletUtil.geoDocument.popupContent ==null || leafletUtil.geoDocument.popupContent ==''){
                var content = '<div class="popup-content"><table class="table table-striped table-bordered table-condensed">';
                for (var title, i = 0; title = titles[i++];) {
                    try {
                        if (Array.isArray(leafletUtil.geoDocument[title])
                            || (
                            leafletUtil.geoDocument[title] !== null  && typeof leafletUtil.geoDocument[title] === 'object')
                        )continue;
                        //if (typeof leafletUtil.geoDocument[title] !== 'String' || leafletUtil.geoDocument[title] == 'popupContent') continue;
                        if (leafletUtil.geoDocument[title].toString().indexOf('http') === 0) {
                            leafletUtil.geoDocument[title] = '<a target="_blank" href="' + leafletUtil.geoDocument[title] + '">'
                                + leafletUtil.geoDocument[title] + '</a>';
                        }
                        content += '<tr><th>' + title + '</th><td>' + leafletUtil.geoDocument[title] + '</td></tr>';
                    } catch (e) {
                        console.warn("Exception::pushMarkerToArrayMarker ->" + e.message);
                    }
                }//for
                content += "</table></div>";
                leafletUtil.geoDocument.popupContent = content;
            }
            console.info("... prepare marker (" + specialj + "):"
                + leafletUtil.geoDocument.name + ',' + leafletUtil.geoDocument.url +
                ',' + leafletUtil.geoDocument.lat + ',' + leafletUtil.geoDocument.lng + "," + leafletUtil.geoDocument.popupContent);

            leafletUtil.arrayGeoDocuments.push(leafletUtil.geoDocument);
            specialj++;
            console.log("....pushed a marker to the array on javascript side:" + leafletUtil.geoDocument.toString());
        }catch(e){
            console.error("Exception::pushMarkerToArrayMarker ->" +  e.message);
        }
    }

    /**
     * Add the Leaflet Plugin Search.
     * https://github.com/p4535992/leaflet-search.
     */
    function addPluginSearch(){
        if(jQuery.isEmptyObject(map)) {leafletUtil.initMap();}
        try{
            geocoderSearchGoogle = new google.maps.Geocoder();
        }catch(e){
            console.warn("Warning:addPluginSearch->"+e.message);
            geocoderSearchGoogle = null;
        }
        console.log("compile addPluginSearch...");
        try {
            if (!jQuery.isEmptyObject(markerClusters)) {
                /* controlSearch = new L.Control.Search({layer: markerClusters, initial: false,collapsed: false});*/
                if (jQuery.isEmptyObject(geocoderSearchGoogle)) {
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
            console.log("...compiled addPluginSearch");
        }catch(e){
            console.error("Exception:addPluginSearch->"+e.message);
        }
    }

    /**
     * Add the Leaflet leaflet-control-geocoder.
     * https://github.com/perliedman/leaflet-control-geocoder
     * https://github.com/patrickarlt/leaflet-control-geocoder
     */
    function addPluginGeoCoder() {
        if(jQuery.isEmptyObject(map)) {leafletUtil.initMap();}
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

/** http://www.javascript-coder.com/javascript-form/javascript-form-value.phtml */
leafletUtil.loadarrayOnInput = function(idForm,nameElementOrIndex){
    //var oFormObject = document.forms[idForm];
    //var oformElement = oFormObject.elements[nameElementOrIndex];
    alert(67);
    var arrayOfMarker = [];
    for(var j = 0; j < leafletUtil.arrayGeoDocuments.length; j++){
        var marker = {
            name:leafletUtil.arrayGeoDocuments.length[j].name,
            url: leafletUtil.geoDocument.url ,
            latitude: leafletUtil.geoDocument.lat,
            longitude: leafletUtil.geoDocument.lng ,
            popupContent: leafletUtil.geoDocument.popupContent
        };
        arrayOfMarker.push(marker);
    }
    alert(68);
    alert("LOAD JSON:"+JSON.parse(JSON.stringify(arrayOfMarker,undefined,2)));
    /*
     When sending a single object (not list) that Spring controller will accept as a Java object,
     the JSON format has to be only pair of curly braces with properties inside , avoid using JSON.stringify()
     which actually adds one more property with object name and Jackson can't match. Following is the Javascript
     code snippet to pass an object from Javascript to Spring controller:
     */
    document.forms[idForm].elements[nameElementOrIndex].value = JSON.stringify(arrayOfMarker,undefined,2);
    jQuery.ajax({
        type: "POST",
        url: "markers",
        data: arrayOfMarker,
        dataType: "html",
        contentType: "application/json",
        mimeType: "application/json",
        success: function(response){
            console.info("SUCCESS: " + response);
        },
        error: function (e) {
            console.info("Error " + e.message);
        }
    });
    //document.forms[idForm].elements[nameElementOrIndex].value = arrayOfMarker;
    //return arrayOfMarker;
};


    function addPluginFileLayer(){
        if(jQuery.isEmptyObject(map)) {leafletUtil.initMap();}
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

        L.Control.fileLayerLoad({layerOptions: geoJsonOption, }).addTo(map);
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



//UTILITY

/**
 * JavaScript format string functio
 */
String.prototype.format = function(){
    var args = arguments;
    return this.replace(/{(\d+)}/g, function(match, number){
        return typeof args[number] != 'undefined' ? args[number] :
        '{' + number + '}';
    });
};

String.prototype.replaceAll = function(toSearch,toreplace){
    return this.split(toSearch).join(toreplace);
};

















