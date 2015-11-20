<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <title>ServiceMap</title>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <%--<link rel="stylesheet" href="/WebAppGrafo/css/leaflet-gps.css" type="text/css" />
  <script src='https://api.tiles.mapbox.com/mapbox.js/v2.1.4/mapbox.js'></script>
  <link href='https://api.tiles.mapbox.com/mapbox.js/v2.1.4/mapbox.css' rel='stylesheet' />
  <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
  <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
  <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" />
  <link rel="stylesheet" href="/WebAppGrafo/css/leaflet.awesome-markers.css">
  <script src="/WebAppGrafo/js/leaflet.awesome-markers.min.js"></script>
  <script src="/WebAppGrafo/js/leaflet-gps.js"></script>
  <script src="/WebAppGrafo/js/leaflet.markercluster.js"></script>
  <script src="/WebAppGrafo/js/mustache.js"></script>
  <script src="/WebAppGrafo/js/mustache.min.js"></script>
  <link rel="stylesheet" href="/WebAppGrafo/css/MarkerCluster.css" type="text/css" />
  <link rel="stylesheet" href="/WebAppGrafo/css/MarkerCluster.Default.css" type="text/css" />
  <link rel="stylesheet" href="/WebAppGrafo/css/style.css" type="text/css" />--%>
  <!-- PLUGIN LEAFLET CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/awesome-markers/leaflet.awesome-markers.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/gps/leaflet-gps.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/markercluster/MarkerCluster.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/markercluster/MarkerCluster.Default.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/label/leaflet.label.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/search/leaflet-search.css"/>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/leaflet-0.7.3.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/jquery/jquery-ui1.10.04.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/bootstrap/css/bootstrap.css"/>
  <!-- OTHER -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/search/leaflet-search.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/plugin/control-geocoder/Control.Geocoder.css"/>

  <!-- Servicemap -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css"/>
  <script src="${pageContext.request.contextPath}/resources/js/ServiceMap/utility.js" type="text/javascript"></script>

  <!-- MAPBOX -->
  <script src='https://api.tiles.mapbox.com/mapbox.js/v2.1.4/mapbox.js' type="text/javascript"></script>
  <link href='https://api.tiles.mapbox.com/mapbox.js/v2.1.4/mapbox.css' rel='stylesheet' />

  <!-- Leaflet -->
  <script src="${pageContext.request.contextPath}/resources/js/leaflet/leaflet-0.7.3.js" type="text/javascript"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/leaflet/leaflet-0.7.3.css"/>

  <!-- JS -->
  <script src="${pageContext.request.contextPath}/resources/js/mustache/mustache.js" type="text/javascript"></script>

  <!-- JS - leafletmap support -->
  <script src="${pageContext.request.contextPath}/resources/js/leaflet_buildMap_support2.js" type="text/javascript"></script>

</head>
<body onload="getBusLines();
            changeLanguage('ENG')" class="Chrome">
