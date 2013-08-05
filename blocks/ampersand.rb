def math(a, b)
    p 'mm'; yield(a, b) if block_given?
end

def teach_math(a, b, &operation)
    p '----'
    p a
    p b
    p 'tt'; p operation if operation
    p '++++'
    puts math(a, b, &operation)
end

teach_math(7, 3) {|x, y| x * y}
#teach_math(7, 3)
