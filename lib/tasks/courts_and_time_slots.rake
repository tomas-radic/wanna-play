namespace :courts_and_time_slots do
  
  desc 'Creates courts and time slots'
  task create: :environment do
    puts 'Creating courts...'

    ['Kurt 1', 'Kurt 2'].each do |court_name|
      Court.where(name: court_name).first_or_create!
    end

    puts 'Courts created.'
    puts 'Creating time slots...'

    [
      { order_key: 700, label_begin_time: '7:00', label_end_time: '7:30' },
      { order_key: 730, label_begin_time: '7:30', label_end_time: '8:00' },
      { order_key: 800, label_begin_time: '8:00', label_end_time: '8:30' },
      { order_key: 830, label_begin_time: '8:30', label_end_time: '9:00' },
      { order_key: 900, label_begin_time: '9:00', label_end_time: '9:30' },
      { order_key: 930, label_begin_time: '9:30', label_end_time: '10:00' },
      { order_key: 1000, label_begin_time: '10:00', label_end_time: '10:30' },
      { order_key: 1030, label_begin_time: '10:30', label_end_time: '11:00' },
      { order_key: 1100, label_begin_time: '11:00', label_end_time: '11:30' },
      { order_key: 1130, label_begin_time: '11:30', label_end_time: '12:00' },
      { order_key: 1200, label_begin_time: '12:00', label_end_time: '12:30' },
      { order_key: 1230, label_begin_time: '12:30', label_end_time: '13:00' },
      { order_key: 1300, label_begin_time: '13:00', label_end_time: '13:30' },
      { order_key: 1330, label_begin_time: '13:30', label_end_time: '14:00' },
      { order_key: 1400, label_begin_time: '14:00', label_end_time: '14:30' },
      { order_key: 1430, label_begin_time: '14:30', label_end_time: '15:00' },
      { order_key: 1500, label_begin_time: '15:00', label_end_time: '15:30' },
      { order_key: 1530, label_begin_time: '15:30', label_end_time: '16:00' },
      { order_key: 1600, label_begin_time: '16:00', label_end_time: '16:30' },
      { order_key: 1630, label_begin_time: '16:30', label_end_time: '17:00' },
      { order_key: 1700, label_begin_time: '17:00', label_end_time: '17:30' },
      { order_key: 1730, label_begin_time: '17:30', label_end_time: '18:00' },
      { order_key: 1800, label_begin_time: '18:00', label_end_time: '18:30' },
      { order_key: 1830, label_begin_time: '18:30', label_end_time: '19:00' },
      { order_key: 1900, label_begin_time: '19:00', label_end_time: '19:30' },
      { order_key: 1930, label_begin_time: '19:30', label_end_time: '20:00' },
      { order_key: 2000, label_begin_time: '20:00', label_end_time: '20:30' },
      { order_key: 2030, label_begin_time: '20:30', label_end_time: '21:00' },
      { order_key: 2100, label_begin_time: '21:00', label_end_time: '21:30' },
      { order_key: 2130, label_begin_time: '21:30', label_end_time: '22:00' }
    ].each do |time_slot_data|
      TimeSlot.where(order_key: time_slot_data[:order_key]).first_or_create!(
        label_begin_time: time_slot_data[:label_begin_time],
        label_end_time: time_slot_data[:label_end_time]
      )
    end

    puts 'Time slots created.'
    puts 'Connecting courts with time slots...'

    Court.all.each do |court|
      TimeSlot.all.each do |time_slot|
        CourtToTimeSlot.where(court: court, time_slot: time_slot).first_or_create
      end
    end

    puts 'Connected.'
  end
end
