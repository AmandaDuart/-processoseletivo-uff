require 'sinatra'
require "httparty"
require_relative "./classe/endereco"

get '/' do
  erb :index
end

post '/check_bike' do
  puts params
  puts "http://nominatim.openstreetmap.org/search?street=#{params[ "post"]["endereco"]}&city=#{params["post"]["cidade"]}&format=json&polygon=1&addressdetails=1"

  response  = HTTParty.get("http://nominatim.openstreetmap.org/search?street=#{params[ "post"]["endereco"]}&city=#{params["post"]["cidade"]}&format=json&polygon=1&addressdetails=1")
  endereco_data = JSON.parse(response.body)

  if endereco_data == []
    @pontos_bike = []
  else
    response_bike  = HTTParty.get("http://dadosabertos.rio.rj.gov.br/apiTransporte/apresentacao/rest/index.cfm/estacoesBikeRio")
    endereco_bike = JSON.parse(response_bike.body)

    @endereco_usuario = Endereco.new(endereco_data[0]['address']['road'], endereco_data[0]['lat'], endereco_data[0]['lon'])

    dados_bike = endereco_bike["DATA"]
    pontos_bike = []
    dados_bike.each do |dado|
      pontos_bike << Endereco.new(dado[3], dado[5], dado[6])
    end

    @pontos_bike = pontos_bike.sort { |a, b| a.calcula_distancia(@endereco_usuario) <=> b.calcula_distancia(@endereco_usuario) }
  end

  erb :distancias
end
