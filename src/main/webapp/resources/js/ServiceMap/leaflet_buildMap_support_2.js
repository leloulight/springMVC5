
var leafletUtil = {};

var categories = {
    101 : {desc: "Musées & Châteaux", icon:"museum_archeological.png"},
    103 : {desc: "Médiathèque", icon:"library.png"},
    104 : {desc: "Monument", icon:"mural.png"},
    105 : {desc: "Ecole Culturelle", icon:"music_choral.png"},
    106 : {desc: "Salle d'exposition", icon:"museum_art.png"},
    107 : {desc: "Salle de spectacle", icon:"theater.png"},
    108 : {desc: "Cinéma", icon:"cinema.png"}
};


/***  Set constructor variable for leaflet_buildMap_support */
var leaflet_buildMap_support_2 = {
    // Get a list of marker with coordinates and a url href and put the marker on the map
    initLeaflet: leafletUtil.initLeaflet,
    initMap: function () {
        leafletUtil.initMap();
    },
    addSingleMarker: function (name, url, lat, lng,bound,popupContent) {
        leafletUtil.addSingleMarker(name,url,lat,lng,bounds,popupContent);},
    pushMarkerToArrayMarker:
        function(nameVar,urlVar,latVar,lngVar,regionVar,provinceVar,
                 cityVar,addressVar,phoneVar,emailVar,faxVar,ivaVar,popupContentVar){
            leafletUtil.initMap(); //check fast if the map is setted
            leafletUtil.pushMarkerToArrayMarker(
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
var geoCoderGoogle;




//Variabili suppport java SPRING
leafletUtil.geoDocument = {name:'',url:'',lat:'',lng:'',region:'',province:'',city:'',
    address:'',phone:'',email:'',fax:'',iva:'',popupContent:'',other:'',marker:{}};

leafletUtil.arrayGeoDocuments =[]; // array support of makers
leafletUtil.markerList = [];
leafletUtil.marker = {name:'',url:'',latitude:'',longitude:'',popupContent:'',category:''};
/*** Set a personal icon marker */
leafletUtil.deathIcon = L.icon({
        iconUrl: '../leaflet/images/marker-shadow.png',
        //iconRetinaUrl: myURL + 'img/me.png',
        iconSize: [36, 36], iconAnchor: [18, 18],popupAnchor: [0, -18],labelAnchor: [14, 0]
    });

leafletUtil.layers = {};
leafletUtil.cultureLayer = L.layerGroup();
leafletUtil.layerCtrl = L.control.layers();

/*** Set the src of the javascript file*/
//var mySRC = jQuery('script[src$="resources/js_utility/leaflet_buildMap_support.js"]').attr('src').replace('js_utility/leaflet_buildMap_support.js', '');



//leafletUtil.initLeaflet = function() {
    /*** On ready document  */
    jQuery( document ).ready(function() {

    /** if you have add a new marker from spring put in the map. */
    if ((!jQuery.isEmptyObject(leafletUtil.arrayGeoDocuments)) && leafletUtil.arrayGeoDocuments.length > 0) {
        leafletUtil.addMultipleMarker(leafletUtil.arrayGeoDocuments);
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
    leafletUtil.addPluginFuseSearch('name',null,null);

    console.info("Loaded all JQUERY variable");

   });
//};

//Set the Object foe manaage the research by Google,Bing,ecc.
var btn;
// Added Controls
leafletUtil.geoCoderControl ={selection:{},geoCoderControl:{},selector:{},
                            geocoders:{
                                'Nominatim': L.Control.Geocoder.nominatim(),
                                'Bing': L.Control.Geocoder.bing( bingAPIKey),
                                'Mapbox': L.Control.Geocoder.mapbox( mapBoxAPIKey),
                                'Google': L.Control.Geocoder.google( googleAPIKey),
                                'Photon': L.Control.Geocoder.photon()
                            },containerSelectorId:''};

leafletUtil.fuseSearchCtrl = {};


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
                            leafletUtil.addSingleMarker(name, '', result.center.lat, result.center.lng, bounds, popupContent);
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

leafletUtil.preparePopupTable = function(object){
    var popupContent2 = '<div class="popup-content">\n<table class="table table-striped table-bordered table-condensed">\n';
    try {
        //if is a json object
        if(leafletUtil.IsJson(object) == true) {
            var json = JSON.parse(JSON.stringify(object, 2));
            //console.warn("RESULT:" + JSON.stringify(json, 2));
            popupContent2 += leafletUtil.preparePopupColumn(json, '', '');
        }
        //if is a array
      /*  else if(leafletUtil.Is(object) == 'array'){

        }*/
        else if(!leafletUtil.IsNull(object) && leafletUtil.IsObject(object)){
            var titles = Object.keys(object).toString().split(",");
            for (var title, i = 0; title = titles[i++];) {
                try {
                    // is Array or Object
                    if (!leafletUtil.IsNull(object[title]) &&
                        (leafletUtil.IsArray(object[title])|| leafletUtil.IsObject(object[title])))continue;
                    //if (typeof leafletUtil.geoDocument[title] !== 'String' || leafletUtil.geoDocument[title] == 'popupContent') continue;
                    if (object[title].toString().indexOf('http') === 0) {
                        object[title] = '<a target="_blank" href="' + object[title] + '">'
                            + object[title] + '</a>';
                    }
                    content += '<tr><th>' + title + '</th><td>' + object[title] + '</td></tr>';
                } catch (e) {
                    console.warn('Warning::preparePopupTable() ->' + e.message);
                }
            }//for
        }else{
            console.error(
                'preparePopupTable() -> Try to create a popuptable from a \'null\' object -> '+JSON.stringify(object));
        }
    }catch(e){
        console.error('Exception::preparePopupTable() ->'+ e.message);
    }
    popupContent2 += "</table>\n</div>\n";
    return popupContent2;
};

leafletUtil.IsEmptyObject = function(object){ return leafletUtil.Is(object,'emptyobject');};
leafletUtil.IsEmpty = function(object){ return leafletUtil.Is(object,'empty');};
leafletUtil.IsJson = function(object){ return leafletUtil.Is(object,'json');};
leafletUtil.IsNull = function(object){ return leafletUtil.Is(object,'null');};
leafletUtil.IsUndefined =  function(object){return leafletUtil.Is(object,'undefined');};
leafletUtil.IsString =  function(object){ return leafletUtil.Is(object,'string');};
leafletUtil.IsArray =  function(object){return leafletUtil.Is(object,'array');};
leafletUtil.IsEmpty =  function(object){return leafletUtil.Is(object,'empty');};
leafletUtil.IsObject =  function(object){return leafletUtil.Is(object,'object');};
leafletUtil.Is = function(object,stringValue){
    var result = false;
    try {
        if (stringValue)stringValue = stringValue.toString().toLowerCase();
        switch(stringValue){
            case 'json':{
                try {
                    JSON.parse(JSON.stringify(object));
                    result = true;
                } catch (e) { result = false;}
                break;
            }
            case 'null':{
                result =  (object === null || object == null);
                break;
            }
            case 'undefined': {
                result =  (object === undefined);
                break;
            }
            case 'string': {
                result =  object.constructor === "test".constructor;
                break;
            }
            case 'array': {
                result =  (Array.isArray(object) || object.constructor === [].constructor);
                break;
            }
            case 'empty': {
                if(leafletUtil.IsString(object)){
                    result = (object.toString() == '')
                }else if(leafletUtil.IsArray(object)){
                    result =  !(typeof object != "undefined" && object != null && object.length > 0);
                }else if(leafletUtil.IsObject(object)){
                    result = (Object.keys(object).length == 0);
                }else{
                    result = (JSON.stringify(object)=='{}');
                }
                break;
            }
            case 'emptyobject':{
                var name;
                for ( name in obj ) { result = false; }
                result = true;
                break;
            }
            case 'object': {
                result =  (object.constructor === {}.constructor || typeof object === 'object');
                break;
            }
            default: result =  false;
        }
        //console.info('Try Is with '+stringValue+ ' -> ' +result);
    }catch(e){
        console.error('Exception::leafletUtil.Is -> Try Is with '+stringValue+ ' -> ' +result +'-> '+e.message);
    }
    return result;
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
    try{
        key = key.indexOf('+') == 0 ? key.substring(1) : key;
        //need for clean the result send to the SpringFramework project
        value = value.toString().replaceAll(',', ' ');

        //check if is  url to a remote resource...
        if (value.toString().indexOf('http') === 0) {
            value = '<a target="_blank" href="' + value + '">'+ value + '</a>';
        }
        //console.warn('<tr><th>' + key + '</th><td>' + value + '</td></tr>\n')
        return '<tr><th>' + key + '</th><td>' + value + '</td></tr>';
    }catch(e){
        console.error('leafletUtil.preparePopupRow ->'+ e.message)
    }
};

/**
 * function to get the information on the marker ont he Layer to a Array to pass
 * by create a list of input to pass to a specific form.
 */
leafletUtil.inspectMarkerOnLayer = function(myLayerGroup){
    var array = [];
    console.log("compile getMarkers");
    try{
        myLayerGroup.eachLayer(function (layer) {
            try {
                var lat = layer.getLatLng().lat;
                var lng = layer.getLatLng().lng;
                var label;
                //label = layer.getLabel()._content;
                if(lat!=0 && lng !=0) {
                    label = layer.label._content; //get name with Leaflet.Label
                    var popupContent = layer.getPopup().getContent();
                    console.info("marker number():" + lat + "," + lng + "," + label);
                    array.push({name: label, latitude: lat, longitude: lng, popupContent: popupContent});
                }
                //i++;
            }catch(e){
                console.error("Exception:getMarkers -> "+e.message);
            }
        });

    }catch(e){console.error("Exception:getMarkers -> "+e.message);}
    console.info("...compiled getMarkers");
    return array;
};

leafletUtil.addNewInput = function(input_id,input_name,input_val,input_type,containerId,index) {
    var input = document.createElement('input');
    if(leafletUtil.IsNull(index)){
        input.setAttribute('id', input_id+index);
    }else {
        input.setAttribute('id', input_id);
    }
    input.setAttribute('name', input_name); //same name for all input so Spring get all like a String
    input.setAttribute('type', input_type);
    input.setAttribute('value', input_val);
    //document.body.appendChild(input);
    document.getElementById(containerId).appendChild(input);
    //setInputValue(input_id,val);
};

leafletUtil.addNewArrayOfInputs = function(array,containerId,nameElementOrIndex){
    for (var i = 0; i < array.length; i++) {
        var content = JSON.stringify(array[i]);
        try {
            if(leafletUtil.Is(nameElementOrIndex) == 'null') {
                leafletUtil.addNewInput('array' + i, 'array', content, containerId, i);
            }else{
                leafletUtil.addNewInput('array' + i, nameElementOrIndex, content,'hidden', containerId, i);
            }
        }catch(e){console.error('addNewArrayOfInputs:: Can\'t create the new Input'+e.message);}
    }
};


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

            // Information pane need a div with id='infopane'
            //L.control.infoPane('infopane', {position: 'bottomright'}).addTo(map);
        } catch (e) {
           console.error('Exception::initMap() -> ' + e.message);
        }
    }
};

/*** function for add a marker to the leaflet map */
leafletUtil.addSingleMarker = function(name, url, lat, lng, bounds, popupContent) {
    /*https://groups.google.com/forum/#!topic/leaflet-js/_oInGLe9uOY*/
    /*http://gis.stackexchange.com/questions/113076/custom-marker-icon-based-on-attribute-data-in-leaflet-geojson*/
    var markerVar;
    var marker = {
        name:name.toString(),url:url.toString(),latitude:lat.toString(),
        longitude:lng.toString(),popupContent:popupContent.toString()};

    //Extend my L.Marker for save some data on the L.marker
    var customMarkerVar = L.Marker.extend({
        options: {
            name: marker.name,
            popupContent: marker.popupContent
        }
    });

    if(jQuery.isEmptyObject(map)) {leafletUtil.initMap();}
    console.info("... add single marker:" + name + ',' + url + ',' + lat + ',' + lng + ',' + popupContent);
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
            loc = [parseFloat(lat), parseFloat(lng)];		//position found
        }catch(e){
            try{
                loc = [lat,lng];	//position found
            }catch(e){
                console.error("addSingleMarker"+e.message+ " , probably some error on the value pof the coordinates you using");
            }
        }
        //CREATE A L.Marker
        /*marker = new L.marker([parseFloat(lat), parseFloat(lng)], {draggable:false}, { icon: deathIcon},{title: name} )
         .bindLabel(text, { noHide: true }).addTo(map);
         */
        /*  markerVar = new L.Marker(new L.latLng(loc), {title: name, icon: new L.Icon.Default()} )
         .bindLabel(text, { noHide: true });//se property searched*/
        markerVar = new customMarkerVar(new L.latLng(loc), {title: name, icon: new L.Icon.Default()} )
            .bindLabel(text, { noHide: true });//se property searched

        //...set the popup on mouse over
        //var latlngOver = L.latLng(latVar, lngVar);
        //...set the popup on mouse click
        //var popupClick = new L.popup().setContent(text);
        var popupOver = new L.popup(
            {maxWidth:100,minWidth:50,maxHeight:200}
        ).setContent(popupContent);

        markerVar.bindPopup(popupOver);

        //..set some action for the marker
        //evt.target is the marker where set the action
        //marker.on('mouseover', function (e) {e.target.bindPopup(popupOver).openPopup();});
        //marker.on('mouseout', function (e) { e.target.closePopup();});
        markerVar.on('click', function (e) { e.target.bindPopup(popupOver).openPopup();});
       //marker.on('dblclick',function (e) { map.removeLayer(e.target)});
        /*marker.on('click', onMarkerClick(), this);*/

        //..add marker to the array of cluster marker

        //Add property dinamically [WORK] .....
        var geoJsonWithProperties = leafletUtil.loadPropertiesToGeoJson(markerVar,{name:name});
        var layerGeoJson = L.geoJson(geoJsonWithProperties, {
            style: function (feature) {
                return feature.properties.style;
            },
            // add a popup content to the marker
            onEachFeature: function (feature, layer) {
                layer.bindPopup(popupOver);
                layer.on('click', function (e) { e.target.bindPopup(popupOver).openPopup();});
            },
            pointToLayer: function (feature, latlng) {
                //L.CircleMarker
                return new L.Marker(new L.latLng(loc), {title: name, icon: new L.Icon.Default()} )
                    .bindLabel(text, { noHide: true });//se property searched
            }
            // correctly map the geojson coordinates on the image
            /*coordsToLatLng: function(coords) {
             return rc.unproject(coords);
             },*/
        });
        //Add GeoJson Layer to the layerGroup
        markerClusters.addLayer(layerGeoJson);

        //Add Marker to the layerGroup
        //markerClusters.addLayer(markerVar);
        //...set to a Global variable for use with different javascript function
        //map.addLayer(markerClusters);
        markerClusters.addTo(map);
        //set the view...
        map.setView([lat, lng], 8);
    }catch(e) {
        console.error("Exception::addSingleMarker() -> "+e.message +" ,Sorry the program can't create the Marker");
    }
    console.info('Content Marker:'+JSON.stringify(markerVar.toGeoJSON()));
    console.info('Content Layer:'+JSON.stringify(markerClusters.toGeoJSON()));
    leafletUtil.invokePluginFuseSearch(markerClusters.toGeoJSON(),['name']);
    leafletUtil.markerList.push(marker);
    console.info("...Compiled addSingleMarker()");
};

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
leafletUtil.addMultipleMarker = function(markers){
    console.log("add multiple marker "+markers.length+"...");
    try {
        //var titles = Object.keys(markers[0]).split(",");
        for (var j = 0; j < markers.length; j++){
            try {
                console.log("... add multiple marker (" + j + "):"
                    + markers[j].name + ',' + markers[j].url + ',' + markers[j].lat + ',' + markers[j].lng);
                leafletUtil.addSingleMarker(markers[j].name, markers[j].url, markers[j].lat, markers[j].lng, null,
                    markers[j].popupContent);
            }catch(e){
                console.warn(e.message);
            }
        }
        console.log("... added multiple marker");
    }catch(e){
        console.error(e.message);
    }
};

