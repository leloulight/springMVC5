<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset='utf-8'>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/gtfsViewer/leaflet.css" />>
  <style>
    body { padding: 0; margin: 0; }
    html, body, #map { height: 100%; }
    #uploader {
      position: absolute;
      top: 10px ;
      left: 50px;
      background-color: white;
      border: 2px solid black;
      padding: 10px 20px;
    }
  </style>
</head>
<body>
<div id="map"></div>
<input type="file" id="uploader">
<!-- GTFS SUPPORT-->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/gtfsViewer/zip.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/gtfsViewer/d3.v3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/gtfsViewer/leaflet.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/gtfsViewer/tile.stamen.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/gtfsViewer/gtfsParser.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/gtfsViewer/main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/gtfsViewer/inflate.js"></script>

</body>
</html>
