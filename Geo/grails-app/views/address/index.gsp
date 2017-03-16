<!DOCTYPE html>
<html>
<head>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>

<title>MELI GEO</title>
</head>
<body>
<body bgcolor="#ffffff">
	<div id="map" style="heigth: 200px"></div>
	<div class="row">
		<div class="col-sm-6 col-sm-offset-3">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<span class="glyphicon glyphicon-filter"></span>Filtros
				</div>
				<div class="panel-body">
					<label for="direccion" class="col-sm-4">Direccion o Lugar</label> <input
						type="text" class="col-sm-8" id="direccion"
						placeholder="Ingrese una direccion" value=""> 
					<label for="radio" class="col-sm-4">Radio (mts)</label> <input
						type="text" class="col-sm-8" id="radio"
						placeholder="Ingrese el radio en metros" value="0"> <label
						for="cantidadResultados" class="col-sm-4">Cantidad
						Resultados</label> <input type="text" class="col-sm-8"
						id="cantidadResultados" placeholder="Ingrese cantidad" value="5">
					<label for="mediosPago" class="col-sm-4">Medio de Pago</label> <g:select
					id="mediosPago" name="mediosPago" from="${mediosPago }"></g:select>
				</div>
				<div class="panel-footer">
					<button class="btn btn-primary" onclick="obtenerMiUbicacion()">
						<span class="glyphicon glyphicon-map-marker"></span>Usar mi
						ubicación!
					</button>
					<button class="btn btn-primary" onclick="geolocalizarDireccion()">
						<span class="glyphicon glyphicon-map-marker"></span>Usar direccion
					</button>
				</div>
			</div>
		</div>
	</div>

	<div class="col-sm-6 col-sm-offset-3" id="pnlMsj">
		<div class="progress col-sm-8 col-sm-offset-2">
			<div
				class="progress-bar progress-bar-success progress-bar-striped active"
				role="progressbar" aria-valuenow="100" aria-valuemin="0"
				aria-valuemax="100" style="width: 100%"></div>
		</div>
		<center>
			<h2 id="msj">Buscando ...</h2>
		</center>
	</div>
	<div id="divLugares" class="row"></div>
	<script type="text/javascript">
			
			
			function mostrarCargando(){
				$("#pnlMsj").show();
			}

			function ocultarCargando(){
				$("#pnlMsj").hide();
			}

			function setMensajeCargando(msj){
				$("#msj").text(msj);
			}
			
			function obtenerMiUbicacion(){
				if(navigator.geolocation){
					setMensajeCargando("Obteniendo su geolocalización.");
					mostrarCargando();
					navigator.geolocation.getCurrentPosition(funcionSi, funcionNo);
				}
				else{
			    	console.log("No soporta geolocalización");
			    	ocultarCargando();
				}
			}
			
		
			function funcionSi(resultado) {
				console.log(resultado);
				var latitud = resultado.coords.latitude;
				var longitud = resultado.coords.longitude;
				var radio = $("#radio").val();
				var cantResultados = $("#cantidadResultados").val();
				getMediosOff(latitud, longitud, radio, cantResultados);
			}
		
			function funcionNo(err) {
				console.log("error");
				console.log(err);
			}

			function getMediosOff(latitud, longitud, radio, cantResultados){
				<g:remoteFunction action="getPayments"
					controller="address"
					params= "\'latitud=\'+ latitud +\'&longitud=\'+ longitud +\'&radio=\'+ radio +\'&cantResultados=\'+ cantResultados"
					update="divLugares"
					onLoading="funcionCargandoLugares()"
					onSuccess="funcionExitoBusqueda(data)"
					onFailure="funcionErrorBusqueda()"/>
			}

			function funcionExitoBusqueda(res){
				ocultarCargando();
			}

			function funcionErrorBusqueda(){
				alert("Algo salió mal.");
				ocultarCargando();
			}

			function funcionCargandoLugares(){
				ocultarCargando();
				setMensajeCargando("Buscando lugares de pagos cercanos.");
				mostrarCargando();
			}

			function initMap() {
			  map = new google.maps.Map(document.getElementById('map'), {
			    center: {lat: -34.397, lng: 150.644},
			    zoom: 8
			  });
			}

			function geolocalizarDireccion(){
				var direccion = $("#direccion").val();
				<g:remoteFunction action="getCoordenadas" 
					controller="address"
					params= "\'direccion=\'+ direccion"
					update="divLugares"
					onLoading="funcionCargandoCoordenadas()"
					onSuccess="funcionExitoCoordenadas(data)"
					onFailure="funcionErrorBusqueda()"/>
			}

			function funcionExitoCoordenadas(resultado){
				console.log(resultado.latitud)
				console.log(resultado.longitud)
				ocultarCargando();
				var radio = $("#radio").val();
				var cantResultados = $("#cantidadResultados").val();
				console.log(radio)
				console.log(cantResultados)
				getMediosOff(resultado.latitud, resultado.longitud, radio, cantResultados);
			}

			function funcionCargandoCoordenadas(){
				ocultarCargando();
				setMensajeCargando("Geolocalizando dirección.");
				mostrarCargando();
			}
			
			ocultarCargando();
			
		</script>
</body>
</html>