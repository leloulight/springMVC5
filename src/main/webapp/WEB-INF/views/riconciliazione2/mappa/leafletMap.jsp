
<%--
  Created by IntelliJ IDEA.
  User: Marco
  Date: 15/06/2015
  Time: 14.11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <!-- SUPPPORT CSS LIBRARY -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery-ui1.10.04.css" />
    <link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">

    <!-- PLUGIN LEAFLET CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/leaflet.awesome-markers.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/coordinates/Leaflet.Coordinates-0.1.4.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/coordinates/Leaflet.Coordinates-0.1.4.ie.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/gps/leaflet-gps.css"/>
    <%--<link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/0.4.0/MarkerCluster.css" />--%>
    <%--<link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/0.4.0/MarkerCluster.Default.css" />--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/markercluster/MarkerCluster.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/markercluster/MarkerCluster.Default.css" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/leaflet-locatecontrol-gh-pages/L.Control.Locate.ie.scss" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/leaflet-locatecontrol-gh-pages/L.Control.Locate.mapbox.scss" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/leaflet-locatecontrol-gh-pages/L.Control.Locate.scss"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/label/leaflet.label.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/search/leaflet-search.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/search/leaflet-search.mobile.css"/>
    <!-- OTHER CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css"/>
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/leaflet-0.7.3.css" />
    <!--[if lte IE 8]><link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.6.4/leaflet.ie.css" /><![endif]-->

    <!-- CONFIG FILE WITH VARISABLES ALREADY SETTED (not used)-->
    <%--<script src="${pageContext.request.contextPath}/resources/js/config/config.js"></script>--%>
    <!-- Leaflet JS -->
    <script src="${pageContext.request.contextPath}/resources/js/leaflet/leaflet-0.7.3.js"></script>
    <!--[if lte IE 8]><link rel="stylesheet" href="http://leaflet.cloudmade.com/dist/leaflet.ie.css" /><![endif]-->
    <!-- SUPPORT JQUERY,Boostrap LIBRARY -->
    <%--<script href='http://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js'></script>
    <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery/jquery.csv-0.71.js"></script>
    <script src="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>--%>

    <script src="${pageContext.request.contextPath}/resources/js/jquery/jquery2.1.4.min.js"></script>
    <%--<script src="${pageContext.request.contextPath}/resources/js/jquery/jquery-1.10.1.min.js"></script>--%>
    <script src="${pageContext.request.contextPath}/resources/js/jquery/jquery-migrate-1.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery/jquery-ui1.10.4.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery/jquery.csv-0.71.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery/bootstrap2.3.2.min.js"></script>

    <%-- Script Javascript leaflet plugin --%>
    <script src="${pageContext.request.contextPath}/resources/js/leaflet/plugin/awesome-markers/leaflet.awesome-markers.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/leaflet/plugin/gps/leaflet-gps.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/leaflet/plugin/coordinates/Leaflet.Coordinates-0.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/leaflet/plugin/markercluster/leaflet.markercluster.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/leaflet/plugin/stamen-base-maps/tile.stamenv1.3.0.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/leaflet/plugin/leaflet-locatecontrol-gh-pages/L.Control.Locate.js"></script>


    <script src="${pageContext.request.contextPath}/resources/js/leaflet/plugin/label/Label.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/leaflet/plugin/label/BaseMarkerMethods.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/leaflet/plugin/label/Marker.Label.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/leaflet/plugin/label/CircleMarker.Label.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/leaflet/plugin/label/Path.Label.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/leaflet/plugin/label/Map.Label.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/leaflet/plugin/label/FeatureGroup.Label.js"></script>

    <script src="${pageContext.request.contextPath}/resources/js/leaflet/plugin/geocsv/leaflet.geocsv-src.js"></script>

    <script src="${pageContext.request.contextPath}/resources/js/leaflet/plugin/search/leaflet-search.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/leaflet_buildMap_support.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/utility_leaflet_csv.js"></script>
  <title></title>