<%--<script>
  (function (i, s, o, g, r, a, m) {
    i['GoogleAnalyticsObject'] = r;
    i[r] = i[r] || function () {
              (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date();
    a = s.createElement(o),
            m = s.getElementsByTagName(o)[0];
    a.async = 1;
    a.src = g;
    m.parentNode.insertBefore(a, m)
  })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
  ga('create', 'UA-64916363-1', 'auto');
  ga('send', 'pageview');
  /*$(document).ready(function () {
   $("input[name='radio-language']").click(function () {
   changeLanguage($(this).val());
   });
   });*/

</script>--%>
<script type="text/javascript">var mode = "";</script>

<div id="dialog"></div>
<!-- <div id="QueryConfirmSave" title="'Save Query"> <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0; display: none;"></span>Do you want to save this query?</p> </div> !-->
<div id="map" class="leaflet-container leaflet-fade-anim" style="position: relative;" tabindex="0">
  <div id="help" class="menu">
    <a target="_blank" title="Aiuto Service Map" href="http://www.disit.org/servicemap"><img width="28" alt="help SiiMobility ServiceMap" src="/WebAppGrafo/img/help.png"></a>
  </div>
  <div class="leaflet-map-pane" style="transform: translate(23px, -55px);"><div class="leaflet-tile-pane"><div class="leaflet-layer" style="z-index: 2;"><div class="leaflet-tile-container leaflet-zoom-animated" style=""></div><div class="leaflet-tile-container leaflet-zoom-animated" style=""><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(366px, -121px);" src="https://c.tiles.mapbox.com/v4/mapbox.streets-satellite/8/135/92.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(622px, -121px);" src="https://a.tiles.mapbox.com/v4/mapbox.streets-satellite/8/136/92.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(366px, 135px);" src="https://a.tiles.mapbox.com/v4/mapbox.streets-satellite/8/135/93.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(622px, 135px);" src="https://b.tiles.mapbox.com/v4/mapbox.streets-satellite/8/136/93.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(110px, -121px);" src="https://b.tiles.mapbox.com/v4/mapbox.streets-satellite/8/134/92.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(878px, -121px);" src="https://b.tiles.mapbox.com/v4/mapbox.streets-satellite/8/137/92.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(110px, 135px);" src="https://c.tiles.mapbox.com/v4/mapbox.streets-satellite/8/134/93.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(878px, 135px);" src="https://c.tiles.mapbox.com/v4/mapbox.streets-satellite/8/137/93.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(-146px, -121px);" src="https://a.tiles.mapbox.com/v4/mapbox.streets-satellite/8/133/92.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(1134px, -121px);" src="https://c.tiles.mapbox.com/v4/mapbox.streets-satellite/8/138/92.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(-146px, 135px);" src="https://b.tiles.mapbox.com/v4/mapbox.streets-satellite/8/133/93.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(1134px, 135px);" src="https://a.tiles.mapbox.com/v4/mapbox.streets-satellite/8/138/93.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(366px, -377px);" src="https://b.tiles.mapbox.com/v4/mapbox.streets-satellite/8/135/91.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(622px, -377px);" src="https://c.tiles.mapbox.com/v4/mapbox.streets-satellite/8/136/91.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(366px, 391px);" src="https://b.tiles.mapbox.com/v4/mapbox.streets-satellite/8/135/94.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(622px, 391px);" src="https://c.tiles.mapbox.com/v4/mapbox.streets-satellite/8/136/94.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(110px, -377px);" src="https://a.tiles.mapbox.com/v4/mapbox.streets-satellite/8/134/91.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(878px, -377px);" src="https://a.tiles.mapbox.com/v4/mapbox.streets-satellite/8/137/91.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(110px, 391px);" src="https://a.tiles.mapbox.com/v4/mapbox.streets-satellite/8/134/94.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(878px, 391px);" src="https://a.tiles.mapbox.com/v4/mapbox.streets-satellite/8/137/94.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(-146px, -377px);" src="https://c.tiles.mapbox.com/v4/mapbox.streets-satellite/8/133/91.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(1134px, -377px);" src="https://b.tiles.mapbox.com/v4/mapbox.streets-satellite/8/138/91.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(-146px, 391px);" src="https://c.tiles.mapbox.com/v4/mapbox.streets-satellite/8/133/94.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"><img class="leaflet-tile leaflet-tile-loaded" style="height: 256px; width: 256px; transform: translate(1134px, 391px);" src="https://b.tiles.mapbox.com/v4/mapbox.streets-satellite/8/138/94.png?access_token=pk.eyJ1IjoicGJlbGxpbmkiLCJhIjoiNTQxZDNmNDY0NGZjYTk3YjlkNTAzNWQwNzc0NzQwYTcifQ.CNfaDbrJLPq14I30N1EqHg"></div></div></div><div class="leaflet-objects-pane"><div class="leaflet-shadow-pane"></div><div class="leaflet-overlay-pane"><svg class="leaflet-zoom-animated" style="transform: translate(-287px, -28px);" width="1690" height="533" viewBox="-287 -28 1690 533"><g><path stroke-linejoin="round" stroke-linecap="round" fill-rule="evenodd" stroke="#0033ff" stroke-opacity="0.5" stroke-width="2" fill="#0033ff" fill-opacity="0.2" d="M0 0" class="leaflet-clickable"/></g></svg></div><div class="leaflet-marker-pane"></div><div class="leaflet-popup-pane"></div></div></div><div class="leaflet-control-container"><div class="leaflet-top leaflet-left"><div class="leaflet-control-zoom leaflet-bar leaflet-control"><a class="leaflet-control-zoom-in" href="#" title="Zoom in">+</a><a class="leaflet-control-zoom-out" href="#" title="Zoom out">-</a></div><div class="leaflet-control-gps leaflet-control"><a class="gps-button" href="#" title="Center map on your location"></a><div class="gps-alert" style="display: none;"></div></div></div><div class="leaflet-top leaflet-right"></div><div class="leaflet-bottom leaflet-left"></div><div class="leaflet-bottom leaflet-right"><div class="leaflet-control-layers leaflet-control" aria-haspopup="true"><a class="leaflet-control-layers-toggle" href="#" title="Layers"></a>
    <form class="leaflet-control-layers-list"><div class="leaflet-control-layers-base">
        <label>
            <input type="radio" checked="checked" name="leaflet-base-layers" class="leaflet-control-layers-selector">
            <span> Satellite</span>
        </label>
        <label>
        <input type="radio" name="leaflet-base-layers" class="leaflet-control-layers-selector">
        <span> Streets</span>
        </label>
        <label>
            <input type="radio" name="leaflet-base-layers" class="leaflet-control-layers-selector"><span> Grayscale</span>
        </label>
    </div>
        <div class="leaflet-control-layers-separator" style="display: none;"></div>
        <div class="leaflet-control-layers-overlays"></div>
    </form></div><div class="leaflet-control-attribution leaflet-control"><a title="A JS library for interactive maps" href="http://leafletjs.com">Leaflet</a> | Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery &copy; <a href="http://mapbox.com">Mapbox</a></div></div></div></div>
<div id="save" class="menu">
  <img width="28" onclick="save_handler(null, null, null, true);" alt="Salva la configurazione" src="/WebAppGrafo/img/save.png">
</div>
<div id="embed" class="menu">
  <img width="28" onclick="embedConfiguration();" alt="Embed Servie Map" src="/WebAppGrafo/img/embed_icon.png">
</div>
<div class="menu" id="menu-alto">
  <div value="ENG" id="lang"><img id="icon_lang" src="/WebAppGrafo/img/icon_ITA.png" onclick="changeLanguage('ITA')"></div>
  <div class="header">
    <span caption="Hide_Menu_sx" name="lbl">Hide Menu</span>
  </div>
  <div class="content">
    <div id="tabs" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
      <ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all" role="tablist">
        <li class="ui-state-default ui-corner-top ui-tabs-active ui-state-active" role="tab" tabindex="0" aria-controls="tabs-1" aria-labelledby="ui-id-1" aria-selected="true"><a href="#tabs-1" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-1"><span caption="Bus_Search" name="lbl">Florence Bus</span></a></li>
        <li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-2" aria-labelledby="ui-id-2" aria-selected="false"><a href="#tabs-2" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-2"><span caption="Municipality_Search" name="lbl">Tuscan Municipalities</span></a></li>
        <li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-search" aria-labelledby="ui-id-3" aria-selected="false"><a href="#tabs-search" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-3"><span caption="Text_Search" name="lbl">Text Search</span></a></li>
        <li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-Event" aria-labelledby="ui-id-4" aria-selected="false"><a href="#tabs-Event" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-4"><span caption="Event_Search" name="lbl">Events</span></a></li>
        <%--Added from 4535992--%>
        <li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-101" aria-labelledby="ui-id-101" aria-selected="false"><a href="#tabs-101" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-101"><span caption="Utility" name="lbl">Utility</span></a></li>
      </ul>
      <div id="tabs-1" aria-labelledby="ui-id-1" class="ui-tabs-panel ui-widget-content ui-corner-bottom" role="tabpanel" aria-expanded="true" aria-hidden="false">
        <div class="use-case-1">
          <span caption="Select_Line" name="lbl">Select a line</span>:
          <br>
          <!--<select id="elencolinee" name="elencolinee" onchange="mostraElencoFermate(this);"> </select>-->
          <select onchange="mostraElencoPercorsi(this);" name="elencolinee" id="elencolinee"><option value=""> - Select a Bus Line - </option>
            <option value="all">ALL THE BUS LINES</option>
            <option value="S1">Line S1</option>
            <option value="S3">Line S3</option>
            <option value="SC">Line SC</option>
            <option value="C1">Line C1</option>
            <option value="C2">Line C2</option>
            <option value="C3">Line C3</option>
            <option value="D">Line D</option>
            <option value="M">Line M</option>
            <option value="R">Line R</option>
            <option value="SF">Line SF</option>
            <option value="1">Line 1</option>
            <option value="2">Line 2</option>
            <option value="3">Line 3</option>
            <option value="4">Line 4</option>
            <option value="5">Line 5</option>
            <option value="6">Line 6</option>
            <option value="7">Line 7</option>
            <option value="8">Line 8</option>
            <option value="9">Line 9</option>
            <option value="10">Line 10</option>
            <option value="11">Line 11</option>
            <option value="12">Line 12</option>
            <option value="13">Line 13</option>
            <option value="14">Line 14</option>
            <option value="15">Line 15</option>
            <option value="17">Line 17</option>
            <option value="19">Line 19</option>
            <option value="20">Line 20</option>
            <option value="21">Line 21</option>
            <option value="22">Line 22</option>
            <option value="23">Line 23</option>
            <option value="24">Line 24</option>
            <option value="25">Line 25</option>
            <option value="26">Line 26</option>
            <option value="27">Line 27</option>
            <option value="28">Line 28</option>
            <option value="29">Line 29</option>
            <option value="30">Line 30</option>
            <option value="31">Line 31</option>
            <option value="35">Line 35</option>
            <option value="36">Line 36</option>
            <option value="37">Line 37</option>
            <option value="38">Line 38</option>
            <option value="40">Line 40</option>
            <option value="41">Line 41</option>
            <option value="42">Line 42</option>
            <option value="43">Line 43</option>
            <option value="44">Line 44</option>
            <option value="45">Line 45</option>
            <option value="46">Line 46</option>
            <option value="47">Line 47</option>
            <option value="48">Line 48</option>
            <option value="49">Line 49</option>
            <option value="50">Line 50</option>
            <option value="52">Line 52</option>
            <option value="54">Line 54</option>
            <option value="56">Line 56</option>
            <option value="57">Line 57</option>
            <option value="58">Line 58</option>
            <option value="59">Line 59</option>
            <option value="60">Line 60</option>
            <option value="61">Line 61</option>
            <option value="62">Line 62</option>
            <option value="63">Line 63</option>
            <option value="64">Line 64</option>
            <option value="66">Line 66</option>
            <option value="72">Line 72</option>
            <option value="73">Line 73</option>
            <option value="74">Line 74</option>
            <option value="75">Line 75</option>
            <option value="76">Line 76</option>
            <option value="77">Line 77</option>
            <option value="78">Line 78</option>
            <option value="81">Line 81</option>
            <option value="82">Line 82</option>
            <option value="83">Line 83</option>
            <option value="84">Line 84</option>
            <option value="85">Line 85</option>
            <option value="86">Line 86</option>
            <option value="89">Line 89</option>
            <option value="90">Line 90</option>
            <option value="91">Line 91</option>
            <option value="92">Line 92</option>
            <option value="93">Line 93</option>
            <option value="94">Line 94</option>
            <option value="303">Line 303</option>
          </select>
          <br>
          <span caption="Select_Route" name="lbl">Select a route</span>:
          <br>
          <!--<select id="elencopercorsi" name="elencopercorsi" onchange="mostraElencoPercorsi(this);"></select>-->
          <select onchange="mostraElencoFermate(this);" name="elencopercorsi" id="elencopercorsi">
            <option value=""> - Select a Bus Route -</option>
          </select>
          <br>
          <span caption="Select_BusStop" name="lbl">Select a bus stop</span>:
          <br>
          <select onchange="mostraFermate(this);" name="elencofermate" id="elencofermate">
            <option value=""> - Select a Bus Stop - </option>
          </select>
          <div onclick="mostraAutobusRT(true);" name="autobusRealTime" id="pulsanteRT"><span caption="Position_Bus" name="lbl">Position of selected Busses</span></div>
        </div>
      </div>
      <div id="tabs-2" aria-labelledby="ui-id-2" class="ui-tabs-panel ui-widget-content ui-corner-bottom" role="tabpanel" style="display: none;" aria-expanded="false" aria-hidden="true">
        <div class="use-case-2">
          <span caption="Select_Province" name="lbl">Select a province</span>:
          <br>
          <select onchange="mostraElencoComuni(this);" name="elencoprovince" id="elencoprovince">
            <option value=""> - Select a Province - </option>
            <option value="all">ALL THE PROVINCES</option>
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
          <br>
          <span caption="Select_Municipality" name="lbl">Select a municipality</span>:
          <br>
          <select onchange="updateSelection();
                                    " name="elencocomuni" id="elencocomuni">
            <option value=""> - Select a Municipality - </option>
          </select>
        </div>
      </div>
      <div id="tabs-search" aria-labelledby="ui-id-3" class="ui-tabs-panel ui-widget-content ui-corner-bottom" role="tabpanel" style="display: none;" aria-expanded="false" aria-hidden="true">
        <div class="use-case-search"><span caption="Select_Text_sx" name="lbl">Search by Text</span>:
          <input type="text" onkeypress="event.keyCode == 13 ? searchText() : false" id="freeSearch" name="search">
          <br><br><span caption="Num_Results_sx" name="lbl">Max number of results</span>:
          <select name="numberResults" id="numberResults">
            <option value="100">100</option>
            <option value="200">200</option>
            <option value="500">500</option>
            <option value="0">No limit</option>
          </select>
          <div id="serviceTextSearch" class="menu">
            <img width="28" onclick="searchText()" alt="Search Services" src="/WebAppGrafo/img/search_icon.png">
          </div>
          <div id="saveQuerySearch" class="menu">
            <img width="28" onclick="save_handler(null, null, null, false, 'freeText');" alt="Salva la query" src="/WebAppGrafo/img/save.png">
          </div>
        </div>
      </div>
      <div style="padding-top: 10px; display: none;" id="tabs-Event" aria-labelledby="ui-id-4" class="ui-tabs-panel ui-widget-content ui-corner-bottom" role="tabpanel" aria-expanded="false" aria-hidden="true">
        <span caption="Select_Time" name="lbl">Select a time interval</span>
        <input type="radio" onchange="searchEvent(this.value, null, null)" value="day" name="event_choice"><span caption="Day" name="lbl">Day</span>
        <input type="radio" onchange="searchEvent(this.value, null, null)" value="week" name="event_choice"><span caption="Week" name="lbl">Week</span>
        <input type="radio" onchange="searchEvent(this.value, null, null)" value="month" name="event_choice"><span caption="Month" name="lbl">Month</span>
        <fieldset id="event">
          <legend><span caption="Event_Florence" name="lbl">Events in Florence</span></legend>
          <div style="display:none;" id="eventNum"></div>
          <div id="eventList"></div>
        </fieldset>
      </div>
      <%--Added from 4535992--%>
      <div div id="tabs-101" aria-labelledby="ui-id-101" class="ui-tabs-panel ui-widget-content ui-corner-bottom" role="tabpanel" style="display: none;" aria-expanded="false" aria-hidden="true">
        <div class="use-case-101">
          <ul>
            <%--TRACK MY URL--%>
            <li>
            <c:if test="${(not empty arrayMarker)}" >
              <input id="arrayMarkerForm" name="arrayMarkerParam" type="hidden" value="<c:out value="${arrayMarker}" />"/>
              <p>LENGTH OF MARKERS: ${arrayMarker.size()}</p>
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
                <script type="text/javascript">
                  //leaflet_buildMap_support.initMap();
                  //alert("try to push a marker");
                  leaflet_buildMap_support.pushMarkerToArrayMarker(
                          "${idMarker.name}","${idMarker.url}","${idMarker.latitude}","${idMarker.longitude}",
                          "${idMarker.markerInfo.region}","${idMarker.markerInfo.province}","${idMarker.markerInfo.city}",
                          "${idMarker.markerInfo.address}","${idMarker.markerInfo.phone}","${idMarker.markerInfo.email}",
                          "${idMarker.markerInfo.fax}","${idMarker.markerInfo.iva}");
                </script>
              </c:forEach>
            </c:if>
            TrackMyURL:
            <c:url var="url" value="/map3" />
            <form:form action="${url}" method="post" >
              <input type="text" name="urlParam" value=""  title="urlParam"/>
              <input type="submit" name="urlFormParam" value="urlForm" />
            </form:form>
            <c:if test="${(not empty marker)}" >
              <ul>
                <li>Name:<c:out value="${marker.name}"/></li>
                <li>URL:<c:out value="${marker.url}"/></li>
                <li>LAT:<c:out value="${marker.latitude}"/></li>
                <li>LNG:<c:out value="${marker.longitude}"/></li>
              </ul>
            </c:if>
            </li>
            <%--GET MARKERS--%>
            <li>
            <c:url var="url2" value="/map4" />
            <form:form action="${url2}" method="post" onSubmit="getMarkers();">
              <div id="loadMarker">
                  <%--<input type="button" value="Get Markers" id="getMarkers"  />--%>
                <input type="submit" name="GetMarkersParam" value="getMarkers" />
              </div>
            </form:form>
            </li>
          </ul>
        </div>
      </div>
        <%-- END ADDED FROM 4535992--%>
      <fieldset id="selection">
        <legend><span caption="Actual_Selection" name="lbl">Actual Selection</span></legend>
        <span id="selezione">No selection</span> <br>
        <div id="approximativeAddress"></div>

      </fieldset>
      <div id="queryBox"></div>
    </div>
  </div>
</div>
<div id="loading">
  <div id="messaggio-loading">
    <img width="32" src="/WebAppGrafo/img/ajax-loader.gif">
    <h3>Loading...</h3>
    <span caption="Loading_Message" name="lbl&quot;">Loading may take time</span>
  </div>
</div>
<div id="serviceMap_query_toggle"></div>
<div class="menu" id="menu-dx">
  <div class="header">
    <span caption="Hide_Menu_dx" name="lbl">Hide Menu</span>
  </div>
  <div class="content">
    <div id="tabs-servizi" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
      <ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all" role="tablist">
        <li class="ui-state-default ui-corner-top ui-tabs-active ui-state-active" role="tab" tabindex="0" aria-controls="tabs-4" aria-labelledby="ui-id-5" aria-selected="true"><a href="#tabs-4" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-5"><span caption="Search_Regular_Services" name="lbl">Regular Services</span></a></li>
        <li class="ui-state-default ui-corner-top" role="tab" tabindex="-1" aria-controls="tabs-5" aria-labelledby="ui-id-6" aria-selected="false"><a href="#tabs-5" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-6"><span caption="Search_Transversal_Services" name="lbl">Transversal Services</span></a></li>
      </ul>
      <div id="tabs-4" aria-labelledby="ui-id-5" class="ui-tabs-panel ui-widget-content ui-corner-bottom" role="tabpanel" aria-expanded="true" aria-hidden="false">
        <div class="use-case-4">
          <input type="text" onkeypress="event.keyCode == 13 ? ricercaServizi('categorie') : false" placeholder="search text into service" id="serviceTextFilter" name="serviceTextFilter"><br>
          <span caption="Services_Categories_R" name="lbl">Services Categories</span>
          <br>
          <input type="checkbox" value="Select All" id="macro-select-all" name="macro-select-all"> <span caption="Select_All_R" name="lbl">De/Select All</span>
          <div id="categorie">
            <input type="checkbox" class="macrocategory" value="Accommodation" name="Accommodation"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/Accommodation.png"> <span class="Accommodation macrocategory-label">Accommodation</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_Accommodation subcategory" value="Agritourism" name="Agritourism"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Agritourism.png">
              <span class="Accommodation subcategory-label">Agritourism</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Beach_resort" name="Beach_resort"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Beach_resort.png">
              <span class="Accommodation subcategory-label">Beach_resort</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Bed_and_breakfast" name="Bed_and_breakfast"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Bed_and_breakfast.png">
              <span class="Accommodation subcategory-label">Bed_and_breakfast</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Boarding_house" name="Boarding_house"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Boarding_house.png">
              <span class="Accommodation subcategory-label">Boarding_house</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Camping" name="Camping"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Camping.png">
              <span class="Accommodation subcategory-label">Camping</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Day_care_centre" name="Day_care_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Day_care_centre.png">
              <span class="Accommodation subcategory-label">Day_care_centre</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Farm_house" name="Farm_house"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Farm_house.png">
              <span class="Accommodation subcategory-label">Farm_house</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Historic_residence" name="Historic_residence"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Historic_residence.png">
              <span class="Accommodation subcategory-label">Historic_residence</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Holiday_village" name="Holiday_village"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Holiday_village.png">
              <span class="Accommodation subcategory-label">Holiday_village</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Hostel" name="Hostel"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Hostel.png">
              <span class="Accommodation subcategory-label">Hostel</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Hotel" name="Hotel"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Hotel.png">
              <span class="Accommodation subcategory-label">Hotel</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Mountain_shelter" name="Mountain_shelter"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Mountain_shelter.png">
              <span class="Accommodation subcategory-label">Mountain_shelter</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Other_accommodation" name="Other_accommodation"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Other_accommodation.png">
              <span class="Accommodation subcategory-label">Other_accommodation</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Religiuos_guest_house" name="Religiuos_guest_house"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Religiuos_guest_house.png">
              <span class="Accommodation subcategory-label">Religiuos_guest_house</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Rest_home" name="Rest_home"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Rest_home.png">
              <span class="Accommodation subcategory-label">Rest_home</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Summer_camp" name="Summer_camp"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Summer_camp.png">
              <span class="Accommodation subcategory-label">Summer_camp</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Summer_residence" name="Summer_residence"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Summer_residence.png">
              <span class="Accommodation subcategory-label">Summer_residence</span>
              <br>
              <input type="checkbox" class="sub_Accommodation subcategory" value="Vacation_resort" name="Vacation_resort"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Accommodation_Vacation_resort.png">
              <span class="Accommodation subcategory-label">Vacation_resort</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="Advertising" name="Advertising"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/Advertising.png" class="ufpbuimjcdizjqxmvdtm"> <span class="Advertising macrocategory-label">Advertising</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_Advertising subcategory" value="Advertising_and_promotion" name="Advertising_and_promotion"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Advertising_Advertising_and_promotion.png" class="ufpbuimjcdizjqxmvdtm">
              <span class="Advertising subcategory-label">Advertising_and_promotion</span>
              <br>
              <input type="checkbox" class="sub_Advertising subcategory" value="Market_polling" name="Market_polling"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Advertising_Market_polling.png" class="ufpbuimjcdizjqxmvdtm">
              <span class="Advertising subcategory-label">Market_polling</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="AgricultureAndLivestock" name="AgricultureAndLivestock"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/AgricultureAndLivestock.png"> <span class="AgricultureAndLivestock macrocategory-label">AgricultureAndLivestock</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_AgricultureAndLivestock subcategory" value="Animal_production" name="Animal_production"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/AgricultureAndLivestock_Animal_production.png">
              <span class="AgricultureAndLivestock subcategory-label">Animal_production</span>
              <br>
              <input type="checkbox" class="sub_AgricultureAndLivestock subcategory" value="Crop_animal_production_hunting" name="Crop_animal_production_hunting"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/AgricultureAndLivestock_Crop_animal_production_hunting.png">
              <span class="AgricultureAndLivestock subcategory-label">Crop_animal_production_hunting</span>
              <br>
              <input type="checkbox" class="sub_AgricultureAndLivestock subcategory" value="Crop_production" name="Crop_production"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/AgricultureAndLivestock_Crop_production.png">
              <span class="AgricultureAndLivestock subcategory-label">Crop_production</span>
              <br>
              <input type="checkbox" class="sub_AgricultureAndLivestock subcategory" value="Fishing_and_aquaculture" name="Fishing_and_aquaculture"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/AgricultureAndLivestock_Fishing_and_aquaculture.png">
              <span class="AgricultureAndLivestock subcategory-label">Fishing_and_aquaculture</span>
              <br>
              <input type="checkbox" class="sub_AgricultureAndLivestock subcategory" value="Hunting_trapping_and_services" name="Hunting_trapping_and_services"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/AgricultureAndLivestock_Hunting_trapping_and_services.png">
              <span class="AgricultureAndLivestock subcategory-label">Hunting_trapping_and_services</span>
              <br>
              <input type="checkbox" class="sub_AgricultureAndLivestock subcategory" value="Support_animal_production" name="Support_animal_production"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/AgricultureAndLivestock_Support_animal_production.png">
              <span class="AgricultureAndLivestock subcategory-label">Support_animal_production</span>
              <br>
              <input type="checkbox" class="sub_AgricultureAndLivestock subcategory" value="Veterinary" name="Veterinary"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/AgricultureAndLivestock_Veterinary.png">
              <span class="AgricultureAndLivestock subcategory-label">Veterinary</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="CivilAndEdilEngineering" name="CivilAndEdilEngineering"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/CivilAndEdilEngineering.png"> <span class="CivilAndEdilEngineering macrocategory-label">CivilAndEdilEngineering</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_CivilAndEdilEngineering subcategory" value="Architectural_consulting" name="Architectural_consulting"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CivilAndEdilEngineering_Architectural_consulting.png">
              <span class="CivilAndEdilEngineering subcategory-label">Architectural_consulting</span>
              <br>
              <input type="checkbox" class="sub_CivilAndEdilEngineering subcategory" value="Building_construction" name="Building_construction"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CivilAndEdilEngineering_Building_construction.png">
              <span class="CivilAndEdilEngineering subcategory-label">Building_construction</span>
              <br>
              <input type="checkbox" class="sub_CivilAndEdilEngineering subcategory" value="Cartographers" name="Cartographers"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CivilAndEdilEngineering_Cartographers.png">
              <span class="CivilAndEdilEngineering subcategory-label">Cartographers</span>
              <br>
              <input type="checkbox" class="sub_CivilAndEdilEngineering subcategory" value="Civil_engineering" name="Civil_engineering"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CivilAndEdilEngineering_Civil_engineering.png">
              <span class="CivilAndEdilEngineering subcategory-label">Civil_engineering</span>
              <br>
              <input type="checkbox" class="sub_CivilAndEdilEngineering subcategory" value="Engineering_consulting" name="Engineering_consulting"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CivilAndEdilEngineering_Engineering_consulting.png">
              <span class="CivilAndEdilEngineering subcategory-label">Engineering_consulting</span>
              <br>
              <input type="checkbox" class="sub_CivilAndEdilEngineering subcategory" value="Other_specialized_construction" name="Other_specialized_construction"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CivilAndEdilEngineering_Other_specialized_construction.png">
              <span class="CivilAndEdilEngineering subcategory-label">Other_specialized_construction</span>
              <br>
              <input type="checkbox" class="sub_CivilAndEdilEngineering subcategory" value="Specialized_construction" name="Specialized_construction"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CivilAndEdilEngineering_Specialized_construction.png">
              <span class="CivilAndEdilEngineering subcategory-label">Specialized_construction</span>
              <br>
              <input type="checkbox" class="sub_CivilAndEdilEngineering subcategory" value="Surveyor" name="Surveyor"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CivilAndEdilEngineering_Surveyor.png">
              <span class="CivilAndEdilEngineering subcategory-label">Surveyor</span>
              <br>
              <input type="checkbox" class="sub_CivilAndEdilEngineering subcategory" value="Technical_consultants" name="Technical_consultants"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CivilAndEdilEngineering_Technical_consultants.png">
              <span class="CivilAndEdilEngineering subcategory-label">Technical_consultants</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="CulturalActivity" name="CulturalActivity"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity.png"> <span class="CulturalActivity macrocategory-label">CulturalActivity</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Archaeological_site" name="Archaeological_site"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Archaeological_site.png">
              <span class="CulturalActivity subcategory-label">Archaeological_site</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Auditorium" name="Auditorium"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Auditorium.png">
              <span class="CulturalActivity subcategory-label">Auditorium</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Botanical_and_zoological_gardens" name="Botanical_and_zoological_gardens"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Botanical_and_zoological_gardens.png">
              <span class="CulturalActivity subcategory-label">Botanical_and_zoological_gardens</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Churches" name="Churches"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Churches.png">
              <span class="CulturalActivity subcategory-label">Churches</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Cultural_centre" name="Cultural_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Cultural_centre.png">
              <span class="CulturalActivity subcategory-label">Cultural_centre</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Cultural_sites" name="Cultural_sites"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Cultural_sites.png">
              <span class="CulturalActivity subcategory-label">Cultural_sites</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Historical_buildings" name="Historical_buildings"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Historical_buildings.png">
              <span class="CulturalActivity subcategory-label">Historical_buildings</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Journalist" name="Journalist"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Journalist.png">
              <span class="CulturalActivity subcategory-label">Journalist</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Leasing_of_intellectual_property" name="Leasing_of_intellectual_property"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Leasing_of_intellectual_property.png">
              <span class="CulturalActivity subcategory-label">Leasing_of_intellectual_property</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Library" name="Library"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Library.png">
              <span class="CulturalActivity subcategory-label">Library</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Monument_location" name="Monument_location"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Monument_location.png">
              <span class="CulturalActivity subcategory-label">Monument_location</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Motion_picture_and_television_programme_activities" name="Motion_picture_and_television_programme_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Motion_picture_and_television_programme_activities.png">
              <span class="CulturalActivity subcategory-label">Motion_picture_and_television_programme_activities</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Museum" name="Museum"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Museum.png">
              <span class="CulturalActivity subcategory-label">Museum</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="News_agency" name="News_agency"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_News_agency.png">
              <span class="CulturalActivity subcategory-label">News_agency</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Other_broadcasting" name="Other_broadcasting"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Other_broadcasting.png">
              <span class="CulturalActivity subcategory-label">Other_broadcasting</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Photographic_activities" name="Photographic_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Photographic_activities.png">
              <span class="CulturalActivity subcategory-label">Photographic_activities</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Printing_and_recorded_media" name="Printing_and_recorded_media"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Printing_and_recorded_media.png">
              <span class="CulturalActivity subcategory-label">Printing_and_recorded_media</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Printing_and_services" name="Printing_and_services"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Printing_and_services.png">
              <span class="CulturalActivity subcategory-label">Printing_and_services</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Publishing_activities" name="Publishing_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Publishing_activities.png">
              <span class="CulturalActivity subcategory-label">Publishing_activities</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Radio_broadcasting" name="Radio_broadcasting"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Radio_broadcasting.png">
              <span class="CulturalActivity subcategory-label">Radio_broadcasting</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Reproduction_recorded_media" name="Reproduction_recorded_media"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Reproduction_recorded_media.png">
              <span class="CulturalActivity subcategory-label">Reproduction_recorded_media</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Sound_recording_and_music_publishing" name="Sound_recording_and_music_publishing"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Sound_recording_and_music_publishing.png">
              <span class="CulturalActivity subcategory-label">Sound_recording_and_music_publishing</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Squares" name="Squares"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Squares.png">
              <span class="CulturalActivity subcategory-label">Squares</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Television_broadcasting" name="Television_broadcasting"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Television_broadcasting.png">
              <span class="CulturalActivity subcategory-label">Television_broadcasting</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Theatre" name="Theatre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Theatre.png">
              <span class="CulturalActivity subcategory-label">Theatre</span>
              <br>
              <input type="checkbox" class="sub_CulturalActivity subcategory" value="Translation_and_interpreting" name="Translation_and_interpreting"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Translation_and_interpreting.png">
              <span class="CulturalActivity subcategory-label">Translation_and_interpreting</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="EducationAndResearch" name="EducationAndResearch"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch.png"> <span class="EducationAndResearch macrocategory-label">EducationAndResearch</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Automobile_driving_and_flying_schools" name="Automobile_driving_and_flying_schools"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Automobile_driving_and_flying_schools.png">
              <span class="EducationAndResearch subcategory-label">Automobile_driving_and_flying_schools</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Conservatory" name="Conservatory"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Conservatory.png">
              <span class="EducationAndResearch subcategory-label">Conservatory</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Cultural_education" name="Cultural_education"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Cultural_education.png">
              <span class="EducationAndResearch subcategory-label">Cultural_education</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Dance_schools" name="Dance_schools"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Dance_schools.png">
              <span class="EducationAndResearch subcategory-label">Dance_schools</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Diving_school" name="Diving_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Diving_school.png">
              <span class="EducationAndResearch subcategory-label">Diving_school</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Educational_support_activities" name="Educational_support_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Educational_support_activities.png">
              <span class="EducationAndResearch subcategory-label">Educational_support_activities</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Higher_education" name="Higher_education"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Higher_education.png">
              <span class="EducationAndResearch subcategory-label">Higher_education</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Language_courses" name="Language_courses"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Language_courses.png">
              <span class="EducationAndResearch subcategory-label">Language_courses</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Performing_arts_schools" name="Performing_arts_schools"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Performing_arts_schools.png">
              <span class="EducationAndResearch subcategory-label">Performing_arts_schools</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Post_secondary_education" name="Post_secondary_education"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Post_secondary_education.png">
              <span class="EducationAndResearch subcategory-label">Post_secondary_education</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Pre_primary_education" name="Pre_primary_education"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Pre_primary_education.png">
              <span class="EducationAndResearch subcategory-label">Pre_primary_education</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Primary_education" name="Primary_education"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Primary_education.png">
              <span class="EducationAndResearch subcategory-label">Primary_education</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Private_high_school" name="Private_high_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Private_high_school.png">
              <span class="EducationAndResearch subcategory-label">Private_high_school</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Private_infant_school" name="Private_infant_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Private_infant_school.png">
              <span class="EducationAndResearch subcategory-label">Private_infant_school</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Private_junior_high_school" name="Private_junior_high_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Private_junior_high_school.png">
              <span class="EducationAndResearch subcategory-label">Private_junior_high_school</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Private_junior_school" name="Private_junior_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Private_junior_school.png">
              <span class="EducationAndResearch subcategory-label">Private_junior_school</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Private_polytechnic_school" name="Private_polytechnic_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Private_polytechnic_school.png">
              <span class="EducationAndResearch subcategory-label">Private_polytechnic_school</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Private_preschool" name="Private_preschool"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Private_preschool.png">
              <span class="EducationAndResearch subcategory-label">Private_preschool</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Private_professional_institute" name="Private_professional_institute"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Private_professional_institute.png">
              <span class="EducationAndResearch subcategory-label">Private_professional_institute</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Public_high_school" name="Public_high_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Public_high_school.png">
              <span class="EducationAndResearch subcategory-label">Public_high_school</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Public_infant_school" name="Public_infant_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Public_infant_school.png">
              <span class="EducationAndResearch subcategory-label">Public_infant_school</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Public_junior_high_school" name="Public_junior_high_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Public_junior_high_school.png">
              <span class="EducationAndResearch subcategory-label">Public_junior_high_school</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Public_junior_school" name="Public_junior_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Public_junior_school.png">
              <span class="EducationAndResearch subcategory-label">Public_junior_school</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Public_polytechnic_school" name="Public_polytechnic_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Public_polytechnic_school.png">
              <span class="EducationAndResearch subcategory-label">Public_polytechnic_school</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Public_professional_institute" name="Public_professional_institute"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Public_professional_institute.png">
              <span class="EducationAndResearch subcategory-label">Public_professional_institute</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Public_university" name="Public_university"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Public_university.png">
              <span class="EducationAndResearch subcategory-label">Public_university</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Research_and_development" name="Research_and_development"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Research_and_development.png">
              <span class="EducationAndResearch subcategory-label">Research_and_development</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Sailing_school" name="Sailing_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Sailing_school.png">
              <span class="EducationAndResearch subcategory-label">Sailing_school</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Secondary_education" name="Secondary_education"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Secondary_education.png">
              <span class="EducationAndResearch subcategory-label">Secondary_education</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Ski_school" name="Ski_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Ski_school.png">
              <span class="EducationAndResearch subcategory-label">Ski_school</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Sports_and_recreation_education" name="Sports_and_recreation_education"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Sports_and_recreation_education.png">
              <span class="EducationAndResearch subcategory-label">Sports_and_recreation_education</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Training_school" name="Training_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Training_school.png">
              <span class="EducationAndResearch subcategory-label">Training_school</span>
              <br>
              <input type="checkbox" class="sub_EducationAndResearch subcategory" value="Training_school_for_teachers" name="Training_school_for_teachers"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Training_school_for_teachers.png">
              <span class="EducationAndResearch subcategory-label">Training_school_for_teachers</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="Emergency" name="Emergency"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/Emergency.png"> <span class="Emergency macrocategory-label">Emergency</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_Emergency subcategory" value="Carabinieri" name="Carabinieri"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Emergency_Carabinieri.png">
              <span class="Emergency subcategory-label">Carabinieri</span>
              <br>
              <input type="checkbox" class="sub_Emergency subcategory" value="Civil_protection" name="Civil_protection"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Emergency_Civil_protection.png">
              <span class="Emergency subcategory-label">Civil_protection</span>
              <br>
              <input type="checkbox" class="sub_Emergency subcategory" value="Coast_guard_harbormaster" name="Coast_guard_harbormaster"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Emergency_Coast_guard_harbormaster.png">
              <span class="Emergency subcategory-label">Coast_guard_harbormaster</span>
              <br>
              <input type="checkbox" class="sub_Emergency subcategory" value="Commissariat_of_public_safety" name="Commissariat_of_public_safety"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Emergency_Commissariat_of_public_safety.png">
              <span class="Emergency subcategory-label">Commissariat_of_public_safety</span>
              <br>
              <input type="checkbox" class="sub_Emergency subcategory" value="Corps_of_forest_rangers" name="Corps_of_forest_rangers"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Emergency_Corps_of_forest_rangers.png">
              <span class="Emergency subcategory-label">Corps_of_forest_rangers</span>
              <br>
              <input type="checkbox" class="sub_Emergency subcategory" value="Emergency_medical_care" name="Emergency_medical_care"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Emergency_Emergency_medical_care.png">
              <span class="Emergency subcategory-label">Emergency_medical_care</span>
              <br>
              <input type="checkbox" class="sub_Emergency subcategory" value="Emergency_services" name="Emergency_services"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Emergency_Emergency_services.png">
              <span class="Emergency subcategory-label">Emergency_services</span>
              <br>
              <input type="checkbox" class="sub_Emergency subcategory" value="Fire_brigade" name="Fire_brigade"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Emergency_Fire_brigade.png">
              <span class="Emergency subcategory-label">Fire_brigade</span>
              <br>
              <input type="checkbox" class="sub_Emergency subcategory" value="First_aid" name="First_aid"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Emergency_First_aid.png">
              <span class="Emergency subcategory-label">First_aid</span>
              <br>
              <input type="checkbox" class="sub_Emergency subcategory" value="Italian_finance_police" name="Italian_finance_police"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Emergency_Italian_finance_police.png">
              <span class="Emergency subcategory-label">Italian_finance_police</span>
              <br>
              <input type="checkbox" class="sub_Emergency subcategory" value="Local_police" name="Local_police"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Emergency_Local_police.png">
              <span class="Emergency subcategory-label">Local_police</span>
              <br>
              <input type="checkbox" class="sub_Emergency subcategory" value="Towing_and_roadside_assistance" name="Towing_and_roadside_assistance"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Emergency_Towing_and_roadside_assistance.png">
              <span class="Emergency subcategory-label">Towing_and_roadside_assistance</span>
              <br>
              <input type="checkbox" class="sub_Emergency subcategory" value="Traffic_corps" name="Traffic_corps"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Emergency_Traffic_corps.png">
              <span class="Emergency subcategory-label">Traffic_corps</span>
              <br>
              <input type="checkbox" class="sub_Emergency subcategory" value="Useful_numbers" name="Useful_numbers"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Emergency_Useful_numbers.png">
              <span class="Emergency subcategory-label">Useful_numbers</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="Entertainment" name="Entertainment"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/Entertainment.png"> <span class="Entertainment macrocategory-label">Entertainment</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_Entertainment subcategory" value="Amusement_activities" name="Amusement_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Amusement_activities.png">
              <span class="Entertainment subcategory-label">Amusement_activities</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Amusement_and_theme_parks" name="Amusement_and_theme_parks"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Amusement_and_theme_parks.png">
              <span class="Entertainment subcategory-label">Amusement_and_theme_parks</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Aquarium" name="Aquarium"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Aquarium.png">
              <span class="Entertainment subcategory-label">Aquarium</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Betting_shops" name="Betting_shops"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Betting_shops.png">
              <span class="Entertainment subcategory-label">Betting_shops</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Boxoffice" name="Boxoffice"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Boxoffice.png">
              <span class="Entertainment subcategory-label">Boxoffice</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Cinema" name="Cinema"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Cinema.png">
              <span class="Entertainment subcategory-label">Cinema</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Climbing" name="Climbing"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Climbing.png">
              <span class="Entertainment subcategory-label">Climbing</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Discotheque" name="Discotheque"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Discotheque.png">
              <span class="Entertainment subcategory-label">Discotheque</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Fishing_reserve" name="Fishing_reserve"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Fishing_reserve.png">
              <span class="Entertainment subcategory-label">Fishing_reserve</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Gambling_and_betting" name="Gambling_and_betting"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Gambling_and_betting.png">
              <span class="Entertainment subcategory-label">Gambling_and_betting</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Game_reserve" name="Game_reserve"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Game_reserve.png">
              <span class="Entertainment subcategory-label">Game_reserve</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Game_room" name="Game_room"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Game_room.png">
              <span class="Entertainment subcategory-label">Game_room</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Gardens" name="Gardens"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Gardens.png">
              <span class="Entertainment subcategory-label">Gardens</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Golf" name="Golf"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Golf.png">
              <span class="Entertainment subcategory-label">Golf</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Green_areas" name="Green_areas"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Green_areas.png">
              <span class="Entertainment subcategory-label">Green_areas</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Gym_fitness" name="Gym_fitness"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Gym_fitness.png">
              <span class="Entertainment subcategory-label">Gym_fitness</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Hippodrome" name="Hippodrome"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Hippodrome.png">
              <span class="Entertainment subcategory-label">Hippodrome</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Operation_of_casinos" name="Operation_of_casinos"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Operation_of_casinos.png">
              <span class="Entertainment subcategory-label">Operation_of_casinos</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Pool" name="Pool"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Pool.png">
              <span class="Entertainment subcategory-label">Pool</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Rafting_kayak" name="Rafting_kayak"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Rafting_kayak.png">
              <span class="Entertainment subcategory-label">Rafting_kayak</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Recreation_room" name="Recreation_room"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Recreation_room.png">
              <span class="Entertainment subcategory-label">Recreation_room</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Riding_stables" name="Riding_stables"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Riding_stables.png">
              <span class="Entertainment subcategory-label">Riding_stables</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Skiing_facility" name="Skiing_facility"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Skiing_facility.png">
              <span class="Entertainment subcategory-label">Skiing_facility</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Social_centre" name="Social_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Social_centre.png">
              <span class="Entertainment subcategory-label">Social_centre</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Sports_clubs" name="Sports_clubs"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Sports_clubs.png">
              <span class="Entertainment subcategory-label">Sports_clubs</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Sports_facility" name="Sports_facility"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Sports_facility.png">
              <span class="Entertainment subcategory-label">Sports_facility</span>
              <br>
              <input type="checkbox" class="sub_Entertainment subcategory" value="Sport_event_promoters" name="Sport_event_promoters"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Sport_event_promoters.png">
              <span class="Entertainment subcategory-label">Sport_event_promoters</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="Environment" name="Environment"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/Environment.png"> <span class="Environment macrocategory-label">Environment</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_Environment subcategory" value="Building_and_industrial_cleaning_activities" name="Building_and_industrial_cleaning_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Environment_Building_and_industrial_cleaning_activities.png">
              <span class="Environment subcategory-label">Building_and_industrial_cleaning_activities</span>
              <br>
              <input type="checkbox" class="sub_Environment subcategory" value="Cleaning_activities" name="Cleaning_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Environment_Cleaning_activities.png">
              <span class="Environment subcategory-label">Cleaning_activities</span>
              <br>
              <input type="checkbox" class="sub_Environment subcategory" value="Disinfecting_and_exterminating_activities" name="Disinfecting_and_exterminating_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Environment_Disinfecting_and_exterminating_activities.png">
              <span class="Environment subcategory-label">Disinfecting_and_exterminating_activities</span>
              <br>
              <input type="checkbox" class="sub_Environment subcategory" value="Forestry" name="Forestry"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Environment_Forestry.png">
              <span class="Environment subcategory-label">Forestry</span>
              <br>
              <input type="checkbox" class="sub_Environment subcategory" value="Geologists" name="Geologists"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Environment_Geologists.png">
              <span class="Environment subcategory-label">Geologists</span>
              <br>
              <input type="checkbox" class="sub_Environment subcategory" value="Landscape_care" name="Landscape_care"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Environment_Landscape_care.png">
              <span class="Environment subcategory-label">Landscape_care</span>
              <br>
              <input type="checkbox" class="sub_Environment subcategory" value="Materials_recovery" name="Materials_recovery"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Environment_Materials_recovery.png">
              <span class="Environment subcategory-label">Materials_recovery</span>
              <br>
              <input type="checkbox" class="sub_Environment subcategory" value="Photovoltaic_system" name="Photovoltaic_system"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Environment_Photovoltaic_system.png">
              <span class="Environment subcategory-label">Photovoltaic_system</span>
              <br>
              <input type="checkbox" class="sub_Environment subcategory" value="Sewerage" name="Sewerage"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Environment_Sewerage.png">
              <span class="Environment subcategory-label">Sewerage</span>
              <br>
              <input type="checkbox" class="sub_Environment subcategory" value="Street_sweeping" name="Street_sweeping"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Environment_Street_sweeping.png">
              <span class="Environment subcategory-label">Street_sweeping</span>
              <br>
              <input type="checkbox" class="sub_Environment subcategory" value="Waste_collection_and_treatment" name="Waste_collection_and_treatment"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Environment_Waste_collection_and_treatment.png">
              <span class="Environment subcategory-label">Waste_collection_and_treatment</span>
              <br>
              <input type="checkbox" class="sub_Environment subcategory" value="Weather_sensor" name="Weather_sensor"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Environment_Weather_sensor.png">
              <span class="Environment subcategory-label">Weather_sensor</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="FinancialService" name="FinancialService"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/FinancialService.png"> <span class="FinancialService macrocategory-label">FinancialService</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_FinancialService subcategory" value="Accountants" name="Accountants"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/FinancialService_Accountants.png">
              <span class="FinancialService subcategory-label">Accountants</span>
              <br>
              <input type="checkbox" class="sub_FinancialService subcategory" value="Auditing_activities" name="Auditing_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/FinancialService_Auditing_activities.png">
              <span class="FinancialService subcategory-label">Auditing_activities</span>
              <br>
              <input type="checkbox" class="sub_FinancialService subcategory" value="Bank" name="Bank"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/FinancialService_Bank.png">
              <span class="FinancialService subcategory-label">Bank</span>
              <br>
              <input type="checkbox" class="sub_FinancialService subcategory" value="Financial_institute" name="Financial_institute"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/FinancialService_Financial_institute.png">
              <span class="FinancialService subcategory-label">Financial_institute</span>
              <br>
              <input type="checkbox" class="sub_FinancialService subcategory" value="Insurance" name="Insurance"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/FinancialService_Insurance.png">
              <span class="FinancialService subcategory-label">Insurance</span>
              <br>
              <input type="checkbox" class="sub_FinancialService subcategory" value="Insurance_and_financial" name="Insurance_and_financial"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/FinancialService_Insurance_and_financial.png">
              <span class="FinancialService subcategory-label">Insurance_and_financial</span>
              <br>
              <input type="checkbox" class="sub_FinancialService subcategory" value="Labour_consultant" name="Labour_consultant"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/FinancialService_Labour_consultant.png">
              <span class="FinancialService subcategory-label">Labour_consultant</span>
              <br>
              <input type="checkbox" class="sub_FinancialService subcategory" value="Legal_office" name="Legal_office"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/FinancialService_Legal_office.png">
              <span class="FinancialService subcategory-label">Legal_office</span>
              <br>
              <input type="checkbox" class="sub_FinancialService subcategory" value="Tax_advice" name="Tax_advice"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/FinancialService_Tax_advice.png">
              <span class="FinancialService subcategory-label">Tax_advice</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="GovernmentOffice" name="GovernmentOffice"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice.png"> <span class="GovernmentOffice macrocategory-label">GovernmentOffice</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_GovernmentOffice subcategory" value="Airport_lost_property_office" name="Airport_lost_property_office"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_Airport_lost_property_office.png">
              <span class="GovernmentOffice subcategory-label">Airport_lost_property_office</span>
              <br>
              <input type="checkbox" class="sub_GovernmentOffice subcategory" value="Civil_registry" name="Civil_registry"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_Civil_registry.png">
              <span class="GovernmentOffice subcategory-label">Civil_registry</span>
              <br>
              <input type="checkbox" class="sub_GovernmentOffice subcategory" value="Consulate" name="Consulate"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_Consulate.png">
              <span class="GovernmentOffice subcategory-label">Consulate</span>
              <br>
              <input type="checkbox" class="sub_GovernmentOffice subcategory" value="Department_of_motor_vehicles" name="Department_of_motor_vehicles"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_Department_of_motor_vehicles.png">
              <span class="GovernmentOffice subcategory-label">Department_of_motor_vehicles</span>
              <br>
              <input type="checkbox" class="sub_GovernmentOffice subcategory" value="District" name="District"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_District.png">
              <span class="GovernmentOffice subcategory-label">District</span>
              <br>
              <input type="checkbox" class="sub_GovernmentOffice subcategory" value="Employment_exchange" name="Employment_exchange"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_Employment_exchange.png">
              <span class="GovernmentOffice subcategory-label">Employment_exchange</span>
              <br>
              <input type="checkbox" class="sub_GovernmentOffice subcategory" value="Income_revenue_authority" name="Income_revenue_authority"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_Income_revenue_authority.png">
              <span class="GovernmentOffice subcategory-label">Income_revenue_authority</span>
              <br>
              <input type="checkbox" class="sub_GovernmentOffice subcategory" value="Other_office" name="Other_office"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_Other_office.png">
              <span class="GovernmentOffice subcategory-label">Other_office</span>
              <br>
              <input type="checkbox" class="sub_GovernmentOffice subcategory" value="Police_headquarters" name="Police_headquarters"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_Police_headquarters.png">
              <span class="GovernmentOffice subcategory-label">Police_headquarters</span>
              <br>
              <input type="checkbox" class="sub_GovernmentOffice subcategory" value="Postal_office" name="Postal_office"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_Postal_office.png">
              <span class="GovernmentOffice subcategory-label">Postal_office</span>
              <br>
              <input type="checkbox" class="sub_GovernmentOffice subcategory" value="Prefecture" name="Prefecture"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_Prefecture.png">
              <span class="GovernmentOffice subcategory-label">Prefecture</span>
              <br>
              <input type="checkbox" class="sub_GovernmentOffice subcategory" value="Social_security_service_office" name="Social_security_service_office"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_Social_security_service_office.png">
              <span class="GovernmentOffice subcategory-label">Social_security_service_office</span>
              <br>
              <input type="checkbox" class="sub_GovernmentOffice subcategory" value="Train_lost_property_office" name="Train_lost_property_office"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_Train_lost_property_office.png">
              <span class="GovernmentOffice subcategory-label">Train_lost_property_office</span>
              <br>
              <input type="checkbox" class="sub_GovernmentOffice subcategory" value="Welfare_worker_office" name="Welfare_worker_office"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_Welfare_worker_office.png">
              <span class="GovernmentOffice subcategory-label">Welfare_worker_office</span>
              <br>
              <input type="checkbox" class="sub_GovernmentOffice subcategory" value="Youth_information_centre" name="Youth_information_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_Youth_information_centre.png">
              <span class="GovernmentOffice subcategory-label">Youth_information_centre</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="HealthCare" name="HealthCare"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/HealthCare.png"> <span class="HealthCare macrocategory-label">HealthCare</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_HealthCare subcategory" value="Addiction_recovery_centre" name="Addiction_recovery_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Addiction_recovery_centre.png">
              <span class="HealthCare subcategory-label">Addiction_recovery_centre</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Community_centre" name="Community_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Community_centre.png">
              <span class="HealthCare subcategory-label">Community_centre</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Dentist" name="Dentist"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Dentist.png">
              <span class="HealthCare subcategory-label">Dentist</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Doctor_office" name="Doctor_office"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Doctor_office.png">
              <span class="HealthCare subcategory-label">Doctor_office</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Family_counselling" name="Family_counselling"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Family_counselling.png">
              <span class="HealthCare subcategory-label">Family_counselling</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Group_practice" name="Group_practice"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Group_practice.png">
              <span class="HealthCare subcategory-label">Group_practice</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Haircare_centres" name="Haircare_centres"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Haircare_centres.png">
              <span class="HealthCare subcategory-label">Haircare_centres</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Healthcare_centre" name="Healthcare_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Healthcare_centre.png">
              <span class="HealthCare subcategory-label">Healthcare_centre</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Health_district" name="Health_district"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Health_district.png">
              <span class="HealthCare subcategory-label">Health_district</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Health_reservations_centre" name="Health_reservations_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Health_reservations_centre.png">
              <span class="HealthCare subcategory-label">Health_reservations_centre</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Human_health_activities" name="Human_health_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Human_health_activities.png">
              <span class="HealthCare subcategory-label">Human_health_activities</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Local_health_authority" name="Local_health_authority"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Local_health_authority.png">
              <span class="HealthCare subcategory-label">Local_health_authority</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Medical_analysis_laboratories" name="Medical_analysis_laboratories"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Medical_analysis_laboratories.png">
              <span class="HealthCare subcategory-label">Medical_analysis_laboratories</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Mental_health_centre" name="Mental_health_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Mental_health_centre.png">
              <span class="HealthCare subcategory-label">Mental_health_centre</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Paramedical_activities" name="Paramedical_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Paramedical_activities.png">
              <span class="HealthCare subcategory-label">Paramedical_activities</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Physical_therapy_centre" name="Physical_therapy_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Physical_therapy_centre.png">
              <span class="HealthCare subcategory-label">Physical_therapy_centre</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Poison_control_centre" name="Poison_control_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Poison_control_centre.png">
              <span class="HealthCare subcategory-label">Poison_control_centre</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Private_clinic" name="Private_clinic"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Private_clinic.png">
              <span class="HealthCare subcategory-label">Private_clinic</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Psychologists" name="Psychologists"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Psychologists.png">
              <span class="HealthCare subcategory-label">Psychologists</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Public_hospital" name="Public_hospital"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Public_hospital.png">
              <span class="HealthCare subcategory-label">Public_hospital</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Red_cross" name="Red_cross"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Red_cross.png">
              <span class="HealthCare subcategory-label">Red_cross</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Residential_care_activities" name="Residential_care_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Residential_care_activities.png">
              <span class="HealthCare subcategory-label">Residential_care_activities</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Senior_centre" name="Senior_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Senior_centre.png">
              <span class="HealthCare subcategory-label">Senior_centre</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Social_work" name="Social_work"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Social_work.png">
              <span class="HealthCare subcategory-label">Social_work</span>
              <br>
              <input type="checkbox" class="sub_HealthCare subcategory" value="Youth_assistance" name="Youth_assistance"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Youth_assistance.png">
              <span class="HealthCare subcategory-label">Youth_assistance</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="IndustryAndManufacturing" name="IndustryAndManufacturing"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing.png"> <span class="IndustryAndManufacturing macrocategory-label">IndustryAndManufacturing</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Animal_feeds_manufacture" name="Animal_feeds_manufacture"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Animal_feeds_manufacture.png">
              <span class="IndustryAndManufacturing subcategory-label">Animal_feeds_manufacture</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Beverage_manufacture" name="Beverage_manufacture"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Beverage_manufacture.png">
              <span class="IndustryAndManufacturing subcategory-label">Beverage_manufacture</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Building_materials_manufacture" name="Building_materials_manufacture"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Building_materials_manufacture.png">
              <span class="IndustryAndManufacturing subcategory-label">Building_materials_manufacture</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Coke_and_petroleum_derivatives" name="Coke_and_petroleum_derivatives"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Coke_and_petroleum_derivatives.png">
              <span class="IndustryAndManufacturing subcategory-label">Coke_and_petroleum_derivatives</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Computer_data_processing" name="Computer_data_processing"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Computer_data_processing.png">
              <span class="IndustryAndManufacturing subcategory-label">Computer_data_processing</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Computer_programming_and_consultancy" name="Computer_programming_and_consultancy"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Computer_programming_and_consultancy.png">
              <span class="IndustryAndManufacturing subcategory-label">Computer_programming_and_consultancy</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Food_manufacture" name="Food_manufacture"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Food_manufacture.png">
              <span class="IndustryAndManufacturing subcategory-label">Food_manufacture</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Footwear_manufacture" name="Footwear_manufacture"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Footwear_manufacture.png">
              <span class="IndustryAndManufacturing subcategory-label">Footwear_manufacture</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Ict_service" name="Ict_service"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Ict_service.png">
              <span class="IndustryAndManufacturing subcategory-label">Ict_service</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Installation_of_industrial_machinery" name="Installation_of_industrial_machinery"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Installation_of_industrial_machinery.png">
              <span class="IndustryAndManufacturing subcategory-label">Installation_of_industrial_machinery</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Knitted_manufacture" name="Knitted_manufacture"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Knitted_manufacture.png">
              <span class="IndustryAndManufacturing subcategory-label">Knitted_manufacture</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Leather_manufacture" name="Leather_manufacture"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Leather_manufacture.png">
              <span class="IndustryAndManufacturing subcategory-label">Leather_manufacture</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Machinery_repair_and_installation" name="Machinery_repair_and_installation"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Machinery_repair_and_installation.png">
              <span class="IndustryAndManufacturing subcategory-label">Machinery_repair_and_installation</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_basic_metals" name="Manufacture_of_basic_metals"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_basic_metals.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_basic_metals</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_chemicals_products" name="Manufacture_of_chemicals_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_chemicals_products.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_chemicals_products</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_clay_and_ceramic" name="Manufacture_of_clay_and_ceramic"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_clay_and_ceramic.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_clay_and_ceramic</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_electrical_equipment" name="Manufacture_of_electrical_equipment"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_electrical_equipment.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_electrical_equipment</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_electronic_products" name="Manufacture_of_electronic_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_electronic_products.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_electronic_products</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_furniture" name="Manufacture_of_furniture"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_furniture.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_furniture</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_glass" name="Manufacture_of_glass"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_glass.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_glass</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_jewellery_bijouterie" name="Manufacture_of_jewellery_bijouterie"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_jewellery_bijouterie.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_jewellery_bijouterie</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_machinery_and_equipment" name="Manufacture_of_machinery_and_equipment"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_machinery_and_equipment.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_machinery_and_equipment</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_motor_vehicles" name="Manufacture_of_motor_vehicles"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_motor_vehicles.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_motor_vehicles</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_musical_instruments" name="Manufacture_of_musical_instruments"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_musical_instruments.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_musical_instruments</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_non_metallic_mineral_products" name="Manufacture_of_non_metallic_mineral_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_non_metallic_mineral_products.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_non_metallic_mineral_products</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_paper" name="Manufacture_of_paper"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_paper.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_paper</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_paper_products" name="Manufacture_of_paper_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_paper_products.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_paper_products</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_pharmaceutical_products" name="Manufacture_of_pharmaceutical_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_pharmaceutical_products.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_pharmaceutical_products</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_plastics_products" name="Manufacture_of_plastics_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_plastics_products.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_plastics_products</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_refined_petroleum_products" name="Manufacture_of_refined_petroleum_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_refined_petroleum_products.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_refined_petroleum_products</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_refractory_products" name="Manufacture_of_refractory_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_refractory_products.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_refractory_products</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_rubber_and_plastics_products" name="Manufacture_of_rubber_and_plastics_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_rubber_and_plastics_products.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_rubber_and_plastics_products</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_rubber_products" name="Manufacture_of_rubber_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_rubber_products.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_rubber_products</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_sports_goods" name="Manufacture_of_sports_goods"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_sports_goods.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_sports_goods</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_structural_metal_products" name="Manufacture_of_structural_metal_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_structural_metal_products.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_structural_metal_products</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_textiles" name="Manufacture_of_textiles"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_textiles.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_textiles</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_toys_and_game" name="Manufacture_of_toys_and_game"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_toys_and_game.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_toys_and_game</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_transport_equipment" name="Manufacture_of_transport_equipment"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_transport_equipment.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_transport_equipment</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_travel_articles" name="Manufacture_of_travel_articles"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_travel_articles.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_travel_articles</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_wearing_apparel" name="Manufacture_of_wearing_apparel"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_wearing_apparel.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_wearing_apparel</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_wood" name="Manufacture_of_wood"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_wood.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_wood</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Manufacture_of_wood_products" name="Manufacture_of_wood_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Manufacture_of_wood_products.png">
              <span class="IndustryAndManufacturing subcategory-label">Manufacture_of_wood_products</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Mining_support_services" name="Mining_support_services"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Mining_support_services.png">
              <span class="IndustryAndManufacturing subcategory-label">Mining_support_services</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Other_manufacturing" name="Other_manufacturing"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Other_manufacturing.png">
              <span class="IndustryAndManufacturing subcategory-label">Other_manufacturing</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Quality_control_and_certification" name="Quality_control_and_certification"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Quality_control_and_certification.png">
              <span class="IndustryAndManufacturing subcategory-label">Quality_control_and_certification</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Sawmilling" name="Sawmilling"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Sawmilling.png">
              <span class="IndustryAndManufacturing subcategory-label">Sawmilling</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Software_publishing" name="Software_publishing"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Software_publishing.png">
              <span class="IndustryAndManufacturing subcategory-label">Software_publishing</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Specialized_design" name="Specialized_design"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Specialized_design.png">
              <span class="IndustryAndManufacturing subcategory-label">Specialized_design</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Stone_processing" name="Stone_processing"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Stone_processing.png">
              <span class="IndustryAndManufacturing subcategory-label">Stone_processing</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Tannery" name="Tannery"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Tannery.png">
              <span class="IndustryAndManufacturing subcategory-label">Tannery</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Technical_testing" name="Technical_testing"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Technical_testing.png">
              <span class="IndustryAndManufacturing subcategory-label">Technical_testing</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Textile_manufacturing" name="Textile_manufacturing"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Textile_manufacturing.png">
              <span class="IndustryAndManufacturing subcategory-label">Textile_manufacturing</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Tobacco_industry" name="Tobacco_industry"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Tobacco_industry.png">
              <span class="IndustryAndManufacturing subcategory-label">Tobacco_industry</span>
              <br>
              <input type="checkbox" class="sub_IndustryAndManufacturing subcategory" value="Web_and_internet_provider" name="Web_and_internet_provider"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/IndustryAndManufacturing_Web_and_internet_provider.png">
              <span class="IndustryAndManufacturing subcategory-label">Web_and_internet_provider</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="MiningAndQuarrying" name="MiningAndQuarrying"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/MiningAndQuarrying.png"> <span class="MiningAndQuarrying macrocategory-label">MiningAndQuarrying</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_MiningAndQuarrying subcategory" value="Extraction_of_salt" name="Extraction_of_salt"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/MiningAndQuarrying_Extraction_of_salt.png">
              <span class="MiningAndQuarrying subcategory-label">Extraction_of_salt</span>
              <br>
              <input type="checkbox" class="sub_MiningAndQuarrying subcategory" value="Mining_of_metal_ores" name="Mining_of_metal_ores"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/MiningAndQuarrying_Mining_of_metal_ores.png">
              <span class="MiningAndQuarrying subcategory-label">Mining_of_metal_ores</span>
              <br>
              <input type="checkbox" class="sub_MiningAndQuarrying subcategory" value="Other_mining_and_quarrying" name="Other_mining_and_quarrying"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/MiningAndQuarrying_Other_mining_and_quarrying.png">
              <span class="MiningAndQuarrying subcategory-label">Other_mining_and_quarrying</span>
              <br>
              <input type="checkbox" class="sub_MiningAndQuarrying subcategory" value="Petroleum_and_natural_gas_extraction" name="Petroleum_and_natural_gas_extraction"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/MiningAndQuarrying_Petroleum_and_natural_gas_extraction.png">
              <span class="MiningAndQuarrying subcategory-label">Petroleum_and_natural_gas_extraction</span>
              <br>
              <input type="checkbox" class="sub_MiningAndQuarrying subcategory" value="Quarrying_of_stone_sand_and_clay" name="Quarrying_of_stone_sand_and_clay"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/MiningAndQuarrying_Quarrying_of_stone_sand_and_clay.png">
              <span class="MiningAndQuarrying subcategory-label">Quarrying_of_stone_sand_and_clay</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="ShoppingAndService" name="ShoppingAndService"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService.png"> <span class="ShoppingAndService macrocategory-label">ShoppingAndService</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Adult_clothing" name="Adult_clothing"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Adult_clothing.png">
              <span class="ShoppingAndService subcategory-label">Adult_clothing</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Antiques" name="Antiques"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Antiques.png">
              <span class="ShoppingAndService subcategory-label">Antiques</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Artisan_shop" name="Artisan_shop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Artisan_shop.png">
              <span class="ShoppingAndService subcategory-label">Artisan_shop</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Art_galleries" name="Art_galleries"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Art_galleries.png">
              <span class="ShoppingAndService subcategory-label">Art_galleries</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Auctioning_houses" name="Auctioning_houses"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Auctioning_houses.png">
              <span class="ShoppingAndService subcategory-label">Auctioning_houses</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Audio_and_video" name="Audio_and_video"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Audio_and_video.png">
              <span class="ShoppingAndService subcategory-label">Audio_and_video</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Beauty_centre" name="Beauty_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Beauty_centre.png">
              <span class="ShoppingAndService subcategory-label">Beauty_centre</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Boat_equipment" name="Boat_equipment"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Boat_equipment.png">
              <span class="ShoppingAndService subcategory-label">Boat_equipment</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Bookshop" name="Bookshop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Bookshop.png">
              <span class="ShoppingAndService subcategory-label">Bookshop</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Building_material" name="Building_material"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Building_material.png">
              <span class="ShoppingAndService subcategory-label">Building_material</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Carpentry" name="Carpentry"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Carpentry.png">
              <span class="ShoppingAndService subcategory-label">Carpentry</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Carpets" name="Carpets"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Carpets.png">
              <span class="ShoppingAndService subcategory-label">Carpets</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Carpets_and_curtains" name="Carpets_and_curtains"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Carpets_and_curtains.png">
              <span class="ShoppingAndService subcategory-label">Carpets_and_curtains</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Car_washing" name="Car_washing"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Car_washing.png">
              <span class="ShoppingAndService subcategory-label">Car_washing</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Cleaning_materials" name="Cleaning_materials"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Cleaning_materials.png">
              <span class="ShoppingAndService subcategory-label">Cleaning_materials</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Clothing" name="Clothing"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Clothing.png">
              <span class="ShoppingAndService subcategory-label">Clothing</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Clothing_accessories" name="Clothing_accessories"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Clothing_accessories.png">
              <span class="ShoppingAndService subcategory-label">Clothing_accessories</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Clothing_and_linen" name="Clothing_and_linen"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Clothing_and_linen.png">
              <span class="ShoppingAndService subcategory-label">Clothing_and_linen</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Clothing_children_and_infants" name="Clothing_children_and_infants"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Clothing_children_and_infants.png">
              <span class="ShoppingAndService subcategory-label">Clothing_children_and_infants</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Clothing_factory_outlet" name="Clothing_factory_outlet"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Clothing_factory_outlet.png">
              <span class="ShoppingAndService subcategory-label">Clothing_factory_outlet</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Coffee_rosters" name="Coffee_rosters"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Coffee_rosters.png">
              <span class="ShoppingAndService subcategory-label">Coffee_rosters</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Computer_systems" name="Computer_systems"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Computer_systems.png">
              <span class="ShoppingAndService subcategory-label">Computer_systems</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Computer_technician" name="Computer_technician"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Computer_technician.png">
              <span class="ShoppingAndService subcategory-label">Computer_technician</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Cultural_and_recreation_goods" name="Cultural_and_recreation_goods"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Cultural_and_recreation_goods.png">
              <span class="ShoppingAndService subcategory-label">Cultural_and_recreation_goods</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Curtains_and_net_curtains" name="Curtains_and_net_curtains"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Curtains_and_net_curtains.png">
              <span class="ShoppingAndService subcategory-label">Curtains_and_net_curtains</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Dairy_products" name="Dairy_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Dairy_products.png">
              <span class="ShoppingAndService subcategory-label">Dairy_products</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Dating_service" name="Dating_service"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Dating_service.png">
              <span class="ShoppingAndService subcategory-label">Dating_service</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Diet_products" name="Diet_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Diet_products.png">
              <span class="ShoppingAndService subcategory-label">Diet_products</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Discount" name="Discount"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Discount.png">
              <span class="ShoppingAndService subcategory-label">Discount</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Door_to_door" name="Door_to_door"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Door_to_door.png">
              <span class="ShoppingAndService subcategory-label">Door_to_door</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Estate_activities" name="Estate_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Estate_activities.png">
              <span class="ShoppingAndService subcategory-label">Estate_activities</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Fine_arts_articles" name="Fine_arts_articles"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Fine_arts_articles.png">
              <span class="ShoppingAndService subcategory-label">Fine_arts_articles</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Fish_and_seafood" name="Fish_and_seafood"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Fish_and_seafood.png">
              <span class="ShoppingAndService subcategory-label">Fish_and_seafood</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Flower_shop" name="Flower_shop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Flower_shop.png">
              <span class="ShoppingAndService subcategory-label">Flower_shop</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Food_and_tobacconist" name="Food_and_tobacconist"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Food_and_tobacconist.png">
              <span class="ShoppingAndService subcategory-label">Food_and_tobacconist</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Footwear_and_accessories" name="Footwear_and_accessories"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Footwear_and_accessories.png">
              <span class="ShoppingAndService subcategory-label">Footwear_and_accessories</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Footwear_and_leather_goods" name="Footwear_and_leather_goods"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Footwear_and_leather_goods.png">
              <span class="ShoppingAndService subcategory-label">Footwear_and_leather_goods</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Footwear_factory_outlet" name="Footwear_factory_outlet"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Footwear_factory_outlet.png">
              <span class="ShoppingAndService subcategory-label">Footwear_factory_outlet</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Frozen_food" name="Frozen_food"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Frozen_food.png">
              <span class="ShoppingAndService subcategory-label">Frozen_food</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Fruit_and_vegetables" name="Fruit_and_vegetables"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Fruit_and_vegetables.png">
              <span class="ShoppingAndService subcategory-label">Fruit_and_vegetables</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Funeral" name="Funeral"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Funeral.png">
              <span class="ShoppingAndService subcategory-label">Funeral</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Funeral_and_cemetery_articles" name="Funeral_and_cemetery_articles"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Funeral_and_cemetery_articles.png">
              <span class="ShoppingAndService subcategory-label">Funeral_and_cemetery_articles</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Fur_and_leather_clothing" name="Fur_and_leather_clothing"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Fur_and_leather_clothing.png">
              <span class="ShoppingAndService subcategory-label">Fur_and_leather_clothing</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Games_and_toys" name="Games_and_toys"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Games_and_toys.png">
              <span class="ShoppingAndService subcategory-label">Games_and_toys</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Garden_and_agriculture" name="Garden_and_agriculture"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Garden_and_agriculture.png">
              <span class="ShoppingAndService subcategory-label">Garden_and_agriculture</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Gifts_and_smoking_articles" name="Gifts_and_smoking_articles"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Gifts_and_smoking_articles.png">
              <span class="ShoppingAndService subcategory-label">Gifts_and_smoking_articles</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Haberdashery" name="Haberdashery"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Haberdashery.png">
              <span class="ShoppingAndService subcategory-label">Haberdashery</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Hairdressing" name="Hairdressing"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Hairdressing.png">
              <span class="ShoppingAndService subcategory-label">Hairdressing</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Hairdressing_and_beauty_treatment" name="Hairdressing_and_beauty_treatment"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Hairdressing_and_beauty_treatment.png">
              <span class="ShoppingAndService subcategory-label">Hairdressing_and_beauty_treatment</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Hardware_electrical_plumbing_and_heating" name="Hardware_electrical_plumbing_and_heating"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Hardware_electrical_plumbing_and_heating.png">
              <span class="ShoppingAndService subcategory-label">Hardware_electrical_plumbing_and_heating</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Hardware_paints_and_glass" name="Hardware_paints_and_glass"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Hardware_paints_and_glass.png">
              <span class="ShoppingAndService subcategory-label">Hardware_paints_and_glass</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Herbalists_shop" name="Herbalists_shop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Herbalists_shop.png">
              <span class="ShoppingAndService subcategory-label">Herbalists_shop</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Household_appliances_shop" name="Household_appliances_shop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Household_appliances_shop.png">
              <span class="ShoppingAndService subcategory-label">Household_appliances_shop</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Household_articles" name="Household_articles"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Household_articles.png">
              <span class="ShoppingAndService subcategory-label">Household_articles</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Household_fuel" name="Household_fuel"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Household_fuel.png">
              <span class="ShoppingAndService subcategory-label">Household_fuel</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Household_furniture" name="Household_furniture"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Household_furniture.png">
              <span class="ShoppingAndService subcategory-label">Household_furniture</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Household_products" name="Household_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Household_products.png">
              <span class="ShoppingAndService subcategory-label">Household_products</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Household_utensils" name="Household_utensils"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Household_utensils.png">
              <span class="ShoppingAndService subcategory-label">Household_utensils</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Hypermarket" name="Hypermarket"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Hypermarket.png">
              <span class="ShoppingAndService subcategory-label">Hypermarket</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Industrial_laundries" name="Industrial_laundries"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Industrial_laundries.png">
              <span class="ShoppingAndService subcategory-label">Industrial_laundries</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Jeweller" name="Jeweller"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Jeweller.png">
              <span class="ShoppingAndService subcategory-label">Jeweller</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Jewellery" name="Jewellery"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Jewellery.png">
              <span class="ShoppingAndService subcategory-label">Jewellery</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Laundries_and_dry_cleaners" name="Laundries_and_dry_cleaners"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Laundries_and_dry_cleaners.png">
              <span class="ShoppingAndService subcategory-label">Laundries_and_dry_cleaners</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Lighting" name="Lighting"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Lighting.png">
              <span class="ShoppingAndService subcategory-label">Lighting</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Maintenance_repair_of_motorcycles" name="Maintenance_repair_of_motorcycles"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Maintenance_repair_of_motorcycles.png">
              <span class="ShoppingAndService subcategory-label">Maintenance_repair_of_motorcycles</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Maintenance_repair_of_motor_vehicles" name="Maintenance_repair_of_motor_vehicles"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Maintenance_repair_of_motor_vehicles.png">
              <span class="ShoppingAndService subcategory-label">Maintenance_repair_of_motor_vehicles</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Manicure_and_pedicure" name="Manicure_and_pedicure"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Manicure_and_pedicure.png">
              <span class="ShoppingAndService subcategory-label">Manicure_and_pedicure</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Meat_and_poultry" name="Meat_and_poultry"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Meat_and_poultry.png">
              <span class="ShoppingAndService subcategory-label">Meat_and_poultry</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Mechanic_workshop" name="Mechanic_workshop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Mechanic_workshop.png">
              <span class="ShoppingAndService subcategory-label">Mechanic_workshop</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Medical_and_orthopaedic_goods" name="Medical_and_orthopaedic_goods"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Medical_and_orthopaedic_goods.png">
              <span class="ShoppingAndService subcategory-label">Medical_and_orthopaedic_goods</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Minimarket" name="Minimarket"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Minimarket.png">
              <span class="ShoppingAndService subcategory-label">Minimarket</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Motorcycles_parts_wholesale_and_retail" name="Motorcycles_parts_wholesale_and_retail"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Motorcycles_parts_wholesale_and_retail.png">
              <span class="ShoppingAndService subcategory-label">Motorcycles_parts_wholesale_and_retail</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Motorcycles_wholesale_and_retail" name="Motorcycles_wholesale_and_retail"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Motorcycles_wholesale_and_retail.png">
              <span class="ShoppingAndService subcategory-label">Motorcycles_wholesale_and_retail</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Motor_vehicles_wholesale_and_retail" name="Motor_vehicles_wholesale_and_retail"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Motor_vehicles_wholesale_and_retail.png">
              <span class="ShoppingAndService subcategory-label">Motor_vehicles_wholesale_and_retail</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Musical_instruments_and_scores" name="Musical_instruments_and_scores"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Musical_instruments_and_scores.png">
              <span class="ShoppingAndService subcategory-label">Musical_instruments_and_scores</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Music_and_video_recordings" name="Music_and_video_recordings"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Music_and_video_recordings.png">
              <span class="ShoppingAndService subcategory-label">Music_and_video_recordings</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Newspapers_and_stationery" name="Newspapers_and_stationery"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Newspapers_and_stationery.png">
              <span class="ShoppingAndService subcategory-label">Newspapers_and_stationery</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Non_food_large_retailers" name="Non_food_large_retailers"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Non_food_large_retailers.png">
              <span class="ShoppingAndService subcategory-label">Non_food_large_retailers</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Non_food_products" name="Non_food_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Non_food_products.png">
              <span class="ShoppingAndService subcategory-label">Non_food_products</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Office_furniture" name="Office_furniture"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Office_furniture.png">
              <span class="ShoppingAndService subcategory-label">Office_furniture</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Optics_and_photography" name="Optics_and_photography"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Optics_and_photography.png">
              <span class="ShoppingAndService subcategory-label">Optics_and_photography</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Other_goods" name="Other_goods"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Other_goods.png">
              <span class="ShoppingAndService subcategory-label">Other_goods</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Other_retail_sale" name="Other_retail_sale"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Other_retail_sale.png">
              <span class="ShoppingAndService subcategory-label">Other_retail_sale</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Parties_and_ceremonies" name="Parties_and_ceremonies"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Parties_and_ceremonies.png">
              <span class="ShoppingAndService subcategory-label">Parties_and_ceremonies</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Perfumery_and_cosmetic_articles" name="Perfumery_and_cosmetic_articles"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Perfumery_and_cosmetic_articles.png">
              <span class="ShoppingAndService subcategory-label">Perfumery_and_cosmetic_articles</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Personal_service_activities" name="Personal_service_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Personal_service_activities.png">
              <span class="ShoppingAndService subcategory-label">Personal_service_activities</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Pet_care_services" name="Pet_care_services"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Pet_care_services.png">
              <span class="ShoppingAndService subcategory-label">Pet_care_services</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Pet_shop" name="Pet_shop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Pet_shop.png">
              <span class="ShoppingAndService subcategory-label">Pet_shop</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Pharmaceuticals" name="Pharmaceuticals"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Pharmaceuticals.png">
              <span class="ShoppingAndService subcategory-label">Pharmaceuticals</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Pharmacy" name="Pharmacy"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Pharmacy.png">
              <span class="ShoppingAndService subcategory-label">Pharmacy</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Repair" name="Repair"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Repair.png">
              <span class="ShoppingAndService subcategory-label">Repair</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Repair_musical_instruments" name="Repair_musical_instruments"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Repair_musical_instruments.png">
              <span class="ShoppingAndService subcategory-label">Repair_musical_instruments</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Repair_of_communication_equipment" name="Repair_of_communication_equipment"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Repair_of_communication_equipment.png">
              <span class="ShoppingAndService subcategory-label">Repair_of_communication_equipment</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Repair_of_consumer_electronics" name="Repair_of_consumer_electronics"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Repair_of_consumer_electronics.png">
              <span class="ShoppingAndService subcategory-label">Repair_of_consumer_electronics</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Repair_of_footwear_and_leather_goods" name="Repair_of_footwear_and_leather_goods"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Repair_of_footwear_and_leather_goods.png">
              <span class="ShoppingAndService subcategory-label">Repair_of_footwear_and_leather_goods</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Repair_of_garden_equipment" name="Repair_of_garden_equipment"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Repair_of_garden_equipment.png">
              <span class="ShoppingAndService subcategory-label">Repair_of_garden_equipment</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Repair_of_home_equipment" name="Repair_of_home_equipment"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Repair_of_home_equipment.png">
              <span class="ShoppingAndService subcategory-label">Repair_of_home_equipment</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Repair_of_household_appliances" name="Repair_of_household_appliances"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Repair_of_household_appliances.png">
              <span class="ShoppingAndService subcategory-label">Repair_of_household_appliances</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Repair_of_sporting_goods" name="Repair_of_sporting_goods"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Repair_of_sporting_goods.png">
              <span class="ShoppingAndService subcategory-label">Repair_of_sporting_goods</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Restorers" name="Restorers"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Restorers.png">
              <span class="ShoppingAndService subcategory-label">Restorers</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Retail_motor_vehicles_parts" name="Retail_motor_vehicles_parts"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Retail_motor_vehicles_parts.png">
              <span class="ShoppingAndService subcategory-label">Retail_motor_vehicles_parts</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Retail_sale_non_specialized_stores" name="Retail_sale_non_specialized_stores"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Retail_sale_non_specialized_stores.png">
              <span class="ShoppingAndService subcategory-label">Retail_sale_non_specialized_stores</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Retail_trade" name="Retail_trade"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Retail_trade.png">
              <span class="ShoppingAndService subcategory-label">Retail_trade</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Rope_cord_and_twine" name="Rope_cord_and_twine"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Rope_cord_and_twine.png">
              <span class="ShoppingAndService subcategory-label">Rope_cord_and_twine</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Sale_motor_vehicles_parts" name="Sale_motor_vehicles_parts"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Sale_motor_vehicles_parts.png">
              <span class="ShoppingAndService subcategory-label">Sale_motor_vehicles_parts</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Sale_of_motorcycles" name="Sale_of_motorcycles"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Sale_of_motorcycles.png">
              <span class="ShoppingAndService subcategory-label">Sale_of_motorcycles</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Sale_of_motor_vehicles" name="Sale_of_motor_vehicles"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Sale_of_motor_vehicles.png">
              <span class="ShoppingAndService subcategory-label">Sale_of_motor_vehicles</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Sale_of_motor_vehicles_and_motorcycles" name="Sale_of_motor_vehicles_and_motorcycles"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Sale_of_motor_vehicles_and_motorcycles.png">
              <span class="ShoppingAndService subcategory-label">Sale_of_motor_vehicles_and_motorcycles</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Sale_via_mail_order_houses_or_via_internet" name="Sale_via_mail_order_houses_or_via_internet"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Sale_via_mail_order_houses_or_via_internet.png">
              <span class="ShoppingAndService subcategory-label">Sale_via_mail_order_houses_or_via_internet</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Sanitary_equipment" name="Sanitary_equipment"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Sanitary_equipment.png">
              <span class="ShoppingAndService subcategory-label">Sanitary_equipment</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Second_hand_books" name="Second_hand_books"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Second_hand_books.png">
              <span class="ShoppingAndService subcategory-label">Second_hand_books</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Second_hand_goods" name="Second_hand_goods"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Second_hand_goods.png">
              <span class="ShoppingAndService subcategory-label">Second_hand_goods</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Security_systems" name="Security_systems"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Security_systems.png">
              <span class="ShoppingAndService subcategory-label">Security_systems</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Sexy_shop" name="Sexy_shop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Sexy_shop.png">
              <span class="ShoppingAndService subcategory-label">Sexy_shop</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Shopping_centre" name="Shopping_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Shopping_centre.png">
              <span class="ShoppingAndService subcategory-label">Shopping_centre</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Single_brand_store" name="Single_brand_store"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Single_brand_store.png">
              <span class="ShoppingAndService subcategory-label">Single_brand_store</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Small_household_appliances" name="Small_household_appliances"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Small_household_appliances.png">
              <span class="ShoppingAndService subcategory-label">Small_household_appliances</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Souvenirs_craftwork_and_religious_articles" name="Souvenirs_craftwork_and_religious_articles"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Souvenirs_craftwork_and_religious_articles.png">
              <span class="ShoppingAndService subcategory-label">Souvenirs_craftwork_and_religious_articles</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Sporting_equipment" name="Sporting_equipment"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Sporting_equipment.png">
              <span class="ShoppingAndService subcategory-label">Sporting_equipment</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Stalls_and_markets" name="Stalls_and_markets"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Stalls_and_markets.png">
              <span class="ShoppingAndService subcategory-label">Stalls_and_markets</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Stalls_and_markets_of_clothing_and_footwear" name="Stalls_and_markets_of_clothing_and_footwear"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Stalls_and_markets_of_clothing_and_footwear.png">
              <span class="ShoppingAndService subcategory-label">Stalls_and_markets_of_clothing_and_footwear</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Stalls_and_markets_of_food" name="Stalls_and_markets_of_food"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Stalls_and_markets_of_food.png">
              <span class="ShoppingAndService subcategory-label">Stalls_and_markets_of_food</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Stalls_and_markets_other_goods" name="Stalls_and_markets_other_goods"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Stalls_and_markets_other_goods.png">
              <span class="ShoppingAndService subcategory-label">Stalls_and_markets_other_goods</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Stamps_and_coins" name="Stamps_and_coins"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Stamps_and_coins.png">
              <span class="ShoppingAndService subcategory-label">Stamps_and_coins</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Supermarket" name="Supermarket"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Supermarket.png">
              <span class="ShoppingAndService subcategory-label">Supermarket</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Tattoo_and_piercing" name="Tattoo_and_piercing"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Tattoo_and_piercing.png">
              <span class="ShoppingAndService subcategory-label">Tattoo_and_piercing</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Telecommunications" name="Telecommunications"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Telecommunications.png">
              <span class="ShoppingAndService subcategory-label">Telecommunications</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Textiles_products" name="Textiles_products"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Textiles_products.png">
              <span class="ShoppingAndService subcategory-label">Textiles_products</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Tobacco_shop" name="Tobacco_shop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Tobacco_shop.png">
              <span class="ShoppingAndService subcategory-label">Tobacco_shop</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Travel_goods" name="Travel_goods"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Travel_goods.png">
              <span class="ShoppingAndService subcategory-label">Travel_goods</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Trinkets" name="Trinkets"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Trinkets.png">
              <span class="ShoppingAndService subcategory-label">Trinkets</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Underwear_knitwear_and_shirts" name="Underwear_knitwear_and_shirts"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Underwear_knitwear_and_shirts.png">
              <span class="ShoppingAndService subcategory-label">Underwear_knitwear_and_shirts</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Upholsterer" name="Upholsterer"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Upholsterer.png">
              <span class="ShoppingAndService subcategory-label">Upholsterer</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Vacating_service" name="Vacating_service"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Vacating_service.png">
              <span class="ShoppingAndService subcategory-label">Vacating_service</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Vehicle_trade" name="Vehicle_trade"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Vehicle_trade.png">
              <span class="ShoppingAndService subcategory-label">Vehicle_trade</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Vending_machines" name="Vending_machines"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Vending_machines.png">
              <span class="ShoppingAndService subcategory-label">Vending_machines</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Wallpaper_and_floor_coverings" name="Wallpaper_and_floor_coverings"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Wallpaper_and_floor_coverings.png">
              <span class="ShoppingAndService subcategory-label">Wallpaper_and_floor_coverings</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Weapons_and_ammunition" name="Weapons_and_ammunition"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Weapons_and_ammunition.png">
              <span class="ShoppingAndService subcategory-label">Weapons_and_ammunition</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Wedding_favors" name="Wedding_favors"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Wedding_favors.png">
              <span class="ShoppingAndService subcategory-label">Wedding_favors</span>
              <br>
              <input type="checkbox" class="sub_ShoppingAndService subcategory" value="Wellness_centre" name="Wellness_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Wellness_centre.png">
              <span class="ShoppingAndService subcategory-label">Wellness_centre</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="TourismService" name="TourismService"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/TourismService.png"> <span class="TourismService macrocategory-label">TourismService</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_TourismService subcategory" value="Beacon" name="Beacon"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Beacon.png">
              <span class="TourismService subcategory-label">Beacon</span>
              <br>
              <input type="checkbox" class="sub_TourismService subcategory" value="Camper_service" name="Camper_service"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Camper_service.png">
              <span class="TourismService subcategory-label">Camper_service</span>
              <br>
              <input type="checkbox" class="sub_TourismService subcategory" value="Fresh_place" name="Fresh_place"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Fresh_place.png">
              <span class="TourismService subcategory-label">Fresh_place</span>
              <br>
              <input type="checkbox" class="sub_TourismService subcategory" value="Pedestrian_zone" name="Pedestrian_zone"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Pedestrian_zone.png">
              <span class="TourismService subcategory-label">Pedestrian_zone</span>
              <br>
              <input type="checkbox" class="sub_TourismService subcategory" value="Ticket_sale" name="Ticket_sale"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Ticket_sale.png">
              <span class="TourismService subcategory-label">Ticket_sale</span>
              <br>
              <input type="checkbox" class="sub_TourismService subcategory" value="Toilet" name="Toilet"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Toilet.png">
              <span class="TourismService subcategory-label">Toilet</span>
              <br>
              <input type="checkbox" class="sub_TourismService subcategory" value="Tourist_complaints_office" name="Tourist_complaints_office"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Tourist_complaints_office.png">
              <span class="TourismService subcategory-label">Tourist_complaints_office</span>
              <br>
              <input type="checkbox" class="sub_TourismService subcategory" value="Tourist_guides" name="Tourist_guides"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Tourist_guides.png">
              <span class="TourismService subcategory-label">Tourist_guides</span>
              <br>
              <input type="checkbox" class="sub_TourismService subcategory" value="Tourist_information_office" name="Tourist_information_office"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Tourist_information_office.png">
              <span class="TourismService subcategory-label">Tourist_information_office</span>
              <br>
              <input type="checkbox" class="sub_TourismService subcategory" value="Tourist_trail" name="Tourist_trail"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Tourist_trail.png">
              <span class="TourismService subcategory-label">Tourist_trail</span>
              <br>
              <input type="checkbox" class="sub_TourismService subcategory" value="Tour_operator" name="Tour_operator"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Tour_operator.png">
              <span class="TourismService subcategory-label">Tour_operator</span>
              <br>
              <input type="checkbox" class="sub_TourismService subcategory" value="Travel_agency" name="Travel_agency"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Travel_agency.png">
              <span class="TourismService subcategory-label">Travel_agency</span>
              <br>
              <input type="checkbox" class="sub_TourismService subcategory" value="Travel_bureau" name="Travel_bureau"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Travel_bureau.png">
              <span class="TourismService subcategory-label">Travel_bureau</span>
              <br>
              <input type="checkbox" class="sub_TourismService subcategory" value="Travel_information" name="Travel_information"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Travel_information.png">
              <span class="TourismService subcategory-label">Travel_information</span>
              <br>
              <input type="checkbox" class="sub_TourismService subcategory" value="Wifi" name="Wifi"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Wifi.png">
              <span class="TourismService subcategory-label">Wifi</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="TransferServiceAndRenting" name="TransferServiceAndRenting"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting.png"> <span class="TransferServiceAndRenting macrocategory-label">TransferServiceAndRenting</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Airfields" name="Airfields"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Airfields.png">
              <span class="TransferServiceAndRenting subcategory-label">Airfields</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Airplanes_rental" name="Airplanes_rental"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Airplanes_rental.png">
              <span class="TransferServiceAndRenting subcategory-label">Airplanes_rental</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Bike_rack" name="Bike_rack"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Bike_rack.png">
              <span class="TransferServiceAndRenting subcategory-label">Bike_rack</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Bike_rental" name="Bike_rental"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Bike_rental.png">
              <span class="TransferServiceAndRenting subcategory-label">Bike_rental</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Boats_and_ships_rental" name="Boats_and_ships_rental"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Boats_and_ships_rental.png">
              <span class="TransferServiceAndRenting subcategory-label">Boats_and_ships_rental</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="BusStop" name="BusStop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_BusStop.png">
              <span class="TransferServiceAndRenting subcategory-label">BusStop</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Bus_tickets_retail" name="Bus_tickets_retail"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Bus_tickets_retail.png">
              <span class="TransferServiceAndRenting subcategory-label">Bus_tickets_retail</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Cargo_handling" name="Cargo_handling"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Cargo_handling.png">
              <span class="TransferServiceAndRenting subcategory-label">Cargo_handling</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Car_park" name="Car_park"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Car_park.png">
              <span class="TransferServiceAndRenting subcategory-label">Car_park</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Car_rental_with_driver" name="Car_rental_with_driver"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Car_rental_with_driver.png">
              <span class="TransferServiceAndRenting subcategory-label">Car_rental_with_driver</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Charging_stations" name="Charging_stations"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Charging_stations.png">
              <span class="TransferServiceAndRenting subcategory-label">Charging_stations</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Charter_airlines" name="Charter_airlines"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Charter_airlines.png">
              <span class="TransferServiceAndRenting subcategory-label">Charter_airlines</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Civil_airport" name="Civil_airport"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Civil_airport.png">
              <span class="TransferServiceAndRenting subcategory-label">Civil_airport</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Controlled_parking_zone" name="Controlled_parking_zone"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Controlled_parking_zone.png">
              <span class="TransferServiceAndRenting subcategory-label">Controlled_parking_zone</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Courier" name="Courier"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Courier.png">
              <span class="TransferServiceAndRenting subcategory-label">Courier</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Cycle_paths" name="Cycle_paths"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Cycle_paths.png">
              <span class="TransferServiceAndRenting subcategory-label">Cycle_paths</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Flight_companies" name="Flight_companies"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Flight_companies.png">
              <span class="TransferServiceAndRenting subcategory-label">Flight_companies</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Freight_transport_and_furniture_removal" name="Freight_transport_and_furniture_removal"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Freight_transport_and_furniture_removal.png">
              <span class="TransferServiceAndRenting subcategory-label">Freight_transport_and_furniture_removal</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Fuel_station" name="Fuel_station"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Fuel_station.png">
              <span class="TransferServiceAndRenting subcategory-label">Fuel_station</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Helipads" name="Helipads"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Helipads.png">
              <span class="TransferServiceAndRenting subcategory-label">Helipads</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Land_transport" name="Land_transport"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Land_transport.png">
              <span class="TransferServiceAndRenting subcategory-label">Land_transport</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Land_transport_rental" name="Land_transport_rental"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Land_transport_rental.png">
              <span class="TransferServiceAndRenting subcategory-label">Land_transport_rental</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Lifting_and_handling_equipment_rental" name="Lifting_and_handling_equipment_rental"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Lifting_and_handling_equipment_rental.png">
              <span class="TransferServiceAndRenting subcategory-label">Lifting_and_handling_equipment_rental</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Logistics_activities" name="Logistics_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Logistics_activities.png">
              <span class="TransferServiceAndRenting subcategory-label">Logistics_activities</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Passenger_air_transport" name="Passenger_air_transport"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Passenger_air_transport.png">
              <span class="TransferServiceAndRenting subcategory-label">Passenger_air_transport</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Postal_and_courier_activities" name="Postal_and_courier_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Postal_and_courier_activities.png">
              <span class="TransferServiceAndRenting subcategory-label">Postal_and_courier_activities</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="RTZgate" name="RTZgate"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_RTZgate.png">
              <span class="TransferServiceAndRenting subcategory-label">RTZgate</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="SensorSite" name="SensorSite"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_SensorSite.png">
              <span class="TransferServiceAndRenting subcategory-label">SensorSite</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Support_activities_for_transportation" name="Support_activities_for_transportation"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Support_activities_for_transportation.png">
              <span class="TransferServiceAndRenting subcategory-label">Support_activities_for_transportation</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Taxi_company" name="Taxi_company"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Taxi_company.png">
              <span class="TransferServiceAndRenting subcategory-label">Taxi_company</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Taxi_park" name="Taxi_park"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Taxi_park.png">
              <span class="TransferServiceAndRenting subcategory-label">Taxi_park</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Train_station" name="Train_station"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Train_station.png">
              <span class="TransferServiceAndRenting subcategory-label">Train_station</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Tramline" name="Tramline"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Tramline.png">
              <span class="TransferServiceAndRenting subcategory-label">Tramline</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Tram_stops" name="Tram_stops"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Tram_stops.png">
              <span class="TransferServiceAndRenting subcategory-label">Tram_stops</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Urban_bus" name="Urban_bus"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Urban_bus.png">
              <span class="TransferServiceAndRenting subcategory-label">Urban_bus</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Vehicle_rental" name="Vehicle_rental"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Vehicle_rental.png">
              <span class="TransferServiceAndRenting subcategory-label">Vehicle_rental</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Warehousing_and_storage" name="Warehousing_and_storage"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Warehousing_and_storage.png">
              <span class="TransferServiceAndRenting subcategory-label">Warehousing_and_storage</span>
              <br>
              <input type="checkbox" class="sub_TransferServiceAndRenting subcategory" value="Water_transport" name="Water_transport"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Water_transport.png">
              <span class="TransferServiceAndRenting subcategory-label">Water_transport</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="UtilitiesAndSupply" name="UtilitiesAndSupply"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply.png"> <span class="UtilitiesAndSupply macrocategory-label">UtilitiesAndSupply</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Accommodation_or_office_containers_rental" name="Accommodation_or_office_containers_rental"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Accommodation_or_office_containers_rental.png">
              <span class="UtilitiesAndSupply subcategory-label">Accommodation_or_office_containers_rental</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Agents" name="Agents"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Agents.png">
              <span class="UtilitiesAndSupply subcategory-label">Agents</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Associations" name="Associations"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Associations.png">
              <span class="UtilitiesAndSupply subcategory-label">Associations</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Business_support" name="Business_support"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Business_support.png">
              <span class="UtilitiesAndSupply subcategory-label">Business_support</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Call_center" name="Call_center"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Call_center.png">
              <span class="UtilitiesAndSupply subcategory-label">Call_center</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Combined_facilities_support_activities" name="Combined_facilities_support_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Combined_facilities_support_activities.png">
              <span class="UtilitiesAndSupply subcategory-label">Combined_facilities_support_activities</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Consulting_services" name="Consulting_services"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Consulting_services.png">
              <span class="UtilitiesAndSupply subcategory-label">Consulting_services</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Credit_collection_agencies" name="Credit_collection_agencies"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Credit_collection_agencies.png">
              <span class="UtilitiesAndSupply subcategory-label">Credit_collection_agencies</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Energy_supply" name="Energy_supply"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Energy_supply.png">
              <span class="UtilitiesAndSupply subcategory-label">Energy_supply</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Equipment_for_events_and_shows_rental" name="Equipment_for_events_and_shows_rental"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Equipment_for_events_and_shows_rental.png">
              <span class="UtilitiesAndSupply subcategory-label">Equipment_for_events_and_shows_rental</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Extraction_of_natural_gas" name="Extraction_of_natural_gas"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Extraction_of_natural_gas.png">
              <span class="UtilitiesAndSupply subcategory-label">Extraction_of_natural_gas</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Internet_point_and_public_telephone" name="Internet_point_and_public_telephone"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Internet_point_and_public_telephone.png">
              <span class="UtilitiesAndSupply subcategory-label">Internet_point_and_public_telephone</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Internet_service_provider" name="Internet_service_provider"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Internet_service_provider.png">
              <span class="UtilitiesAndSupply subcategory-label">Internet_service_provider</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Investigation_activities" name="Investigation_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Investigation_activities.png">
              <span class="UtilitiesAndSupply subcategory-label">Investigation_activities</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Machinery_and_equipment_rental" name="Machinery_and_equipment_rental"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Machinery_and_equipment_rental.png">
              <span class="UtilitiesAndSupply subcategory-label">Machinery_and_equipment_rental</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Management_consultancy" name="Management_consultancy"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Management_consultancy.png">
              <span class="UtilitiesAndSupply subcategory-label">Management_consultancy</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Office_administrative_and_support_activities" name="Office_administrative_and_support_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Office_administrative_and_support_activities.png">
              <span class="UtilitiesAndSupply subcategory-label">Office_administrative_and_support_activities</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Organization_of_conventions_and_trade_shows" name="Organization_of_conventions_and_trade_shows"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Organization_of_conventions_and_trade_shows.png">
              <span class="UtilitiesAndSupply subcategory-label">Organization_of_conventions_and_trade_shows</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Other_telecommunications_activities" name="Other_telecommunications_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Other_telecommunications_activities.png">
              <span class="UtilitiesAndSupply subcategory-label">Other_telecommunications_activities</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Packaging_activities" name="Packaging_activities"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Packaging_activities.png">
              <span class="UtilitiesAndSupply subcategory-label">Packaging_activities</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Personal_and_household_goods_rental" name="Personal_and_household_goods_rental"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Personal_and_household_goods_rental.png">
              <span class="UtilitiesAndSupply subcategory-label">Personal_and_household_goods_rental</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Private_security" name="Private_security"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Private_security.png">
              <span class="UtilitiesAndSupply subcategory-label">Private_security</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Recreational_and_sports_goods_rental" name="Recreational_and_sports_goods_rental"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Recreational_and_sports_goods_rental.png">
              <span class="UtilitiesAndSupply subcategory-label">Recreational_and_sports_goods_rental</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Recruitment" name="Recruitment"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Recruitment.png">
              <span class="UtilitiesAndSupply subcategory-label">Recruitment</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Reporting_agencies" name="Reporting_agencies"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Reporting_agencies.png">
              <span class="UtilitiesAndSupply subcategory-label">Reporting_agencies</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Secretarial_support_services" name="Secretarial_support_services"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Secretarial_support_services.png">
              <span class="UtilitiesAndSupply subcategory-label">Secretarial_support_services</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Security_systems_service" name="Security_systems_service"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Security_systems_service.png">
              <span class="UtilitiesAndSupply subcategory-label">Security_systems_service</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Temp_agency" name="Temp_agency"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Temp_agency.png">
              <span class="UtilitiesAndSupply subcategory-label">Temp_agency</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Video_tapes_disks_rental" name="Video_tapes_disks_rental"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Video_tapes_disks_rental.png">
              <span class="UtilitiesAndSupply subcategory-label">Video_tapes_disks_rental</span>
              <br>
              <input type="checkbox" class="sub_UtilitiesAndSupply subcategory" value="Water_collection_treatment_and_supply" name="Water_collection_treatment_and_supply"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/UtilitiesAndSupply_Water_collection_treatment_and_supply.png">
              <span class="UtilitiesAndSupply subcategory-label">Water_collection_treatment_and_supply</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="Wholesale" name="Wholesale"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/Wholesale.png"> <span class="Wholesale macrocategory-label">Wholesale</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_Wholesale subcategory" value="Non_specialized_wholesale_trade" name="Non_specialized_wholesale_trade"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Wholesale_Non_specialized_wholesale_trade.png">
              <span class="Wholesale subcategory-label">Non_specialized_wholesale_trade</span>
              <br>
              <input type="checkbox" class="sub_Wholesale subcategory" value="Other_specialized_wholesale" name="Other_specialized_wholesale"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Wholesale_Other_specialized_wholesale.png">
              <span class="Wholesale subcategory-label">Other_specialized_wholesale</span>
              <br>
              <input type="checkbox" class="sub_Wholesale subcategory" value="Wholesale_agricultural_raw_materials_live_animals" name="Wholesale_agricultural_raw_materials_live_animals"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Wholesale_Wholesale_agricultural_raw_materials_live_animals.png">
              <span class="Wholesale subcategory-label">Wholesale_agricultural_raw_materials_live_animals</span>
              <br>
              <input type="checkbox" class="sub_Wholesale subcategory" value="Wholesale_commission_trade" name="Wholesale_commission_trade"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Wholesale_Wholesale_commission_trade.png">
              <span class="Wholesale subcategory-label">Wholesale_commission_trade</span>
              <br>
              <input type="checkbox" class="sub_Wholesale subcategory" value="Wholesale_food_beverages_tobacco" name="Wholesale_food_beverages_tobacco"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Wholesale_Wholesale_food_beverages_tobacco.png">
              <span class="Wholesale subcategory-label">Wholesale_food_beverages_tobacco</span>
              <br>
              <input type="checkbox" class="sub_Wholesale subcategory" value="Wholesale_household_goods" name="Wholesale_household_goods"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Wholesale_Wholesale_household_goods.png">
              <span class="Wholesale subcategory-label">Wholesale_household_goods</span>
              <br>
              <input type="checkbox" class="sub_Wholesale subcategory" value="Wholesale_ict_equipment" name="Wholesale_ict_equipment"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Wholesale_Wholesale_ict_equipment.png">
              <span class="Wholesale subcategory-label">Wholesale_ict_equipment</span>
              <br>
              <input type="checkbox" class="sub_Wholesale subcategory" value="Wholesale_machinery_equipmentent_supplies" name="Wholesale_machinery_equipmentent_supplies"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Wholesale_Wholesale_machinery_equipmentent_supplies.png">
              <span class="Wholesale subcategory-label">Wholesale_machinery_equipmentent_supplies</span>
              <br>
              <input type="checkbox" class="sub_Wholesale subcategory" value="Wholesale_motor_vehicles_parts" name="Wholesale_motor_vehicles_parts"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Wholesale_Wholesale_motor_vehicles_parts.png">
              <span class="Wholesale subcategory-label">Wholesale_motor_vehicles_parts</span>
              <br>
              <input type="checkbox" class="sub_Wholesale subcategory" value="Wholesale_trade" name="Wholesale_trade"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Wholesale_Wholesale_trade.png">
              <span class="Wholesale subcategory-label">Wholesale_trade</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="WineAndFood" name="WineAndFood"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood.png"> <span class="WineAndFood macrocategory-label">WineAndFood</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Bakery" name="Bakery"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Bakery.png">
              <span class="WineAndFood subcategory-label">Bakery</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Bar" name="Bar"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Bar.png">
              <span class="WineAndFood subcategory-label">Bar</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Canteens_and_food_service" name="Canteens_and_food_service"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Canteens_and_food_service.png">
              <span class="WineAndFood subcategory-label">Canteens_and_food_service</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Catering" name="Catering"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Catering.png">
              <span class="WineAndFood subcategory-label">Catering</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Dining_hall" name="Dining_hall"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Dining_hall.png">
              <span class="WineAndFood subcategory-label">Dining_hall</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Drinking_fountain" name="Drinking_fountain"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Drinking_fountain.png">
              <span class="WineAndFood subcategory-label">Drinking_fountain</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Food_and_ice_cream_truck" name="Food_and_ice_cream_truck"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Food_and_ice_cream_truck.png">
              <span class="WineAndFood subcategory-label">Food_and_ice_cream_truck</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Food_trade" name="Food_trade"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Food_trade.png">
              <span class="WineAndFood subcategory-label">Food_trade</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Grill" name="Grill"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Grill.png">
              <span class="WineAndFood subcategory-label">Grill</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Highway_stop" name="Highway_stop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Highway_stop.png">
              <span class="WineAndFood subcategory-label">Highway_stop</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Ice_cream_parlour" name="Ice_cream_parlour"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Ice_cream_parlour.png">
              <span class="WineAndFood subcategory-label">Ice_cream_parlour</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Literary_cafe" name="Literary_cafe"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Literary_cafe.png">
              <span class="WineAndFood subcategory-label">Literary_cafe</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Pastry_shop" name="Pastry_shop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Pastry_shop.png">
              <span class="WineAndFood subcategory-label">Pastry_shop</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Pizzeria" name="Pizzeria"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Pizzeria.png">
              <span class="WineAndFood subcategory-label">Pizzeria</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Restaurant" name="Restaurant"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Restaurant.png">
              <span class="WineAndFood subcategory-label">Restaurant</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Sandwich_shop_pub" name="Sandwich_shop_pub"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Sandwich_shop_pub.png">
              <span class="WineAndFood subcategory-label">Sandwich_shop_pub</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Small_shop" name="Small_shop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Small_shop.png">
              <span class="WineAndFood subcategory-label">Small_shop</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Sushi_bar" name="Sushi_bar"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Sushi_bar.png">
              <span class="WineAndFood subcategory-label">Sushi_bar</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Take_away" name="Take_away"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Take_away.png">
              <span class="WineAndFood subcategory-label">Take_away</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Trattoria" name="Trattoria"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Trattoria.png">
              <span class="WineAndFood subcategory-label">Trattoria</span>
              <br>
              <input type="checkbox" class="sub_WineAndFood subcategory" value="Wine_shop_and_wine_bar" name="Wine_shop_and_wine_bar"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Wine_shop_and_wine_bar.png">
              <span class="WineAndFood subcategory-label">Wine_shop_and_wine_bar</span>
              <br>
            </div>
            <br>
            <br>

          </div>
          <span caption="Num_Results_dx_R" name="lbl">N. results</span>:
          <select name="nResultsServizi" id="nResultsServizi">
            <option value="10">10</option>
            <option value="20">20</option>
            <option value="50">50</option>
            <option selected="selected" value="100">100</option>
            <option value="200">200</option>
            <option value="500">500</option>
            <option value="0">No Limit</option>
          </select>
          <br>
          <hr>

          <!-- <input type="checkbox" name="road-sensor" value="RoadSensor" id="Sensor" class="macrocategory" /> <img src='/WebAppGrafo/img/mapicons/RoadSensor.png' height='19' width='16' align='top'/> <span class="road-sensor macrocategory-label">Road Sensors</span> 
<br />
<br />
N. risultati:
<select id="nResultsSensor" name="nResultsSensor">
    <option value="10">10</option>
    <option value="20">20</option>
    <option value="50">50</option>
    <option value="100" selected="selected">100</option>
    <option value="200">200</option>
    <option value="500">500</option>
    <option value="0">Nessun Limite</option>
</select>
<hr />
<input type="checkbox" name="near-bus-stops" value="NearBusStops" class="macrocategory" id="Bus" /> <img src='/WebAppGrafo/img/mapicons/NearBusStop.png' height='19' width='16' align='top'/> <span class="near-bus-stops macrocategory-label">Bus Stops</span>
<br />
<br />
N. risultati:
<select id="nResultsBus" name="nResultsBus">
    <option value="10">10</option>
    <option value="20">20</option>
    <option value="50">50</option>
    <option value="100" selected="selected">100</option>
    <option value="200">200</option>
    <option value="500">500</option>
    <option value="0">Nessun Limite</option>
</select>
<hr />-->
          <span caption="Search_Range_R" name="lbl">Search Range</span>
          <select name="raggioricerca" id="raggioricerca">
            <option value="0.1">100 mt</option>
            <option value="0.2">200 mt</option>
            <option value="0.3">300 mt</option>
            <option value="0.5">500 mt</option>
            <option value="1">1 km</option>
            <option value="2">2 km</option>
            <option value="5">5 km</option>
            <option value="area">visible areas</option>
          </select>
          <hr>
          <!--<input type="button" value="Cerca!" id="pulsante-ricerca" onclick="ricercaServizi();" />
                             <input type="button" value="Pulisci" id="pulsante-reset" onclick="resetTotale();" /> !-->
          <div id="serviceSearch2" class="menu">
            <img width="28" onclick="ricercaServizi('categorie');" alt="Search Services" src="/WebAppGrafo/img/search_icon.png">
          </div>
          <div id="clearAll2" class="menu">
            <img width="28" onclick="resetTotale();" alt="Clear all" src="/WebAppGrafo/img/clear_icon.png">
          </div>
          <div id="saveQuery" class="menu">
            <img width="28" onclick="save_handler();" alt="Salva la query" src="/WebAppGrafo/img/save.png">
          </div>
          <br>

        </div>
      </div>
      <div id="tabs-6" aria-labelledby="ui-id-6" class="ui-tabs-panel ui-widget-content ui-corner-bottom" role="tabpanel" style="display: none;" aria-expanded="false" aria-hidden="true">
        <div class="use-case-6">
          <!--<h3>Coming soon...</h3>-->
          <!-- AGGIUNTA TRANSVERSAL SERVICES -->
          <input type="text" onkeypress="event.keyCode == 13 ? ricercaServizi('categorie_t') : false" placeholder="search text into service" id="serviceTextFilter_t" name="serviceTextFilter_t"><br>
          <span caption="Services_Categories_T" name="lbl">Services Categories</span>
          <br>
          <input type="checkbox" value="Select All" id="macro-select-all_t" name="macro-select-all_t"> <span caption="Select_All_T" name="lbl">De/Select All</span>
          <div id="categorie_t">
            <br>
            <input type="checkbox" class="macrocategory" value="Area" name="Area"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/Area.png"> <span class="Area macrocategory-label">Area</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_Area subcategory" value="Controlled_parking_zone" name="Controlled_parking_zone"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Controlled_parking_zone.png">
              <span class="Area subcategory-label">Controlled_parking_zone</span>
              <br>
              <input type="checkbox" class="sub_Area subcategory" value="Gardens" name="Gardens"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Gardens.png">
              <span class="Area subcategory-label">Gardens</span>
              <br>
              <input type="checkbox" class="sub_Area subcategory" value="Green_areas" name="Green_areas"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Green_areas.png">
              <span class="Area subcategory-label">Green_areas</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="DigitalLocation" name="DigitalLocation"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/DigitalLocation.png"> <span class="DigitalLocation macrocategory-label">DigitalLocation</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Artisan_shop" name="Artisan_shop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Artisan_shop.png">
              <span class="DigitalLocation subcategory-label">Artisan_shop</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Bank" name="Bank"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/FinancialService_Bank.png">
              <span class="DigitalLocation subcategory-label">Bank</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Bookshop" name="Bookshop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Bookshop.png">
              <span class="DigitalLocation subcategory-label">Bookshop</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Boxoffice" name="Boxoffice"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Boxoffice.png">
              <span class="DigitalLocation subcategory-label">Boxoffice</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Churches" name="Churches"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Churches.png">
              <span class="DigitalLocation subcategory-label">Churches</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Cinema" name="Cinema"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Cinema.png">
              <span class="DigitalLocation subcategory-label">Cinema</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Consulate" name="Consulate"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/GovernmentOffice_Consulate.png">
              <span class="DigitalLocation subcategory-label">Consulate</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Controlled_parking_zone" name="Controlled_parking_zone"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Controlled_parking_zone.png">
              <span class="DigitalLocation subcategory-label">Controlled_parking_zone</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Cycle_paths" name="Cycle_paths"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Cycle_paths.png">
              <span class="DigitalLocation subcategory-label">Cycle_paths</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Gardens" name="Gardens"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Gardens.png">
              <span class="DigitalLocation subcategory-label">Gardens</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Green_areas" name="Green_areas"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Green_areas.png">
              <span class="DigitalLocation subcategory-label">Green_areas</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Gym_fitness" name="Gym_fitness"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Gym_fitness.png">
              <span class="DigitalLocation subcategory-label">Gym_fitness</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Healthcare_centre" name="Healthcare_centre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Healthcare_centre.png">
              <span class="DigitalLocation subcategory-label">Healthcare_centre</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Historical_buildings" name="Historical_buildings"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Historical_buildings.png">
              <span class="DigitalLocation subcategory-label">Historical_buildings</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Library" name="Library"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Library.png">
              <span class="DigitalLocation subcategory-label">Library</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Literary_cafe" name="Literary_cafe"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Literary_cafe.png">
              <span class="DigitalLocation subcategory-label">Literary_cafe</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Local_health_authority" name="Local_health_authority"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Local_health_authority.png">
              <span class="DigitalLocation subcategory-label">Local_health_authority</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Monument_location" name="Monument_location"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Monument_location.png">
              <span class="DigitalLocation subcategory-label">Monument_location</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Museum" name="Museum"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Museum.png">
              <span class="DigitalLocation subcategory-label">Museum</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Pastry_shop" name="Pastry_shop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Pastry_shop.png">
              <span class="DigitalLocation subcategory-label">Pastry_shop</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Pharmacy" name="Pharmacy"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/ShoppingAndService_Pharmacy.png">
              <span class="DigitalLocation subcategory-label">Pharmacy</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Public_hospital" name="Public_hospital"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HealthCare_Public_hospital.png">
              <span class="DigitalLocation subcategory-label">Public_hospital</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Public_infant_school" name="Public_infant_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Public_infant_school.png">
              <span class="DigitalLocation subcategory-label">Public_infant_school</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Restaurant" name="Restaurant"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Restaurant.png">
              <span class="DigitalLocation subcategory-label">Restaurant</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="RTZgate" name="RTZgate"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_RTZgate.png">
              <span class="DigitalLocation subcategory-label">RTZgate</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Small_shop" name="Small_shop"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Small_shop.png">
              <span class="DigitalLocation subcategory-label">Small_shop</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Sports_facility" name="Sports_facility"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/Entertainment_Sports_facility.png">
              <span class="DigitalLocation subcategory-label">Sports_facility</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Squares" name="Squares"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Squares.png">
              <span class="DigitalLocation subcategory-label">Squares</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Theatre" name="Theatre"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/CulturalActivity_Theatre.png">
              <span class="DigitalLocation subcategory-label">Theatre</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Toilet" name="Toilet"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Toilet.png">
              <span class="DigitalLocation subcategory-label">Toilet</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Tourist_complaints_office" name="Tourist_complaints_office"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Tourist_complaints_office.png">
              <span class="DigitalLocation subcategory-label">Tourist_complaints_office</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Tourist_information_office" name="Tourist_information_office"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Tourist_information_office.png">
              <span class="DigitalLocation subcategory-label">Tourist_information_office</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Tourist_trail" name="Tourist_trail"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Tourist_trail.png">
              <span class="DigitalLocation subcategory-label">Tourist_trail</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Training_school" name="Training_school"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/EducationAndResearch_Training_school.png">
              <span class="DigitalLocation subcategory-label">Training_school</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Train_station" name="Train_station"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Train_station.png">
              <span class="DigitalLocation subcategory-label">Train_station</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Tramline" name="Tramline"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Tramline.png">
              <span class="DigitalLocation subcategory-label">Tramline</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Tram_stops" name="Tram_stops"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Tram_stops.png">
              <span class="DigitalLocation subcategory-label">Tram_stops</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Trattoria" name="Trattoria"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/WineAndFood_Trattoria.png">
              <span class="DigitalLocation subcategory-label">Trattoria</span>
              <br>
              <input type="checkbox" class="sub_DigitalLocation subcategory" value="Wifi" name="Wifi"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Wifi.png">
              <span class="DigitalLocation subcategory-label">Wifi</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="HappeningNow" name="HappeningNow"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/HappeningNow.png"> <span class="HappeningNow macrocategory-label">HappeningNow</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_HappeningNow subcategory" value="Event" name="Event"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/HappeningNow_Event.png">
              <span class="HappeningNow subcategory-label">Event</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" value="Path" name="Path"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/Path.png"> <span class="Path macrocategory-label">Path</span> <span title="Mostra sottocategorie" class="toggle-subcategory">+</span>
            <div class="subcategory-content">
              <input type="checkbox" class="sub_Path subcategory" value="Cycle_paths" name="Cycle_paths"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Cycle_paths.png">
              <span class="Path subcategory-label">Cycle_paths</span>
              <br>
              <input type="checkbox" class="sub_Path subcategory" value="Tourist_trail" name="Tourist_trail"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TourismService_Tourist_trail.png">
              <span class="Path subcategory-label">Tourist_trail</span>
              <br>
              <input type="checkbox" class="sub_Path subcategory" value="Tramline" name="Tramline"> <img width="16" height="19" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Tramline.png">
              <span class="Path subcategory-label">Tramline</span>
              <br>
            </div>
            <br>
            <input type="checkbox" class="macrocategory" id="FreshPlace" value="Fresh_place" name="fresh-place"> <img width="20" height="23" align="top" '="" src="/WebAppGrafo/img/mapicons/TourismService_Fresh_place.png"> <span class="fresh-place macrocategory-label">Fresh Place</span>
            <br>
            <input type="checkbox" class="macrocategory" id="PublicTransportLine" value="PublicTransportLine" name="public-transport-line"> <img width="20" height="23" align="top" '="" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_Urban_bus.png"> <span class="public-transport-line macrocategory-label">Public Transport Line</span>
            <br>
            <input type="checkbox" class="macrocategory" id="Sensor" value="SensorSite" name="road-sensor"> <img width="20" height="23" align="top" '="" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_SensorSite.png"> <span class="road-sensor macrocategory-label">Road Sensors</span>
            <br>
            <input type="checkbox" id="Bus" class="macrocategory" value="BusStop" name="near-bus-stops"> <img width="20" height="23" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_BusStop.png"> <span class="near-bus-stops macrocategory-label">Bus Stops</span>

          </div>
          <br>
          <span caption="Num_Results_dx_T" name="lbl">N. results for each</span>:
          <select name="nResultsServizi" id="nResultsServizi_t">
            <option value="10">10</option>
            <option value="20">20</option>
            <option value="50">50</option>
            <option selected="selected" value="100">100</option>
            <option value="200">200</option>
            <option value="500">500</option>
            <option value="0">No Limit</option>
          </select>
          <br>
          <!--
                                                    Raggio di Ricerca: 
                                                    <br />
                                                    <select id="raggioricerca" name="raggioricerca">
                                                        <option value="0.1">100 metri</option>
                                                        <option value="0.2">200 metri</option>
                                                        <option value="0.3">300 metri</option>
                                                        <option value="0.5">500 metri</option>
                                                        <option value="1">1 km</option>
                                                        <option value="2">2 km</option>
                                                        <option value="5">5 km</option>
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
                            !-->
          <!-- da decommentare -->
          <hr>
          <span caption="Search_Range_T" name="lbl">Search Range</span>
          <select name="raggioricerca" id="raggioricerca_t">
            <option value="0.1">100 mt</option>
            <option value="0.2">200 mt</option>
            <option value="0.3">300 mt</option>
            <option value="0.5">500 mt</option>
            <option value="1">1 km</option>
            <option value="2">2 km</option>
            <option value="5">5 km</option>
            <option value="area">visible areas</option>
          </select>
          <hr>
          <div id="serviceSearch" class="menu">
            <img width="28" onclick="ricercaServizi('categorie_t');" alt="Search Services" src="/WebAppGrafo/img/search_icon.png">
          </div>
          <!--<div class="menu" id="textSearch">
                                <img src="/WebAppGrafo/img/text_search.jpg" alt="Text Search" width="28" onclick="showTextSearchDialog();" />
                            </div>-->
          <div id="clearAll" class="menu">
            <img width="28" onclick="resetTotale();" alt="Clear all" src="/WebAppGrafo/img/clear_icon.png">
          </div>
          <!--<input type="checkbox" name="open_path" value="open_path" id="apri_path" />  <span>Open Path/Area</span>-->
          <!-- DA DECOMMENTARE QUANDO SARA' FATTO IL SALVATAGGIO DEI SERVIZI TRASVERSALI -->
          <!-- <div class="menu" id="saveQuery">
                              <img src="/WebAppGrafo/img/save.png" alt="Salva la query" width="28" onclick="save_handler();" />
                            </div> -->
          <br>

        </div>
      </div>
    </div>
    <fieldset id="searchOutput">
      <legend><span caption="Search_Results" name="lbl">Search Results</span></legend>
      <div id="cluster-msg" class="result"></div>
      <div id="msg" class="result"></div>
      <div id="serviceRes" class="result"><img width="18" height="21" align="top" src="/WebAppGrafo/img/mapicons/TourismService.png"><span class="label">Services:</span><div class="value"></div></div>
      <div id="busstopRes" class="result"><img width="18" height="21" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_BusStop.png"><span class="label">Bus Stops:</span><div class="value"></div></div>
      <div id="busDirection" class="result"><span class="label">Direction:</span><div class="value"></div></div>
      <div id="sensorRes" class="result"><img width="18" height="21" align="top" src="/WebAppGrafo/img/mapicons/TransferServiceAndRenting_SensorSite.png"><span class="label">Road Sensors:</span><div class="value"></div></div>
    </fieldset>
    <fieldset id="resultTPL">
      <legend><span caption="Results_BusLines" name="lbl">Bus Lines</span></legend>
      <div style="display:none;" id="numTPL"></div>
      <div id="listTPL"></div>
    </fieldset>

  </div>
</div>
<div class="menu" id="info-aggiuntive">
  <div class="header"><span caption="Hide_Menu_meteo" name="lbl">Hide Menu</span>
  </div>
  <div class="content"></div>
</div>
<!--  CARICAMENTO DEL FILE utility.js CON FUNZIONI NECESSARIE  -->
<script src="${pageContext.request.contextPath}/resources/js/ServiceMap/utility.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/ServiceMap/@server1.conn0.source628.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/ServiceMap/save_embed.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/ServiceMap/support.js" type="text/javascript"></script>
<div id="overMap"></div>
</body>

</html>
