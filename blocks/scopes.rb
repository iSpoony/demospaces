@v1 = 1

class MyClass
    @v1
    v2 = 2
    local_variables

    def my_method
        v3 = 3
        local_variables
    end

    local_variables
end

obj = MyClass.new
obj.my_method
obj.my_method
local_variables

def a_scope
    $var = "some value"
end

def another_scope
    $var
end

a_scope
another_scope
