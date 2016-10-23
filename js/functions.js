// Version 1.5

function zoom_out() {
      document.all.bild_klein.style.display = "none";  
      document.all.bild_gross.style.display = "block";          
}

function zoom_in() {
      document.all.bild_klein.style.display = "inline";  
      document.all.bild_gross.style.display = "none";          
}


function changeList(id) {
  if (document.getElementById(id).style.display!="none") var aktion="einklappen";
  
  for (i=1;;i++) {
     if (document.getElementById("zielgruppe"+i)) {      
	      document.getElementById("zielgruppe"+i).style.display="none";	
        document.getElementById("zielgruppe"+i).parentNode.className="ausklappen";	
        }
     else break;
	}
    
	if (aktion=="einklappen")
  {
  document.getElementById(id).style.display="none";	
  document.getElementById(id).parentNode.className="ausklappen";
  } else {
  document.getElementById(id).style.display="block";	
  document.getElementById(id).parentNode.className="ausgeklappt";
  }
}

function printFooter()  {
      var heute = new Date();
      var jahr = heute.getYear();
      var monat = heute.getMonth()+1;
      var tag = heute.getDate();
      document.all["print_data"].innerHTML = window.document.URL+"<br>ausgedruckt am "+tag+"."+monat+"."+jahr;
}

startList = function() {
   for (i=1;;i++) {
     if (document.getElementById("zielgruppe"+i)) {      
	      document.getElementById("zielgruppe"+i).style.display="none";	
        document.getElementById("zielgruppe"+i).parentNode.className="ausklappen";	
        }
     else break;
	}
}

function go(x)  {
       window.location.href=x;
}


window.onload=startList;