</head>
<body>
    <div id="map"></div>
    <script>
        leaflet_buildMap_support.initMap();
    </script>
    <%--<div id="caricamento">Caricamento...</div>--%>

    <%-- Script support GTFS --%>
   <%-- <script src="${pageContext.request.contextPath}/resources/js_utility/gtfsViewer/zip.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js_utility/gtfsViewer/d3.v3.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js_utility/gtfsViewer/gtfsParser.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js_utility/gtfsViewer/gtfsLeaflet.js"></script>--%>

<!-- PULSANTI IN ALTO A SINISTRA (HELP E SELEZIONE PUNTO MAPPA) -->
<%--<div class="menu" id="help">
    <a href="http://www.disit.org/servicemap" title="Aiuto Service Map" target="_blank"><img src="${pageContext.request.contextPath}/resources/img/help.png" alt="help SiiMobility ServiceMap" width="26" /></a>
</div>--%>
<div class="menu" id="info">
    <img src="${pageContext.request.contextPath}/resources/img/info.png" alt="Seleziona un punto della mappa" width="26" />
</div>


<!-- DIV CONTENENTE IL MENU IN ALTO A SINISTRA -->
<div id="menu-alto" class="menu">
    <div class="header"><span>- Nascondi Menu</span>
    </div>
    <div class="content">
        <div id="tabs">
            <ul>
                <!-- ELENCO DELLE DUE TAB JQUERY UI -->
                <li><a href="#tabs-1">Ricerca Web-Geolocalizzazione</a></li>
                <li><a href="#tabs-2">Ricerca Servizi in Toscana</a></li>
                <li><a href="#tabs-3">Importa Markers</a></li>
                <li><a href="#tabs-4">Ricerca Markers</a></li>
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
                    <br />Seleziona un comune:<br/>
                    <select id="elencocomuni" name="elencocomuni" onchange="mostraComune(this);">
                        <option value=""> - Seleziona un Comune - </option>
                    </select>
                    <br />
                </div>
            </div>
            <div id="tabs-3">
                <div class="use-case-3">
                    UPLOAD a CSV File.
                    <br />Set Field Separator CSV file (default "|"):<input id="fieldSeparator" type="text" name="fieldSeparatorCSVParam" value="" maxlength="1" size="1"/>
                    <br />Set Line Separator CSV file (default "\n"):<input id="lineSeparator" type="text" name="lineSeparatorCSVParam" value="" maxlength="1" size="1"/>
                    <br />Choose CSV file:<input type="file" id="uploader" name="files[]" multiple accept="text/csv">
                    <%--<div id="buttonLocalize2">
                        <button id="localizeName2" class="buttonLocalizeName2">Cercando Località</button><br />
                    </div>--%>
                    <br />Inserisci un URL:
                    <c:url var="url" value="/map3" />
                    <form:form action="${url}" method="post" >
                        <input type="text" name="urlParam" value="" />
                        <c:if test="${(not empty arrayMarker) && (arrayMarker.size() >= indiceMarker)}" >
                            <input id="arrayMarkerForm" name="arrayMarkerParam" type="hidden" value="<c:out value="${arrayMarker}" />"/>
                            LENGTH OF MARKERS: ${arrayMarker.size()}
                            <c:forEach items="${arrayMarker}" var="idMarker">
                                <p id="marker">
                                    <input id="nameForm" name="nameParam" type="hidden" value="<c:out value="${idMarker.name}" />"/>
                                    <input id="urlForm" name="urlParam" type="hidden" value="<c:out  value="${idMarker.url}" />"/>
                                    <input id="latForm" name="latParam" type="hidden" value="<c:out  value="${idMarker.latitude}" />"/>
                                    <input id="lngForm" name="lngParam" type="hidden" value="<c:out  value="${idMarker.longitude}" />"/>
                                    <input id="regionForm" name="regionParam" type="hidden" value="<c:out  value="${idMarker.markerInfo.region}" />"/>
                                    <input id="provinceForm" name="provinceParam" type="hidden" value="<c:out  value="${idMarker.markerInfo.province}" />"/>
                                    <input id="cityForm" name="cityParam" type="hidden" value="<c:out  value="${idMarker.markerInfo.city}" />"/>
                                    <input id="addressForm" name="addressParam" type="hidden" value="<c:out  value="${idMarker.markerInfo.address}" />"/>
                                    <input id="phoneForm" name="phoneParam" type="hidden" value="<c:out  value="${idMarker.markerInfo.phone}" />"/>
                                    <input id="emailForm" name="emailParam" type="hidden" value="<c:out  value="${idMarker.markerInfo.email}" />"/>
                                    <input id="faxForm" name="faxParam" type="hidden" value="<c:out  value="${idMarker.markerInfo.fax}" />"/>
                                    <input id="ivaForm" name="ivaParam" type="hidden" value="<c:out  value="${idMarker.markerInfo.iva}" />"/>
                                </p>
                                <script>
                                    //leaflet_buildMap_support.initMap();
                                    leaflet_buildMap_support.pushMarkerToArrayMarker(
                                            "${idMarker.name}","${idMarker.url}","${idMarker.latitude}","${idMarker.longitude}",
                                            "${idMarker.markerInfo.region}","${idMarker.markerInfo.province}","${idMarker.markerInfo.city}",
                                            "${idMarker.markerInfo.address}","${idMarker.markerInfo.phone}","${idMarker.markerInfo.email}",
                                            "${idMarker.markerInfo.fax}","${idMarker.markerInfo.iva}");
                                </script>
                            </c:forEach>
                        </c:if>
                        <input type="submit" name="urlFormParam" value="urlForm" />
                    </form:form>
                    <ul>
                        <li>Name:<c:out value="${marker.name}"/></li>
                        <li>URL:<c:out value="${marker.url}"/></li>
                        <li>LAT:<c:out value="${marker.latitude}"/></li>
                        <li>LNG:<c:out value="${marker.longitude}"/></li>
                    </ul>

                    <c:url var="url2" value="/map4" />
                    <form:form action="${url2}" method="post" onSubmit="getMarkers();">
                        <div id="loadMarker">
                                <%--<input type="button" value="Get Markers" id="getMarkers"  />--%>
                            <input type="submit" name="GetMarkersParam" value="getMarkers" />
                        </div>
                    </form:form>
                </div>
            </div>
            <div id="tabs-4">
                <div class="use-case-4">
                    <br/>
                    <label>Search Marker 1:</label>
                    <div id="filter-container">
                        <form class="form-search" class="noSelect" onSubmit="addCsvMarkers(); return false;">
                            <a href="#" id="clear" class="leaflet-popup-close-button">&#215;</a>
                            <div class="input-append">
                                <input type="text" id="filter-string" class="input-medium search-query search-box" autocomplete="off">
                                <button type="submit" class="btn search-box"><i class="icon-search"></i></button>
                                <!-- <span class="add-on">
                                </span> -->
                            </div>
                        </form>
                        <div id="search-results" class="leaflet-control-attribution leaflet-control pull-right"></div>
                    </div>
                    <label>Search Marker 2:</label>
                    <div id="formsearch" style="margin: 0 2em 1em 2em;float:left">
                        <label>Search <input id="textsearch" type="text" value="" /></label>
                    </div>
                    <br />
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
            <!-- CODE CONNECTION MYSQL-->
            ${HTML}
            <!-- END OF THE CONNECTION -->
            <br />
            <input type="checkbox" name="near-bus-stops" value="NearBusStops" class="macrocategory" />
            <span class="near-bus-stops macrocategory-label">Fermate Autobus</span>
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
        <input type="button" value="Clean Map" id="pulsante-reset"  />
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
        <img src="${pageContext.request.contextPath}/resources/img/ajax-loader.gif" width="32" />
        <h3>Caricamento in corso</h3>
        Il caricamento può richiedere del tempo
    </div>
</div>



</body>
</html>

