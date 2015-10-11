var dataUrl = 'data/data.csv';
var maxZoom = 9;
var fieldSeparator = '|';
var baseUrl = 'http://otile{s}.mqcdn.com/tiles/1.0.0/osm/{z}/{x}/{y}.jpg';
var baseAttribution = 'Data, imagery and map information provided by <a href="http://open.mapquest.co.uk" target="_blank">MapQuest</a>, <a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a> and contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/" target="_blank">CC-BY-SA</a>';
var subdomains = '1234';
var clusterOptions = {showCoverageOnHover: false, maxClusterRadius: 50};
var labelColumn = "Name";
var opacity = 1.0;

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