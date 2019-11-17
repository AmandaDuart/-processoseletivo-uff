
class Endereco
  def initialize(endereco, lat, lon)
    @endereco = endereco
    @lat = lat
    @lon = lon
  end

  def endereco
    @endereco
  end

  def lat
    @lat.to_f
  end

  def lon
    @lon.to_f
  end

  def calcula_distancia(ponto)
    dLat = to_rad(lat-ponto.lat);
    dLon = to_rad(lon-ponto.lon);
    a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(to_rad(lat)) * Math.cos(to_rad(ponto.lat)) * Math.sin(dLon/2) * Math.sin(dLon/2);
    c = 2 * Math.atan2(Math.sqrt(a),Math.sqrt(1-a));
    distance = 6371 * c;
    distance
  end

   private

  def to_rad(num)
    num * Math::PI/180;
  end
end
