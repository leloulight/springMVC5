/**
 * Created by 4535992 on 15/06/2015.
 */

//DEFINE DIFFERNET MARKER WITH DIFFERNET COLOR
var markerAccommodation = L.AwesomeMarkers.icon({
    markerColor: 'red'
});
var markerCulturalActivity = L.AwesomeMarkers.icon({
    markerColor: 'orange'
});
var markerEducation = L.AwesomeMarkers.icon({
    markerColor: 'green'
});
var markerEmergency = L.AwesomeMarkers.icon({
    markerColor: 'blue'
});
var markerEntertainment = L.AwesomeMarkers.icon({
    markerColor: 'purple'
});
var markerFinancialService = L.AwesomeMarkers.icon({
    markerColor: 'darkred'
});
var markerGovernmentOffice = L.AwesomeMarkers.icon({
    markerColor: 'darkblue'
});
var markerHealthCare = L.AwesomeMarkers.icon({
    markerColor: 'darkgreen'
});
var markerShopping = L.AwesomeMarkers.icon({
    markerColor: 'darkpurple'
});
var markerTourismService = L.AwesomeMarkers.icon({
    markerColor: 'cadetblue'
});
var markerTransferService = L.AwesomeMarkers.icon({
    markerColor: 'yellow'
});
var markerWineAndFood = L.AwesomeMarkers.icon({
    markerColor: 'black'
});
var markerBusStops = L.AwesomeMarkers.icon({
    markerColor: 'pink'
});

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
//Feature group
var layerMarker = new L.FeatureGroup();

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
var map;
var myURL = jQuery('script[src$="leaflet_buildMap_support.js"]').attr('src').replace('leaflet_buildMap_support.js', '');
var leaflet_markers_support = {

    setMapLeaflet:function(mapLeaflet){
        map = mapLeaflet;
    },
    /*** Get a list of marker with coordinates and a url href and put the marker on the map*/
    addListMarkers: function (markers) {
        //choose a personal icon image
        /*
         var myIcon = L.icon({
         iconUrl: myURL + 'images/pin24.png',
         iconRetinaUrl: myURL + 'images/pin48.png',
         iconSize: [29, 24],
         iconAnchor: [9, 21],
         popupAnchor: [0, -14]
         });
         */
        for (var i = 0; i < markers.length; ++i) {
            /* L.marker( [markers[i].lat, markers[i].lng] )
             .bindPopup( '<a href="' + markers[i].url + '" target="_blank">' + markers[i].name + '</a>' )
             .addTo( map );*/
            L.marker([markers[i].lat, markers[i].lng], {icon: myIcon})
                .bindPopup('<a href="' + markers[i].url + '" target="_blank">' + markers[i].name + '</a>')
                .addTo(map);
        }
    },
    /*
     var marker = {
     "name": "Japan",
     "url": "https://en.wikipedia.org/wiki/Japan",
     "lat": 36.204824,
     "lng": 138.252924
     };
     */
    addMarker: function (marker) {


        //choose a personal icon image
        /*
         var myIcon = L.icon({
         iconUrl: myURL + 'images/pin24.png',
         iconRetinaUrl: myURL + 'images/pin48.png',
         iconSize: [29, 24],
         iconAnchor: [9, 21],
         popupAnchor: [0, -14]
         });
         */
        /*
         L.marker( [marker.lat, marker.lng], {icon: myIcon} )
         .bindPopup( '<a href="' + marker.url + '" target="_blank">' + marker.name + '</a>' )
         .addTo( map );
         */
        //best use a different layer for add the marker.
        var m = L.marker([marker.lat, marker.lng], {icon: myIcon})
            .bindPopup('<a href="' + marker.url + '" target="_blank">' + marker.name + '</a>');
        //add to map with layer
        layerMarker.addLayer(m);
        map.addLayer(layerMarker);

    },


    addMarker: function (name, url, lat, lng) {
        var marker = {
            "name": name,
            "url": url,
            "lat": lat,
            "lng": lng
        };
        leaflet_markers_support.addMarker(marker);
    }

}
