module Exercise
  module Fp2
    class MyArray < Array
      # Использовать стандартные функции массива для решения задач нельзя.
      # Использовать свои написанные функции для реализации следующих - можно.

      # Написать свою функцию my_each
      def my_each
        for e in self
          yield e
        end
      end

      # Написать свою функцию my_map
      def my_map
        my_reduce(MyArray.new) { |a, e| a << (yield e) }
      end

      # Написать свою функцию my_compact
      def my_compact
        my_reduce(MyArray.new) do |a, e|
          a << e unless e.nil?
          a
        end
      end

      # Написать свою функцию my_reduce
      def my_reduce(a = nil)
        start = 0
        if a.nil?
          start = 1
          a = self[0]
        end
        for e in self[start..-1]
          a = yield a, e
        end
        a
      end
    end
  end
end
