/**
 * Created by Marco on 15/06/2015.
 */
/*** For store data in GeoJSON format I use Leaflet function toGeoJSON()*/
function convertDataToGeoJson(data){
    var myMarkers = new L.FeatureGroup();
    map.addLayer(myMarkers);
    // get json
    var myMarkersJson = myMarkers.toGeoJSON();
};
//http://stackoverflow.com/questions/3199887/send-json-object-to-mysql-using-jquery-javascript-php
function storeJsonObjectToMySQL(myObj){
    $.ajax({
        url: someURL,
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