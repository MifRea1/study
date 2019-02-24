module Exercise
  module Fp
    class << self
      # Обратиться к параметрам фильма можно так:
      # film["name"], film["rating_kinopoisk"], film["rating_imdb"],
      # film["genres"], film["year"], film["access_level"], film["country"]
      def rating(array)
        films = array.select { |film| film['rating_kinopoisk'].to_f > 0 && film['country'].to_s.include?(',') }
        ratings = films.map { |film| film['rating_kinopoisk'].to_f }
        ratings.reduce(:+) / ratings.size
      end

      def chars_count(films, threshold)
        above_threshold = films.select { |film| film['rating_kinopoisk'].to_f >= threshold }
        names = above_threshold.map { |film| film['name'] }
        names.join.count('и')
      end
    end
  end
end
