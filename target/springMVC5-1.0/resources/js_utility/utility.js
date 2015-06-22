/**
 * Created by 4535992 on 11/06/2015.
 */
/**
 *
 */

function switchCategorie(categoria){
    // FUNZIONE PER L'ASSEGNAZIONE DI UN PARTICOLARE MARKER AD OGNI SOTTOCATEGORIA
    switch (categoria) {
        case 'affittacamere': case 'villaggio_vacanze': case 'albergo':
        case 'casa_per_vacanze': case 'casa_di_riposo': case 'casa_per_ferie':
        case 'bed_and_breakfast': case 'ostello': case 'residenza_turistica_alberghiera':
        case 'agriturismo': case 'residence_di_villeggiatura': case 'centri_accoglienza_e_case_alloggio':
        case 'campeggio': case 'residenze_epoca': case 'rifugio_alpino':
        return markerAccommodation;
        break;
        case 'autogrill': case 'bar_pasticceria': case 'paninoteche_pubs':
        case 'pizzeria': case 'forno': case 'rosticceria':
        case 'sushi_bar': case 'mense': case 'ristorante':
        case 'catering': case 'Enoteche_e_wine_bar': case 'gelateria':
        case 'trattoria':
            return markerWineAndFood;
            break;
        case 'museo': case 'luogo_monumento': case 'biblioteca': case 'auditorium':
        return markerCulturalActivity;
        break;
        case 'istituti_tecnici_pubblici':
        case 'scuole_elementari_pubbliche':
        case 'licei_privati':
        case 'universita_pubbliche':
        case 'scuola_di_vela':
        case 'istituti_magistrali':
        case 'istituti_professionali_privati':
        case 'istituti_tecnici_privati':
        case 'scuole_materne_private':
        case 'istituti_professionali_pubblici':
        case 'conservatori_di_musica':
        case 'scuola_di_formazione':
        case 'licei_pubblici':
        case 'scuola_di_sci':
        case 'scuole_elementari_private':
        case 'scuole_medie_pubbliche':
        case 'corsi_di_lingue':
        case 'scuole_materne_pubbliche':
        case 'scuole_medie_private':
        case 'scuola_di_sub':
        case 'nidi_privati':
            return markerEducation;
            break;
        case 'farmacia':
        case 'guardia_costiera_capitaneria_di_porto':
        case 'polizia_stradale':
        case 'commissariato_di_pubblica_sicurezza':
        case 'pronto_soccorso':
        case 'polizia_municipale':
        case 'carabinieri':
        case 'numeri_utili':
        case 'guardia_medica':
        case 'soccorso_stradale':
        case 'guardia_di_finanza':
        case 'corpo_forestale_dello_stato':
        case 'protezione_civile':
        case 'vigili_del_fuoco':
            return markerEmergency;
            break;
        case 'cinema':
        case 'discoteca':
        case 'golf':
        case 'sala_gioco':
        case 'ludoteca':
        case 'rafting_canoa_e_kayak':
        case 'riserve_di_pesca':
        case 'maneggi':
        case 'teatro':
        case 'centro_sociale':
        case 'ippodromo':
        case 'alpinismo':
        case 'piscina':
        case 'palestra_fitness':
        case 'impianti_sciistici':
        case 'impianto_sportivo':
        case 'parco_naturale':
        case 'acquario':
            return markerEntertainment;
            break;
        case 'banca':
        case 'banche':
        case 'assicurazione':
        case 'ATM':
        case 'istituto_monetario':
            return markerFinancialService;
            break;
        case 'ufficio_inps':
        case 'Agenzia_delle_entrate':
        case 'Informa_Giovani':
        case 'centro_per_l_impiego':
        case 'motorizzazione_civile':
        case 'anagrafe_e_uffici_vari':
        case 'caf':
        case 'prefettura':
        case 'questura':
        case 'Consolato':
        case 'Ufficio_postale':
        case 'assistenti_sociali_uffici':
        case 'ufficio_oggetti_smarriti_aeroporto':
        case 'ufficio_oggetti_smarriti_stazione_treno':
            return markerGovernmentOffice;
            break;
        case 'ambulatorio_medico':
        case 'ricoveri':
        case 'veterinario':
        case 'centro_unico_di_prenotazione':
        case 'clinica_privata':
        case 'poliambulatorio':
        case 'croce_rossa':
        case 'ospedale_pubblico':
        case 'centri_di_riabilitazione':
        case 'asl':
        case 'distretto_sanitario':
        case 'dentista':
        case 'consultori':
        case 'comunita_e_centri_di_recupero_per_dipendenze':
        case 'centro_antiveleni':
        case 'centri_assistenza':
        case 'centri_diurni':
            return markerHealthCare;
            break;
        case 'ipermercati':
        case 'grande_distribuzione_non_alimentare':
        case 'negozio_artigiano':
        case 'spacci_outlet_abbigliamento':
        case 'centri_commerciali':
        case 'negozi_monomarca':
        case 'spacci_outlet_calzature':
            return markerShopping;
            break;
        case 'noleggio_veicoli':
        case 'camper_service':
        case 'agenzia_di_viaggi':
        case 'ufficio_visite_guidate':
        case 'tour_operator':
            return markerTourismService;
            break;
        case 'autobus_urbani':
        case 'elisuperfici':
        case 'aviosuperfici':
        case 'parcheggio_auto':
        case 'stazione_ferroviaria':
        case 'aeroporto_civile':
        case 'corriere_espresso':
            return markerTransferService;
            break;
        case 'fermata':
            return markerBusStops;
            break;
        default:
            return markerEducation;
            break;
    }

}


