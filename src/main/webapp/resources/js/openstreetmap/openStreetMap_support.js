/**
 * Created by 4535992 on 15/06/2015.
 */
var mapLayer, mappingLayer, vectorLayer, selectMarkerControl, selectedFeature;
var superlat;
var superlon;
/**funzione per la cattura dell'evento click sulle icone nella mappa OpenStreetMap*/
function onFeatureSelect(feature) {
    selectedFeature = feature;
    var popup = new OpenLayers.Popup.FramedCloud(
        "tempId",
        feature.geometry.getBounds().getCenterLonLat(),
        null,
        '<div class="markerContent">' + selectedFeature.attributes.salutation
//                               +";Latlon:("+selectedFeature.attributes.Lat+","+ selectedFeature.attributes.Lon
        +'</div>',
        null,
        true,
        null);

    feature.popup = popup;
    mapLayer.addPopup(popup);
    mapLayer.setCenter(
        new OpenLayers.LonLat(selectedFeature.attributes.Lon,selectedFeature.attributes.Lat).transform(
            new OpenLayers.Projection("EPSG:4326"),
            mapLayer.getProjectionObject())

        , 18
    );

    /**function per la cattura dell'evento di chiusura dell'icona di popup sulla mappa OpenStreetMap*/
    function onPopupClose(feature) {
        mapLayer.removePopup(feature.popup);
        feature.popup.destroy();
        feature.popup = null
    }

    /**function per la cattura dell'evento di deselezione dell'icone o selezione di un'altra icona
     * sulla mappa OpenStreetMap*/
    function onFeatureUnselect(feature) {
        mapLayer.removePopup(feature.popup);
        feature.popup.destroy();
        feature.popup = null;
    }

    /**function per la inizializzaione dell mappa OpenStreetMap, attraverso uno dei tanti
     * Costruttori possibili abilitati dall'API*/
    function initMap2(position){

        if (navigator.geolocation) {
            var timeoutVal = 10 * 1000 * 1000;
            navigator.geolocation.getCurrentPosition(
                displayPosition,
                displayError,
                { enableHighAccuracy: true, timeout: timeoutVal, maximumAge: 0 }
            );

            ////////////////////////////////////////////////////////////////////////
        }
        else {
            alert("Geolocation is not supported by this browser");

        }
    }

    /**mostra la posizione dell'utente sulla mappa OpenStreetMap*/
    function displayPosition(position){
        mapLayer = new OpenLayers.Map( 'map');
        mappingLayer = new OpenLayers.Layer.OSM("Simple OSM Map");
        mapLayer.addLayer(mappingLayer);
        vectorLayer = new OpenLayers.Layer.Vector("Vector Layer", {projection: "EPSG:4326"});
        selectMarkerControl = new OpenLayers.Control.SelectFeature(vectorLayer, {onSelect: onFeatureSelect, onUnselect: onFeatureUnselect});
        mapLayer.addControl(selectMarkerControl);
        selectMarkerControl.activate();
        mapLayer.addLayer(vectorLayer);

        var zoom =18;
//           alert(position.coords.latitude);
//           alert(position.coords.longitude);
        mapLayer.setCenter(
            new OpenLayers.LonLat(position.coords.longitude,position.coords.latitude).transform(
                new OpenLayers.Projection("EPSG:4326"),
                map.getProjectionObject())
            , zoom
        );
        var lat=position.coords.latitude;
        var lon=position.coords.longitude;
        superlat=lat;
        superlon=lon;
        var imageIcon = "/img/me.png";
        placeLocationMarker(lat,lon,"YOU ARE HERE",imageIcon,false,false);
    }
    /**funzione per il controllo di errore nell'atto della geolocalizzazione dell'utente*/
    function displayError(error) {
        var errors = {
            1: 'Permission denied',
            2: 'Position unavailable',
            3: 'Request timeout'
        };
        alert("Error: " + errors[error.code]);
    }
    i=0;

    /**funzione per il piazzamento delle icone/immagini sulla mappa openstreetmap*/
    function placeLocationMarker(lat,lon,string,url,b,menu){
        var randomLat = lat;
        var randomLon = lon;
        var randomLonLat = new OpenLayers.Geometry.Point( randomLon, randomLat);
        randomLonLat.transform("EPSG:4326", mapLayer.getProjectionObject());

        if(url==null||menu==true){
            if(string=="YOU ARE HERE"){url= "img/me.png";}
            else{url= "img/cluster.png";}
            loww = 31;
            lowh = 35;
            var randomFeature = new OpenLayers.Feature.Vector(
                randomLonLat,
//                    {salutation:string} ,
                {salutation:string,Lon : randomLon, Lat : randomLat} ,
                {externalGraphic: url, graphicHeight: lowh, graphicWidth: loww, graphicXOffset: -12, graphicYOffset: -25}
            );
            var randomFeature = new OpenLayers.Feature.Vector(
                randomLonLat,
//                    {salutation:string} ,
                {salutation:string,Lon : randomLon, Lat : randomLat} ,
                {externalGraphic: url, graphicHeight: lowh, graphicWidth: loww, graphicXOffset: -12, graphicYOffset: -25}
            );
        }else if((b==false && url!=null)){
            loww = 31; //21
            lowh = 35; //25
            var randomFeature = new OpenLayers.Feature.Vector(
                randomLonLat,
//                    {salutation:string} ,
                {salutation:string,Lon : randomLon, Lat : randomLat} ,
                {externalGraphic: url, graphicHeight: lowh, graphicWidth: loww, graphicXOffset: -12, graphicYOffset: -25}
            );
        }else if(b==true && url!=null){
            loww = 31;
            lowh = 35;
            var randomFeature = new OpenLayers.Feature.Vector(
                randomLonLat,
//                    {salutation:string} ,
                {salutation:string,Lon : randomLon, Lat : randomLat} ,
                {externalGraphic: url, graphicHeight: lowh, graphicWidth: loww, rotation:i*15}
            );
            i=i+1;
        }
        vectorLayer.addFeatures(randomFeature);
//            selectedFeature = randomFeature;
//            vectorLayer.addFeatures(selectedFeature);
        if((b==false && randomFeature.attributes.salutation=="YOU ARE HERE")||menu==true){
            var popup = new OpenLayers.Popup.FramedCloud(
                "tempId",
                new OpenLayers.LonLat( randomLon, randomLat).transform("EPSG:4326", mapLayer.getProjectionObject()),
                null,
//                       randomFeature.attributes.salutation,
//                               + " Lat:" + randomFeature.attributes.Lat + " Lon:" + randomFeature.attributes.Lon,
                '<div class="markerContent">' + randomFeature.attributes.salutation + '</div>',
                null,
                true,
                null);
            randomFeature.popup = popup;
            mapLayer.addPopup(popup);
        }
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////77
    /**funzione che stampa sulla mappa tutte le locazioni vicine all'utente e ripsettivamente
     * cattura tutte per ogni locazione tutte le immagini a lui vicine */
    function allLocationCoordinates(coord){
        var images =[];
        for (var key in coord) {
            var laty = coord[key].LAT;
            var lngy = coord[key].LON;
            var string = coord[key].NAME;
            placeLocationMarker(laty,lngy,string,null,false,false);
        }

    }

    /**funzione che abilita il centramento della mappa alla locazione desiderata*/
    function centraEPopup(name,lat,lng){
        mapLayer.setCenter(
            new OpenLayers.LonLat(lng,lat).transform(
                new OpenLayers.Projection("EPSG:4326"),
                mapLayer.getProjectionObject())

            , 18
        );
        placeLocationMarker(lat,lng,name,null,false,true);
    }
    /**funzione che non fa nulla Ã¨ stata messa per evitare il lancio di un'eccezione in fase
     * di chiamata dell'API foursquare*/
    function nothing(){}

}