/**
 * function to add every single company from java object in JSP page to a javascript array
 */
var specialj =0;
leafletUtil.pushMarkerToArrayMarker = function(nameVar,urlVar,latVar,lngVar,regionVar,provinceVar,cityVar,addressVar,
                                     phoneVar,emailVar,faxVar,ivaVar,popupContentVar){
        try {
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

            if(leafletUtil.IsNull(leafletUtil.geoDocument.popupContent)) {
                leafletUtil.geoDocument.popupContent = leafletUtil.preparePopupTable(leafletUtil.geoDocument);
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
    };

    /**
     * Add the Leaflet Plugin Search.
     * https://github.com/p4535992/leaflet-search.
     */
    var geocoderSearchGoogle;
    function addPluginSearch(){
        if(jQuery.isEmptyObject(map)) {leafletUtil.initMap();}
        /*try{
         geocoderSearchGoogle = new google.maps.Geocoder();
         }catch(e){
         console.warn("Warning:addPluginSearch->"+e.message);
         geocoderSearchGoogle = null;
         }*/
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
leafletUtil.loadArrayOnInput2 = function(idForm,nameElementOrIndex){
    leafletUtil.addNewArrayOfInputs(leafletUtil.markerList,idForm,nameElementOrIndex);
    return document.forms[idForm].elements[nameElementOrIndex].value = JSON.stringify(leafletUtil.markerList);
};

leafletUtil.invokePluginFuseSearch = function(geojsonData,propsArray){
    // Load the data from remote
   /* jQuery.getJSON("data/lieux_culture_nantes.json", function(data) {
        displayFeatures(data.features, layers, icons);
        var props = ['nom_comple', 'libcategor', 'commune'];
        fuseSearchCtrl.indexFeatures(data.features, props);
    });*/
    try {
        var layers = [];
        var icons = [];
        console.info("10 invokePluginFuseSearch:: ->" + JSON.stringify(geojsonData));
        leafletUtil.displayFeatures(geojsonData.features,layers, icons,null,null);
        //var props = ['nom_comple', 'libcategor', 'commune'];
        console.info('11 invokePluginFuseSearch:: ->'+ geojsonData.toString());
        leafletUtil.fuseSearchCtrl.indexFeatures(geojsonData, propsArray);
    }catch(e){
        console.error('invokePluginFuseSearch:: ->'+e.message);
    }
};

/**
 * Function for add to the map a Layer populate with multiple Layer created from the content of the
 * map category.
 * e.g.
 * var categories = {
 *  101 : {desc: "Musées & Châteaux", icon:"museum_archeological.png"},
 *  103 : {desc: "Médiathèque", icon:"library.png"},
 * };
 * @param layersObject
 * @param mapCategory
 * @param layerGroupToPopulate
 */
leafletUtil.addLayerControlToMapCategory = function(layersObject,mapCategory,layerGroupToPopulate){
    // Layer control, setting up 1 layer per category
    //var layers = {};
    //var  cultureLayer = L.layerGroup();
    if(jQuery.isEmptyObject(layerGroupToPopulate)){
        layerGroupToPopulate = L.layerGroup();
    }
    var layerCtrl = L.control.layers();
    for (var icat in mapCategory) {
        if(categories.hasOwnProperty(icat)) {
            var layer = L.featureGroup();
                layers[icat] = layer;
                layerGroupToPopulate.addLayer(layer);

            var cat = categories[icat],
                desc = '<img class="layer-control-img" src="images/' + cat.icon + '"> ' + cat.desc;
            layerCtrl.addOverlay(layer, desc);
        }
    }
    layerGroupToPopulate.addTo(map);
    layerCtrl.addTo(map);
};

leafletUtil.addPluginFuseSearch = function(stringNameToSearch,stringTypeToSearch,stringCategoryToSearch){
    try {
        // Add fuse search control
        var options = {
            position: 'topright',
            title: 'Search Marker',
            placeholder: 'put the name of the marker',
            maxResultLength: 15,
            threshold: 0.5,
            showInvisibleFeatures: true,
            showResultFct: function (feature, container) {
                var props = feature.properties;
                var name = L.DomUtil.create('b', null, container);
                name.innerHTML = props[stringNameToSearch];

                container.appendChild(L.DomUtil.create('br', null, container));
                var info;
                if(leafletUtil.IsNull(stringTypeToSearch) || leafletUtil.IsNull(stringCategoryToSearch)) {
                    var cat = props[stringTypeToSearch] ? props[stringTypeToSearch] : props[stringCategoryToSearch];
                    info = '' + cat + ', ' + props[stringNameToSearch];
                }else{
                    info = props[stringNameToSearch];
                }
                container.appendChild(document.createTextNode(info));
            }
        };
        try {
            leafletUtil.fuseSearchCtrl = L.control.fuseSearch(options);
            map.addControl(leafletUtil.fuseSearchCtrl);
        }catch(e){
            console.error('addPluginFuseSearch::L.control.fuseSearch ->'+e.message);
        }
        //layerCtrl.addTo(map);
    }catch(e){
        console.error('addPluginFuseSearch ->'+e.message);
    }
};

/**
 * Method support for the Plugin FuseSearch generate and create the dropdown menu of the research.
 */
leafletUtil.displayFeatures = function(features, layers, icons,stringFeatureCategoryLayer,stringFeatureNameMarker) {
    try {
        //create div tiny-popup
        var popup = L.DomUtil.create('div', 'tiny-popup', map.getContainer());
        if (stringFeatureCategoryLayer == null) stringFeatureCategoryLayer = 'name';
        if (stringFeatureNameMarker== null) stringFeatureNameMarker = 'name';
        console.warn('SPECIAL:'+JSON.stringify(features));
        for (var id in features) {
            if (features.hasOwnProperty(id)) {
                var geojsondata = features[id];
                var cat = geojsondata.properties[stringFeatureCategoryLayer];
                //Load GeoJson on the map
                var site = L.geoJson(geojsondata, {
                    pointToLayer: function (feature, latLng) {
                        try {
                            //Set L.Icon
                            /* var icon;
                             if(icons.isEmpty()){
                             icon = new L.Icon.Default();
                             }else{
                             if(!jQuery.isEmptyObject(icons[cat])) icon = icons[cat];
                             else icon = new L.Icon.Default();
                             }*/
                            //Set L.Marker
                            var marker = L.marker(latLng, {
                                icon: new L.Icon.Default(), keyboard: false, riseOnHover: true
                            });
                            //Set event Listener and zoom
                            if (!L.touch) {
                                marker.on('mouseover', function (e) {
                                    var nom = e.target.feature.properties[stringFeatureNameMarker];
                                    var pos = map.latLngToContainerPoint(e.latlng);
                                    popup.innerHTML = nom;
                                    L.DomUtil.setPosition(popup, pos);
                                    L.DomUtil.addClass(popup, 'visible');

                                }).on('mouseout', function () {
                                    L.DomUtil.removeClass(popup, 'visible');
                                });
                            }
                            return marker;
                        }catch(e){
                            console.error('Exception::leafletUtil.displayFeatures -> '+e.message);
                        }
                    },
                    onEachFeature: function (feature, layer) {
                        leafletUtil.onEachFeature_bindPopup(feature, layer);
                    }
                });
            }
            var layer = layers[cat];
            if (layer !== undefined) layer.addLayer(site);
        }
    }catch(e){
        console.error('displayFeatures ->'+e.message);
    }
    console.warn('SPECIAL 2:'+JSON.stringify(layer));
    return layers;
};

leafletUtil.onEachFeature_bindPopup = function(feature, layer){
    try {
        // Keep track of the layer(marker)
        feature.layer = layer;
        var props = feature.properties;
        if (props) {
            var popupContent = feature.properties.popupContent;
            layer.bindPopup(popupContent);
        }
    }catch(e){
        console.error('Exception::leafletUtil.onEachFeature_bindPopup -> '+e.message);
    }
};

leafletUtil.setupIcons = function(arrayJsonOrMap) {
    var icons = {};
    for (var cat in arrayJsonOrMap) {
        if(arrayJsonOrMap[cat].hasOwnProperty('icon')) {
            /*var icon = arrayJsonOrMap[cat]['icon'];
            var url = "images/" + icon;*/
            var icon = L.icon({
                iconUrl: arrayJsonOrMap[cat]['icon'],
                iconSize: [32, 32],
                iconAnchor: [16, 37],
                popupAnchor: [0, -28]
            });
            icons[cat] = icon;
        }
    }
    return icons;
};

leafletUtil.loadPropertiesToGeoJson = function(myLayer,geoJsonPropertiesToAdd){
    try {
        //Marker:{"type":"Feature","properties":{},"geometry":{"type":"Point","coordinates":[11.3701787,44.5953705]}}
        //Layer:{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"Point","coordinates":[11.3701787,44.5953705]}}]}
        var geoJsonBase = myLayer.toGeoJSON();
        if (leafletUtil.IsEmpty(myLayer)) { //if the layer json object is empty
            myLayer = new L.markerClusterGroup({
                disableClusteringAtZoom: 19,
                iconCreateFunction: function (cluster) {
                    return L.divIcon({
                        html: cluster.getChildCount(), className: 'mycluster', iconSize: null
                    });
                }
            });
        }
        // Add custom popups to each using our custom feature properties
        /*myLayerGroup.on('layeradd', function (e) {
            for (var key in objectProperties) {
                //feature.properties.news = 23; //add/update a properties to the feature.
                e.layer.properties[key] = objectProperties[key];
            }
        });*/
        //If is the geoJson of a Layer or of a Marker.....
        if (geoJsonBase.hasOwnProperty('features'))geoJsonBase = geoJsonBase.features;
        for (var key in geoJsonBase) {
            if (geoJsonBase.hasOwnProperty(key) && key == 'properties') {
                //is a empty object.........
                console.warn('empty?' + JSON.stringify(geoJsonBase.properties));
                if (leafletUtil.IsEmpty(geoJsonBase.properties)) { //if the properties json object is empty
                    //console.warn('20:'+JSON.stringify(geoJsonBase));
                    for (var key2 in geoJsonPropertiesToAdd) {
                        //add the new property...
                        geoJsonBase.properties[key2] = geoJsonPropertiesToAdd[key2];
                        //console.warn('21:'+JSON.stringify(geoJsonBase));
                    }
                }
                console.warn('19:'+JSON.stringify(geoJsonBase));
            }
        }
        console.warn('22:'+JSON.stringify(geoJsonBase));
        //var layerGeoJsonBase = L.geoJson(geoJsonBase);
        //myLayer.addLayer(layerGeoJsonBase);
        return geoJsonBase;
    }catch(e){
        console.error('loadPropertiesGeoJson -> '+e.message);
    }
};

leafletUtil.getGeoJsonContentFromLayer = function(myLayerGroup){
    try{
        if(!$.isEmptyObject(myLayerGroup)) {
            console.log("Marker cluster is not empty go to check the Marker.");
            myLayerGroup.eachLayer(function (layer) {
                //note layer == marker
                try {
                    var lat = layer.getLatLng().lat;
                    var lng = layer.getLatLng().lng;
                    var label;
                    if(lat!=0 && lng !=0) {
                        label = layer.label._content; //get name with Leaflet.Label
                        var popupContent = layer.getPopup().getContent();
                        console.info("marker number():" + lat + "," + lng + "," + label);
                        //array.push({name: label, latitude: lat, longitude: lng, popupContent: popupContent});
                    }
                    //i++;
                }catch(e){
                    console.error("Exception:getGeoJsonContentOfLayer -> "+e.message);
                }
            });
        }
    }catch(e){
        console.error("Exception:getGeoJsonContentOfLayer -> "+e.message);
    }
};

leafletUtil.loadGeoJsonToLayer =
    function(myLayerGroup,geoJsonData,styleFunction,coordsToLatLngFunction,onEachFeatureFunction,pointToLayerFunction){
    //Customize
    var myLayer = L.geoJson(undefined, {
        style: function (feature) {
            return feature.properties.style;
        },
        // correctly map the geojson coordinates on the image
        coordsToLatLng: function(coords) {
            return rc.unproject(coords);
        },
        // add a popup content to the marker
        onEachFeature: function (feature, layer) {
            layer.bindPopup(feature.properties.name);
        },
        pointToLayer: function (feature, latlng) {
            return L.circleMarker(latlng, {
                radius: 8,
                fillColor: "#800080",
                color: "#D107D1",
                weight: 1,
                opacity: 1,
                fillOpacity: 0.8
            });
        }
    });
    myLayer.addData(geoJsonData);
    myLayer.addTo(map);

};





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
    if(this.includes(toSearch)) return this.split(toSearch).join(toreplace);
    else return this;
};

Array.prototype.isEmpty = function(){
    return !(typeof this != "undefined" && this != null && this.length > 0);
};
















