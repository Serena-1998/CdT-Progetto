$().ready(function()
{
    //le variabili servono per verificare se le parole/espressioni che fanno parte delle annotazioni sono già evidenziate o no
    var highlight = false;
    var highlight_title = false;
    var highlight_persName = false;
    var highlight_orgName = false;
    var highlight_eventName = false;
    var highlight_places = false;
    var highlight_term = false;
    var highlight_date = false;

    //quando viene cliccato il button "Mostra tutti gli elementi", tutte le parole/espressioni che fanno parte delle annotazioni vengono evindenziate
    $("#highlight-button").click(function()
    {
        if(highlight == false) //se non sono già evidentiate, si evidenziano
        {
            $(".title, .persName, .placeName, .geogName, .term, .date, .orgName, .eventName").addClass("color");
            highlight = true;
        }
        else //se sono già evidenziate, il colore viene rimosso
        {
            $(".title, .persName, .placeName, .geogName, .term, .date, .orgName, .eventName").removeClass("color");
            highlight = false;
        }
    });

    //quando viene cliccato il button "Titoli", tutti i title vengono evindenziati
    $("#highlight-title").click(function()
    {
        if(highlight_title == false) 
        {
            $(".title").addClass("color");
            highlight_title = true;
        }
        else //quando il button viene ricliccato, il colore viene rimosso
        {
            $(".title").removeClass("color");
            highlight_title = false;
        }
    });

    //Button "Persone"
    $("#highlight-persName").click(function()
    {
        if(highlight_persName == false) 
        {
            $(".persName").addClass("color");
            highlight_persName = true;
        }
        else 
        {
            $(".persName").removeClass("color");
            highlight_persName = false;
        }
    });

    //Button "Siti geografici"
    $("#highlight-places").click(function()
    {
        if(highlight_places == false)
        {
            $(".placeName").addClass("color");
            highlight_places = true;
        }
        else
        {
            $(".placeName").removeClass("color");
            highlight_places = false;
        }
    });

    //Button "Termini"
    $("#highlight-term").click(function()
    {
        if(highlight_term == false)
        {
            $(".term").addClass("color");
            highlight_term = true;
        }
        else
        {
            $(".term").removeClass("color");
            highlight_term = false;
        }
    });

    //Button "Date"
    $("#highlight-date").click(function()
    {
        if(highlight_date == false)
        {
            $(".date").addClass("color");
            highlight_date = true;
        }
        else
        {
            $(".date").removeClass("color");
            highlight_date = false;
        }
    });

    //Button "Organizzazioni"
    $("#highlight-orgName").click(function()
    {
        if(highlight_orgName == false)
        {
            $(".orgName").addClass("color");
            highlight_orgName = true;
        }
        else
        {
            $(".orgName").removeClass("color");
            highlight_orgName = false;
        }
    });

    //Button "Eventi"
    $("#highlight-eventName").click(function()
    {
        if(highlight_eventName == false)
        {
            $(".eventName").addClass("color");
            highlight_eventName = true;
        }
        else
        {
            $(".eventName").removeClass("color");
            highlight_eventName = false;
        }
    });

    //quando il cursore passa sopra una parola/espressione che fa parte delle annotazioni, essa si evidenzia
    $(".highlight").mouseover(function()
    {
        //si verifica che la parola/espressione non sia già evidenziata
        if($(this).hasClass("passcolor") == false && $(this).hasClass("color") == false) 
        // "Mostra tutti gli elementi" o il button relativo alla parola/espressione non devono essere stati cliccati per attivare il colore
        {
            $(this).addClass("passcolor"); 
        }
    });

    //quando il cursore si sposta dalla parola/espressione evidenziata, il colore viene rimosso
    $(".highlight").mouseout(function()
    {
        //si rimuove il colore solo se la parola è stata evidenziata passandoci sopra con il cursore (non cliccando su un button)
        if($(this).hasClass("passcolor") == true && $(this).hasClass("color") == false) 
        {
            $(this).removeClass("passcolor");
        }
    });

    //passando il cursore sull'immagine, si evidenzia il testo corrispondente
    $("rect").mouseover(function()
    {
            var facs = $(this).attr("id");
            $(this).addClass("highlighted");
            if (facs == "pg61-p10.2")
            {
                $("*[ data-facs='pg61-p10.1']").addClass("highlighted"); 
            }
            else
            {
                $("*[ data-facs='"+facs+"']").addClass("highlighted");    
            }
    });

    //quando il cursore si sposta dall'immagine, il colore viene rimosso sia dall'immagine che dal testo
    $("rect").mouseout(function()
    { 
        var facs = $(this).attr("id");
        $(this).removeClass("highlighted");
        if (facs == "pg61-p10.2")
        {
            $("*[ data-facs='pg61-p10.1']").removeClass("highlighted"); 
        }
        else
        {
            $("*[ data-facs='"+facs+"']").removeClass("highlighted");    
        }
    });

    //passando il cursore sul testo, si evidenzia la porzione d'immagine corrispondente
    $("*[data-facs]").mouseover(function()
    {
        var facs = $(this).attr("data-facs");
        if(facs == "") return; //@facs è vuoto, quindi non si fa niente
        $(this).addClass("highlighted");

        if (facs == "pg61-p10.1") //se il cursore passa su data-facs="pg61-p10.1", si evidenziano sia id="pg61-p10.1" che id="pg61-p10.2"
        {
            $("#pg61-p10\\.1").addClass("highlighted");
            $("#pg61-p10\\.2").addClass("highlighted");
        }
        else
        {
            $("*[id='"+facs+"']").addClass("highlighted");
        }
    });

    //quando il cursore si sposta dal testo, il colore viene rimosso sia dall'immagine che dal testo
    $("*[data-facs]").mouseout(function()
    {
        var facs = $(this).attr("data-facs");
        $(this).removeClass("highlighted");

        if (facs == "pg61-p10.1") //se il cursore si sposta da data-facs="pg61-p10.1", il colore viene rimosso sia da id="pg61-p10.1" che da id="pg61-p10.2"
        {
            $("#pg61-p10\\.1").removeClass("highlighted");
            $("#pg61-p10\\.2").removeClass("highlighted");
        }
        else
        {
            $("*[id='"+facs+"']").removeClass("highlighted");
        }
    });
});