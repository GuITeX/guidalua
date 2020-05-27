---<<< uno
function fibonacci(n)
    if n < 2 then
        return 1
    end
     
    local n1, n2 = 1, 1
    for i = 1, n-1 do
        n1, n2 = n2, n1 + n2 -- assegnazione multipla
    end
    return n1
end

print(fibonacci(10)) --> 55
--->>>



---<<< due
function fibonacci(n)
    n = n or 10 -- the default value is 10
    if n == 1 then
        return 1, 1
    end
     
    if n == 2 then
        return 1, 2
    end
     
    local sum = 1
    local n1, n2 = 1, 1
    for i = 1, n-1 do
        n1, n2 = n2, n1 + n2
        sum = sum + n1
    end
    return n1, sum
end

local fib_10, sum_fib_10 = fibonacci()
print(fib_10, sum_fib_10)
--->>>
