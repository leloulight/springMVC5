
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
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/leaflet.awesome-markers.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/leaflet/plugin/coordinates/Leaflet.Coordinates-0.1.4.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/leaflet/plugin/coordinates/Leaflet.Coordinates-0.1.4.ie.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/leaflet/plugin/gps/leaflet-gps.css"/>
    <%--<link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/0.4.0/MarkerCluster.css" />--%>
    <%--<link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/0.4.0/MarkerCluster.Default.css" />--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/leaflet/plugin/markercluster/MarkerCluster.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/leaflet/plugin/markercluster/MarkerCluster.Default.css" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css"/>

    <%-- Leaflet  --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/leaflet/leaflet-0.7.3.css" />
    <script src="${pageContext.request.contextPath}/resources/leaflet/leaflet-0.7.3.js"></script>


    <!-- SUPPORT JQUERY LIBRARY -->
    <script href='http://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js'></script>
    <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>

    <%-- Script Javascript leaflet plugin --%>
    <script src="${pageContext.request.contextPath}/resources/leaflet/plugin/awesome-markers/leaflet.awesome-markers.min.js"></script>

    <script src="${pageContext.request.contextPath}/resources/leaflet/plugin/gps/leaflet-gps.js"></script>

    <script src="${pageContext.request.contextPath}/resources/leaflet/plugin/coordinates/Leaflet.Coordinates-0.1.4.min.js"></script>

    <script src="${pageContext.request.contextPath}/resources/leaflet/plugin/markercluster/leaflet.markercluster.js"></script>
  <title></title>
</head>
<!-- DIV PRINCIPALE CONTENENTE LA MAPPA INTERATTIVA -->
<%--<script>
    $.getScript("resources/js_utility/leaflet_buildMap_support.js",function(){
        initMap22();
    });
</script>--%>

   <%-- <script type="text/javascript">
        var name = <c:out value="${marker.name}"/>;
        var url = <c:out value="${marker.url}"/>;
        var lat = <c:out value="${marker.latitude}"/>;
        var lng = <c:out value="${marker.longitude}"/>;
        window.alert(name);
        window.alert(${marker.name});
        var marker = askForPlots3(name,url,lat,lng);
        $('#marker').append('<input type="hidden" name="markerParam" value="'+marker+'"/>');
    </script>--%>


    <div id="map"></div>

<%--<div id="map" style="width: 800px; height: 500px; border: 1px solid #AAA;"></div>--%>

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
            </ul>
            <div id="tabs-1">
                <div class="use-case-1">
                    Inserisci un URL:
                    <%--<c:if test="${empty marker.name}" >--%>
                        <c:if test="${empty marker.url}" >
                            <c:url var="url" value="/map2" />
                            <form:form action="${url}" method="post" >
                                <%-- Pass the string value like input --%>
                                <p>
                                    <input type="text" name="urlParam" value="" />
                                    <input type="submit" name="urlFormParam" value="urlForm" />
                                </p>
                            </form:form>
                        </c:if>
                        <c:if test="${urlJava==''}" >
                            <c:url var="url" value="/map2" />
                            <form:form action="${url}" method="post" >
                                <%-- Pass the string value like input --%>
                                <p>
                                    <input type="text" name="urlParam" value="" />
                                    <input type="submit" name="urlFormParam" value="urlForm" />
                                </p>
                            </form:form>
                        </c:if>
                    <%--</c:if>--%>
                    <c:if test="${not empty marker.url}" >
                        <c:url var="url2" value="/map22" />
                        <form:form action="${url2}" method="post" >
                            <p id="marker">
                                <input type="text" name="urlParam" value="" />
                                <%-- Return from javascript a marker value and pass to controller --%>
                                <%--<input id="nameForm" type="hidden" value="<c:set var='nameVar' value='${marker.name}' />"/>
                                <input id="urlForm" type="hidden" value="<c:set var='urlVar' value='${marker.url}' />"/>
                                <input id="latForm" type="hidden" value="<c:set var='latVar' value='${marker.latitude}' />"/>
                                <input id="lngForm" type="hidden" value="<c:set var='lngVar' value='${marker.longitude}' />"/>--%>
                                <input id="nameForm" name="nameParam" type="hidden" value="<c:out value="${marker.name}" />"/>
                                <input id="urlForm" name="urlParam" type="hidden" value="<c:out  value="${marker.url}" />"/>
                                <input id="latForm" name="latParam" type="hidden" value="<c:out  value="${marker.latitude}" />"/>
                                <input id="lngForm" name="lngParam" type="hidden" value="<c:out  value="${marker.longitude}" />"/>
                                <%-- Marker Infor information --%>
                                <input id="regionForm" name="regionParam" type="hidden" value="<c:out  value="${marker.markerInfo.region}" />"/>
                                <input id="provinceForm" name="provinceParam" type="hidden" value="<c:out  value="${marker.markerInfo.province}" />"/>
                                <input id="cityForm" name="cityParam" type="hidden" value="<c:out  value="${marker.markerInfo.city}" />"/>
                                <input id="addressForm" name="addressParam" type="hidden" value="<c:out  value="${marker.markerInfo.address}" />"/>
                                <input id="phoneForm" name="phoneParam" type="hidden" value="<c:out  value="${marker.markerInfo.phone}" />"/>
                                <input id="emailForm" name="emailParam" type="hidden" value="<c:out  value="${marker.markerInfo.email}" />"/>
                                <input id="faxForm" name="faxParam" type="hidden" value="<c:out  value="${marker.markerInfo.fax}" />"/>
                                <input id="ivaForm" name="ivaParam" type="hidden" value="<c:out  value="${marker.markerInfo.iva}" />"/>
                            </p>
                            <input type="submit" id="markerFormParam" name="markerFormParam" value="markerForm" />
                        </form:form>
                    </c:if>
                    <p>
                    <ul>
                        <li>Name:<c:out value="${marker.name}"/></li>
                        <li>URL:<c:out value="${marker.url}"/></li>
                        <li>LAT:<c:out value="${marker.latitude}"/></li>
                        <li>LNG:<c:out value="${marker.longitude}"/></li>
                    </ul>
                    </p>
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
            <!-- CODE CONNECTION MYSQL-->
            ${HTML}
            <!-- END OF THE CONNECTION -->
            <br />
            <!-- <input type="checkbox" name="near-bus-stops" value="NearBusStops" class="macrocategory" /> <span class="near-bus-stops macrocategory-label">Fermate Autobus</span> -->
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
        <input type="button" value="Pulisci" id="pulsante-reset"  />
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

<!--  CARICAMENTO DEL FILE utility.js CON FUNZIONI NECESSARIE  -->
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js_utility/utility.js"></script>--%>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js_utility/utility_support.js"></script>--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js_utility/leaflet_buildMap_support.js"></script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js_utility/leaflet_markers_support.js"></script>--%>




</body>
</html>

