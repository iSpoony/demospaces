module Printable
    def print
        'print in Printable'
    end

    def prepare_cover
        'prepare_cover in Printable'
    end
end

module Document
    def print_to_screen
        prepare_cover
        format_for_screen
        print
    end

    def format_for_screen
        'format_for_screen'
    end

    def print
        'print in Document'
    end
end

class Book
    include Document
    include Printable
end

