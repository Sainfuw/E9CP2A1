# Clase de mesas
class Table
  def initialize(mesa, *recaudaciones)
    @mesa = mesa
    @recaudaciones = recaudaciones.map(&:to_i)
  end

  def self.leer_archivo(archive)
    mesas = []
    File.readlines(archive).each do |line|
      ls = line.chomp.split(', ')
      mesas << new(*ls)
    end
    mesas
  end

  def self.recaudacion_x_mesa(mesas)
    mesas.each { |mesa| puts mesa.mayor_recaudado }
  end

  def self.prom(mesas)
    suma = mesas.inject(0) { |sum, mesa| sum + mesa.promedio }
    prom = suma / mesas.length
    "El promedo total de todas las mesas es de: #{prom}"
  end

  def mayor_recaudado
    mayor = @recaudaciones.max
    dia = @recaudaciones.index(@recaudaciones.max) + 1
    "#{@mesa}, Dia #{dia}, #{mayor}"
  end

  def promedio
    @recaudaciones.inject(:+) / @recaudaciones.length.to_f
  end
end

mesas = Table.leer_archivo('casino.txt')
Table.recaudacion_x_mesa(mesas)
puts Table.prom(mesas)
