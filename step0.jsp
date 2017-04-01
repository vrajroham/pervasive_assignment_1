<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Thank You</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
</head>
<body bgcolor="#000000" onLoad="">
<div style="margin-left:30px;">
      
	<font color="white"><center><h1>VRaJ's Pizza Shop [Confirm Order]</h1></center>
    <hr width="60%" />
	<center><img src="baking.gif" height=100 width=100><br>
	Please wait we are baking your order.......
</center>
<font color="#FFFFFF">
	<%
		String[] items=request.getParameter("items").split(",");
        String[] price=request.getParameter("price").split(",");
		String fname=request.getParameter("fname");
		String street=request.getParameter("street");
		String city=request.getParameter("city");
		String landmark=request.getParameter("landmark");
		String mobile=request.getParameter("mobile");
		//out.print(street);
	%>
    <form>
	    <input type="hidden" value="<% out.print(street+" "+city); %>" id="origin1" name="origin1" />
        <input type="hidden" id="org">
        <input type="hidden" id="des">
    </form>
  <!--
	 #Load XML File of Branches
  -->
  
  <script type="text/javascript">
  	//https://maps.googleapis.com/maps/api/distancematrix/json?origins=shirdi&destinations=kopargaon&mode=route&language=fr-FR
	  var service = new google.maps.DistanceMatrixService();
  		if (window.XMLHttpRequest)
		  {
		  	xmlhttp=new XMLHttpRequest();
		  }
		else
		  {
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }
			xmlhttp.open("GET","branches.xml",false);
			xmlhttp.send();
			xmlDoc=xmlhttp.responseXML; 
			txt="";	
			itemcnt=xmlDoc.getElementsByTagName("item");
			loc=Array();
			bname=Array(itemcnt);
			orig=Array();
			var final=Array();
			var org=document.getElementById("origin1").value;
			for(i=0;i<itemcnt.length;i++){
				orig.push(org);
				loc.push(xmlDoc.getElementsByTagName("item")[i].getAttribute("blocation"));
				bname.push(xmlDoc.getElementsByTagName("item")[i].getAttribute("bname"));
			}
			document.getElementById("org").value=orig.toString();
			document.getElementById("des").value=loc.toString();
			distance("delhi",orig);
			setTimeout(function(){alert(final);},5000);

	 /*
		 #API Refered From : https://developers.google.com/maps/documentation/javascript/reference?csw=1#Distance
	*/
	function distance(origin,destination){
		var result;
		alert(document.getElementById("org").value+" | "+document.getElementById("des").value);
		service.getDistanceMatrix(
		  {
			origins: [document.getElementById("org").value], //array of origins
			destinations: [document.getElementById("des").value], //aray of destionations
			//origins: ['jeur kumbhari','yeola'], //array of origins
			//destinations: ['shirdi','nashik'], //aray of des
			travelMode: google.maps.TravelMode.DRIVING,
			unitSystem: google.maps.UnitSystem.METRIC,
			avoidHighways: false,
			avoidTolls: false
		  }, callback);		
	}

			function callback(response, status){
			 	 console.log(response);
				  var results = response.rows[0].elements;
				  for (var j = 0; j < results.length; j++) {
	  					//alert(response.destinationAddresses+" -> "+response.originAddresses+" = "+response.rows[j].elements[j].distance.text);							
						result=response.rows[j].elements[j].distance.text;
						final.push(parseInt(result.replace(" km",""))+"km :  "+response.destinationAddresses[0]+"\n");
				  }
			return result;
	}
</script>

</body>
</html>
