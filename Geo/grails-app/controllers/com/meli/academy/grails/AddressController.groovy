package com.meli.academy.grails

import grails.converters.JSON

class AddressController {

	def geoService
	
	static mediosPago = ['Todos','Carga Virtual', 'PagoFacil', 'Rapipago', 'Redlink', 'BaproPagos']

	def index() {
		[mediosPago: mediosPago]
	}

	def getCoordenadas(params) {
		def direccion = params.direccion.toString().replace(" ", "+")
		def coordenadas = geoService.getCoordenadas(direccion)
		render coordenadas as JSON
	}
	
	def getPayments(params) {
		def latitud = params.latitud
		def longitud = params.longitud
		def listaSucursales = geoService.getPayments(params.latitud.toString(), params.longitud.toString(), params.radio, params.cantResultados)
		[listaSucursales:listaSucursales, mediosPago:mediosPago]
	}
}
