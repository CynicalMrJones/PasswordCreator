
passwordcreator = require"passwordcreator"

os.execute("clear")

local function GetPassword()
    local test = io.input("redundant.txt")
    Password = io.read("l")
    io.close(test)
end

local function Login()
    GetPassword()
    print(" ---------------------------------------------------------------------------")
    print("|   Please login with a the password                                        |")
    print(" ---------------------------------------------------------------------------")
    local answer = io.stdin:read()
    if answer == Password then
        os.execute("clear")
        passwordcreator.App()
    else
        print("Something went wrong")
    end
end

local function firsttime()
    if Checker() == true then
        Login()
    else
        os.execute("clear")
        print("You have never set up a password")
        print("Please enter a password:")
        Answer2 = io.stdin:read()
        local J = io.open("redundant.txt","a")
        io.output(J)
        io.write(Answer2)
        io.close(J)
        GetPassword()
        Login()
    end
end

function Checker()
    local f=io.open("redundant.txt","r")
    if f~=nil then io.close(f) return true else return false end
end

firsttime()
