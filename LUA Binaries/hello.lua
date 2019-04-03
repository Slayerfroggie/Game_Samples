print("hello world!")

a = "Hello"
b = 10
c = 10.5
d = true
e = nil
f = function()
   print("f to pay respects") 
end

--function f()
--    print ("press f to pay respect")
--end

f()

dog = {
    name = "Marley"
}

function dog:hello()
    print("Hello" .. self.name)
end

cat = {
    name = "Jess",
    hello = function(self)
        print("hello" .. self.name)
    end
}

-- Not equal symbol is ~=
if "Hello" ~= "bye" then
end

-- arrays
a = {"Hello", "World", "!"}
print(a[1])
print(a[2])
print(a[3])

-- # means to get the length of the array, like .length() in other languages
for i = 1, #a do
    print(a[i])
end
--table
b = {word = "Hello", another_word = "world"}
