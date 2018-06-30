require 'date'

class Course
  attr_reader :fecha_inicio
  def initialize(nombre, fecha_inicio, fecha_termino)
    @nombre = nombre
    @fecha_inicio = Date.parse fecha_inicio
    @fecha_termino = Date.parse fecha_termino
  end

  def already_started(fecha)
    if @fecha_inicio < fecha
      puts "#{@nombre} ya comenzó"
    else
      puts "#{@nombre} aun no empieza"
    end
  end

  def not_close(fecha)
    if @fecha_termino > fecha
      puts "#{@nombre} aun no termina"
    else
      puts "#{@nombre} ya termino"
    end
  end

  def self.leer_archivo(archive)
    cursos = []
    File.readlines(archive).each do |line|
      ls = line.chomp.split(', ')
      cursos << Course.new(*ls)
    end
    cursos
  end

  def self.comprobar_inicio(cursos, fecha = Date.today.to_s)
    fecha = Date.parse(fecha) if fecha.class != Date
    raise ArgumentError, 'Fecha invalida' if fecha >= Date.parse('2018-01-01')
    cursos.each { |curso| curso.already_started(fecha) }
  end

  def self.comprobar_termino(cursos, fecha = Date.today)
    fecha = Date.parse(fecha) if fecha.class != Date
    raise ArgumentError, 'Fecha invalida' if fecha >= Date.parse('2018-01-01')
    cursos.each { |curso| curso.not_close(fecha) }
  end
end

cursos = Course.leer_archivo('cursos.txt')
Course.comprobar_inicio(cursos, '2017-05-20')
puts
Course.comprobar_termino(cursos, '2017-09-10')
