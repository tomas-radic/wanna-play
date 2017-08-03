namespace :availabilities do
  
  desc 'Destroys all availabilities planned for the yesterday or older'
  task destroy_passed: :environment do
    puts "destroyed #{Availability.passed.destroy_all.count} availabilities"
  end

  desc 'Destroys all availabilities that belong to blocked users'
  task destroy_blocked: :environment do
    puts "destroyed #{Availability.blocked.destroy_all.count} availabilities"
  end

  desc 'Connects www.kurty-topolcany.sk page to see planned matches and cancels availabilities for listed players'
  task autocancel: :environment do
    require 'nokogiri'
    require 'open-uri'

    # Fetch and parse HTML document
    doc = Nokogiri::HTML(open('http://www.kurty-topolcany.sk'))
    plan_element = doc.at_css('#najbližšie-zápasy')
    date = nil
    now = DateTime.now

    plan_element.css('tr').each do |row_element|
      row_element.css('td').each do |cell_element|
        cell_content = cell_element.content.strip
        
        # Evaluate if cell_content is like "10-07-2017 ... " or "10-7-2017 ... "
        if /^(([0-9]{1}|[0-9]{2})-([0-9]{1}|[0-9]{2})-[0-9]{4})/.match(cell_content)
          date_string = cell_content.split(' ').first # take only substring in front of first space

          unless date_string.blank?
            # assume date_string to be like "10-07-2017" here
            date_values = date_string.split('-').reverse

            if date_values.count == 3 && date_values.first.length == 4
              suppress(Exception) do
                date = Date.parse date_values.join('-')
                puts "\nSetting date to #{date.to_s}"
              end
            end
          end
        end

        next if date.nil?
        users_recognized = User.where(name: cell_content)
        puts "Users recognized: #{users_recognized.pluck(:id, :name).to_s}"
        next if users_recognized.count != 1

        cancellable_availabilities = users_recognized.first.availabilities.where(
          date: date, 
          autocancel: true,
          occupied_since: nil
        )
        puts "Cancelling availabilities #{cancellable_availabilities.pluck(:id, :date).to_s}"
        cancellable_availabilities.update_all(occupied_since: now)
      end if row_element.present?
    end if plan_element.present?
  end
end
