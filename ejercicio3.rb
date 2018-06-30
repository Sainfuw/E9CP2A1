class Roulette
  def play(ruleta, num)
    azar = ruleta.sample
    logs(azar, num)
    puts azar == num ? 'Ganaste!' : 'Perdiste'
  end

  def logs(azar, num)
    File.open('roulette_history.txt', 'a') { |f| f.puts azar }
    File.open('winners.txt', 'a') { |f| f.puts num } if azar == num
  end

  def self.top_number(ruleta)
    nums = []
    nums_repetidos = []
    File.readlines('roulette_history.txt').each { |num| nums << num.chomp.to_i }
    ruleta.length.times do |val|
      nums.each do |num|
        nums_repetidos[val] = 0 if nums_repetidos[val].nil?
        nums_repetidos[val] += 1 if val + 1 == num
      end
    end
    nums_repetidos.index(nums_repetidos.max) + 1
  end
end

r = (1..10).to_a
Roulette.new.play(r, 5)
puts "El numero mas repetido historicamente es el: #{Roulette.top_number(r)}"
