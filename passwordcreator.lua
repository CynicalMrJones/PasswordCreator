
passwordcreator = {}

--This function loads the table from scratch evertime it is called
function Loadtable()
    Services = {}
    Password = {}
    Linecount = 0
    local i = 0
    for line in io.lines("username.txt") do
        Linecount = Linecount + 1
    end
    local file = io.input("username.txt")
    while i <= Linecount do
        local temp = io.read("l")
        table.insert(Services, temp)
        i = i + 1
    end
    io.close(file)
    local pword = io.input("password.txt")
    local w = 0
    while w <= Linecount do
        local temp2 = io.read("l")
        table.insert(Password, temp2)
        w = w + 1
    end
    io.close(pword)
end

--This is for testing purposes
function TableIterator()
    Loadtable()
    for i = 1, Linecount, 1 do
        print(Services[i])
    end
end

--This is a Dogshit password generator and app again
function DrawMenu()
    print(" ---------------------------------------------------------------------------")
    print("|   Hello and welcome the the password manager!                             |")
    print("|   What would you like to do?                                              |")
    print("|   1) Input a new password                                                 |")
    print("|   2) Search for a password                                                |")
    print("|   3) Generate a password                                                  |")
    print("|   4) View all passwords                                                   |")
    print("|   5) Delete a Password                                                    |")
    print("|   6) Exit Program                                                         |")
    print(" ---------------------------------------------------------------------------")
end

local function ServiceChecker(name)
    Loadtable()
    local i = 1
    while i <= Linecount do
        if Services[i] == name then
            return true
        elseif Services[i] ~= name then
            i = i + 1
        end
    end
    return false
end

local function opt1(service, password) --This serves as what happens when the user picks option 1 hence the name
    local U = io.open("username.txt","a")
    io.output(U)
    io.write(service,"\n")
    io.close(U)
    local P = io.open("password.txt","a")
    io.output(P)
    io.write(password,"\n")
    io.close(P)
    print("Password Successfully saved")
end


--Iterates through the list and returns the password if one exsists
local function opt2() --WIP
    Loadtable()
    print("What services password are you searching for?:")
    local answer2 = io.stdin:read()
    local j = 1
    while j <= Linecount do
        if Services[j].lower == answer2.lower then
            print(Password[j])
            break
        elseif j == Linecount then
            print("Unable to find password")
            break
        else
            j = j + 1
        end
    end
end


--This function is gross and needs to be updated but its functional
--Here is a list of possible changes to make it better:
--1) Making it so the function pulls from the same library at random that way it isnt always random
--letters followed by random symbols
--2) Figuring out what needs to be local and what needs to be global
--3) General name changes to be more specific ex. Changin pt1 to be more specific
local function opt3()
    math.randomseed(os.time())
    local num = math.random(7,9)
    local i = 1
    local randomCap = string.char(math.random(65, 90))
    local pt1 = randomCap
    while i <= num do
        math.randomseed(os.time() + i)
        randomCap = string.char(math.random(65, 90))
        local randomLow = string.char(math.random(65, 90)):lower()
        local flip = math.random(1,2)
        if flip == 1 then
            pt1 = randomCap .. pt1
        else
            pt1 = randomLow .. pt1
        end
        i = i + 1
    end

    local function symbols() --Seperate function for the symbol selection
        i = 1
        local chars = "!@#$%^&*()<>?" -- The Char Library
        local rint = math.random(1, #chars) -- 1 out of length of chars
        local rchar = chars:sub(rint, rint)
        local pt2 = rchar
        while i <= 3 do
            rint = math.random(1, #chars) -- 1 out of length of chars
            rchar = chars:sub(rint, rint)
            pt2 = rchar .. pt2
            i = i + 1
        end
        return pt2
    end
    local final = pt1 .. symbols()
    print(final)
    print("Would you like to record this password and use it for a service (y/n)?")
    local answer = io.stdin:read()
    local pword
    if answer == "y" then
        print("What service is it for?:")
        answer = io.stdin:read()
        pword = final
        opt1(answer, pword)
    end
end

local function opt4()
    Loadtable()
    for i = 1, Linecount, 1 do
       print(Services[i])
       print(Password[i])
       print("")
    end
end

local function opt5()
    
end

local function opt6()
    os.execute("exit")
end

function passwordcreator.App()
    Loadtable()
    DrawMenu()
    print("What option would you like?:")
    local answer = io.stdin:read()

    if answer == "1" then
        print("What is the name of the service that the password is for")
        local bool = true
        while bool  == true do
        Service = io.stdin:read()
            if ServiceChecker(Service) == true then
                print("This service already has an entry. Please pick another:")
                bool = true
            else
                print("What is the password")
                Password = io.stdin:read()
                bool = false
            end
        end
        opt1(Service, Password)
        passwordcreator.App()

    elseif answer == "2" then
        opt2()
        passwordcreator.App()

    elseif answer == "3" then
        opt3()
        passwordcreator.App()

    elseif answer == "4" then
        opt4()
        passwordcreator.App()

    elseif answer == "5" then
        opt5()
        passwordcreator.App()

    elseif answer == "6" then
        opt6()

    else
        passwordcreator.App()
    end
end
return passwordcreator
