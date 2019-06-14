module EventsHelper
  def current_user_3_best_categories_of_interest
    most_recent_liked_events = current_user.liked_events.ten_most_recent
    arr_of_ids_of_categories_of_interest = most_recent_liked_events.map do |event|
      event.category.id   # return array of ids of the 10 most recent events that have been liked by current user
    end                   # A same category may appears multiple times

    ids_occurences_counter_hash = Hash.new(0)

    arr_of_ids_of_categories_of_interest.each do |id|
      ids_occurences_counter_hash[id] += 1  #Count how many times appears each category
    end
      #We sort and take the 3 categories ids that appear the most
    ids_occurences_counter_hash.sort_by { |_, v| -v }.take(3).map { |arr| arr[0] }
  end
end
