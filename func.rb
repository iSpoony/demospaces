def meth_one
    "one"
end
meth_one

def meth_two(arg)
    case
    when arg > 0
        "positive"
    when arg < 0
        "negative"
    else
        "zero"
    end
end
meth_two(23)
meth_two(-12)
meth_two(0)

def meth_three
    100.times do |num|
        square = num ** 2
        return num, square if square > 1000
    end
end
meth_three

def five(a, b, c, d, e)
    "I was passed #{a} #{b} #{c} #{d} #{e}"
end
five(1, 2, 3, 4, 5)
five(1, 2, 3, *['a', 'b'])
five(*(10..14).to_a)

def tell_the_truth(options = {})
    puts 'options---'
    puts options
    if options[:profession] == :lawyer
        'it could be believed that this is almost certainly not false.'
    else
        true
    end
end
tell_the_truth
tell_the_truth :profession => :lawyer
tell_the_truth :profession => 'lawyer'

class Tree
    attr_accessor :children, :node_name

    def initialize(name, children = [])
        @children = children
        @node_name = name
    end

    def visit_all(&block)
        visit &block
        children.each {|c| c.visit_all &block}
    end

    def visit(&block)
        block.call self
    end
end

ruby_tree = Tree.new("Ruby", [Tree.new("Reia"), Tree.new("MacRuby")])

puts "Visiting a node"
ruby_tree.visit {|node| puts node.node_name}
puts

puts "Visiting entire tree"
ruby_tree.visit_all {|node| puts node.node_name}

class MyOpenStruct
    def initialize
        @attributes = {}
    end

    def method_missing(name, *args)
        puts "name:#{name}-"
        puts "args:#{args.to_s}-"
        attribute = name.to_s
        if attribute =~ /=$/
            @attributes[attribute.chop] = args[0]
        else
            @attributes[attribute]
        end
    end
end

class Roulette
    def method_missing(name, *args)
        person = name.to_s.capitalize

        #super unless %w[Bob Frank Bill].include? person

        number = 0
        3.times do
            number = rand(10) + 1
            puts "#{number}.."
        end
        "#{person} got a #{number}"
    end
end

number_of = Roulette.new
puts number_of.bob
puts number_of.frank

class String
    def method_missing(method, *args)
        method == :ghost_reverse ? reverse : super
    end
end
def test_string_ghost_method
    require 'benchmark'
    Benchmark.bm do |b|
        b.report 'Normal method' do
            1000000.times {'abc'.reverse}
        end
        b.report 'Ghost method' do
            1000000.times {'abc'.ghost_reverse}
        end
    end
end

#############################################
# TEST remove_method and undef_method       #
#############################################
class Parent
    def hello
        puts "In Parent"
    end
end

class Child < Parent
    def hello
        puts "In Child"
    end
end
c = Child.new
c.hello

class Child
    remove_method :hello # remove from child, still in parent
end
c.hello

class Child
    undef_method :hello # prevent any calls to 'hello'
end
c.hello

