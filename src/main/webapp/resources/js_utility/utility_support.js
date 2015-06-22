/**
 * Created by 4535992 on 11/06/2015.
 */

/*** Get a javascript file for load a extranll resource on the page*/
function loadJS(src, callback) {
    var s = document.createElement('script');
    s.src = src;
    s.async = true;
    s.onreadystatechange = s.onload = function() {
        var state = s.readyState;
        if (!callback.done && (!state || /loaded|complete/.test(state))) {
            callback.done = true;
            callback();
        }
    };
    document.getElementsByTagName('head')[0].appendChild(s);
}
loadJS('/script/script.js', function() {
    // put your code here to run after script is loaded
});

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

// AL CLICK CERCO L'INDIRIZZO APPROSSIMATIVO
map.on('click', function (e) {

    if (selezioneAttiva == true){

        if (ricercaInCorso == false){
            $('#raggioricerca').prop('disabled', false);
            $('#numerorisultati').prop('disabled', false);

            ricercaInCorso = true;
            $('#info-aggiuntive .content').html("Indirizzo Approssimativo: <img src=\"/resources/img/ajax-loader.gif\" width=\"16\" />");
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
