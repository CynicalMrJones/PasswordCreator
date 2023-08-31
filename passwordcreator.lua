
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

function opt1() --This serves as what happens when the user picks option 1 hence the name
    print("What is the name of the service that the password is for")
    local input = io.read()
    print("What is the password")
    local password = io.read()
    local f = io.open("file.txt","a")
    io.output(f)
    io.write(input, "\n", password, "\n")
    io.close(f)
    DrawMenu()
    print("Password Successfully saved")
end

function opt1mod(answer, pword) --This is a mod of option one that is only called in option 3. Very simple
    local j = io.open("file.txt","a")
    io.output(j)
    io.write(answer, "\n", pword, "\n")
    io.close(j)
end

--WIP still but ive made progress
--Still running into the problem of every entry getting added to the table
--Ideas on how to fix:
--1) Change how the file is read to get more fine control over which line it reads
function opt2() --WIP
    local services = {}
    local linecount = 1
    local f = io.input("file.txt")
    while linecount < 10 do
        if math.fmod(linecount, 2) == 0 then
            linecount = linecount + 1
        else
           local line = io.read("l")
           table.insert(services, line)
           linecount = linecount + 1
        end
    end
    for i=1,10 do
        print(services[i])
    end
end

--This function is gross and needs to be updated but its functional
--Here is a list of possible changes to make it better:
--1) Making it so the function pulls from the same library at random that way it isnt always random
--letters followed by random symbols
--2) Figuring out what needs to be local and what needs to be global
--3) General name changes to be more specific ex. Changin pt1 to be more specific
function opt3() 
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
        i = i+1
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
    local answer = io.read()
    local pword
    if answer == "y" then
        print("What service is it for?:")
        answer = io.read()
        pword = final
        opt1mod(answer, pword)
        DrawMenu()
    else
        DrawMenu()
    end
end

function opt4()
    
end

function opt5()
    
end

function opt6()
    os.execute("exit")
end

DrawMenu()
print("What option would you like?:")
local answer = io.read()
if answer == "1" then
    opt1()
elseif answer == "2" then
    opt2()
elseif answer == "3" then
    opt3()
elseif answer == "4" then
    opt4()
elseif answer == "5" then
    opt5()
elseif answer == "6" then
    opt6()
end
