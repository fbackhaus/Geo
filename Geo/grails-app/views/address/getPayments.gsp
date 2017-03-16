<div class="col-sm-10 col-sm-offset-1">
	<div class="panel panel-primary">
		<div class="panel-heading">Lugares</div>
		<div class="panel-body">
			<div>
				<table class="table">
					<thead>
						<tr>
							<th>Medio de Pago</th>
							<th>Descripcion</th>
							<th>Dirección</th>
							<th>Distancia</th>
							<th>Codigo Agencia</th>
						</tr>
					</thead>
					<tbody>

						<g:each in="${listaSucursales}" var="sucursal">
							<tr>
								<td>
									${sucursal.idMetodoPago}
								</td>
								<td>
									${sucursal.descripcion}
								</td>
								<td>
									${sucursal.direccion.direccion}
								</td>
								<td>
									${sucursal.distancia} mts
								</td>
								<td>
									${sucursal.codigoAgencia}
								</td>
							</tr>
						</g:each>

					</tbody>
				</table>
			</div>

		</div>
		<div class="panel-footer"></div>
	</div>
</div>

