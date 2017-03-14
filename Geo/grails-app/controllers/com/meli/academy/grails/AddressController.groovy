package com.meli.academy.grails

class AddressController {
	
	def geoService
	
	def index() {

	}
	
	def getCoordenadas(String direccion) {
		direccion = direccion.replace(" ", "+")
		def coordenadas = geoService.getCoordenadas(direccion)
		println(geoService.getPayments(coordenadas.latitud[0].toString(),coordenadas.longitud[0].toString()))
	}

}
