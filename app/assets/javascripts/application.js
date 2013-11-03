$(document).ready(function(){
    $('#form_search').submit(function(){
        var x=document.forms["form_search"]["search"].value;
        //cambio el attr action del form, para que cambie su  ruta
        $(this).attr('action', "show/"+x);

        if (x==null || x=="")
        {
            alert("Escriba algo..");
            return false;
        }
    });
});
