def three_times
    yield
    yield
    yield
end
#three_times { puts 'hello'}

def fib_up_to(max)
    i1, i2 = 1, 1
    while i1 < max
        yield i1
        i1, i2 = i2, i1 + i2
    end
end
fib_up_to(1000) { |f| print f, ' '}
puts ' -- '
def fib_up_to0(max)
    i1, i2 = 1, 1
    while i1 < max
        print i1, ' '
        i1, i2 = i2, i1 + i2
    end
end
fib_up_to0(1000)
puts ' -- '

def n_times(thing)
    return lambda { |n| thing * n}
end
p1 = n_times(23)
p1.call(3)
p1.call(4)
p2 = n_times('Hello ')
p2.call(3)

p1.inspect
p2.inspect

def take_block(p1)
    if block_given?
        yield(p1)
    else
        p1
    end
end
take_block('No Block')
take_block('No Block') {|s| s.sub(/No /, '')}

class TaxCalculator
    def initialize(name, &block)
        @name, @block = name, block
    end
    def get_tax(amount)
        "#@name on #{amount} = #{ @block.call(amount) }"
    end
end
tc = TaxCalculator.new("Sales tax") {|amt| amt * 0.075}
tc.get_tax(100)
tc.get_tax(250)
