<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Thank You</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
</head>
<body bgcolor="#000000">
<font color="#FFFFFF">
	<%
		String[] items=request.getParameter("items").split(",");
        	String[] price=request.getParameter("price").split(",");
		String fname=request.getParameter("fname");
		String street=request.getParameter("street");
		String city=request.getParameter("city");
		String landmark=request.getParameter("landmark");
		String mobile=request.getParameter("mobile");
		out.print(street);
	%>
    <form>
	    <input type="hidden" value="<% out.print(street+","+city); %>" id="origin1" name="origin1" />
    </form>
  <!--
	 #Load XML File of Branches
  -->
  <script type="text/javascript">
  var service = new google.maps.DistanceMatrixService();
  			orig=document.getElementById("origin1").value;
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
			loc=Array(itemcnt);
			final=0;
			bname=Array(itemcnt);
			dist=Array();
			tempdist=Array();
			var myArray=new Array(itemcnt);
			i=0;
			var index=1;
			for(i=0;i<itemcnt.length;i++){
				myArray[i]=new Array(3);
				txt+=""+ xmlDoc.getElementsByTagName("item")[i].getAttribute("blocation") + "";
				loc[i]=xmlDoc.getElementsByTagName("item")[i].getAttribute("blocation");
				myArray[i][0]=xmlDoc.getElementsByTagName("item")[i].getAttribute("blocation");
				bname[i]=xmlDoc.getElementsByTagName("item")[i].getAttribute("bname");
				myArray[i][1]=xmlDoc.getElementsByTagName("item")[i].getAttribute("bname");
				dest=xmlDoc.getElementsByTagName("item")[i].getAttribute("blocation");
				index=i;
					 /*
						 #API Refered From : https://developers.google.com/maps/documentation/javascript/reference?csw=1#Distance
				   */
				    service.getDistanceMatrix(
					  {
						origins: [orig], //array of origins
						destinations: [dest], //aray of destionations
						travelMode: google.maps.TravelMode.DRIVING,
						unitSystem: google.maps.UnitSystem.METRIC,
						avoidHighways: false,
						avoidTolls: false
					  }, function(response, status){
						  console.log(response);
						  if(status===google.maps.DistanceMatrixStatus.OK)
						  {
								alert(response.destinationAddresses+" -> "+response.originAddresses+" = "+response.rows[0].elements[0].distance.text);
								result=response.rows[0].elements[0].distance.text;
								dist.push(parseInt(result.replace(" km","")));
								tempdist.push(parseInt(result.replace(" km","")));
								//dist.sort(function(a, b){return a-b});
								myArray[index][2]="d";
								console.log(dist);
								this.final=dist[0];
						  }
					  });
			}
		 setTimeout(function(){
			for(j=0;j<itemcnt.length;j++){
					if(dist[0]==tempdist[j]){
							alert("Min : "+Math.min.apply(Math,dist)+" at : "+ dist.indexOf(Math.min.apply(Math,dist)));
							alert("Your Order will be delievered by branch "+bname[dist.indexOf(Math.min.apply(Math,dist))]);
						}
				}

	  }, 3000);
</script>

</body>
</html>
