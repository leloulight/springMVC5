<%@page import="java.io.IOException"%>
<%@page import="org.openrdf.model.Value"%>
<%@ page import="java.util.*"%>
<%@ page import="org.openrdf.repository.Repository"%>
<%@ page import="org.openrdf.repository.http.HTTPRepository"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="org.openrdf.query.BooleanQuery"%>
<%@ page import="org.openrdf.OpenRDFException"%>
<%@ page import="org.openrdf.repository.RepositoryConnection"%>
<%@ page import="org.openrdf.query.TupleQuery"%>

<%@ page import="org.openrdf.query.TupleQueryResult"%>
<%@ page import="org.openrdf.query.BindingSet"%>
<%@ page import="org.openrdf.query.QueryLanguage"%>
<%@ page import="java.io.File"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.openrdf.rio.RDFFormat"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css" />
<title>SIIMOBILITY - MAPPA</title>

<link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.css" />
<script src="http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.js"></script>

<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/leaflet.awesome-markers.css">

<script src="${pageContext.request.contextPath}/js/leaflet.awesome-markers.min.js"></script>

</head>
<body>
	
		
		 <div id="map"></div>

		<%
			Connection conMySQL = null;
			Statement st = null;
			ResultSet rs = null;
			
			Connection conMySQL2 = null;
			Statement st2 = null;
			ResultSet rs2 = null;


			String url = "jdbc:mysql://localhost:3306/";
			String db = "tesi";
			String driver = "com.mysql.jdbc.Driver";
			String user = "ubuntu";
			String pass = "ubuntu";

			String sesameServer = "http://192.168.0.205:8080/openrdf-sesame/";
			String repositoryID = "siimobilityultimate";

			Repository repo = new HTTPRepository(sesameServer, repositoryID);
			repo.initialize();

		
										
			 RepositoryConnection con = repo.getConnection();
			 
			// String queryString = "";
		
	//		TupleQuery tupleQuery = con.prepareTupleQuery(QueryLanguage.SPARQL, queryString);
		//	 TupleQueryResult result = tupleQuery.evaluate();
			//try{
			// while (result.hasNext()) {
				 
				 
			// }
			//}
			//catch (Exception e){
				
				//out.println(e.getMessage());
			//}
				 
				 
				 
											 
								
		%>
	
	
	<div id="result">
	
	</div>
	<script>

		var map = L.map('map').setView([43.3555664, 11.0290384], 8);
		var busStopsLayer = new L.LayerGroup();
		var servicesLayer = new L.LayerGroup();
		
		L.tileLayer('http://{s}.tile.cloudmade.com/{key}/22677/256/{z}/{x}/{y}.png', {
			attribution: 'Map data &copy; 2011 OpenStreetMap contributors, Imagery &copy; 2012 CloudMade',
			key: 'BC9A493B41014CAABB98F0471D759707',
			minZoom: 8
		}).addTo(map);

		L.marker([43.3555664, 11.0290384]).addTo(map)
			.bindPopup("<b>Toscana</b><br />Progetto SIIMobility").openPopup();

		var popup = L.popup();

function trovaFermateBusAJAX(lat1, long1, lat2, long2){
	$('#result').html('<img src="${pageContext.request.contextPath}/img/ajax-loader.gif" />');
	
$.ajax({
	url : "${pageContext.request.contextPath}/ajax/busstop.jsp",
	type : "GET",
	async: true,
	dataType: 'json',
	data : {
		lat1: lat1,
		long1: long1, 
		lat2: lat2,
		long2: long2, 
	},
	success : function(msg) {
		//$('#result').html(msg);
		busStopsLayer = L.geoJson(msg, {
			
			onEachFeature: function(feature, layer){
				var popupContent = "FERMATA : " + feature.properties.popupContent;
				popupContent = popupContent + "<br /><a href=\"#\" title=\"Mostra i servizi attorno alla Fermata\" onclick=\"mostraServizi('" + feature.properties.popupContent + "')\">Mostra Elenco Servizi</a>";

				layer.bindPopup(popupContent);
				layer.on({
					mouseover: aggiornaAVM
				});
				
			},
			
		}).addTo(map);
		
		
		$('#result').html('');
	}
});

}


$( document ).ready(function() {
	 // trovaFermateBus();
	});
	
map.on('moveend', aggiornaFermateBus);
map.on('zoomend', aggiornaFermateBus);


function aggiornaFermateBus(e) {
	busStopsLayer.clearLayers();
	var bounds = map.getBounds();
	var southWest = bounds.getSouthWest();
	var northEast = bounds.getNorthEast();
	trovaFermateBusAJAX(southWest.lat, southWest.lng, northEast.lat, northEast.lng);
}


function mostraServizi(nomeFermata) {
	servicesLayer.clearLayers();
	var bounds = map.getBounds();
	var southWest = bounds.getSouthWest();
	var northEast = bounds.getNorthEast();
	//console.log(southWest.lat + southWest.lng + northEast.lat + northEast.lng + nomeFermata);
	mostraServiziAJAX(nomeFermata);
}
	

function mostraServiziAJAX(nomeFermata){
	$('#result').html('<img src="${pageContext.request.contextPath}/img/ajax-loader.gif" />');
$.ajax({
	url : "${pageContext.request.contextPath}/ajax/services.jsp",
	type : "GET",
	async: true,
	dataType: 'json',
	data : {
		nomeFermata: nomeFermata
	},
	success : function(msg) {
		console.log(msg);
		servicesLayer = L.geoJson(msg, {
		    //style: function(feature) {
		    //   return {color: "red"};
		    //},
		    pointToLayer: function(feature, latlng) {
		        return new L.Marker(latlng, {icon: redMarker});
		    },
		    onEachFeature: function (feature, layer) {
		        layer.bindPopup(feature.properties.popupContent);
		    }
		}).addTo(map);
		
		$('#result').html('');
	
	}
});

}

//L.marker(latlng, {icon: baseballIcon})

var redMarker = L.AwesomeMarkers.icon({
    icon: 'coffee',
    markerColor: 'red'
  });

//control that shows state info on hover
var info = L.control();

info.onAdd = function (map) {
	this._div = L.DomUtil.create('div', 'info');
	this.update();
	return this._div;
};

info.update = function (nomeFermata) {
	
	this._div.innerHTML = '<img src="${pageContext.request.contextPath}/img/ajax-loader.gif" />';
	//sleep(1000);
	//console.log(this._div);
	mostraAVMAJAX(nomeFermata);
	//this._div.innerHTML = '<h4>SERVIZIO AVM</h4>' + msg;
	
};

info.addTo(map);

function mostraAVMAJAX(nomeFermata){
	//console.log('pinco');
$.ajax({
	url : "${pageContext.request.contextPath}/ajax/avm.jsp",
	type : "GET",
	async: true,
	//dataType: 'json',
	data : {
		nomeFermata: nomeFermata
	},
	success : function(msg) {
		console.log('ok');
		$('.info').html(msg);
		
	}
});
}

function aggiornaAVM(e) {
	var layer = e.target;
	console.log(layer.feature.properties.popupContent);
	info.update(layer.feature.properties.popupContent);
}



</script>
	
</body>
</html>