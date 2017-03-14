package com.meli.academy.grails

import grails.transaction.Transactional
import groovy.json.JsonSlurper

@Transactional
class GeoService {
	
	def getCoordenadas(String direccion) {
		def url = new URL('https://maps.googleapis.com/maps/api/geocode/json?address=' +"'"+ direccion +"'"+'&key=AIzaSyDZAlOKVMj_BeZWwaXo2_yDuzdV1AtfrGU')
		def connection = (HttpURLConnection)url.openConnection()
		connection.setRequestMethod("GET")
		connection.setRequestProperty("Accept", "application/json")
		connection.setRequestProperty("User-Agent", "Mozilla/5.0")
		JsonSlurper json = new JsonSlurper()
		def coordenadas = json.parse(connection.getInputStream()).results
		def address = [direccion:coordenadas.formatted_address, latitud: coordenadas.geometry.location.lat, longitud: coordenadas.geometry.location.lng]
		return address
	}

    def serviceMethod() {

    }
	
	def getPayments(String latitud, String longitud) {
		def url = new URL('https://api.mercadolibre.com/sites/MLA/payment_methods/agencies/search?near_to='+latitud+','+longitud+'&limit=5')
		def connection = (HttpURLConnection)url.openConnection()
		connection.setRequestMethod("GET")
		connection.setRequestProperty("Accept", "application/json")
		connection.setRequestProperty("User-Agent", "Mozilla/5.0")
		JsonSlurper json = new JsonSlurper()
		def suc = json.parse(connection.getInputStream()).results
		def sucursales = []
		suc.each {
			println(it.agency_code)
		}
//		def address = [direccion:coordenadas.formatted_address, latitud: coordenadas.geometry.location.lat, longitud: coordenadas.geometry.location.lng]
//		return address
	}
}