//FUNZIONE PER MOSTRARE/NASCONDERE I MENU
$(".header").click(function () {
    $header = $(this);
    //getting the next element
    $content = $header.next();
    //open up the content needed - toggle the slide- if visible, slide up, if not slidedown.
    $content.slideToggle(200, function () {
        //execute this after slideToggle is done
        //change text of header based on visibility of content div
        $header.text(function () {
            //change text based on condition
            return $content.is(":visible") ? "- Nascondi Menu" : "+ Mostra Menu";
        });
    });
});

//FUNZIONE PER MOSTRARE/NASCONDERE LE SUB CATEGORY
$(".toggle-subcategory").click(function () {
    $tsc = $(this);
    //getting the next element
    $content = $tsc.next();
    if (!$content.is(":visible")){
        $('.subcategory-content').hide();
        $('.toggle-subcategory').html('+');
    }
    //open up the content needed - toggle the slide- if visible, slide up, if not slidedown.
    $content.slideToggle(200, function () {
        //execute this after slideToggle is done
        //change text of header based on visibility of content div
        $tsc.text(function () {
            //change text based on condition
            return $content.is(":visible") ? "-" : "+";
        });
    });
});



//CHECKBOX SELECT/DESELECT ALL
$('#macro-select-all').change(function (){
    if($('#macro-select-all').prop('checked')){
        $('.macrocategory').prop('checked', 'checked');
        $( ".macrocategory" ).trigger( "change" );
    }
    else{
        $('.macrocategory').prop('checked', false);
        $( ".macrocategory" ).trigger( "change" );
    }

});

// RESET DI TUTTI I LAYERS SULLA MAPPA
function svuotaLayers(){
    //clickLayer.clearLayers();
    busStopsLayer.clearLayers();
    servicesLayer.clearLayers();
    GPSLayer.clearLayers();
}

// CANCELLAZIONE DEL CONTENUTO DEL BOX INFO AGGIUNTIVE
function svuotaInfoAggiuntive(){
    $('#info-aggiuntive .content').html('');
}

function cancellaSelezione(){
    $('#selezione').html('Nessun punto selezionato');
    selezione = null;
    coordinateSelezione = null;
}


// FUNZIONE DI RESET GENERALE
function resetTotale(){
    clickLayer.clearLayers();
    svuotaInfoAggiuntive();
    svuotaLayers();
    cancellaSelezione();
    $('#macro-select-all').prop('checked', false);
    $('.macrocategory').prop('checked', false);
    $( ".macrocategory" ).trigger( "change" );
    $('#raggioricerca')[0].options.selectedIndex = 0;
    $('#raggioricerca').prop('disabled', false);
    $('#numerorisultati')[0].options.selectedIndex = 0;
    $('#numerorisultati').prop('disabled', false);
    $('#elencolinee')[0].options.selectedIndex = 0;
    $('#elencoprovince')[0].options.selectedIndex = 0;
    $('#elencofermate').html('<option value=""> - Seleziona una Fermata - </option>');
    $('#elencocomuni').html('<option value=""> - Seleziona un Comune - </option>');
    $('#info').removeClass("active");
    selezioneAttiva = false;
}

// SELEZIONA/DESELEZIONA TUTTE LE CATEGORIE - SOTTOCATEGORIE
$('.macrocategory').change(function (){
    $cat = $(this).next().attr('class');
    $cat = $cat.replace(" macrocategory-label","");
    //console.log($cat);

    if($(this).prop('checked')){
        $('.sub_' + $cat).prop('checked', 'checked');
    }
    else{
        $('.sub_' + $cat).prop('checked', false);
    }


});


