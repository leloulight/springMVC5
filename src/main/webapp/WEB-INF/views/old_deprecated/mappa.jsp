<!--  IMPORTAZIONE NAMESPACES -->
<%@ page import="java.io.IOException"%>
<%@ page import="org.openrdf.model.Value"%>
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--  header HTML -->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Mapservice</title>

<!-- IMPORTAZIONE FOGLI DI STILE -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/leaflet-gps.css" type="text/css" />
<link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.css" />
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" />	
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/leaflet.awesome-markers.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css" />

<!-- IMPORTAZIONE SCRIPT E LIBRERIE JAVASCRIPT -->
<script src="http://cdn.leafletjs.com/leaflet-0.7.2/leaflet.js"></script>
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="${pageContext.request.contextPath}/js/leaflet.awesome-markers.min.js"></script>
<script src="${pageContext.request.contextPath}/js/leaflet-gps.js"></script>

</head>
<body>
	<%
		// INIZIALIZZAZIONE CONNESSIONI CON SPARQL ENDPOINT E DB MYSQL
		Connection conMySQL = null;
		Statement st = null;
		ResultSet rs = null;
	
		Connection conMySQL2 = null;
		Statement st2 = null;
		ResultSet rs2 = null;

		String url = "jdbc:mysql://localhost:3306/";
		String db = "siimobility";
		String driver = "com.mysql.jdbc.Driver";
		String user = "siimobility";
		String pass = "siimobility";

		String sesameServer = "http://localhost:8080/openrdf-sesame/";
		String repositoryID = "siimobilityultimate";

		Repository repo = new HTTPRepository(sesameServer, repositoryID);
		repo.initialize();
		
		RepositoryConnection con = repo.getConnection();					
	%>
	
	<!-- DIV PRINCIPALE CONTENENTE LA MAPPA INTERATTIVA -->
	<div id="map"></div>

	
	<!-- PULSANTI IN ALTO A SINISTRA (HELP E SELEZIONE PUNTO MAPPA) -->
	<div class="menu" id="help">
		<a href="http://www.disit.org/servicemap" title="Aiuto Service Map" target="_blank"><img src="${pageContext.request.contextPath}/img/help.png" alt="help SiiMobility ServiceMap" width="26" /></a>
	</div>
	<div class="menu" id="info">
		<img src="${pageContext.request.contextPath}/img/info.png" alt="Seleziona un punto della mappa" width="26" />
	</div>


	<!-- DIV CONTENENTE IL MENU IN ALTO A SINISTRA -->
	<div id="menu-alto" class="menu">
		<div class="header"><span>- Nascondi Menu</span>
		</div>
    	<div class="content">
    		<div id="tabs">
  				<ul>
  					<!-- ELENCO DELLE DUE TAB JQUERY UI -->
    				<li><a href="#tabs-1">Ricerca Fermata Bus Firenze</a></li>
    				<li><a href="#tabs-2">Ricerca Servizi in Toscana</a></li>
  				</ul>
  			<div id="tabs-1">
    			<div class="use-case-1">
					Seleziona una linea:
					<br/>
					<select id="elencolinee" name="elencolinee" onchange="mostraElencoFermate(this);">
						<option value=""> - Seleziona una Linea - </option>
						<option value="all">TUTTE LE LINEE</option>
						<option value="LINE4">Linea 4</option>
						<option value="LINE6">Linea 6</option>
						<option value="LINE17">Linea 17</option>
						<option value="LINE23">Linea 23</option>
						<option value="LINE23">Linea 31</option>
					</select>
					<br />
					Seleziona una fermata:
					<br/>
					<select id="elencofermate" name="elencofermate" onchange="mostraFermate(this);">
						<option value=""> - Seleziona una Fermata - </option>
						
					</select>
				</div>
      		</div>
  			<div id="tabs-2">
			   <div class="use-case-2">
					Seleziona una provincia:
					<br/>
					<select id="elencoprovince" name="elencoprovince" onchange="mostraElencoComuni(this);">
						<option value=""> - Seleziona una Provincia - </option>
						<option value="all">TUTTE LE PROVINCE</option>
						<option value="AREZZO">AREZZO</option>
						<option value="FIRENZE">FIRENZE</option>
						<option value="GROSSETO">GROSSETO</option>
						<option value="LIVORNO">LIVORNO</option>
						<option value="LUCCA">LUCCA</option>
						<option value="MASSA-CARRARA">MASSA-CARRARA</option>
						<option value="PISA">PISA</option>
						<option value="PISTOIA">PISTOIA</option>
						<option value="PRATO">PRATO</option>
						<option value="SIENA">SIENA</option>
					</select>
					<br />
					Seleziona un comune:
					<br/>
					<select id="elencocomuni" name="elencocomuni" onchange="mostraComune(this);">
						<option value=""> - Seleziona un Comune - </option>
					</select>
				</div>
   			</div>
		</div>
		</div>
	</div>
	
	
	<!-- MENU DI RICERCA SERVIZI A DESTRA -->
	<div id="menu-dx" class="menu">
		<div class="header">
			<span>- Nascondi Menu</span>
    	</div>
    	<div class="content">
			Selezione Attuale:
			<br />
			<span id="selezione">Nessun punto selezionato</span>
			<h3>Cerca Attività</h3>
		
			Tipo Servizio:
			<br />
		
			<input type="checkbox" name="macro-select-all" id="macro-select-all" value="Select All" /> <span>De/Seleziona tutto</span>
 			<div id="categorie">
		
			<%
				// POPOLAZIONE DEI CHECKBOX DELLE SERVICE CATEGORY E DELLE SOTTOCATEGORIE
				Class.forName("com.mysql.jdbc.Driver");
				conMySQL = DriverManager.getConnection(url + db, user, pass);
		
				String query = "SELECT * FROM tbl_service_category ORDER BY ID ASC";
		
				// create the java statement
				st = conMySQL.createStatement();
		
				// execute the query, and get a java resultset
				rs = st.executeQuery(query);
		
				// iterate through the java resultset
				while (rs.next())
				{
					String id = rs.getString("ID");
					String nome = rs.getString("NOME");
					String colore = rs.getString("COLORE");
					String en_name = rs.getString("EN_NAME");
					String classe = rs.getString("CLASS");
					
					out.println("<input type='checkbox' name='" + en_name + "' value='" + en_name + "' class='macrocategory' /> <span class='" + classe + " macrocategory-label'>" + nome + "</span> <span class='toggle-subcategory' title='Mostra sottocategorie'>+</span>");
			 		out.println("<div class='subcategory-content'>");
			 		
			 		conMySQL2 = DriverManager.getConnection(url + db, user, pass);
		
					String query2 = "SELECT * FROM tbl_service_subcategory WHERE IDCATEGORY = " + id + " ORDER BY ID ASC";
		
					// create the java statement
					st2 = conMySQL2.createStatement();
		
					// execute the query, and get a java resultset
					rs2 = st2.executeQuery(query2);
		
					// iterate through the java resultset
					while (rs2.next())
					{
						String sub_nome = rs2.getString("NOME");
						String sub_en_name = rs2.getString("EN_NAME");
						String sub_numero = rs2.getString("NUMERO");
					
			 			out.println("<input type='checkbox' name='" + sub_nome + "' value='" + sub_nome + "' class='sub_" + classe + " subcategory' />");
			 			out.println("<span class='" + classe + " subcategory-label'>" + sub_numero + "- " + sub_nome + "</span>");
			 			out.println("<br />");		
					} 	
					out.println("</div>");
					out.println("<br />");
					
					st2.close();
			  		conMySQL2.close();
				}
				st.close();
		  		conMySQL.close();
			%>

		 	<br />
			<input type="checkbox" name="near-bus-stops" value="NearBusStops" class="macrocategory" /> <span class="near-bus-stops macrocategory-label">Fermate Autobus</span>
			</div>
			<hr />
 			Raggio di Ricerca: 
 			<br />
 			<select id="raggioricerca" name="raggioricerca">
				<option value="100">Entro 100 metri</option>
				<option value="200">Entro 200 metri</option>
				<option value="300">Entro 300 metri</option>
				<option value="500">Entro 500 metri</option>
			</select>
			<br />
			Numero massimo di risultati:
			<br />
 			<select id="numerorisultati" name="numerorisultati">
				<option value="100">100</option>
				<option value="200">200</option>
				<option value="500">500</option>
				<option value="0">Nessun Limite</option>
			</select>
			<br />
 			<hr />
 			<input type="button" value="Cerca!" id="pulsante-ricerca" onclick="ricercaServizi();" />
			<input type="button" value="Pulisci" id="pulsante-reset" onclick="resetTotale();" />
			<br />
		</div>
	</div>
		
		
	<!-- DIV DEL MENU CONTESTUALE IN BASSO A SINISTRA -->
	<div id="info-aggiuntive" class="menu">
		<div class="header">
			<span>- Nascondi Menu</span>
    	</div>
    	<div class="content">
		</div>
	</div>
	
	<!-- DIV SOVRASTANTE DI CARICAMENTO -->
	<div id="loading">
		<div id="messaggio-loading">
			<img src="${pageContext.request.contextPath}/img/ajax-loader.gif" width="32" />
			<h3>Caricamento in corso</h3>
			Il caricamento può richiedere del tempo
		</div>
	</div>
	
	<!--  CARICAMENTO DEL FILE utility.js CON FUNZIONI NECESSARIE  -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/utility.js"></script>
	
	<script>
	
	/***  codice per mantenere aperto più di un popup per volta ***/
	L.Map = L.Map.extend({
	    openPopup: function(popup) {
	        //        this.closePopup();  // just comment this
	        this._popup = popup;

	        return this.addLayer(popup).fire('popupopen', {
	            popup: this._popup
	        });
	    }
	}); 
	
	// CREAZIONE MAPPA CENTRATA NEL PUNTO
	var map = L.map('map').setView([43.3555664, 11.0290384], 8);
	
	// SCELTA DEL TILE LAYER ED IMPOSTAZIONE DEI PARAMETRI DI DEFAULT
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
		
	// DEFINIZIONE DEI CONFINI MASSIMI DELLA MAPPA
	var bounds = new L.LatLngBounds(new L.LatLng(41.7, 8.4), new L.LatLng(44.930222, 13.4));
	map.setMaxBounds(bounds);	
	
	// GENERAZIONE DEI LAYER PRINCIPALI
	var busStopsLayer = new L.LayerGroup();
	var servicesLayer = new L.LayerGroup();
	var clickLayer = new L.LayerGroup();
	var GPSLayer = new L.LayerGroup();
	
	// AGGIUNTA DEL PLUGIN PER LA GEOLOCALIZZAZIONE
	var GPSControl = new L.Control.Gps({
		maxZoom: 16,
		style: null
	}); 
	map.addControl(GPSControl);
	
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
	
	// DEFINIZIONE MARKERS DI DIFFERENTI COLORI 
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
	
	// AL CLICK CERCO L'INDIRIZZO APPROSSIMATIVO	
	 map.on('click', function (e) {
		 
	 	if (selezioneAttiva == true){
	 	
	 	if (ricercaInCorso == false){
	 	$('#raggioricerca').prop('disabled', false);
	 	$('#numerorisultati').prop('disabled', false);
	 	
	 	ricercaInCorso = true;
		$('#info-aggiuntive .content').html("Indirizzo Approssimativo: <img src=\"/WebAppGrafo/img/ajax-loader.gif\" width=\"16\" />");
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
			url : "${pageContext.request.contextPath}/ajax/get-address.jsp",
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
	}); 

	// VARIABILI PER LA FUNZIONALITA' DI RICERCA INDIRIZZO APPROSSIMATIVO
	var selezioneAttiva = false;
	var ricercaInCorso = false;
	
	$( document ).ready(function() {
		// all'apertura della pagina CREO LE TABS JQUERY UI NEL MENU IN ALTO
		$( "#tabs" ).tabs();
	});
	
	
	// VARIABILI PER LA FUNZIONALITA' DI RICERCA SERVIZI
	var selezione;
	var coordinateSelezione;
	var numeroRisultati;
	
	
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
	
	// MOSTRA ELENCO COMUNI DI UNA PROVINCIA
	function mostraElencoComuni(selectOption) {
		if (selectOption.options.selectedIndex != 0){	
			$('#elencolinee')[0].options.selectedIndex = 0;
			$('#elencofermate').html('<option value=""> - Seleziona una Fermata - </option>');
			$('#loading').show();
			$.ajax({
				url : "${pageContext.request.contextPath}/ajax/get-municipality-list.jsp",
				type : "GET",
				async: true,
				//dataType: 'json',
				data : {
					nomeProvincia: selectOption.options[selectOption.options.selectedIndex].value
				},
				success : function(msg) {
					$('#elencocomuni').html(msg);
					$('#loading').hide();
				}
			});
		}
	}
	
	
	
	// FUNZIONI DI RICERCA PRINCIPALI
	
	// MOSTRA AVM DI UNA PARTICOLARE FERMATA
function mostraAVMAJAX(nomeFermata){
	$('#info-aggiuntive .content').html("Ricerca AVM in corso: <img src=\"/WebAppGrafo/img/ajax-loader.gif\" width=\"16\" />");
	$.ajax({
		url : "${pageContext.request.contextPath}/ajax/get-avm.jsp",
		type : "GET",
		async: true,
		//dataType: 'json',
		data : {
			nomeFermata: nomeFermata
		},
		success : function(msg) {
			$('#info-aggiuntive .content').html(msg);		
		}	
	});
}
	// MOSTRA STATO OCCUPAZIONE DI UN PARCHEGGIO
function mostraParcheggioAJAX(nomeParcheggio){
	$.ajax({
		url : "${pageContext.request.contextPath}/ajax/get-parking-status.jsp",
		type : "GET",
		async: true,
		//dataType: 'json',
		data : {
			nomeParcheggio: nomeParcheggio
		},
		success : function(msg) {
			$('#info-aggiuntive .content').html(msg);
		}
	});
	}


	// MOSTRA ELENCO FERMATE DI UNA LINEA (DROPDOWN IN ALTO)
function mostraFermate(selectOption) {
	$('#info-aggiuntive .content').html('');
	if (selectOption.options.selectedIndex != 0){	
		
		GPSControl._isActive = false;
		svuotaLayers();
		$('#loading').show();
		if (selectOption.options[selectOption.options.selectedIndex].value == 'all'){
	
		$('#raggioricerca').prop('disabled', 'disabled');
		$('#raggioricerca')[0].options.selectedIndex = 0;
		$('#numerorisultati').prop('disabled', 'disabled');
		$('#numerorisultati')[0].options.selectedIndex = 0;
		/* TEMPORANEAMENTE DISABILITATO (FUNZIONALITA' PER LA VISUALIZZAZIONE DI UNA ROUTE COME ELENCO DI SEGMENTI)
		if ($('#elencolinee')[0].options[$('#elencolinee')[0].options.selectedIndex].value == 'LINE17'){
			// SE E' LA LINEA 17 FACCIO VEDERE LE ROUTESECTION
			
			$.ajax({
				url : "${pageContext.request.contextPath}/ajax/json/get-bus-route.jsp",
				type : "GET",
				async: true,
				dataType: 'json',
				data : {
					numeroRoute: '438394'
				},
				success : function(msg) {
					var busRouteLayer = L.geoJson(msg).addTo(map);	
				}
			});	  
		}
		
		*/
		$.ajax({
			url : "${pageContext.request.contextPath}/ajax/json/get-bus-stops-of-line.jsp",
			type : "GET",
			async: true,
			dataType: 'json',
			data : {
				nomeLinea: $('#elencolinee')[0].options[$('#elencolinee')[0].options.selectedIndex].value
			},
			success : function(msg) {
				selezione = 'Linea Bus: ' + $('#elencolinee')[0].options[$('#elencolinee')[0].options.selectedIndex].value;
				$('#selezione').html(selezione);
				coordinateSelezione = "";
				busStopsLayer = L.geoJson(msg, {
					pointToLayer: function(feature, latlng) {
				    	return new L.Marker(latlng, {icon: markerBusStops});
				    },
				onEachFeature: function(feature, layer){
					var popupContent = "FERMATA : " + feature.properties.popupContent + "<br />";
					popupContent += "<a href='http://log.disit.org/service/?sparql=http%3A%2F%2F150.217.15.64%2Fopenrdf-workbench%2Frepositories%2Fsiimobilityultimate%2Fquery&uri=" + feature.properties.serviceId + "' title='Linked Open Graph' target='_blank'>LINKED OPEN GRAPH</a>";
				
					layer.bindPopup(popupContent);
					layer.on({
						//mouseover: aggiornaAVM
					});
				},
			}).addTo(map);
				//map.setView(new L.LatLng(latBusStop, longBusStop), 16);
				var confiniMappa = busStopsLayer.getBounds();
				map.fitBounds(confiniMappa, {padding: [50, 50]});
				$('#loading').hide();
				
			},
			error: function (request, status, error) {
				$('#loading').hide();
		    }
		});
	}
	else{
	 	$('#raggioricerca').prop('disabled', false);
	 	$('#numerorisultati').prop('disabled', false);
		$.ajax({
			url : "${pageContext.request.contextPath}/ajax/json/get-bus-stop.jsp",
			type : "GET",
			async: true,
			dataType: 'json',
			data : {
				nomeFermata: selectOption.options[selectOption.options.selectedIndex].value
			},
			success : function(msg) {
				
				//$('#elencofermate').html(msg);
				selezione = 'Fermata Bus: ' + selectOption.options[selectOption.options.selectedIndex].value;
				$('#selezione').html(selezione);
				var longBusStop = msg.features[0].geometry.coordinates[0];
				var latBusStop = msg.features[0].geometry.coordinates[1];
				coordinateSelezione = latBusStop + ";" + longBusStop;
				busStopsLayer = L.geoJson(msg, {
					pointToLayer: function(feature, latlng) {
				    	return new L.Marker(latlng, {icon: markerBusStops});
				    },
				onEachFeature: function(feature, layer){
					var popupContent = "FERMATA : " + feature.properties.popupContent + "<br />";
					popupContent += "<a href='http://log.disit.org/service/?sparql=http%3A%2F%2F150.217.15.64%2Fopenrdf-workbench%2Frepositories%2Fsiimobilityultimate%2Fquery&uri=" + feature.properties.serviceId + "' title='Linked Open Graph' target='_blank'>LINKED OPEN GRAPH</a>";
					
					
					layer.bindPopup(popupContent);
					layer.on({
						//mouseover: aggiornaAVM
					});	
				},			
			}).addTo(map);
				map.setView(new L.LatLng(latBusStop, longBusStop), 16);
				$('#loading').hide();
			}
		});
	}
	}
}

// FUNZIONE JAVASCRIPT ASSOCIATA AL PULSANTE 'CERCA!'
// IN BASE ALLA SELEZIONE ATTUALE EFFETTUA UNA RICERCA DI TIPO PUNTUALE, ALL'INTERNO DI UN COMUNE
// O SU TUTTE LE FERMATE DI UNA LINEA
function ricercaServizi(nomeFermata) {
	// CONTROLLO CHE CI SIA QUALCOSA SELEZIONATO
	if (selezione != '' && undefined != selezione){
		// ESTRAGGO LE CATEGORIE SELEZIONATE
		var categorie = [];
	    $('#categorie :checked').each(function() {
	      categorie.push($(this).val());
	    });
	    var stringaCategorie = categorie.join(";");
	    if (stringaCategorie == ""){
	    	alert("Selezionate almeno una categoria nel menu di destra");
	    }
	    else{
		    $('#loading').show();
		    // SVUOTO LA MAPPA DAI PUNTI PRECEDENTEMENTE DISEGNATI
		    if (selezione.indexOf("Linea Bus:") == -1){
		    	svuotaLayers();
		    }
		    // SE TUTTI I CONTROLLI SONO ANDATI A BUON FINE RICHIAMA LA FUNZIONE mostraServiziAJAX_new
// 			mostraServiziAJAX_new(stringaCategorie, selezione, coordinateSelezione, $('#elencocomuni')[0]);
		}
	}
	else{
		alert("Attenzione, non è stata selezionata alcuna risorsa di partenza per la ricerca");
	}	
}

// FUNZIONE PRINCIPALE DI RICERCA SERVIZI
function mostraServiziAJAX_new(categorie, selezione, coordinateSelezione, selectOption){
	$('#info-aggiuntive .content').html('');
	numeroRisultati = $('#numerorisultati')[0].options[$('#numerorisultati')[0].options.selectedIndex].value;
	var centroRicerca;
	// IN BASE AL CONTENUTO DELLA VARIABILE selezione VIENE ESEGUITA UNA RICERCA DIVERSA 
	if (coordinateSelezione != "" && undefined != coordinateSelezione){
		if (coordinateSelezione == "Posizione Attuale"){
			// SE HO RICHIESTO LA POSIZIONE ATTUALE ESTRAGGO LE COORDINATE
			centroRicerca = GPSControl._currentLocation.lat + ";" + GPSControl._currentLocation.lng;	
		}	
		if (selezione.indexOf("Fermata Bus:") != -1){
			centroRicerca = coordinateSelezione;
			
		}
		if (selezione.indexOf("Coord:") != -1){
			centroRicerca = coordinateSelezione;
		}
		if (selezione.indexOf("Servizio:") != -1){
			centroRicerca = coordinateSelezione;
		}
	
		// FUNZIONE AJAX DI CARICAMENTO SERVIZI ATTORNO AD UN PUNTO
		$.ajax({
			url : "${pageContext.request.contextPath}/ajax/json/get-services.jsp",
			type : "GET",
			async: true,
			dataType: 'json',
			data : {
				
				centroRicerca: centroRicerca,
				raggio: $('#raggioricerca')[0].options[$('#raggioricerca')[0].options.selectedIndex].value,
				categorie: categorie,
				numerorisultati: numeroRisultati
			},
			success : function(msg) {
				// IN CASO DI SUCCESSO DELLA RICHIESTA
				var numeroServizi = 0;
				var numeroBus = 0;
				$('#loading').hide();
				if (msg.features.length > 0){
					//SE HO ALMENO UN RISULTATO AGGIUNGO IL LAYER ALLA MAPPA
					servicesLayer = L.geoJson(msg, {
				    	pointToLayer: function(feature, latlng) {
				    		// AD OGNI PUNTO ASSOCIO UN MARKER DIVERSO IN BASE ALLA MACROCATEGORIA
				    		// LA FUNZIONE switchCategorie è nel file /js/utility.js
				    		var tipoMarker = switchCategorie(feature.properties.tipo);
				    		return new L.Marker(latlng, {icon: tipoMarker});
				    	},
				    	onEachFeature: function (feature, layer) {
							// POPOLAZIONE POPUP DI OGNI ELEMENTO RITROVATO
					    	if (feature.properties.tipo != 'fermata'){
						    	contenutoPopup = "<h3>" + feature.properties.nome + "</h3>";
						    	contenutoPopup = contenutoPopup + "Tipologia: " + feature.properties.tipo + "<br />";
						    	contenutoPopup = contenutoPopup + "Email: " + feature.properties.email + "<br />";
						    	contenutoPopup = contenutoPopup + "Indirizzo: " + feature.properties.indirizzo + "<br />";
						    	contenutoPopup = contenutoPopup + "Note: " + feature.properties.note + "<br />";
						    	contenutoPopup = contenutoPopup + "<a href='http://log.disit.org/service/?sparql=http%3A%2F%2F150.217.15.64%2Fopenrdf-workbench%2Frepositories%2Fsiimobilityultimate%2Fquery&uri=" + feature.properties.serviceId + "' title='Linked Open Graph' target='_blank'>LINKED OPEN GRAPH</a>";
						    	numeroServizi++;
					    	}
					    	else{
					    		contenutoPopup = "Fermata: " + feature.properties.nome + "<br />";
					    		contenutoPopup = contenutoPopup + "<a href='http://log.disit.org/service/?sparql=http%3A%2F%2F150.217.15.64%2Fopenrdf-workbench%2Frepositories%2Fsiimobilityultimate%2Fquery&uri=" + feature.properties.serviceId + "' title='Linked Open Graph' target='_blank'>LINKED OPEN GRAPH</a>";
					    		numeroBus++;
					    	}
				    		layer.bindPopup(contenutoPopup);
				    }
				}).addTo(map);
				// CENTRATURA E ZOOMATURA MAPPA IN BASE AI RISULTATI
				var confiniMappa = servicesLayer.getBounds();
				map.fitBounds(confiniMappa, {padding: [50, 50]});
				if (msg.features.length < numeroRisultati || numeroRisultati == 0){
					// MESSAGGIO DI AVVISO NUMERO RISULTATI
					alert(numeroServizi + " servizi e " + numeroBus + " fermate autobus recuperati");
				}
				else{
					alert("La ricerca è stata limitata a " + numeroServizi + " servizi e " + numeroBus + " fermate autobus. E' possibile aumentare il limite massimo di risultati tramite il menu a destra");
				}
				}
				else{
					alert("La ricerca non ha prodotto risultati");
				}
			},
			error: function (request, status, error) {
				// IN CASO DI ERRORE MOSTRO SULLA CONSOLE L'ERRORE e A VIDEO UN MESSAGGIO DI AVVISO
				$('#loading').hide();
				console.log(error);
				alert('Si è verificato un errore');
		    }
		});
	}
	else{
		// caso tutte le fermate oppure ricerca per comune
		if (selezione.indexOf("COMUNE di") != -1){
			// RICERCA SERVIZI IN COMUNE
			$.ajax({
				url : "${pageContext.request.contextPath}/ajax/json/get-services-in-municipality.jsp",
				type : "GET",
				async: true,
				dataType: 'json',
				data : {
					nomeProvincia: $('#elencoprovince')[0].options[$('#elencoprovince')[0].options.selectedIndex].value,
					nomeComune: selectOption.options[selectOption.options.selectedIndex].value,
					categorie: categorie,
					numerorisultati: numeroRisultati
				},
				success : function(msg) {
					// IN CASO DI SUCCESSO
					if (selectOption.options[selectOption.options.selectedIndex].value != 'all'){
						// RICERCA DATI METEO DEL COMUNE
						$.ajax({
							url : "${pageContext.request.contextPath}/ajax/get-weather.jsp",
							type : "GET",
							async: true,
							//dataType: 'json',
							data : {
								nomeComune: selectOption.options[selectOption.options.selectedIndex].value
							},
							success : function(msg) {
								$('#info-aggiuntive .content').html(msg);
							}
						});
						}
					
					$('#loading').hide();
					
					if (msg.features.length > 0){
					// SE HO ALMENO UN RISULTATO AGGIUNGO IL LAYER ALLA MAPPA
					var numeroServizi = 0;
					var numeroBus = 0;
						servicesLayer = L.geoJson(msg, {
						// AD OGNI PUNTO ASSOCIO UN MARKER DIVERSO IN BASE ALLA MACROCATEGORIA
				    	// LA FUNZIONE switchCategorie è nel file /js/utility.js
					    pointToLayer: function(feature, latlng) {
					    	var tipoMarker = switchCategorie(feature.properties.tipo);
					    	return new L.Marker(latlng, {icon: tipoMarker});
					    },
					    onEachFeature: function (feature, layer) {
					    	// POPOLAZIONE POPUP DI OGNI ELEMENTO RITROVATO
					    	contenutoPopup = "<h3>" + feature.properties.nome + "</h3>";
					    	contenutoPopup = contenutoPopup + "Tipologia: " + feature.properties.tipo + "<br />";
					    	contenutoPopup = contenutoPopup + "Email: " + feature.properties.email + "<br />";
					    	contenutoPopup = contenutoPopup + "Indirizzo: " + feature.properties.indirizzo + "<br />";
					    	contenutoPopup = contenutoPopup + "Note: " + feature.properties.note + "<br />";
					    	contenutoPopup = contenutoPopup + "<a href='http://log.disit.org/service/?sparql=http%3A%2F%2F150.217.15.64%2Fopenrdf-workbench%2Frepositories%2Fsiimobilityultimate%2Fquery&uri=" + feature.properties.serviceId + "' title='Linked Open Graph' target='_blank'>LINKED OPEN GRAPH</a>";
					        layer.bindPopup(contenutoPopup);
					        if (feature.properties.tipo == "fermata"){
					        	numeroBus++;
					        }
					        else{
					        	numeroServizi++;
					        }	
					    }
					}).addTo(map);
					
					// centratura e zoomatura della mappa in base ai risultati
					var confiniMappa = servicesLayer.getBounds();
					map.fitBounds(confiniMappa, {padding: [50, 50]});
					// AVVISO NUMERO DI RISULTATI
					if (msg.features.length < numeroRisultati || numeroRisultati == 0){
						
						alert(numeroServizi + " servizi e " + numeroBus + " fermate autobus recuperati");
					}
					else{
						alert("La ricerca è stata limitata a " + numeroServizi + " servizi e " + numeroBus + " fermate autobus. E' possibile aumentare il limite massimo di risultati tramite il menu a destra");
					}
					}
					else{
						alert("La ricerca non ha prodotto risultati");
					}
				},
				error: function (request, status, error) {
					// IN CASO DI ERRORE MOSTRO UN MESSAGGIO DI AVVISO MA CARICO LO STESSO I DATI METEO
					//console.log(error);
					if (selectOption.options[selectOption.options.selectedIndex].value != 'all'){
						$.ajax({
							url : "${pageContext.request.contextPath}/ajax/get-weather.jsp",
							type : "GET",
							async: true,
							//dataType: 'json',
							data : {
								nomeComune: selectOption.options[selectOption.options.selectedIndex].value
							},
							success : function(msg) {
								$('#info-aggiuntive .content').html(msg);
							}
						});
						}
					$('#loading').hide();
					console.log(error);
					alert('Si è verificato un errore');
			    }
			});
		}
		if (selezione.indexOf("Linea Bus:") != -1){
			// RICERCA DI TUTTI I SERVIZI A MASSIMO 100 METRI DA TUTTE LE FERMATE DI UNA LINEA
			$.ajax({
				url : "${pageContext.request.contextPath}/ajax/json/get-services-near-stops.jsp",
				type : "GET",
				async: true,
				dataType: 'json',
				data : {
					
					nomeLinea: $('#elencolinee')[0].options[$('#elencolinee')[0].options.selectedIndex].value,
					raggio: 100,
					categorie: categorie,
					numerorisultati: 100
				},
				success : function(msg) {
					// IN CASO DI SUCCESSO NELLA RICHIESTA
					$('#loading').hide();
					if (msg.features.length > 0){
						// SE C'E' ALMENO UN RISULTATO AGGIUNGO IL LAYER ALLA MAPPA
						servicesLayer = L.geoJson(msg, {
					 
					    pointToLayer: function(feature, latlng) {
					    	var tipoMarker = switchCategorie(feature.properties.tipo);
					    	return new L.Marker(latlng, {icon: tipoMarker});  
					    },
					    onEachFeature: function (feature, layer) {
					    	// POPOLAZIONE POPUP PER OGNI ELEMENTO
					    	contenutoPopup = "<h3>" + feature.properties.nome + "</h3>";
					    	contenutoPopup = contenutoPopup + "Tipologia: " + feature.properties.tipo + "<br />";
					    	contenutoPopup = contenutoPopup + "Email: " + feature.properties.email + "<br />";
					    	contenutoPopup = contenutoPopup + "Indirizzo: " + feature.properties.indirizzo + "<br />";
					    	contenutoPopup = contenutoPopup + "Note: " + feature.properties.note + "<br />";
					    	contenutoPopup = contenutoPopup + "<a href='http://log.disit.org/service/?sparql=http%3A%2F%2F150.217.15.64%2Fopenrdf-workbench%2Frepositories%2Fsiimobilityultimate%2Fquery&uri=" + feature.properties.serviceId + "' title='Linked Open Graph' target='_blank'>LINKED OPEN GRAPH</a>";
					        layer.bindPopup(contenutoPopup);
					    }
					}).addTo(map);
					
					// CENTRATURA E ZOOMATURA
					var confiniMappa = servicesLayer.getBounds();
					map.fitBounds(confiniMappa, {padding: [50, 50]});
					// AVVISO NUMERO SERVIZI TROVATI
					alert(msg.features.length + " servizi recuperati");
					
					}
					else{
						alert("La ricerca non ha prodotto risultati");
					}
				},
				error: function (request, status, error) {
					$('#loading').hide();
					console.log(error);
					alert('Si è verificato un errore');
			    }
			});
			
		}
		
	}
		
	}


// CLICCANDO SUL PULSANTE GPS VENGONO SALVATE LE COORDINATE ATTUALI PER LA RICERCA DI SERVIZI
$('.gps-button').click(function(){
	if (GPSControl._isActive == true){
		selezione = 'Posizione Attuale';
		$('#selezione').html(selezione);
		coordinateSelezione = "Posizione Attuale";
		$('#raggioricerca').prop('disabled', false);
		$('#numerorisultati').prop('disabled', false);
	}
});


// FUNZIONE DI RICERCA DEI SERVIZI ALL'INTERNO DI UN COMUNE
function mostraComune(selectOption) {
	$('#raggioricerca')[0].options.selectedIndex = 0;
	$('#raggioricerca').prop('disabled', 'disabled');
	selezione = "COMUNE di " + selectOption.options[selectOption.options.selectedIndex].value;
	$('#selezione').html(selezione);
	if (selectOption.options.selectedIndex != 0){
		var categorie = [];
	    $('#categorie :checked').each(function() {
	      categorie.push($(this).val());
	    });
	    var stringaCategorie = categorie.join(";");
		if (stringaCategorie == ""){
			alert("Selezionate almeno una categoria nel menu di destra");
		}
		else{
			$('#loading').show();
			svuotaLayers();
		    coordinateSelezione = null;
		    mostraServiziAJAX_new(stringaCategorie, selezione, coordinateSelezione, selectOption);
		}
	}
}

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




</script>
	
</body>
</html>