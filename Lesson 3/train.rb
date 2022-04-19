class Station
  
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    puts "Станция #{name}"
  end

  def get_train(train)
    @trains << train
    puts "Уважаемые пассажиры! На станцию #{name} прибыл поезд № #{train.number}"
  end

  def show_trains(type = nil)
    if type
      puts "На станции #{name} поездa типа #{type} №:"
      trains.each {|train| puts train.number if train.type == type}
    else
      puts "На станции #{name} поезда №:"
      trains.each {|train| puts train.number}
    end
  end

  def send_train(train)
    trains.each {|train| train.number}
    trains.delete(train)
    puts "Поезд номер #{train.number} отправляется со станции #{name}"
  end

end

class Route
  attr_accessor :stations, :starting_station, :end_station

  def initialize(starting_station, end_station)
    @end_station = end_station
    @stations = [starting_station, end_station]
    puts "Построен маршрут #{stations.first.name} - #{stations.last.name}"
  end

  def add_station(station)
    self.stations[-1] = station
    self.stations << @end_station
    puts "К маршруту #{stations.first.name} - #{stations.last.name} добавлена станция #{station.name}"
  end

  def delete_station(station)
    if [stations.first, stations.last].include?(station)
      puts "Нельзя удалять первую и последнюю станции!"
    else self.stations.delete(station)
      puts "Станция #{station.name} удалена из списка!"
    end
  end

  def show_stations
    puts "Список всех станций: "
    self.stations.each {|station| puts "#{station.name}"}
    
  end

end

class Train

  attr_accessor :speed, :wagons_count, :number, :station, :route
  attr_reader :type

  def initialize(speed = 0, number, type, wagons_count)
    @speed = speed
    @number = number
    @type = type
    @wagons_count = wagons_count
    puts "Поезд № #{number}, тип: #{type}, вагонов: #{wagons_count}"
  end

  def current_speed
    self.speed
  end

  def stop 
    self.speed = 0
  end

  def add_wagons
    if speed == 0
      self.wagons_count += 1
      puts "Прицеплен 1 вагон. Всего вагонов: #{wagons_count}"
    else  
      puts "Поезд находится в движении, невозможно прицеплять вагоны!"
    end  
  end

  def remove_wagons
    if wagons_count.zero?
      puts "Все вагоны уже были отцеплены"
    elsif speed == 0
      self.wagons_count -= 1
      puts "Отцеплен 1 вагон. Теперь их #{wagons_count}"
    else
      puts "Нельзя на ходу отцеплять вагоны!"
    end

  end

  def received_route(route)
    self.route = route
    puts "Поезду № #{number} назначен маршрут #{route.stations.first.name} - #{route.stations.last.name}"
  end

  def moving(station)
    if @station == station
      puts "Поезд № #{number} всё еще на станции #{station.name}"
    elsif route.stations.include?(station)
      @station.send_train(self) if @station
      @station = station
      station.get_train(self)
    else
      puts "Такой станции нет в маршруте поезда №#{number}!"
    end
  end

  def pre_curr_next
    station_index = route.stations.index(station)
    puts "Текущая станция поезда #{station.name}"
    puts "Следующая - #{route.stations[station_index + 1].name}" if station_index != route.stations.size - 1
    puts "Предыдущая - #{route.stations[station_index - 1].name}" if station_index != 0 
  end

end


station_romashka = Station.new("Ромашка")
station_lyutik = Station.new("Лютик")
station_roza = Station.new("Роза")
station_pion = Station.new("Пион")
station_mimoza = Station.new("Мимоза")


train1 = Train.new(1, "passenger", 13)
train2 = Train.new(2, "passenger", 19)
train3 = Train.new(3, "passenger", 10)
train4 = Train.new(4, "cargo", 0)
train5 = Train.new(5, "cargo", 25)

station_romashka.get_train(train1)
station_romashka.get_train(train2)
station_romashka.get_train(train5)
station_romashka.show_trains
station_romashka.show_trains("cargo")
station_romashka.show_trains("passenger")
station_romashka.send_train(train2)
station_romashka.show_trains

route_romashka_mimoza = Route.new(station_romashka, station_mimoza)
route_romashka_mimoza.add_station(station_pion)
route_romashka_mimoza.add_station(station_roza)
route_romashka_mimoza.show_stations
route_romashka_mimoza.delete_station(station_pion)
route_romashka_mimoza.delete_station(station_mimoza)
route_romashka_mimoza.show_stations

train1.speed = 50
train1.speed = 100
train1.stop
train1.wagons_count
train1.add_wagons
train1.speed = 50
train1.add_wagons
train1.remove_wagons
train1.current_speed
train1.received_route(route_romashka_mimoza)
train1.moving(station_romashka)
train1.moving(station_roza)
train1.moving(station_roza)
train1.pre_curr_next
train1.moving(station_mimoza)
train1.pre_curr_next
train1.moving(station_pion)

