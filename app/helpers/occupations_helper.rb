module OccupationsHelper
  def tab_class(court_order_number)
    'active' if court_order_number == 0
  end

  def tab_href(court)
    "court_#{court.name.downcase.parameterize.underscore}"
  end

  def time_slot_row(court, date, time_slot, occupied_time_slots)
    occupation = nil
    if occupied_time_slots[court.id].keys.include?(time_slot.id)
      occupation = Occupation.find occupied_time_slots[court.id][time_slot.id]
    end

    row_content = content_tag :td do
      content_tag :div, class: 'checkbox' do
        label_tag do
          check_box_tag(
            "court_#{court.id}[]", 
            time_slot.id, 
            occupation.present?,
            disabled: occupation.present? || !policy(Occupation).create_multiple?,
            class: 'time-slot-checkbox'
          )
        end
      end
    end

    row_content += content_tag :td do
      label_tag "#{time_slot.label_begin_time} - #{time_slot.label_end_time}"
    end

    row_content += content_tag :td do
      occupation.user.name if occupation.present?
    end

    row_content += content_tag :td do
      if occupation.present?
        link_to t('.release'), occupation_path(occupation), 
            method: :delete, remote: true, class: 'btn btn-default btn-sm'
      else
        ''
      end
    end

    row_content.html_safe
  end
end
