if getgenv().Library and getgenv().Library.Exit then
    getgenv().Library:Exit()
end

cloneref = cloneref or function(Object) return Object end 

--#region Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local CoreGui = cloneref(game:GetService("CoreGui"))
--#endregion

gethui = gethui or function() return CoreGui end

--#region Variables 
local LocalPlayer = Players.LocalPlayer
local IsMobile = UserInputService.TouchEnabled or false
local GuiInset = GuiService:GetGuiInset().Y
local Mouse = cloneref(LocalPlayer:GetMouse())
--#endregion

local Library = { 
    Flags = { },
    MenuKeybind = tostring(Enum.KeyCode.X),

    Directory = "cloude",
    Folders = {
        Assets = "/Assets",
        Configs = "/Configs",
        Themes = "/Themes"
    },

    FontSize = 31,

    Animation = {
        Time = 0.3,
        Style = "Quint",
        Direction = "Out"
    },

    ZIndexOrder = {
        ["OptionHolder"] = 4,
        ["KeybindWindow"] = 4, -- burp
        ["ColorpickerWindow"] = 6
    },

    Theme = nil,
    Themes = nil,
    ThemeOrder = nil,
    Notifications = { },

    -- Ignore below
    Threads = { },
    Connections = { },
    SetFlags = { },

    ThemingStuff = { },
    ThemeMap = { },

    OpenFrames = { },

    Holder = nil,
    UnusedHolder = nil,

    Font = nil,
} do 
    Library.__index = Library

    local Flags = Library.Flags 
    local SetFlags = Library.SetFlags

    local Keys = {
        ["Unknown"]           = "Unknown",
        ["Backspace"]         = "Back",
        ["Tab"]               = "Tab",
        ["Clear"]             = "Clear",
        ["Return"]            = "Return",
        ["Pause"]             = "Pause",
        ["Escape"]            = "Escape",
        ["Space"]             = "Space",
        ["QuotedDouble"]      = '"',
        ["Hash"]              = "#",
        ["Dollar"]            = "$",
        ["Percent"]           = "%",
        ["Ampersand"]         = "&",
        ["Quote"]             = "'",
        ["LeftParenthesis"]   = "(",
        ["RightParenthesis"]  = " )",
        ["Asterisk"]          = "*",
        ["Plus"]              = "+",
        ["Comma"]             = ",",
        ["Minus"]             = "-",
        ["Period"]            = ".",
        ["Slash"]             = "`",
        ["Three"]             = "3",
        ["Seven"]             = "7",
        ["Eight"]             = "8",
        ["Colon"]             = ":",
        ["Semicolon"]         = ";",
        ["LessThan"]          = "<",
        ["GreaterThan"]       = ">",
        ["Question"]          = "?",
        ["Equals"]            = "=",
        ["At"]                = "@",
        ["LeftBracket"]       = "LeftBracket",
        ["RightBracket"]      = "RightBracked",
        ["BackSlash"]         = "BackSlash",
        ["Caret"]             = "^",
        ["Underscore"]        = "_",
        ["Backquote"]         = "`",
        ["LeftCurly"]         = "{",
        ["Pipe"]              = "|",
        ["RightCurly"]        = "}",
        ["Tilde"]             = "~",
        ["Delete"]            = "Delete",
        ["End"]               = "End",
        ["KeypadZero"]        = "Keypad0",
        ["KeypadOne"]         = "Keypad1",
        ["KeypadTwo"]         = "Keypad2",
        ["KeypadThree"]       = "Keypad3",
        ["KeypadFour"]        = "Keypad4",
        ["KeypadFive"]        = "Keypad5",
        ["KeypadSix"]         = "Keypad6",
        ["KeypadSeven"]       = "Keypad7",
        ["KeypadEight"]       = "Keypad8",
        ["KeypadNine"]        = "Keypad9",
        ["KeypadPeriod"]      = "KeypadP",
        ["KeypadDivide"]      = "KeypadD",
        ["KeypadMultiply"]    = "KeypadM",
        ["KeypadMinus"]       = "KeypadM",
        ["KeypadPlus"]        = "KeypadP",
        ["KeypadEnter"]       = "KeypadE",
        ["KeypadEquals"]      = "KeypadE",
        ["Insert"]            = "Insert",
        ["Home"]              = "Home",
        ["PageUp"]            = "PageUp",
        ["PageDown"]          = "PageDown",
        ["RightShift"]        = "RightShift",
        ["LeftShift"]         = "LeftShift",
        ["RightControl"]      = "RightControl",
        ["LeftControl"]       = "LeftControl",
        ["LeftAlt"]           = "LeftAlt",
        ["RightAlt"]          = "RightAlt"
    }

    -- Folders
    if not isfolder(Library.Directory) then 
        makefolder(Library.Directory)
    end

    for _, Folder in Library.Folders do 
        if not isfolder(Library.Directory .. Folder) then 
            makefolder(Library.Directory .. Folder)
        end
    end

    if not isfile(Library.Directory .. "/autoload.json") then
        writefile(Library.Directory .. "/autoload.json", "")
    end

    local Themes = {
        ["Default"] = {
            ["Background"] = Color3.fromRGB(14, 16, 22),
            ["Inline"] = Color3.fromRGB(20, 24, 34),
            ["Text"] = Color3.fromRGB(232, 236, 244),
            ["Inactive Text"] = Color3.fromRGB(126, 136, 156),
            ["Element"] = Color3.fromRGB(30, 36, 50),
            ["Accent"] = Color3.fromRGB(78, 148, 255),
            ["Outline"] = Color3.fromRGB(40, 50, 70),
            ["Outline 2"] = Color3.fromRGB(8, 10, 14),
            ["Hovered Element"] = Color3.fromRGB(40, 52, 74),
        },
        ["Graphite"] = {
            ["Background"] = Color3.fromRGB(14, 14, 15),
            ["Inline"] = Color3.fromRGB(20, 20, 22),
            ["Text"] = Color3.fromRGB(220, 220, 225),
            ["Inactive Text"] = Color3.fromRGB(110, 110, 118),
            ["Element"] = Color3.fromRGB(38, 38, 42),
            ["Accent"] = Color3.fromRGB(180, 185, 195),
            ["Outline"] = Color3.fromRGB(28, 28, 30),
            ["Outline 2"] = Color3.fromRGB(7, 7, 8),
            ["Hovered Element"] = Color3.fromRGB(52, 52, 58),
        },
        ["Vapor"] = {
            ["Background"] = Color3.fromRGB(12, 10, 16),
            ["Inline"] = Color3.fromRGB(18, 15, 26),
            ["Text"] = Color3.fromRGB(235, 230, 245),
            ["Inactive Text"] = Color3.fromRGB(130, 115, 155),
            ["Element"] = Color3.fromRGB(36, 30, 52),
            ["Accent"] = Color3.fromRGB(255, 120, 200),
            ["Outline"] = Color3.fromRGB(30, 24, 42),
            ["Outline 2"] = Color3.fromRGB(6, 5, 10),
            ["Hovered Element"] = Color3.fromRGB(50, 42, 72),
        },
        ["Oxide"] = {
            ["Background"] = Color3.fromRGB(15, 12, 10),
            ["Inline"] = Color3.fromRGB(22, 17, 14),
            ["Text"] = Color3.fromRGB(235, 220, 205),
            ["Inactive Text"] = Color3.fromRGB(130, 105, 85),
            ["Element"] = Color3.fromRGB(48, 34, 26),
            ["Accent"] = Color3.fromRGB(210, 105, 55),
            ["Outline"] = Color3.fromRGB(34, 24, 18),
            ["Outline 2"] = Color3.fromRGB(8, 5, 4),
            ["Hovered Element"] = Color3.fromRGB(66, 46, 36),
        },
        ["Glacier"] = {
            ["Background"] = Color3.fromRGB(10, 13, 16),
            ["Inline"] = Color3.fromRGB(14, 19, 24),
            ["Text"] = Color3.fromRGB(220, 235, 245),
            ["Inactive Text"] = Color3.fromRGB(100, 125, 145),
            ["Element"] = Color3.fromRGB(28, 38, 48),
            ["Accent"] = Color3.fromRGB(140, 210, 240),
            ["Outline"] = Color3.fromRGB(20, 28, 36),
            ["Outline 2"] = Color3.fromRGB(5, 7, 9),
            ["Hovered Element"] = Color3.fromRGB(40, 54, 68),
        },
        ["Nectar"] = {
            ["Background"] = Color3.fromRGB(13, 12, 9),
            ["Inline"] = Color3.fromRGB(20, 18, 12),
            ["Text"] = Color3.fromRGB(240, 230, 200),
            ["Inactive Text"] = Color3.fromRGB(135, 120, 80),
            ["Element"] = Color3.fromRGB(42, 36, 22),
            ["Accent"] = Color3.fromRGB(245, 190, 45),
            ["Outline"] = Color3.fromRGB(30, 26, 16),
            ["Outline 2"] = Color3.fromRGB(7, 6, 3),
            ["Hovered Element"] = Color3.fromRGB(58, 50, 30),
        },
        ["Poison"] = {
            ["Background"] = Color3.fromRGB(10, 14, 10),
            ["Inline"] = Color3.fromRGB(14, 22, 14),
            ["Text"] = Color3.fromRGB(210, 245, 210),
            ["Inactive Text"] = Color3.fromRGB(90, 130, 95),
            ["Element"] = Color3.fromRGB(26, 44, 28),
            ["Accent"] = Color3.fromRGB(90, 255, 120),
            ["Outline"] = Color3.fromRGB(18, 32, 20),
            ["Outline 2"] = Color3.fromRGB(4, 8, 5),
            ["Hovered Element"] = Color3.fromRGB(36, 62, 40),
        },
        ["Circuit"] = {
            ["Background"] = Color3.fromRGB(8, 12, 14),
            ["Inline"] = Color3.fromRGB(12, 18, 22),
            ["Text"] = Color3.fromRGB(200, 245, 240),
            ["Inactive Text"] = Color3.fromRGB(80, 130, 125),
            ["Element"] = Color3.fromRGB(22, 40, 44),
            ["Accent"] = Color3.fromRGB(0, 255, 200),
            ["Outline"] = Color3.fromRGB(16, 30, 34),
            ["Outline 2"] = Color3.fromRGB(3, 7, 8),
            ["Hovered Element"] = Color3.fromRGB(32, 56, 62),
        },
    }

    local ThemeOrder = { "Default", "Graphite", "Vapor", "Oxide", "Glacier", "Nectar", "Poison", "Circuit" }

    Library.Themes = Themes
    Library.ThemeOrder = ThemeOrder
    Library.Theme = Themes.Default

    -- Custom Font
    local CustomFont = { } do
        function CustomFont:New(Name, Weight, Style, Data)
            if not isfile(Data.Id) then 
                writefile(Data.Id, game:HttpGet(Data.Url))
            end

            local Data = {
                name = Name,
                faces = {
                    {
                        name = Name,
                        weight = Weight,
                        style = Style,
                        assetId = getcustomasset(Data.Id)
                    }
                }
            }

            writefile(`{Library.Directory .. Library.Folders.Assets}/{Name}.font`, HttpService:JSONEncode(Data))
            return Font.new(getcustomasset(`{Library.Directory .. Library.Folders.Assets}/{Name}.font`))
        end

        Library.Font = CustomFont:New("basim33", 400, "Regular", {
            Id = "basim33a",
            Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/basim33.ttf"
        })

        Library.BoldFont = CustomFont:New("basim33BOLD", 400, "Regular", {
            Id = "basim33BOLaD",
            Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/basim33BOLD.ttf"
        })
    end

    Library.FontCache = {}
    Library.FontBase = "https://raw.githubusercontent.com/xhafoenterskin-sudo/AetheriaUi/main/"
    Library.FontFiles = { Purrfect = "Purrfect.ttf" }
    Library.FontNames = { "Purrfect" }
    local FontPack = {
        "AbrilFatface-Regular.ttf", "Alegreya-Regular.ttf", "AlexBrush-Regular.ttf", "AlfaSlabOne-Regular.ttf",
        "AmaticSC-Regular.ttf", "AnonymousPro-Regular.ttf", "Anton-Regular.ttf", "Arimo-Regular.ttf",
        "Arvo-Regular.ttf", "Bangers-Regular.ttf", "Barlow-Regular.ttf", "BebasNeue-Regular.ttf",
        "Bitter-Regular.ttf", "BodoniModa-Regular.ttf", "Bungee-Regular.ttf", "Cabin-Regular.ttf",
        "Catamaran-Regular.ttf", "Caveat-Regular.ttf", "ChangaOne-Regular.ttf", "Cinzel-Regular.ttf",
        "CinzelDecorative-Regular.ttf", "Comfortaa-Regular.ttf", "Cookie-Regular.ttf", "Courgette-Regular.ttf",
        "Cousine-Regular.ttf", "CrimsonText-Regular.ttf", "DancingScript-Regular.ttf", "Domine-Regular.ttf",
        "Dosis-Regular.ttf", "EBGaramond-Regular.ttf", "Exo2-Regular.ttf", "FiraCode-Regular.ttf",
        "FiraSans-Regular.ttf", "FrankRuhlLibre-Regular.ttf", "Fredoka-Regular.ttf", "GreatVibes-Regular.ttf",
        "Heebo-Regular.ttf", "Hind-Regular.ttf", "Inconsolata-Regular.ttf", "IndieFlower-Regular.ttf",
        "Inter-Regular.ttf", "JosefinSans-Regular.ttf", "Kalam-Regular.ttf", "Kanit-Regular.ttf",
        "Karla-Regular.ttf", "KaushanScript-Regular.ttf", "Lato-Regular.ttf", "Lobster-Regular.ttf",
        "Lora-Regular.ttf", "Manrope-Regular.ttf", "MarckScript-Regular.ttf", "Montserrat-Regular.ttf",
        "Mukta-Regular.ttf", "Mulish-Regular.ttf", "Neuton-Regular.ttf", "Nunito-Regular.ttf",
        "OpenSans-Regular.ttf", "Oswald-Regular.ttf", "Overpass-Regular.ttf", "Oxygen-Regular.ttf",
        "Pacifico-Regular.ttf", "Parisienne-Regular.ttf", "PassionOne-Regular.ttf", "PatuaOne-Regular.ttf",
        "PlayfairDisplay-Regular.ttf", "Poppins-Regular.ttf", "Prata-Regular.ttf", "PressStart2P-Regular.ttf",
        "Prompt-Regular.ttf", "Quicksand-Regular.ttf", "Raleway-Regular.ttf", "Righteous-Regular.ttf",
        "Roboto-Regular.ttf", "RobotoCondensed-Regular.ttf", "RobotoMono-Regular.ttf", "Rubik-Regular.ttf",
        "RussoOne-Regular.ttf", "Sacramento-Regular.ttf", "Signika-Regular.ttf", "SourceCodePro-Regular.ttf",
        "SourceSans3-Regular.ttf", "SpaceMono-Regular.ttf", "SquadaOne-Regular.ttf", "TitanOne-Regular.ttf",
        "VT323-Regular.ttf", "Vollkorn-Regular.ttf", "WorkSans-Regular.ttf",
    }
    for _, File in ipairs(FontPack) do
        local Name = File:gsub("%-Regular%.ttf$", ""):gsub("%.ttf$", "")
        Library.FontFiles[Name] = "Popular_100_Fonts/" .. File
        Library.FontNames[#Library.FontNames + 1] = Name
    end

    function Library:LoadFace(Name)
        if type(Name) ~= "string" or Name == "" then
            return self.Font
        end
        local Cached = self.FontCache[Name]
        if Cached then
            return Cached
        end
        local File = self.FontFiles[Name]
        if not File then
            return self.Font
        end
        local Folder = self.Directory .. "/fonts"
        local Ttf = Folder .. "/" .. Name .. ".ttf"
        if type(isfolder) == "function" and type(makefolder) == "function" and not isfolder(Folder) then
            makefolder(Folder)
        end
        if type(isfile) ~= "function" or not isfile(Ttf) then
            writefile(Ttf, game:HttpGet(self.FontBase .. File))
        end
        local FaceFile = self.Directory .. self.Folders.Assets .. "/" .. Name .. ".font"
        local Asset = getcustomasset(Ttf)
        writefile(FaceFile, HttpService:JSONEncode({
            name = Name,
            faces = {
                {
                    name = Name,
                    weight = 400,
                    style = "Regular",
                    assetId = Asset,
                },
            },
        }))
        local Face = Font.new(getcustomasset(FaceFile))
        self.FontCache[Name] = Face
        return Face
    end

    function Library:PaintText(Object, Face)
        if not Object or not Face then
            return
        end
        if Object:IsA("TextLabel") or Object:IsA("TextButton") or Object:IsA("TextBox") then
            Object.FontFace = Face
            if Object.TextSize > 22 then
                Object.TextSize = 14
            end
        end
    end

    function Library:ApplyMenuFont(Name)
        local Face = self:LoadFace(Name)
        if not Face then
            return
        end
        self.Font = Face
        self.BoldFont = Face
        local Roots = {}
        if self.Holder and self.Holder.Instance then
            Roots[#Roots + 1] = self.Holder.Instance
        end
        if self.NotifHolder then
            Roots[#Roots + 1] = self.NotifHolder.Instance or self.NotifHolder
        end
        if self.UnusedHolder and self.UnusedHolder.Instance then
            Roots[#Roots + 1] = self.UnusedHolder.Instance
        end
        for _, Root in ipairs(Roots) do
            if typeof(Root) == "Instance" then
                self:PaintText(Root, Face)
                for _, Object in ipairs(Root:GetDescendants()) do
                    self:PaintText(Object, Face)
                end
            end
        end
        if not self.FontHooked and self.Holder and self.Holder.Instance then
            self.FontHooked = true
            local Conn = self.Holder.Instance.DescendantAdded:Connect(function(Object)
                if Library and Library.Font then
                    Library:PaintText(Object, Library.Font)
                end
                task.defer(function()
                    if Library and Library.Font and Object.Parent then
                        Library:PaintText(Object, Library.Font)
                    end
                end)
            end)
            table.insert(Library.Connections, Conn)
        end
    end

    Library.Exit = function(Self)
        for _, Connection in Library.Connections do 
            Connection:Disconnect()
        end

        for _, Thread in Library.Threads do 
            coroutine.close(Thread)
        end

        if Self.Holder then 
            Self.Holder.Instance:Destroy()
        end

        if Self.UnusedHolder then 
            Self.UnusedHolder.Instance:Destroy()
        end

        Library = nil
        getgenv().Library = nil
    end

    Library.Create = function(Self, Class, Properties)
        local Data = {
            Class = Class,
            Properties = Properties,
            Instance = Instance.new(Class)
        }

        for Index, Property in Properties do 
            if Property == "FontFace" then
                Data.Instance[Property] = Library.Font
                continue
            end

            if Property == "TextSize" then 
                Data.Instance[Property] = Library.FontSize
                continue
            end

            if Property == "Name" then 
                Data.Instance[Property] = "\0"
                continue
            end

            if Class == "TextButton" then 
                if Property == "AutoButtonColor" then 
                    Data.Instance[Property] = false
                    continue
                end

                if Property == "Text" then 
                    Data.Instance[Property] = ""
                    continue
                end
            end

            Data.Instance[Index] = Property
        end

        if (Class == "TextLabel" or Class == "TextButton" or Class == "TextBox") and Library.Font then
            Data.Instance.FontFace = Library.Font
            if Data.Instance.TextSize > 22 then
                Data.Instance.TextSize = 14
            end
        end

        return setmetatable(Data, Library)
    end

    --#region skin
    -- shared spacing / radius / type scale. every control below reads from here so padding and
    -- type sizes stay consistent instead of each constructor hardcoding its own numbers.
    Library.Pad = {
        Radius = 4,
        RadiusLarge = 8,
        RadiusPill = 999,
        Row = 4,
        Section = 8,
        Control = 8,
        Text = 12,
        Title = 13,
    }

    local function resolve(Object)
        if typeof(Object) == "Instance" then
            return Object
        end
        if type(Object) == "table" then
            return Object.Instance
        end
        return nil
    end
    Library.resolve = resolve

    -- register a static colour against the live theme so palette swaps repaint it.
    function Library:theme(Object, Properties)
        local Inst = resolve(Object)
        if not Inst or type(Properties) ~= "table" then
            return Inst
        end
        for Property, Value in Properties do
            if type(Value) == "string" then
                Inst[Property] = Library.Theme[Value] or Inst[Property]
            elseif type(Value) == "function" then
                Inst[Property] = Value()
            elseif Value ~= nil then
                Inst[Property] = Value
            end
        end
        local Entry = { Item = Inst, Properties = Properties }
        table.insert(Library.ThemingStuff, Entry)
        Library.ThemeMap[Inst] = Entry
        return Inst
    end

    function Library:Corner(Object, Radius)
        local Inst = resolve(Object)
        if not Inst then
            return nil
        end
        local Corner = Inst:FindFirstChildOfClass("UICorner")
        if not Corner then
            Corner = Instance.new("UICorner")
            Corner.Name = "\0"
            Corner.Parent = Inst
        end
        Corner.CornerRadius = UDim.new(0, Radius or Library.Pad.Radius)
        return Corner
    end

    function Library:Stroke(Object, ThemeKey, Thickness, Transparency)
        local Inst = resolve(Object)
        if not Inst then
            return nil
        end
        local Stroke = Instance.new("UIStroke")
        Stroke.Name = "\0"
        Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Stroke.LineJoinMode = Enum.LineJoinMode.Round
        Stroke.Thickness = Thickness or 1
        Stroke.Transparency = Transparency or 0.2
        Stroke.Parent = Inst
        Library:theme(Stroke, { Color = ThemeKey or "Outline" })
        return Stroke
    end

    -- thin accent edge. UIStroke is not a GuiObject so it has no :Tween method -- hand callers a
    -- proxy that forwards reads/writes to the stroke and still resolves Library methods, otherwise
    -- every "Glow:Tween(...)" threw and killed the widget it belonged to.
    local StrokeProxy = {}
    StrokeProxy.__index = function(Self, Key)
        local Method = Library[Key]
        if Method ~= nil then
            return Method
        end
        local Inst = rawget(Self, "Instance")
        return Inst and Inst[Key] or nil
    end
    StrokeProxy.__newindex = function(Self, Key, Value)
        local Inst = rawget(Self, "Instance")
        if Inst then
            Inst[Key] = Value
        end
    end

    function Library:Glow(Object, ThemeKey, Thickness, Transparency)
        local Inst = resolve(Object)
        if not Inst then
            return nil
        end
        local Stroke = Instance.new("UIStroke")
        Stroke.Name = "\0"
        Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Stroke.LineJoinMode = Enum.LineJoinMode.Round
        Stroke.Thickness = Thickness or 1
        Stroke.Transparency = Transparency or 0.85
        Stroke.Parent = Inst
        Library:theme(Stroke, { Color = ThemeKey or "Accent" })
        return setmetatable({ Instance = Stroke }, StrokeProxy)
    end

    -- vertical sheen + alpha falloff. no blur asset in roblox, so this is the closest thing to
    -- glass: light at the top, darker and more transparent toward the bottom.
    function Library:Glass(Object, Strength)
        local Inst = resolve(Object)
        if not Inst then
            return nil
        end
        local Grad = Inst:FindFirstChild("AetheriaGlass")
        if not Grad or not Grad:IsA("UIGradient") then
            Grad = Instance.new("UIGradient")
            Grad.Name = "AetheriaGlass"
            Grad.Parent = Inst
        end
        local S = Strength or 1
        Grad.Rotation = 90
        Grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.45, Color3.fromRGB(226, 232, 244)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(158, 172, 196)),
        })
        Grad.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.02 * S),
            NumberSequenceKeypoint.new(0.55, 0.1 * S),
            NumberSequenceKeypoint.new(1, 0.26 * S),
        })
        return Grad
    end

    function Library:Pop(Object, Hover, Press)
        local Inst = resolve(Object)
        if not Inst then
            return nil
        end
        local Scale = Inst:FindFirstChild("AetheriaPop")
        if not Scale or not Scale:IsA("UIScale") then
            Scale = Instance.new("UIScale")
            Scale.Name = "AetheriaPop"
            Scale.Parent = Inst
        end
        local HoverInfo = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local PressInfo = TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local function to(Value, Info)
            if not Scale.Parent then
                return
            end
            TweenService:Create(Scale, Info, { Scale = Value }):Play()
        end
        Library:Connect(Inst.MouseEnter, function()
            to(Hover or 1.015, HoverInfo)
        end)
        Library:Connect(Inst.MouseLeave, function()
            to(1, HoverInfo)
        end)
        Library:Connect(Inst.InputBegan, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                to(Press or 0.965, PressInfo)
            end
        end)
        Library:Connect(Inst.InputEnded, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                to(Hover or 1.015, HoverInfo)
            end
        end)
        return Scale
    end

    -- tiny rounded pill used for keybind chips / value readouts.
    function Library:Pill(Parent, Radius)
        local Frame = Library:Create("Frame", {
            Name = "\0",
            Parent = resolve(Parent),
            BackgroundColor3 = Library.Theme["Element"],
            BorderSizePixel = 0,
        }):AddToTheme({ BackgroundColor3 = "Element" })
        Library:Corner(Frame, Radius or Library.Pad.Radius)
        Library:Stroke(Frame, "Outline", 1, 0.35)
        return Frame
    end
    --#endregion

    Library.Thread = function(Self, Function)
        local NewThread = coroutine.create(Function)
        
        coroutine.wrap(function()
            coroutine.resume(NewThread)
        end)()

        table.insert(Library.Threads, NewThread)
        return NewThread
    end

    Library.Connect = function(Self, Signal, Callback)
        local Connection

        if Self.Instance then
            if Self.Instance[Signal] then 
                if IsMobile and Signal == "MouseButton1Down" then 
                    Connection = Self.Instance.InputBegan:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            Callback(Input)
                        end
                    end)

                    return
                end
                
                Connection = Self.Instance[Signal]:Connect(Callback)
            else
                Connection = Signal:Connect(Callback)
            end
        else
            Connection = Signal:Connect(Callback)
        end

        table.insert(Library.Connections, Connection)
        return Connection
    end

    Library.Tween = function(Self, Properties, Info, IsRawItem)
        local Object = Self.Instance or IsRawItem
        Info = Info or TweenInfo.new(Library.Animation.Time, Enum.EasingStyle[Library.Animation.Style], Enum.EasingDirection[Library.Animation.Direction])

        if not Object then 
            return 
        end

        local NewTween = TweenService:Create(Object, Info, Properties)
        NewTween:Play()

        return NewTween
    end

    Library.GetTweenProperty = function(Self, IsRawItem)
        local Object = Self.Instance or IsRawItem

        if not Object then 
            return { }
        end

        if Object:IsA("Frame") then
            return { "BackgroundTransparency" }
        elseif Object:IsA("TextLabel") or Object:IsA("TextButton") then
            return { "TextTransparency", "BackgroundTransparency" }
        elseif Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
            return { "BackgroundTransparency", "ImageTransparency" }
        elseif Object:IsA("ScrollingFrame") then
            return { "BackgroundTransparency", "ScrollBarImageTransparency" }
        elseif Object:IsA("TextBox") then
            return { "TextTransparency", "BackgroundTransparency" }
        elseif Object:IsA("UIStroke") then 
            return { "Transparency" }
        end
    end

    Library.Fade = function(Self, Property, Visibility, IsRawItem)
        local Object = Self.Instance or IsRawItem

        if not Object then 
            return 
        end

        local OrigAttr = "_Orig" .. Property
        local GenAttr = "_FadeGen" .. Property
        local BusyAttr = "_Fading" .. Property

        if not Object:GetAttribute(BusyAttr) or Object:GetAttribute(OrigAttr) == nil then
            Object:SetAttribute(OrigAttr, Object[Property])
        end

        local Original = Object:GetAttribute(OrigAttr)
        local Gen = (Object:GetAttribute(GenAttr) or 0) + 1
        Object:SetAttribute(GenAttr, Gen)
        Object:SetAttribute(BusyAttr, true)

        local NewTween

        if Visibility then
            Object[Property] = 1
            NewTween = Library:Tween({[Property] = Original}, nil, Object)
        else
            NewTween = Library:Tween({[Property] = 1}, nil, Object)
        end

        NewTween.Completed:Once(function()
            if Object:GetAttribute(GenAttr) ~= Gen then
                return
            end

            Object:SetAttribute(BusyAttr, nil)

            if not Visibility and Object.Parent then
                Object[Property] = Original
            end
        end)

        return NewTween
    end

    Library.FadeDescendants = function(Self, Visibility, Callback)
        if Visibility then 
            Self.Instance.Visible = true 
        end

        local NewTween 

        local Children = Self.Instance:GetDescendants()
        table.insert(Children, Self.Instance)

        for _, Child in Children do 
            local TransparencyProperty = Library:GetTweenProperty(Child)

            if not TransparencyProperty then 
                continue 
            end

            if type(TransparencyProperty) == "table" then
                for _, Property in TransparencyProperty do
                    NewTween = Library:Fade(Property, Visibility, Child)
                end
            else
                NewTween = Library:Fade(TransparencyProperty, Visibility, Child)
            end
        end

        if not NewTween then
            if Callback and type(Callback) == "function" then
                Callback()
            end

            Self.Instance.Visible = Visibility
            return
        end

        Library:Connect(NewTween.Completed, function()
            if Callback and type(Callback) == "function" then 
                Callback()
            end

            Self.Instance.Visible = Visibility
        end)
    end

    Library.MakeDraggable = function(Self)
        if not Self.Instance then 
            return
        end
    
        local Gui = Self.Instance
        local Dragging = false 
        local DragStart
        local StartPosition 
    
        local Set = function(Input)
            local DragDelta = Input.Position - DragStart
            local NewX = StartPosition.X.Offset + DragDelta.X
            local NewY = StartPosition.Y.Offset + DragDelta.Y

            local ScreenSize = Gui.Parent.AbsoluteSize
            local GuiSize = Gui.AbsoluteSize
    
            NewX = math.clamp(NewX, 0, ScreenSize.X - GuiSize.X)
            NewY = math.clamp(NewY, 0, ScreenSize.Y - GuiSize.Y)
    
            Self:Tween({Position = UDim2.new(0, NewX, 0, NewY)}, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
        end
    
        local InputChanged
    
        Self:Connect("InputBegan", function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = Input.Position
                StartPosition = Gui.Position
    
                if InputChanged then 
                    return
                end
    
                InputChanged = Input.Changed:Connect(function()
                    if Input.UserInputState == Enum.UserInputState.End then
                        Dragging = false
                        InputChanged:Disconnect()
                        InputChanged = nil
                    end
                end)
            end
        end)
    
        Library:Connect(UserInputService.InputChanged, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                if Dragging then
                    Set(Input)
                end
            end
        end)
    
        return Dragging
    end

    Library.MakeResizeable = function(Self, Minimum)
        if not Self.Instance then 
            return
        end

        local Gui = Self.Instance

        local Resizing = false 
        local CurrentSide = nil

        local StartMouse = nil 
        local StartPosition = nil 
        local StartSize = nil
        
        local EdgeThickness = 2

        local MakeEdge = function(Name, Position, Size)
            local Button = Library:Create("TextButton", {
                Name = "\0",
                Size = Size,
                Position = Position,
                BackgroundColor3 = Color3.fromRGB(166, 147, 243),
                BackgroundTransparency = 1,
                Text = "",
                BorderSizePixel = 0,
                AutoButtonColor = false,
                Parent = Gui,
                ZIndex = 99999,
            })  Button:AddToTheme({BackgroundColor3 = "Accent"})

            return Button
        end

        local Edges = {
            {Button = MakeEdge(
                "Left", 
                UDim2.new(0, 0, 0, 0), 
                UDim2.new(0, EdgeThickness, 1, 0)), 
                Side = "L"
            },

            {Button = MakeEdge(
                "Right", 
                UDim2.new(1, -EdgeThickness, 0, 0), 
                UDim2.new(0, EdgeThickness, 1, 0)), 
                Side = "R"
            },

            {Button = MakeEdge(
                "Top", UDim2.new(0, 0, 0, 0), 
                UDim2.new(1, 0, 0, EdgeThickness)), 
                Side = "T"
            },

            {Button = MakeEdge(
                "Bottom", 
                UDim2.new(0, 0, 1, -EdgeThickness), 
                UDim2.new(1, 0, 0, EdgeThickness)), 
                Side = "B"
            },
        }

        local BeginResizing = function(Side)
            Resizing = true 
            CurrentSide = Side 

            StartMouse = UserInputService:GetMouseLocation()

            StartPosition = Vector2.new(Gui.Position.X.Offset, Gui.Position.Y.Offset)
            StartSize = Vector2.new(Gui.Size.X.Offset, Gui.Size.Y.Offset)
            
            for Index, Value in Edges do 
                Value.Button.Instance.BackgroundTransparency = (Value.Side == Side) and 0 or 1
            end
        end

        local EndResizing = function()
            Resizing = false 
            CurrentSide = nil

            for Index, Value in Edges do 
                Value.Button.Instance.BackgroundTransparency = 1
            end
        end

        for Index, Value in Edges do 
            Value.Button:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    BeginResizing(Value.Side)
                end
            end)
        end

        Library:Connect(UserInputService.InputEnded, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                if Resizing then
                    EndResizing()
                end
            end
        end)

        Library:Connect(RunService.RenderStepped, function()
            if not Resizing or not CurrentSide then 
                return 
            end

            local MouseLocation = UserInputService:GetMouseLocation()
            local dx = MouseLocation.X - StartMouse.X
            local dy = MouseLocation.Y - StartMouse.Y
        
            local x, y = StartPosition.X, StartPosition.Y
            local w, h = StartSize.X, StartSize.Y

            if CurrentSide == "L" then
                x = StartPosition.X + dx
                w = StartSize.X - dx
            elseif CurrentSide == "R" then
                w = StartSize.X + dx
            elseif CurrentSide == "T" then
                y = StartPosition.Y + dy
                h = StartSize.Y - dy
            elseif CurrentSide == "B" then
                h = StartSize.Y + dy
            end
        
            if w < Minimum.X then
                if CurrentSide == "L" then
                    x = x - (Minimum.X - w)
                end
                w = Minimum.X
            end
            if h < Minimum.Y then
                if CurrentSide == "T" then
                    y = y - (Minimum.Y - h)
                end
                h = Minimum.Y
            end
        
            Self:Tween({Position = UDim2.fromOffset(x, y)}, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
            Self:Tween({Size = UDim2.fromOffset(w, h)}, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
        end)
    end

    Library.IsMouseOverFrame = function(Self)
        if not Self.Instance then 
            return 
        end

        local Object = Self.Instance

        local MousePosition = Vector2.new(Mouse.X, Mouse.Y)

        return MousePosition.X >= Object.AbsolutePosition.X and MousePosition.X <= Object.AbsolutePosition.X + Object.AbsoluteSize.X 
        and MousePosition.Y >= Object.AbsolutePosition.Y and MousePosition.Y <= Object.AbsolutePosition.Y + Object.AbsoluteSize.Y
    end

    Library.SafeCall = function(Self, Function, ...)
        local Arguements = { ... }
        local Success, Result = pcall(Function, table.unpack(Arguements))

        if not Success then
            warn(Result)
            return false
        end

        return Success, Result
    end

    Library.Round = function(Self, Number, Float)
        local Multiplier = 1 / (Float or 1)
        return math.floor(Number * Multiplier) / Multiplier
    end

    Library.GetConfig = function(Self)
        local Config = { }

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Library.Flags do 
                if type(Value) == "table" and Value.Key then
                    Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode}
                elseif type(Value) == "table" and Value.Color then
                    Config[Index] = {Color = "#" .. Value.HexValue, Alpha = Value.Alpha}
                else
                    Config[Index] = Value
                end
            end
        end)

        if not Success then
            warn("Failed to get config:\n"..Result)
            return
        end

        return HttpService:JSONEncode(Config)
    end

    Library.LoadConfig = function(Self, Config)
        local Decoded = HttpService:JSONDecode(Config)
        if type(Decoded) ~= "table" then
            return false, "config did not decode"
        end

        Library.LoadingConfig = true

        local function ApplyFlag(Index, Value)
            local Name = tostring(Index)
            local SetFunction = Library.SetFlags[Index]
            if type(Value) == "table" and Value.Color and Name:sub(1, 5) == "Theme" then
                local Color = Value.Color
                if type(Color) == "string" then
                    Color = Color3.fromHex(Color)
                end
                local ThemeKey = Name:sub(6)
                if Library.Theme[ThemeKey] ~= nil and typeof(Color) == "Color3" then
                    Library:ChangeTheme(ThemeKey, Color)
                end
            end
            if type(SetFunction) ~= "function" then
                return
            end
            if type(Value) == "table" and Value.Key ~= nil then
                SetFunction({ Key = Value.Key, Mode = Value.Mode or "Toggle" })
            elseif type(Value) == "table" and Value.Color then
                SetFunction(Value.Color, Value.Alpha)
            else
                SetFunction(Value)
            end
        end

        local function SafeApply(Index, Value)
            local Ok, Err = pcall(ApplyFlag, Index, Value)
            if not Ok then
                warn(("[%s] config '%s': %s"):format(tostring(Library.Directory), tostring(Index), tostring(Err)))
            end
        end

        for Index, Current in Library.Flags do
            if type(Current) == "boolean" and Current == true and Decoded[Index] ~= true then
                SafeApply(Index, false)
            end
        end

        if Decoded.ThemePreset ~= nil then
            SafeApply("ThemePreset", Decoded.ThemePreset)
        end

        local KeyFlags = {}
        local ThemeFlags = {}
        for Index, Value in Decoded do
            local Name = tostring(Index)
            if Name:sub(1, 5) == "Theme" and Name ~= "ThemePreset" then
                ThemeFlags[#ThemeFlags + 1] = Index
            elseif type(Value) == "table" and Value.Key ~= nil then
                KeyFlags[#KeyFlags + 1] = Index
            elseif Name ~= "ThemePreset" then
                SafeApply(Index, Value)
            end
        end

        for Index = 1, #ThemeFlags do
            local Flag = ThemeFlags[Index]
            SafeApply(Flag, Decoded[Flag])
        end

        for Index = 1, #KeyFlags do
            local Flag = KeyFlags[Index]
            SafeApply(Flag, Decoded[Flag])
        end

        for _, Item in Library.ThemingStuff do
            if Item.Item and Item.Item.Parent then
                for Property, Value in Item.Properties do
                    if type(Value) == "string" and Library.Theme[Value] then
                        Item.Item[Property] = Library.Theme[Value]
                    elseif type(Value) == "function" then
                        Item.Item[Property] = Value()
                    end
                end
            end
        end

        Library.LoadingConfig = false
        return true
    end

    Library.GetConfigsList = function(Self, Element)
        local List = { }
        local ReturnList = { }

        List = listfiles(Library.Directory .. Library.Folders.Configs)

        for Index = 1, #List do 
            local File = List[Index]

            if File:sub(-5) == ".json" then
                local Position = File:find(".json", 1, true)
                local StartPosition = Position

                local Character = File:sub(Position, Position)
                while Character ~= "/" and Character ~= "\\" and Character ~= "" do
                    Position = Position - 1
                    Character = File:sub(Position, Position)
                end

                if Character == "/" or Character == "\\" then
                    table.insert(ReturnList, File:sub(Position + 1, StartPosition - 1))
                end
            end
        end

        Element:Refresh(ReturnList)
    end

    Library.GetTheme = function(Self)
        local ThemeConfig = { }

        local Success, Result = Library:SafeCall(function()
            for Index, Color in Library.Theme do
                local Flag = Flags["Theme" .. Index]

                if type(Flag) == "table" and Flag.HexValue then
                    ThemeConfig["Theme" .. Index] = {
                        Color = "#" .. Flag.HexValue,
                        Alpha = Flag.Alpha or 0
                    }
                else
                    ThemeConfig["Theme" .. Index] = {
                        Color = "#" .. Color:ToHex(),
                        Alpha = 0
                    }
                end
            end
        end)

        if not Success then
            warn("Failed to get theme:\n" .. Result)
            return
        end

        return HttpService:JSONEncode(ThemeConfig)
    end

    Library.LoadTheme = function(Self, Theme)
        local Decoded = HttpService:JSONDecode(Theme)

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Decoded do
                local SetFunction = Library.SetFlags[Index]

                if not SetFunction then
                    local ThemeKey = tostring(Index):gsub("^Theme", "")
""
                    if Library.Theme[ThemeKey] ~= nil then
                        local Color = Value

                        if type(Value) == "table" and Value.Color then
                            Color = Value.Color
                        end

                        if type(Color) == "string" then
                            Color = Color3.fromHex(Color)
                        end

                        Library:ChangeTheme(ThemeKey, Color)

                        local ThemeSet = SetFlags["Theme" .. ThemeKey]

                        if ThemeSet then
                            ThemeSet(Color, type(Value) == "table" and Value.Alpha or 0)
                        end
                    end

                    continue
                end

                if type(Value) == "table" and Value.Color then
                    SetFunction(Value.Color, Value.Alpha)
                elseif typeof(Value) == "Color3" or type(Value) == "string" then
                    SetFunction(Value, 0)
                end
            end
        end)

        return Success, Result
    end

    Library.GetThemesList = function(Self, Element)
        local List = { }
        local ReturnList = { }

        List = listfiles(Library.Directory .. Library.Folders.Themes)

        for Index = 1, #List do 
            local File = List[Index]

            if File:sub(-5) == ".json" then
                local Position = File:find(".json", 1, true)
                local StartPosition = Position

                local Character = File:sub(Position, Position)
                while Character ~= "/" and Character ~= "\\" and Character ~= "" do
                    Position = Position - 1
                    Character = File:sub(Position, Position)
                end

                if Character == "/" or Character == "\\" then
                    table.insert(ReturnList, File:sub(Position + 1, StartPosition - 1))
                end
            end
        end

        Element:Refresh(ReturnList)
    end

    Library.AddToTheme = function(Self, Properties)
        local Object = Self.Instance

        local ThemeData = {
            Item = Object,
            Properties = Properties,
        }

        for Property, Value in ThemeData.Properties do
            if type(Value) == "string" then
                if not Library.Theme[Value] then
                    Object[Property] = Value 
                end

                Object[Property] = Library.Theme[Value]
            else
                Object[Property] = Value()
            end
        end

        table.insert(Library.ThemingStuff, ThemeData)
        Library.ThemeMap[Object] = ThemeData
        return Self
    end

    Library.ChangeItemTheme = function(Self, Properties)
        local Object = Self.Instance

        if not Library.ThemeMap[Object] then 
            return
        end

        Library.ThemeMap[Object].Properties = Properties
        Library.ThemeMap[Object] = Library.ThemeMap[Object]
    end

    Library.ChangeTheme = function(Self, Theme, Color)
        Library.Theme[Theme] = Color

        for _, Item in Library.ThemingStuff do
            for Property, Value in Item.Properties do
                if type(Value) == "string" and Value == Theme then
                    Item.Item[Property] = Color
                elseif type(Value) == "function" then
                    Item.Item[Property] = Value()
                end
            end
        end

        if Theme == "Accent" then
            Library:ChangeRichTextTheme()
        end
    end

    Library.ApplyTheme = function(Self, Name)
        local ThemeData = Themes[Name]

        if not ThemeData then
            return false
        end

        for Index, Color in ThemeData do
            Library:ChangeTheme(Index, Color)

            local SetFunction = SetFlags["Theme" .. Index]

            if SetFunction then
                SetFunction(Color, 0)
            end
        end

        return true
    end

    Library.GetAutoload = function(Self)
        local Path = Library.Directory .. "/autoload.json"

        if not isfile(Path) then
            return ""
        end

        return readfile(Path) or ""
    end

    Library.SetAutoload = function(Self, Name)
        writefile(Library.Directory .. "/autoload.json", tostring(Name or ""))
    end

    Library.LoadAutoload = function(Self)
        local AutoloadName = Library:GetAutoload()

        if not AutoloadName or AutoloadName == "" then
            return false, "none"
        end

        local ConfigPath = Library.Directory .. Library.Folders.Configs .. "/" .. AutoloadName .. ".json"

        if not isfile(ConfigPath) then
            return false, "missing"
        end

        local Success, Error = Library:LoadConfig(readfile(ConfigPath))

        if Success then
            return true, AutoloadName
        end

        return false, Error
    end

    Library.OnHover = function(Self, OnHoverEnter, OnHoverLeave)
        local Object = Self.Instance

        if not Object then 
            return 
        end 

        Library:Connect(Object.MouseEnter, OnHoverEnter)
        Library:Connect(Object.MouseLeave, OnHoverLeave)
    end

    local RichTextMap = { }

    Library.AddToRichTextTheme = function(Self, Theme, OriginalText, RealOriginalText)
        if RichTextMap[Self.Instance] then
            return 
        end

        RichTextMap[Self.Instance] = {Theme, OriginalText, RealOriginalText}
    end

    Library.UpdateRichTextTheme = function(Self, Theme, OriginalText, RealOriginalText)
        if not RichTextMap[Self.Instance] then
            return
        end

        RichTextMap[Self.Instance] = {Theme, OriginalText, RealOriginalText}
    end

    Library.ChangeRichTextTheme = function(Self)
        for Index, Value in RichTextMap do
            local Theme = Value[1]
            local OriginalText = Value[2]

            if not Library.Theme[Theme] then
                continue
            end

            local ThemeColor = Library.Theme[Theme]
            local Red, Green, Blue = math.floor(ThemeColor.R * 255), math.floor(ThemeColor.G * 255), math.floor(ThemeColor.B * 255)

            Index.Text = tostring(Value[3]) .. '<font color="rgb(' .. Red .. ',' .. Green .. ',' .. Blue .. ')">' .. tostring(OriginalText) .. '</font>'
        end
    end

    Library.ExtractRichTextContent = function(Self, Str)
        local Content = string.match(Str, "<font.-%>(.-)</font>")
        return Content
    end

    Library.Holder = Library:Create("ScreenGui", {
        Parent = gethui(),
        IgnoreGuiInset = true,
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        ResetOnSpawn = false
    })

    Library.UnusedHolder = Library:Create("ScreenGui", {
        Parent = gethui(),
        Name = "\0",
        Enabled = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        ResetOnSpawn = false
    })

    Library.NotifHolder = Library:Create("Frame", {
        Name = "\0",
        Parent = Library.Holder.Instance,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        BorderSizePixel = 0
    })

    Library.NotificationPadding = 8
    Library.NotificationOrigin = Vector2.new(16, 16)
    Library.NotificationSlide = 36
    Library.NotificationMax = 10
    Library.NotificationStackInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

    Library.RefreshNotifications = function(IgnoreNotif)
        local Y = Library.NotificationOrigin.Y

        for _, Notif in Library.Notifications do
            if Notif.Removing then
                continue
            end

            local Height = Notif.Height or 32
            local Target = UDim2.new(1, -Library.NotificationOrigin.X, 0, Y)
            Notif.TargetPosition = Target

            if Notif ~= IgnoreNotif and Notif.Items and Notif.Items["Notification"] then
                Notif.Items["Notification"]:Tween({Position = Target}, Library.NotificationStackInfo)
            end

            Y += Height + Library.NotificationPadding
        end
    end

    do
        Library.CreateColorpicker = function(Self, Data)
            local Colorpicker = {
                Hue = 0,
                Saturation = 0,
                Value = 0,

                Alpha = 0,

                Color = Color3.fromRGB(255, 255, 255),
                HexValue = "#FFFFFF",

                Flag = Data.Flag,
                IsOpen = false,

                Items = { }
            }

            local Items = { } do 
                Items["ColorpickerButton"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Data.Parent.Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = UDim2.fromOffset(18, 18),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(154, 87, 255)
                })
                Library:Corner(Items["ColorpickerButton"], 6)
                Library:Stroke(Items["ColorpickerButton"], "Outline", 1, 0.25)
                Library:Pop(Items["ColorpickerButton"], 1.12, 0.94)
                
                Items["ButtonCheckers"] = Library:Create("ImageLabel", {
                    Name = "\0",
                    Parent = Items["ColorpickerButton"].Instance,
                    ScaleType = Enum.ScaleType.Tile,
                    ImageTransparency = 0.6000000238418579,
                    TileSize = UDim2.new(0, 6, 0, 6),
                    Image = "http://www.roblox.com/asset/?id=18274452449",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0
                })
                                
                Items["ColorpickerWindow"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Library.UnusedHolder.Instance,
                    Visible = false,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Position = UDim2.new(0, 1011, 0, 100),
                    Size = UDim2.new(0, 250, 0, 250),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Inline"]
                }):AddToTheme({BackgroundColor3 = 'Inline'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["ColorpickerWindow"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline 2"],
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = 'Outline 2'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["ColorpickerWindow"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Items["CurrentColor"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["ColorpickerWindow"].Instance,
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 8, 1, -8),
                    Size = UDim2.new(0, 18, 0, 18),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(154, 87, 255)
                })
                
                Items["Checkers"] = Library:Create("ImageLabel", {
                    Name = "\0",
                    Parent = Items["CurrentColor"].Instance,
                    ScaleType = Enum.ScaleType.Tile,
                    ImageTransparency = 0.6000000238418579,
                    TileSize = UDim2.new(0, 6, 0, 6),
                    Image = "http://www.roblox.com/asset/?id=18274452449",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0
                })
                
                Items["Hue"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["ColorpickerWindow"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    AutoButtonColor = false,
                    Position = UDim2.new(0, 8, 0, 8),
                    Size = UDim2.new(0, 18, 1, -42),
                    BorderSizePixel = 0
                })
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["Hue"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
                    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
                    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                }
                })
                
                Items["HueDragger"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Hue"].Instance,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Size = UDim2.new(1, 0, 0, 2),
                    BorderSizePixel = 0
                })
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["HueDragger"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline 2"]
                }):AddToTheme({Color = 'Outline 2'})
                
                Items["Alpha"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["ColorpickerWindow"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2.new(1, 1),
                    Position = UDim2.new(1, -8, 1, -8),
                    Size = UDim2.new(1, -42, 0, 18),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(154, 87, 255)
                })
                
                Items["AlphaCheckers"] = Library:Create("ImageLabel", {
                    Name = "\0",
                    Parent = Items["Alpha"].Instance,
                    ScaleType = Enum.ScaleType.Tile,
                    TileSize = UDim2.new(0, 6, 0, 6),
                    Image = "http://www.roblox.com/asset/?id=18274452449",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0
                })
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["AlphaCheckers"].Instance,
                    Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(1, 0)
                }
                })
                
                Items["AlphaDragger"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Alpha"].Instance,
                    Size = UDim2.new(0, 2, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                })
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["AlphaDragger"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline 2"]
                }):AddToTheme({Color = 'Outline 2'})
                
                Items["Palette"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["ColorpickerWindow"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Position = UDim2.new(0, 34, 0, 8),
                    Size = UDim2.new(1, -42, 1, -42),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(154, 87, 255)
                })
                
                Items["Saturation"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Palette"].Instance,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                })
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["Saturation"].Instance,
                    Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(1, 0)
                }
                })
                
                Items["Value"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Palette"].Instance,
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                })
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["Value"].Instance,
                    Rotation = 90,
                    Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(1, 0)
                }
                })
                
                Items["PaletteDragger"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Palette"].Instance,
                    Size = UDim2.new(0, 4, 0, 4),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                })
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["PaletteDragger"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline 2"]
                }):AddToTheme({Color = 'Outline 2'})                

                Colorpicker.Items = Items
            end

            Colorpicker.Holder = Items["ColorpickerWindow"]

            function Colorpicker:SetVisibility(Bool)
                Items["ColorpickerButton"].Instance.Visible = Bool
            end

            function Colorpicker:Update(IsFromAlpha)
                local Hue, Saturation, Value = Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value
                Colorpicker.Color = Color3.fromHSV(Hue, Saturation, Value)
                Colorpicker.HexValue = Colorpicker.Color:ToHex()
        
                Items["ColorpickerButton"]:Tween({BackgroundColor3 = Colorpicker.Color})
                Items["Palette"]:Tween({BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)})
                Items["CurrentColor"]:Tween({BackgroundColor3 = Colorpicker.Color})

                Flags[Colorpicker.Flag] = {
                    Alpha = Colorpicker.Alpha,
                    Color = Colorpicker.Color,
                    HexValue = Colorpicker.HexValue,
                    Transparency = 1 - Colorpicker.Alpha
                }
    
                if not IsFromAlpha then 
                    Items["Alpha"]:Tween({BackgroundColor3 = Colorpicker.Color})
                end
    
                Items["Checkers"]:Tween({ImageTransparency = 1 - Colorpicker.Alpha})
                Items["ButtonCheckers"]:Tween({ImageTransparency = 1 - Colorpicker.Alpha})

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Colorpicker.Color, Colorpicker.Alpha)
                end
            end

            local Debounce = false 
            local ColorpickerWindow = Items["ColorpickerWindow"].Instance
            local ColorpickerButton = Items["ColorpickerButton"].Instance

            local IsSettings = Data.Section and Data.Section.IsSettings

            function Colorpicker:SetOpen(Bool)
                if Debounce then 
                    return 
                end

                Colorpicker.IsOpen = Bool

                Debounce = true 
                
                if Colorpicker.IsOpen then 
                    ColorpickerWindow.Position = UDim2.new(0, ColorpickerButton.AbsolutePosition.X, 0, ColorpickerButton.AbsolutePosition.Y + ColorpickerButton.AbsoluteSize.Y + GuiInset)

                    ColorpickerWindow.Parent = Library.Holder.Instance
                    ColorpickerWindow.Visible = true
                    Items["ColorpickerWindow"]:Tween({Position = UDim2.new(0, ColorpickerButton.AbsolutePosition.X, 0, ColorpickerButton.AbsolutePosition.Y + ColorpickerButton.AbsoluteSize.Y + 10 + GuiInset)})
                    
                    Items["ColorpickerWindow"]:FadeDescendants(true, function()
                        Debounce = false
                    end)

                    for Index, Value in Library.OpenFrames do
                        if Value ~= IsSettings then
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Colorpicker] = Colorpicker 
                else
                    Items["ColorpickerWindow"]:Tween({Position = UDim2.new(0, ColorpickerButton.AbsolutePosition.X, 0, ColorpickerButton.AbsolutePosition.Y + ColorpickerButton.AbsoluteSize.Y - 10 + GuiInset)})
                    Items["ColorpickerWindow"]:FadeDescendants(false, function()
                        ColorpickerWindow.Parent = Library.UnusedHolder.Instance
                        Debounce = false
                    end)

                    if Library.OpenFrames[Colorpicker] then 
                        Library.OpenFrames[Colorpicker] = nil
                    end
                end

                local Descendants = ColorpickerWindow:GetDescendants()
                table.insert(Descendants, ColorpickerWindow)

                for Index, Value in Descendants do 
                    if Value.ClassName:find("UI") then
                        continue
                    end

                    if IsSettings then
                        Value.ZIndex = Colorpicker.IsOpen and Library.ZIndexOrder.ColorpickerWindow + 4 or 1
                    else
                        Value.ZIndex = Colorpicker.IsOpen and Library.ZIndexOrder.ColorpickerWindow or 1
                    end
                end
            end
    
            local DraggerPlacement = function(X, Y)
                return {
                    AnchorPoint = Vector2.new(X or 0, Y or 0),
                    Position = UDim2.new(X or 0, X and 1 - 2 * X or 0, Y or 0, Y and 1 - 2 * Y or 0)
                }
            end

            local SlidingPalette = false
            local PaletteChanged
            
            function Colorpicker:SlidePalette(Input)
                if not Input or not SlidingPalette then
                    return
                end
    
                local ValueX = math.clamp(1 - (Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 1)
                local ValueY = math.clamp(1 - (Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 1)
    
                Colorpicker.Saturation = ValueX
                Colorpicker.Value = ValueY
    
                local SlideX = math.clamp((Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 1)
                local SlideY = math.clamp((Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 1)

                Items["PaletteDragger"]:Tween(DraggerPlacement(SlideX, SlideY), TweenInfo.new(Library.Animation.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
                Colorpicker:Update()
            end
            
            local SlidingHue = false
            local HueChanged
    
            function Colorpicker:SlideHue(Input)
                if not Input or not SlidingHue then
                    return
                end
                
                local ValueY = math.clamp((Input.Position.Y - Items["Hue"].Instance.AbsolutePosition.Y) / Items["Hue"].Instance.AbsoluteSize.Y, 0, 1)
    
                Colorpicker.Hue = ValueY
    
                local SlideY = math.clamp((Input.Position.Y - Items["Hue"].Instance.AbsolutePosition.Y) / Items["Hue"].Instance.AbsoluteSize.Y, 0, 1)

                Items["HueDragger"]:Tween(DraggerPlacement(nil, SlideY), TweenInfo.new(Library.Animation.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
                Colorpicker:Update()
            end
    
            local SlidingAlpha = false 
            local AlphaChanged
    
            function Colorpicker:SlideAlpha(Input)
                if not Input or not SlidingAlpha then
                    return
                end
    
                local ValueX = math.clamp((Input.Position.X - Items["Alpha"].Instance.AbsolutePosition.X) / Items["Alpha"].Instance.AbsoluteSize.X, 0, 1)
    
                Colorpicker.Alpha = ValueX
    
                local SlideX = math.clamp((Input.Position.X - Items["Alpha"].Instance.AbsolutePosition.X) / Items["Alpha"].Instance.AbsoluteSize.X, 0, 1)

                Items["AlphaDragger"]:Tween(DraggerPlacement(SlideX, nil), TweenInfo.new(Library.Animation.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
                Colorpicker:Update(true)
            end
    
            function Colorpicker:Set(Color, Alpha)
                if type(Color) == "table" then
                    Color = Color3.fromRGB(Color[1], Color[2], Color[3])
                elseif type(Color) == "string" then
                    Color = Color3.fromHex(Color)
                else
                    Color = Color -- lul
                end 

                Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value = Color:ToHSV()
                Colorpicker.Alpha = Alpha or 0  
    
                local PaletteValueX = math.clamp(1 - Colorpicker.Saturation, 0, 1)
                local PaletteValueY = math.clamp(1 - Colorpicker.Value, 0, 1)

                local AlphaPositionX = math.clamp(Colorpicker.Alpha, 0, 1)

                local HuePositionY = math.clamp(Colorpicker.Hue, 0, 1)

                Items["PaletteDragger"]:Tween(DraggerPlacement(PaletteValueX, PaletteValueY), TweenInfo.new(Library.Animation.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
                Items["HueDragger"]:Tween(DraggerPlacement(nil, HuePositionY), TweenInfo.new(Library.Animation.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
                Items["AlphaDragger"]:Tween(DraggerPlacement(AlphaPositionX, nil), TweenInfo.new(Library.Animation.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
                Colorpicker:Update()
            end

            Items["ColorpickerButton"]:Connect("MouseButton1Down", function()
                Colorpicker:SetOpen(not Colorpicker.IsOpen)
            end)
    
            Items["Palette"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    SlidingPalette = true 
    
                    Colorpicker:SlidePalette(Input)
    
                    if PaletteChanged then
                        return
                    end
    
                    PaletteChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingPalette = false
    
                            PaletteChanged:Disconnect()
                            PaletteChanged = nil
                        end
                    end)
                end
            end)
    
            Items["Hue"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    SlidingHue = true 
    
                    Colorpicker:SlideHue(Input)
    
                    if HueChanged then
                        return
                    end
    
                    HueChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingHue = false
    
                            HueChanged:Disconnect()
                            HueChanged = nil
                        end
                    end)
                end
            end)
    
            Items["Alpha"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    SlidingAlpha = true 
    
                    Colorpicker:SlideAlpha(Input)
    
                    if AlphaChanged then
                        return
                    end
    
                    AlphaChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingAlpha = false
    
                            AlphaChanged:Disconnect()
                            AlphaChanged = nil
                        end
                    end)
                end
            end)
    
            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if SlidingPalette then 
                        Colorpicker:SlidePalette(Input)
                    end
    
                    if SlidingHue then
                        Colorpicker:SlideHue(Input)
                    end
    
                    if SlidingAlpha then
                        Colorpicker:SlideAlpha(Input)
                    end
                end
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    if Colorpicker.IsOpen then
                        if Items["ColorpickerWindow"]:IsMouseOverFrame() then 
                            return 
                        end

                        Colorpicker:SetOpen(false)
                    end
                end
            end)

            if Data.Default then
                Colorpicker:Set(Data.Default, Data.Alpha)
            end
    
            SetFlags[Colorpicker.Flag] = function(Value, Alpha)
                Colorpicker:Set(Value, Alpha)
            end

            return Colorpicker, Items 
        end

        Library.CreateKeybind = function(Self, Data)
            local Keybind = {
                Flag = Data.Flag,
                IsOpen = false,

                Key = "",
                Mode = "",
                Value = "",

                Toggled = false,
                Picking = false,

                Items = { },
            }

            local Items = { } do
                Items["KeyButton"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.BoldFont,
                    TextSize = Library.FontSize,
                    Parent = Data.Parent.Instance,
                    TextColor3 = Library.Theme["Accent"],
                    Text = "Toggle: B",
                    AutoButtonColor = false,
                    BackgroundTransparency = 0.55,
                    BackgroundColor3 = Library.Theme["Element"],
                    Size = UDim2.new(0, 0, 0, 18),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X
                }):AddToTheme({TextColor3 = 'Accent', BackgroundColor3 = 'Element'})
                Items["KeyButton"].Instance.FontFace = Library.BoldFont
                Library:Corner(Items["KeyButton"], 999)
                Library:Stroke(Items["KeyButton"], "Outline", 1, 0.5)
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["KeyButton"].Instance,
                    PaddingLeft = UDim.new(0, 7),
                    PaddingRight = UDim.new(0, 7),
                })
                Items["KeyButton"]:OnHover(function()
                    Items["KeyButton"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"], BackgroundTransparency = 0.35})
                end, function()
                    Items["KeyButton"]:Tween({BackgroundColor3 = Library.Theme["Element"], BackgroundTransparency = 0.55})
                end)
                                
                Items["KeybindWindow"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Library.UnusedHolder.Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = UDim2.new(0, 210, 0, 0),
                    Position = UDim2.new(0, 1036, 0, 100),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = Library.Theme["Inline"]
                }):AddToTheme({BackgroundColor3 = 'Inline'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["KeybindWindow"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Round,
                    Thickness = 1,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["KeybindWindow"].Instance,
                    PaddingTop = UDim.new(0, 8),
                    PaddingBottom = UDim.new(0, 8),
                    PaddingRight = UDim.new(0, 8),
                    PaddingLeft = UDim.new(0, 8)
                })

                Library:Create("UICorner", {
                    Name = "\0",
                    Parent = Items["KeybindWindow"].Instance,
                    CornerRadius = UDim.new(0, 8)
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["KeybindWindow"].Instance,
                    Padding = UDim.new(0, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })                
                
                Keybind.Items = Items
            end

            Keybind.Holder = Items["KeybindWindow"]

            local Debounce = false
            local KeybindWindow = Items["KeybindWindow"].Instance
            local KeyButton = Items["KeyButton"].Instance

            local IsSettings = Data.Section and Data.Section.IsSettings

            function Keybind:SetOpen(Bool)
                if Debounce then 
                    return 
                end

                Keybind.IsOpen = Bool

                Debounce = true 
                
                if Keybind.IsOpen then 
                    KeybindWindow.Position = UDim2.new(0, KeyButton.AbsolutePosition.X, 0, KeyButton.AbsolutePosition.Y + KeyButton.AbsoluteSize.Y + GuiInset)

                    KeybindWindow.Parent = Library.Holder.Instance
                    Items["KeybindWindow"]:Tween({Position = UDim2.new(0, KeyButton.AbsolutePosition.X, 0, KeyButton.AbsolutePosition.Y + KeyButton.AbsoluteSize.Y + 10 + GuiInset)})
                    
                    Items["KeybindWindow"]:FadeDescendants(true, function()
                        Debounce = false 
                    end)

                    for Index, Value in Library.OpenFrames do 
                        if Value ~= IsSettings then
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Keybind] = Keybind 
                else
                    Items["KeybindWindow"]:Tween({Position = UDim2.new(0, KeyButton.AbsolutePosition.X, 0, KeyButton.AbsolutePosition.Y + KeyButton.AbsoluteSize.Y - 10 + GuiInset)})
                    Items["KeybindWindow"]:FadeDescendants(false, function()
                        Items["KeybindWindow"].Instance.Parent = Library.UnusedHolder.Instance
                        Debounce = false
                    end)

                    if Library.OpenFrames[Keybind] then 
                        Library.OpenFrames[Keybind] = nil
                    end
                end

                local Descendants = KeybindWindow:GetDescendants()
                table.insert(Descendants, KeybindWindow)

                for Index, Value in Descendants do 
                    if Value.ClassName:find("UI") then
                        continue
                    end

                    if IsSettings then 
                        Value.ZIndex = Keybind.IsOpen and Library.ZIndexOrder.KeybindWindow or 1
                    else
                        Value.ZIndex = Keybind.IsOpen and Library.ZIndexOrder.KeybindWindow + 1 or 1
                    end
                end
            end
    
            function Keybind:SetMode()
                Flags[Keybind.Flag] = {
                    Mode = Keybind.Mode,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }
    
                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Keybind.Toggled)
                end
            end

            local KeybindObject

            if Library.KeyList then
                KeybindObject = Library.KeyList:Add("", "")
            end

            local Update = function()
                if KeybindObject then
                    KeybindObject:Set(Data.Name, Keybind.Value, Keybind.Mode)
                    KeybindObject:SetStatus(Keybind.Toggled)
                end
            end

            local ModeDropdown = Library:Dropdown({
                Name = "Mode",
                Flag = Keybind.Flag .. "ModeDropdown",
                Parent = Items["KeybindWindow"],
                Items = { "Toggle", "Hold", "Always" },
                Default = "Toggle",
                Callback = function(Value)
                    Keybind.Mode = Value

                    Keybind:SetMode()

                    if Value == "Always" then 
                        Keybind:Press(true)
                    end

                    Items["KeyButton"].Instance.Text = Keybind.Mode .. ": " .. Keybind.Value
                    Update()
                end
            })

            local ShowInKeybindsList = Library:Toggle({
                Name = "Show In Keybinds List",
                Flag = Keybind.Flag .. "ShowInKeybindsList",
                Parent = Items["KeybindWindow"],
                Default = true,
                Callback = function(Value)
                    KeybindObject:SetVis(Value)
                end
            })
    
            function Keybind:Press(Bool)
                if Keybind.Mode == "Toggle" then 
                    Keybind.Toggled = not Keybind.Toggled
                elseif Keybind.Mode == "Hold" then 
                    Keybind.Toggled = Bool
                elseif Keybind.Mode == "Always" then 
                    Keybind.Toggled = true
                end
    
                Flags[Keybind.Flag] = {
                    Mode = Keybind.Mode,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }
    
                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Keybind.Toggled)
                end

                Update()
            end
    
            function Keybind:Set(Key)
                if string.find(tostring(Key), "Enum") then 
                    Keybind.Key = tostring(Key)
    
                    Key = Key.Name == "Backspace" and "None" or Key.Name
    
                    local KeyString = Keys[Keybind.Key] or string.gsub(Key, "Enum.", "") or "None"
                    local TextToDisplay = string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"
    
                    Keybind.Value = TextToDisplay
                    Items["KeyButton"].Instance.Text = Keybind.Mode .. ": " .. TextToDisplay
    
                    Flags[Keybind.Flag] = {
                        Mode = Keybind.Mode,
                        Key = Keybind.Key,
                        Toggled = Keybind.Toggled
                    }
    
                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end

                    Update()
                elseif type(Key) == "table" then
                    local RealKey = Key.Key == "Backspace" and "None" or Key.Key
                    Keybind.Key = tostring(Key.Key)
    
                    if Key.Mode then
                        Keybind.Mode = Key.Mode
                        Keybind:SetMode(Key.Mode)
                    else
                        Keybind.Mode = "Toggle"
                        Keybind:SetMode("Toggle")
                    end
    
                    local KeyString = Keys[Keybind.Key] or string.gsub(tostring(RealKey), "Enum.", "") or RealKey
                    local TextToDisplay = KeyString and string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"
    
                    TextToDisplay = string.gsub(string.gsub(KeyString, "KeyCode.", ""), "UserInputType.", "")
    
                    Keybind.Value = TextToDisplay
                    Items["KeyButton"].Instance.Text = Keybind.Mode .. ": " .. TextToDisplay
    
                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end

                    Update()
                elseif table.find({"Toggle", "Hold", "Always"}, Key) then
                    Keybind.Mode = Key
                    Keybind:SetMode(Key)
    
                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end

                    Update()
                end

                Keybind.Picking = false
            end
    
            Items["KeyButton"]:Connect("MouseButton1Click", function()
                Keybind.Picking = true 
    
                Items["KeyButton"].Instance.Text = ". . ."
    
                local InputBegan
                InputBegan = UserInputService.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.Keyboard then 
                        Keybind:Set(Input.KeyCode)
                    else
                        Keybind:Set(Input.UserInputType)
                    end
    
                    InputBegan:Disconnect()
                    InputBegan = nil
                end)
            end)
    
            Library:Connect(UserInputService.InputBegan, function(Input, GPE)
                if Keybind.Value == "None" then
                    return
                end
    
                if not GPE then
                    if tostring(Input.KeyCode) == Keybind.Key then
                        if Keybind.Mode == "Toggle" then 
                            Keybind:Press()
                        elseif Keybind.Mode == "Hold" then 
                            Keybind:Press(true)
                        elseif Keybind.Mode == "Always" then 
                            Keybind:Press(true)
                        end
                    elseif tostring(Input.UserInputType) == Keybind.Key then
                        if Keybind.Mode == "Toggle" then 
                            Keybind:Press()
                        elseif Keybind.Mode == "Hold" then 
                            Keybind:Press(true)
                        elseif Keybind.Mode == "Always" then 
                            Keybind:Press(true)
                        end
                    end
                end

                if Input.UserInputType == Enum.UserInputType.MouseButton1 then 
                    if Keybind.IsOpen then 
                        if not Items["KeybindWindow"]:IsMouseOverFrame() and not ModeDropdown.Items.OptionHolder:IsMouseOverFrame() then 
                            Keybind:SetOpen(false)
                        end
                    end
                end
            end)
    
            Library:Connect(UserInputService.InputEnded, function(Input, GPE)
                if GPE then
                    return
                end

                if Keybind.Value == "None" then
                    return
                end
    
                if tostring(Input.KeyCode) == Keybind.Key then
                    if Keybind.Mode == "Hold" then 
                        Keybind:Press(false)
                    elseif Keybind.Mode == "Always" then 
                        Keybind:Press(true)
                    end
                elseif tostring(Input.UserInputType) == Keybind.Key then
                    if Keybind.Mode == "Hold" then 
                        Keybind:Press(false)
                    elseif Keybind.Mode == "Always" then 
                        Keybind:Press(true)
                    end
                end
            end)
    
            Items["KeyButton"]:Connect("MouseButton2Down", function()
                Keybind:SetOpen(not Keybind.IsOpen)
            end)
    
            if Data.Default then 
                Keybind:Set({
                    Mode = Data.Mode or "Toggle",
                    Key = Data.Default,
                })
            end
    
            SetFlags[Keybind.Flag] = function(Value)
                Keybind:Set(Value)
            end

            return Keybind, Items 
        end

        Library.Watermark = function(Self, Params)
            Params = Params or { }

            local Watermark = {
                Name = Params.Name or Params.name or "Watermark",
                SubName = Params.SubName or Params.subname or "for diddy",

                Items = { }
            }

            local Items = { } do
                Items["Watermark"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Library.Holder.Instance,
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, -10, 0, 10),
                    Size = UDim2.new(0, 0, 0, 25),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = Library.Theme["Inline"]
                }):AddToTheme({BackgroundColor3 = 'Inline'})
                
                Items["Watermark"]:MakeDraggable()
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Watermark"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Watermark"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline 2"],
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = 'Outline 2'})
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["Watermark"].Instance,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Watermark"].Instance,
                    PaddingTop = UDim.new(0, 6),
                    PaddingBottom = UDim.new(0, 6),
                    PaddingRight = UDim.new(0, 6),
                    PaddingLeft = UDim.new(0, 6)
                })
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.BoldFont,
                    TextSize = Library.FontSize,
                    Parent = Items["Watermark"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Watermark.Name,
                    Size = UDim2.new(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, -2, 0, 0),
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.X
                }):AddToTheme({TextColor3 = 'Text'})
                
                Items["SubText"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Watermark"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Watermark.SubName,
                    Size = UDim2.new(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, -2, 0, 0),
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.X
                }):AddToTheme({TextColor3 = 'Text'})

                Watermark.Items = Items 
            end
            
            function Watermark:SetVisibility(Bool)
                Items["Watermark"].Instance.Visible = Bool
            end

            function Watermark:SetText(Text)
                Items["Text"].Instance.Text = Text
            end

            function Watermark:SetSubText(Text)
                Items["SubText"].Instance.Text = Text
            end

            function Watermark:Center()
                local AbsPos = Items["Watermark"].Instance.AbsolutePosition
                task.wait()
                Items["Watermark"].Instance.AnchorPoint = Vector2.new(0, 0)
                Items["Watermark"].Instance.Position = UDim2.new(0, AbsPos.X, 0, AbsPos.Y + GuiInset)
            end

            Watermark:Center()

            Library.WatermarkObject = Watermark
            Self.WatermarkObject = Watermark

            return setmetatable(Watermark, Library)
        end

        Library.KeybindList = function(Self, Params)
            Params = Params or { }

            local KeybindList = {
                Name = Params.Name or Params.name or "Keybind List",

                Items = { }
            }

            Library.KeyList = KeybindList

            local Items = { } do 
                Items["KeybindList"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Library.Holder.Instance,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 20, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(0, 208, 0, 0),
                    BackgroundColor3 = Library.Theme["Inline"],
                    BackgroundTransparency = 0.15,
                }):AddToTheme({BackgroundColor3 = 'Inline'})

                Library:Corner(Items["KeybindList"], 10)
                Library:Glass(Items["KeybindList"], 0.3)
                Items["KeybindList"]:MakeDraggable()
                
                Items["UIStroke"] = Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["KeybindList"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Round,
                    Thickness = 1,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                Library:Glow(Items["KeybindList"], "Accent", 1, 0.92)
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.BoldFont,
                    TextSize = Library.FontSize,
                    Parent = Items["KeybindList"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = "KEYBINDS",
                    Size = UDim2.new(1, -40, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(12, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd
                }):AddToTheme({TextColor3 = 'Text'})

                local Star = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["KeybindList"].Instance,
                    Text = "✦",
                    TextColor3 = Library.Theme["Accent"],
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, -12, 0, 0),
                    Size = UDim2.fromOffset(14, 16),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0
                }):AddToTheme({TextColor3 = 'Accent'})

                Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["KeybindList"].Instance,
                    Position = UDim2.new(0, 12, 0, 22),
                    Size = UDim2.new(1, -24, 0, 1),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 0.78,
                    BackgroundColor3 = Library.Theme["Outline"]
                }):AddToTheme({BackgroundColor3 = 'Outline'})

                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["KeybindList"].Instance,
                    PaddingTop = UDim.new(0, 8),
                    PaddingBottom = UDim.new(0, 8),
                    PaddingRight = UDim.new(0, 12),
                    PaddingLeft = UDim.new(0, 12)
                })

                Items["Content"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["KeybindList"].Instance,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(0, 28),
                    Size = UDim2.new(1, 0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["Content"].Instance,
                    Padding = UDim.new(0, 0),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })                

                KeybindList.Items = Items 
                KeybindList.Keys = { }
            end

            local KeybindTweenInfo = TweenInfo.new(0.32, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

            local RowHeight = 18
            local RowGap = 2

            local RowSlot = RowHeight + RowGap
            local SlideOffset = 8
            local ListPaddingX = 32

            local MinListWidth = 208

            function KeybindList:RefreshWidth()
                Library:Thread(function()
                    if not Items["KeybindList"] or not Items["KeybindList"].Instance then
                        return
                    end

                    local Width = Items["Text"].Instance.TextBounds.X

                    for _, Entry in KeybindList.Keys do
                        if Entry.Active and Entry.CanBeVisible then
                            Width = math.max(Width, Entry:GetWidth())
                        end
                    end

                    Width = math.max(math.ceil(Width) + ListPaddingX, MinListWidth)
                    Items["KeybindList"]:Tween({Size = UDim2.new(0, Width, 0, 0)}, KeybindTweenInfo)
                end)
            end

            function KeybindList:SetVisibility(Bool)
                Items["KeybindList"].Instance.Visible = Bool
            end

            function KeybindList:SetText(Text)
                Items["Text"].Instance.Text = Text
                KeybindList:RefreshWidth()
            end

            function KeybindList:Center()
                local AbsPos = Items["KeybindList"].Instance.AbsolutePosition
                task.wait()
                Items["KeybindList"].Instance.AnchorPoint = Vector2.new(0, 0)
                Items["KeybindList"].Instance.Position = UDim2.new(0, AbsPos.X, 0, AbsPos.Y + GuiInset)
            end

            KeybindList:Center()
            KeybindList:RefreshWidth()

            function KeybindList:Add(Name, Key, Mode)
                local NewKey = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Content"].Instance,
                    BackgroundTransparency = 1,
                    ClipsDescendants = false,
                    Size = UDim2.new(1, 0, 0, 0),
                    Visible = false,
                    BorderSizePixel = 0
                })
                
                local NewText = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = NewKey.Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = tostring(Name or ""),
                    Size = UDim2.new(1, -104, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Position = UDim2.fromOffset(0, 0)
                }):AddToTheme({TextColor3 = 'Text'})

                local Chip = Library:Create("Frame", {
                    Name = "\0",
                    Parent = NewKey.Instance,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, 0, 0.5, 0),
                    Size = UDim2.fromOffset(0, 20),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = Library.Theme["Element"],
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                }):AddToTheme({BackgroundColor3 = 'Element'})
                Library:Corner(Chip, 999)
                Library:Stroke(Chip, "Outline", 1, 0.55)
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Chip.Instance,
                    PaddingLeft = UDim.new(0, 9),
                    PaddingRight = UDim.new(0, 9),
                })

                local NewKeyText = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.BoldFont,
                    TextSize = Library.FontSize,
                    Parent = Chip.Instance,
                    TextColor3 = Library.Theme["Accent"],
                    Text = tostring(Key or "None"),
                    Size = UDim2.new(0, 0, 1, 0),
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    BorderSizePixel = 0
                }):AddToTheme({TextColor3 = 'Accent'})

                local Entry = {
                    Instance = NewKey.Instance,
                    Active = false,
                    CanBeVisible = true,
                }

                function Entry:GetWidth()
                    return 52 + NewText.Instance.TextBounds.X + NewKeyText.Instance.TextBounds.X
                end

                function Entry:SetVis(Bool)
                    Entry.CanBeVisible = Bool

                    if not Bool then
                        Entry:SetStatus(false)
                    end
                end

                function Entry:Set(Name, Key, Mode)
                    NewText.Instance.Text = tostring(Name or "")
                    local Shown = tostring(Key or "None")
                    if Shown == "" then
                        Shown = "None"
                    end
                    NewKeyText.Instance.Text = Shown
                    KeybindList:RefreshWidth()
                end

                function Entry:SetStatus(Bool)
                    if not Entry.CanBeVisible then
                        Bool = false
                    end

                    if Entry.Active == Bool then
                        return
                    end

                    Entry.Active = Bool
                    
                    if Bool then
                        NewKey.Instance.Visible = true
                        NewKey:Tween({Size = UDim2.new(1, 0, 0, RowSlot)}, KeybindTweenInfo)
                        NewText:Tween({TextTransparency = 0}, KeybindTweenInfo)
                        NewKeyText:Tween({TextTransparency = 0}, KeybindTweenInfo)
                        Chip:Tween({BackgroundTransparency = 0.55}, KeybindTweenInfo)
                    else
                        NewKey:Tween({Size = UDim2.new(1, 0, 0, 0)}, KeybindTweenInfo)
                        NewText:Tween({TextTransparency = 1}, KeybindTweenInfo)
                        NewKeyText:Tween({TextTransparency = 1}, KeybindTweenInfo)
                        Chip:Tween({BackgroundTransparency = 1}, KeybindTweenInfo)

                        task.delay(KeybindTweenInfo.Time, function()
                            if not Entry.Active and NewKey.Instance and NewKey.Instance.Parent then
                                NewKey.Instance.Visible = false
                            end
                        end)
                    end

                    KeybindList:RefreshWidth()
                end

                setmetatable(Entry, {
                    __index = function(_, Key)
                        return NewKey[Key]
                    end
                })

                table.insert(KeybindList.Keys, Entry)
                return Entry 
            end

            return setmetatable(KeybindList, Library)
        end

        local AnimInfo = TweenInfo.new(0.45, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
        local FadeInfo = TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

        Library.Notification = function(Self, Name, Duration, Color, Icon)
            Name = Name or "Notification"
            Duration = Duration or 3
            Color = Color or Library.Theme.Accent

            local Notification = {
                Removing = false,
                Height = 30,
                Width = 0,
                TargetPosition = UDim2.new(1, -Library.NotificationOrigin.X, 1, -Library.NotificationOrigin.Y),
                Items = { }
            }

            local Slide = Library.NotificationSlide

            local Items = { } do 
                Items["Notification"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Library.NotifHolder.Instance,
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, -Library.NotificationOrigin.X + Slide, 0, Library.NotificationOrigin.Y),
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    BackgroundColor3 = Library.Theme["Inline"],
                    ZIndex = 100
                }):AddToTheme({BackgroundColor3 = 'Inline'})

                Library:Create("UICorner", {
                    Name = "\0",
                    Parent = Items["Notification"].Instance,
                    CornerRadius = UDim.new(0, 14)
                })
                
                Items["Stroke"] = Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Notification"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Round,
                    Thickness = 1,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Notification"].Instance,
                    PaddingTop = UDim.new(0, 6),
                    PaddingBottom = UDim.new(0, 6),
                    PaddingRight = UDim.new(0, 6),
                    PaddingLeft = UDim.new(0, 6)
                })
                
                local TextX = 8
                if type(Icon) == "string" and Icon ~= "" then
                    local Badge = Library:Create("ImageLabel", {
                        Name = "\0",
                        Parent = Items["Notification"].Instance,
                        BackgroundTransparency = 1,
                        Image = "rbxassetid://6031280882",
                        ImageColor3 = Color,
                        ScaleType = Enum.ScaleType.Fit,
                        Size = UDim2.fromOffset(16, 16),
                        Position = UDim2.fromOffset(4, 0),
                        BorderSizePixel = 0,
                        ZIndex = 102,
                    })
                    Items["Badge"] = Badge
                    TextX = 26
                end
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Notification"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Name,
                    Size = UDim2.new(0, 0, 0, 16),
                    Position = UDim2.fromOffset(TextX, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    ZIndex = 101
                }):AddToTheme({TextColor3 = 'Text'})

                Items["Liner"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Notification"].Instance,
                    Position = UDim2.fromOffset(0, 2),
                    Size = UDim2.new(0, 3, 1, -4),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color,
                    ZIndex = 101
                })         
            end

            Notification.Items = Items

            for _, Value in Items do 
                if Value.Instance:IsA("Frame") then
                    Value.Instance.BackgroundTransparency = 1
                elseif Value.Instance:IsA("TextLabel") then 
                    Value.Instance.TextTransparency = 1
                elseif Value.Instance:IsA("ImageLabel") then
                    Value.Instance.ImageTransparency = 1
                elseif Value.Instance:IsA("UIStroke") then 
                    Value.Instance.Transparency = 1
                end
            end

            while #Library.Notifications >= (Library.NotificationMax or 10) do
                local Oldest = Library.Notifications[#Library.Notifications]
                if not Oldest or Oldest.Removing then
                    break
                end
                Oldest.Removing = true
                local OldItems = Oldest.Items
                if OldItems and OldItems["Notification"] and OldItems["Notification"].Instance then
                    local Current = OldItems["Notification"].Instance.Position
                    OldItems["Notification"]:Tween({
                        Position = UDim2.new(1, Current.X.Offset + (Library.NotificationSlide or 36), 0, Current.Y.Offset)
                    }, FadeInfo)
                    task.delay(0.35, function()
                        local Index = table.find(Library.Notifications, Oldest)
                        if Index then
                            table.remove(Library.Notifications, Index)
                        end
                        if OldItems["Notification"].Instance then
                            OldItems["Notification"].Instance:Destroy()
                        end
                        if Library then
                            Library:RefreshNotifications()
                        end
                    end)
                end
                local Index = table.find(Library.Notifications, Oldest)
                if Index then
                    table.remove(Library.Notifications, Index)
                end
            end

            table.insert(Library.Notifications, 1, Notification)
            task.wait()

            -- Exit() nils this local; a notification that was mid-yield during a reload must not
            -- index it afterwards
            if not Library then
                return
            end

            local FullSize = Items["Notification"].Instance.AbsoluteSize

            if FullSize.X <= 0 or FullSize.Y <= 0 then
                FullSize = Vector2.new(math.max(FullSize.X, 120), math.max(FullSize.Y, 30))
            end

            Notification.Height = FullSize.Y
            Notification.Width = FullSize.X
            Notification.FullSize = FullSize

            Library:RefreshNotifications(Notification)

            local Target = Notification.TargetPosition
            local Frame = Items["Notification"].Instance

            Frame.AutomaticSize = Enum.AutomaticSize.None
            Frame.Size = UDim2.new(0, FullSize.X, 0, FullSize.Y)
            Frame.Position = UDim2.new(1, Target.X.Offset + Slide, 1, Target.Y.Offset)

            Library:Thread(function()
                for _, Value in Items do 
                    if Value.Instance:IsA("Frame") then
                        Value:Tween({BackgroundTransparency = 0}, FadeInfo)
                    elseif Value.Instance:IsA("TextLabel") then 
                        Value:Tween({TextTransparency = 0}, FadeInfo)
                    elseif Value.Instance:IsA("ImageLabel") then
                        Value:Tween({ImageTransparency = 0}, FadeInfo)
                    elseif Value.Instance:IsA("UIStroke") then 
                        Value:Tween({Transparency = 0}, FadeInfo)
                    end
                end

                Items["Notification"]:Tween({Position = Target}, AnimInfo)

                task.delay(Duration + 0.05, function()
                    if Notification.Removing then
                        return
                    end

                    Notification.Removing = true
                    Library:RefreshNotifications()

                    for _, Value in Items do 
                        if not Value.Instance or not Value.Instance.Parent then
                            continue
                        end

                        if Value.Instance:IsA("Frame") then
                            Value:Tween({BackgroundTransparency = 1}, FadeInfo)
                        elseif Value.Instance:IsA("TextLabel") then 
                            Value:Tween({TextTransparency = 1}, FadeInfo)
                        elseif Value.Instance:IsA("ImageLabel") then
                            Value:Tween({ImageTransparency = 1}, FadeInfo)
                        elseif Value.Instance:IsA("UIStroke") then 
                            Value:Tween({Transparency = 1}, FadeInfo)
                        end
                    end

                    local Current = Items["Notification"].Instance.Position
                    Items["Notification"]:Tween({Position = UDim2.new(1, Current.X.Offset + Slide, 0, Current.Y.Offset)}, AnimInfo)

                    task.wait(AnimInfo.Time)

                    if not Library then
                        if Items["Notification"].Instance then
                            Items["Notification"].Instance:Destroy()
                        end
                        return
                    end

                    local Index = table.find(Library.Notifications, Notification)

                    if Index then
                        table.remove(Library.Notifications, Index)
                    end

                    if Items["Notification"].Instance then
                        Items["Notification"].Instance:Destroy()
                    end

                    Library:RefreshNotifications()
                end)
            end)

            return Notification
        end

        Library.Tooltip = function(Self, Text)
            local Object = Self.Instance

            if not Object then 
                return 
            end
    
            if Text == "" then 
                return 
            end
    
            if Text == nil then
                return
            end

            local Items = { } do 
                Items["Tooltip"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Library.Holder.Instance,
                    Size = UDim2.new(0, 0, 0, 22),
                    ClipsDescendants = true,
                    Position = UDim2.new(0, 1009, 0, 234),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = Library.Theme["Inline"]
                }):AddToTheme({BackgroundColor3 = 'Inline'})
                
                Items["Stroke2"] = Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Tooltip"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Items["Stroke"] = Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Tooltip"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline 2"],
                    BorderOffset = UDim.new(0, 1)
                }):AddToTheme({Color = 'Outline 2'})
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Tooltip"].Instance,
                    PaddingRight = UDim.new(0, 6),
                    PaddingLeft = UDim.new(0, 6)
                })
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Tooltip"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Text,
                    Size = UDim2.new(0, 0, 0, 15),
                    AnchorPoint = Vector2.new(0, 0.5),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 4, 0.5, -1),
                    AutomaticSize = Enum.AutomaticSize.X
                }):AddToTheme({TextColor3 = 'Text'})
                
                Items["Liner"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Tooltip"].Instance,
                    Position = UDim2.new(0, -6, 0, 0),
                    Size = UDim2.new(0, 1, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Accent"]
                }):AddToTheme({BackgroundColor3 = 'Accent'})                
            end

            local GetSize = function()
                local AbsSize = Items["Tooltip"].Instance.AbsoluteSize
                Items["Tooltip"].Instance.AutomaticSize = Enum.AutomaticSize.None
                task.wait()
                Items["Tooltip"].Instance.Size = UDim2.new(0, AbsSize.X, 0, AbsSize.Y)
                return AbsSize
            end
    
            local TweenDescendants = function(Bool)
                for Index, Value in Items do 
                    if Value.Instance:IsA("UIStroke") then
                        Value:Tween({Transparency = Bool and 1 or 0})
                    elseif Value.Instance:IsA("Frame") then
                        Value:Tween({BackgroundTransparency = Bool and 1 or 0})
                    elseif Value.Instance:IsA("TextLabel") then
                        Value:Tween({TextTransparency = Bool and 1 or 0})
                    end
                end
            end
    
            TweenDescendants(true)
    
            local Size = GetSize()
            Items["Tooltip"].Instance.Size = UDim2.new(0, 0, 0, Size.Y)
    
            local RenderStepped 
            
            Self:OnHover(function()
                local MouseLocation = UserInputService:GetMouseLocation()
                Items["Tooltip"].Instance.Position = UDim2.new(0, MouseLocation.X + 20, 0, MouseLocation.Y + 20)
    
                Items["Tooltip"]:Tween({Size = UDim2.new(0, Size.X, 0, Size.Y)})
                TweenDescendants(false)
    
                RenderStepped = RunService.RenderStepped:Connect(function()
                    MouseLocation = UserInputService:GetMouseLocation()
                    Items["Tooltip"].Instance.Position = UDim2.new(0, MouseLocation.X + 20, 0, MouseLocation.Y + 20)
                end)
            end, function()
                Items["Tooltip"]:Tween({Size = UDim2.new(0, 0, 0, Size.Y)})
                TweenDescendants(true)
    
                RenderStepped:Disconnect()
                RenderStepped = nil
            end)
        end

        Library.Window = function(Self, Params)
            Params = Params or { }

            local Window = {
                Name = Params.Name or Params.name or "Window",

                IsOpen = true,
                Pages = { },
                Items = { }
            }

            local Items = { } do 
                if IsMobile then 
                    Library:Create("UIScale", {
                        Parent = Items["MainFrame"],
                        Scale = 0.7
                    })
                end

                Items["MainFrame"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Library.Holder.Instance,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    Size = UDim2.new(0, 780, 0, 520),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Background"]
                }):AddToTheme({BackgroundColor3 = 'Background'})

                Library:Create("UICorner", {
                    Name = "\0",
                    Parent = Items["MainFrame"].Instance,
                    CornerRadius = UDim.new(0, 10)
                })
                Library:Glass(Items["MainFrame"], 0.2)

                Items["MainFrame"]:MakeDraggable()
                Items["MainFrame"]:MakeResizeable(Vector2.new(640, 420))

                Items["UIStroke"] = Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["MainFrame"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Round,
                    Thickness = 1,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})

                Items["MainFrame"].Instance.ClipsDescendants = true

                Items["Sidebar"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["MainFrame"].Instance,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2.fromOffset(0, 10),
                    Size = UDim2.new(0, 148, 1, -20)
                })

                Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Sidebar"].Instance,
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, 0, 0, 10),
                    Size = UDim2.new(0, 1, 1, -20),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Outline"]
                }):AddToTheme({BackgroundColor3 = 'Outline'})

                Items["Title"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.BoldFont,
                    TextSize = Library.FontSize,
                    Parent = Items["Sidebar"].Instance,
                    Text = string.upper(Window.Name),
                    TextColor3 = Library.Theme["Text"],
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2.fromOffset(16, 2),
                    Size = UDim2.new(1, -28, 0, 18)
                }):AddToTheme({TextColor3 = 'Text'})

                Items["Pages"] = Library:Create("ScrollingFrame", {
                    Name = "\0",
                    Parent = Items["Sidebar"].Instance,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2.fromOffset(0, 26),
                    Size = UDim2.new(1, -6, 1, -58),
                    CanvasSize = UDim2.new(),
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 0,
                    ScrollingDirection = Enum.ScrollingDirection.Y
                })

                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Pages"].Instance,
                    PaddingTop = UDim.new(0, 2),
                    PaddingBottom = UDim.new(0, 2),
                    PaddingLeft = UDim.new(0, 12),
                    PaddingRight = UDim.new(0, 6)
                })

                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["Pages"].Instance,
                    FillDirection = Enum.FillDirection.Vertical,
                    Padding = UDim.new(0, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Items["Content"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["MainFrame"].Instance,
                    Position = UDim2.new(0, 156, 0, 6),
                    Size = UDim2.new(1, -162, 1, -12),
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
                    BackgroundColor3 = Library.Theme["Inline"]
                }):AddToTheme({BackgroundColor3 = 'Inline'})

                Library:Create("UICorner", {
                    Name = "\0",
                    Parent = Items["Content"].Instance,
                    CornerRadius = UDim.new(0, 10)
                })
                Library:Glass(Items["Content"], 0.25)
                Library:Stroke(Items["Content"], "Outline", 1, 0.5)

                Items["CurrentPath"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Content"].Instance,
                    Text = "",
                    TextColor3 = Library.Theme["Inactive Text"],
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2.fromOffset(12, 8),
                    Size = UDim2.new(1, -24, 0, 18),
                    ZIndex = 5
                }):AddToTheme({TextColor3 = 'Inactive Text'})

                Window.Items = Items
            end

            local Debounce = false

            function Window:ClosePopups()
                for Index, Value in Library.OpenFrames do 
                    if Value and Value.SetOpen then
                        Value:SetOpen(false)
                    end
                end
            end

            function Window:ResetPages()
                for _, Tab in Window.Pages do
                    Tab.Debounce = false

                    if Tab.Pages then
                        for _, Sub in Tab.Pages do
                            Sub.Debounce = false

                            if Tab.Current ~= Sub and Sub.Items and Sub.Items["Page"] then
                                Sub.Items["Page"].Instance.Parent = Library.UnusedHolder.Instance
                                Sub.Items["Page"].Instance.Visible = false
                                Sub.Items["Page"].Instance.Position = UDim2.new(0, 0, 0, 0)
                            end
                        end
                    end

                    if Window.Current ~= Tab and Tab.Items and Tab.Items["Page"] then
                        Tab.Items["Page"].Instance.Parent = Library.UnusedHolder.Instance
                        Tab.Items["Page"].Instance.Visible = false
                        Tab.Items["Page"].Instance.Position = UDim2.new(0, 0, 0, 0)
                    end
                end

                local Current = Window.Current

                if Current and Current.Items and Current.Items["Page"] then
                    Current.Items["Page"].Instance.Parent = Items["Content"].Instance
                    Current.Items["Page"].Instance.Visible = true
                    Current.Items["Page"].Instance.Position = UDim2.new(0, 0, 0, 30)
                    Current.Items["Page"].Instance.Size = UDim2.new(1, 0, 1, -30)

                    local CurrentSub = Current.Current

                    if CurrentSub and CurrentSub.Items and CurrentSub.Items["Page"] then
                        CurrentSub.Items["Page"].Instance.Parent = Current.Items["Columns"].Instance
                        CurrentSub.Items["Page"].Instance.Visible = true
                        CurrentSub.Items["Page"].Instance.Position = UDim2.new(0, 0, 0, 0)
                    end

                    if CurrentSub then
                        Items["CurrentPath"].Instance.Text = Current.Name .. "  >  " .. CurrentSub.Name
                    else
                        Items["CurrentPath"].Instance.Text = Current.Name
                    end
                end
            end

            function Window:SetOpen(Bool)
                if Debounce then 
                    return 
                end

                Debounce = true 

                Window.IsOpen = Bool
                Window:ClosePopups()
                Window:ResetPages()

                Items["MainFrame"]:FadeDescendants(Bool, function()
                    Debounce = false
                end)
            end

            function Window:Center()
                local AbsPos = Items["MainFrame"].Instance.AbsolutePosition
                Items["MainFrame"].Instance.AnchorPoint = Vector2.new(0, 0)
                task.wait()
                Items["MainFrame"].Instance.Position = UDim2.new(0, AbsPos.X, 0, AbsPos.Y + GuiInset)
            end

            Library:Connect(UserInputService.InputBegan, function(Input)
                if tostring(Input.KeyCode) == Library.MenuKeybind or tostring(Input.UserInputType) == Library.MenuKeybind then
                    if UserInputService:GetFocusedTextBox() then
                        return
                    end

                    Window:SetOpen(not Window.IsOpen)
                end
            end)

            if not Library.ActiveList then
                local Active = {
                    Rows = {},
                    Count = 0,
                    Shown = {},
                    Enabled = true,
                    Order = 0,
                }
                local SlideInfo = TweenInfo.new(0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

                local Frame = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Library.Holder.Instance,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -20, 0.5, 0),
                    Size = UDim2.fromOffset(208, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = Library.Theme["Inline"],
                    BackgroundTransparency = 0.15,
                    BorderSizePixel = 0,
                    Visible = false,
                }):AddToTheme({BackgroundColor3 = "Inline"})
                Library:Corner(Frame, 10)
                Library:Stroke(Frame, "Outline", 1, 0.45)
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Frame.Instance,
                    PaddingTop = UDim.new(0, 8),
                    PaddingBottom = UDim.new(0, 8),
                    PaddingLeft = UDim.new(0, 8),
                    PaddingRight = UDim.new(0, 8),
                })
                Frame:MakeDraggable()

                local Head = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Frame.Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 16),
                    BorderSizePixel = 0,
                })

                local Dot = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Head.Instance,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 1, 0.5, 0),
                    Size = UDim2.fromOffset(5, 5),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Accent"],
                }):AddToTheme({BackgroundColor3 = "Accent"})
                Library:Corner(Dot, 999)

                Library:Create("TextLabel", {
                    Name = "\0",
                    Parent = Head.Instance,
                    Text = "ACTIVE",
                    FontFace = Library.BoldFont,
                    TextSize = Library.FontSize,
                    TextColor3 = Library.Theme["Text"],
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2.fromOffset(12, 0),
                    Size = UDim2.new(1, -40, 1, 0),
                }):AddToTheme({TextColor3 = "Text"})

                local CountLabel = Library:Create("TextLabel", {
                    Name = "\0",
                    Parent = Head.Instance,
                    Text = "0",
                    FontFace = Library.BoldFont,
                    TextSize = Library.FontSize,
                    TextColor3 = Library.Theme["Accent"],
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, 0, 0.5, 0),
                    Size = UDim2.new(0, 0, 1, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    TextXAlignment = Enum.TextXAlignment.Right,
                }):AddToTheme({TextColor3 = "Accent"})

                Library:Create("Frame", {
                    Name = "\0",
                    Parent = Frame.Instance,
                    Position = UDim2.fromOffset(0, 22),
                    Size = UDim2.new(1, 0, 0, 1),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 0.78,
                    BackgroundColor3 = Library.Theme["Outline"],
                }):AddToTheme({BackgroundColor3 = "Outline"})

                local List = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Frame.Instance,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2.fromOffset(0, 28),
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                })
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = List.Instance,
                    Padding = UDim.new(0, 3),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                })

                local Features = {
                    AimbotEnabled = "Aimbot",
                    SilentEnabled = "Silent aim",
                    SilentManipulation = "Manipulation",
                    TriggerEnabled = "Triggerbot",
                    FlickEnabled = "Flick",
                    RageEnabled = "Ragebot",
                    RageEvasionEnabled = "Evasion",
                    RageUnderground = "Underground",
                    RageFakePos = "Fake position",
                    RageVoid = "Void park",
                    SpeedEnabled = "Speed",
                    SlideEnabled = "Slide",
                    InfJumpEnabled = "Infinite jump",
                    FlyEnabled = "Fly",
                    NoclipEnabled = "Noclip",
                    VelocityEnabled = "Velocity",
                    GunRapid = "Rapid fire",
                    NoSpread = "No spread",
                    NoRecoil = "No recoil",
                    MeleeRapid = "Melee rapid",
                    MeleeRange = "Melee reach",
                    EspEnabled = "ESP",
                    DmgNumbersEnabled = "Damage numbers",
                    HudEnabled = "Crosshair",
                    TracersEnabled = "Tracers",
                    HitSoundEnabled = "Hit sound",
                    KillSoundEnabled = "Kill sound",
                    ShootSoundEnabled = "Shoot sound",
                    CosmeticsEnabled = "Cosmetics",
                    ViewmodelEnabled = "Viewmodel",
                }

                function Active:refresh()
                    local Shown = 0
                    for _, Entry in Active.Rows do
                        if Active.Shown[Entry] then
                            Shown = Shown + 1
                        end
                    end
                    Active.Count = Shown
                    CountLabel.Instance.Text = tostring(Shown)
                    Frame.Instance.Visible = Active.Enabled ~= false and Shown > 0
                end

                function Active:Set(Flag, Name, On)
                    Name = Features[Flag]
                    if not Name then
                        return
                    end
                    local Row = Active.Rows[Flag]
                    if On then
                        if not Row then
                            Active.Order = Active.Order + 1
                            local Pill = Library:Create("Frame", {
                                Name = "\0",
                                Parent = List.Instance,
                                Size = UDim2.new(1, 0, 0, 0),
                                BackgroundColor3 = Library.Theme["Element"],
                                BackgroundTransparency = 0.45,
                                BorderSizePixel = 0,
                                ClipsDescendants = true,
                                LayoutOrder = Active.Order,
                            }):AddToTheme({BackgroundColor3 = "Element"})
                            Library:Corner(Pill, 10)
                            Library:Stroke(Pill, "Outline", 1, 0.55)

                            local Bar = Library:Create("Frame", {
                                Name = "\0",
                                Parent = Pill.Instance,
                                AnchorPoint = Vector2.new(0, 0.5),
                                Position = UDim2.new(0, 8, 0.5, 0),
                                Size = UDim2.new(0, 3, 0, 14),
                                BorderSizePixel = 0,
                                BackgroundColor3 = Library.Theme["Accent"],
                              }):AddToTheme({BackgroundColor3 = "Accent"})
                            Library:Corner(Bar, 999)

                            local Label = Library:Create("TextLabel", {
                                Name = "\0",
                                Parent = Pill.Instance,
                                Text = Name,
                                FontFace = Library.Font,
                                TextSize = Library.FontSize,
                                TextColor3 = Library.Theme["Text"],
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextTruncate = Enum.TextTruncate.AtEnd,
                                TextTransparency = 1,
                                BackgroundTransparency = 1,
                                BorderSizePixel = 0,
                                Position = UDim2.fromOffset(18, 0),
                                Size = UDim2.new(1, -52, 1, 0),
                              }):AddToTheme({TextColor3 = "Text"})

                            local Chip = Library:Create("Frame", {
                                Name = "\0",
                                Parent = Pill.Instance,
                                AnchorPoint = Vector2.new(1, 0.5),
                                Position = UDim2.new(1, -8, 0.5, 0),
                                Size = UDim2.fromOffset(24, 14),
                                BackgroundColor3 = Library.Theme["Accent"],
                                BackgroundTransparency = 0.7,
                                BorderSizePixel = 0,
                              }):AddToTheme({BackgroundColor3 = "Accent"})
                            Library:Corner(Chip, 999)

                            Row = { Pill = Pill, Label = Label, Bar = Bar, Chip = Chip }
                            Active.Rows[Flag] = Row
                        end
                        Row.Label.Instance.Text = Name
                        Row.Pill.Instance.Visible = true
                        Row.Pill.Instance.BackgroundTransparency = 1
                        Row.Label.Instance.TextTransparency = 1
                        Row.Chip.Instance.BackgroundTransparency = 1
                        Row.Pill:Tween({Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 0.45}, SlideInfo)
                        Row.Label:Tween({TextTransparency = 0}, SlideInfo)
                        Row.Chip:Tween({BackgroundTransparency = 0.6}, SlideInfo)
                        Active.Shown[Row] = true
                    elseif Row then
                        Active.Shown[Row] = nil
                        Row.Pill:Tween({Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1}, SlideInfo)
                        Row.Label:Tween({TextTransparency = 1}, SlideInfo)
                        Row.Chip:Tween({BackgroundTransparency = 1}, SlideInfo)
                        task.delay(SlideInfo.Time, function()
                            if Row.Label.Instance and Row.Label.Instance.TextTransparency > 0.5 then
                                Row.Pill.Instance.Visible = false
                            end
                        end)
                    end
                    Active:refresh()
                end

                function Active:SetVisibility(Bool)
                    Active.Enabled = Bool ~= false
                    Active:refresh()
                end

                Library.ActiveList = Active
            end

            Window:Center()
            return setmetatable(Window, Library)
        end

        Library.Page = function(Self, Params)
            Params = Params or { }

            local Page = {
                Name = Params.Name or Params.name or "Page",

                Window = Self,
                Pages = { },
                Items = { },
                Current = nil,
                Active = false,
                Debounce = false
            }

            local Items = { } do 
                local Order = (#Page.Window.Pages + 1) * 2

                Items["Inactive"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Page.Window.Items["Pages"].Instance,
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 26),
                    BorderSizePixel = 0,
                    ClipsDescendants = false,
                    LayoutOrder = Order
                })

                Library:Create("UICorner", {
                    Name = "\0",
                    Parent = Items["Inactive"].Instance,
                    CornerRadius = UDim.new(0, 6)
                })

                Items["Bar"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Inactive"].Instance,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 4, 0.5, 0),
                    Size = UDim2.new(0, 3, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Accent"],
                    ZIndex = 2,
                }):AddToTheme({BackgroundColor3 = 'Accent'})
                Library:Corner(Items["Bar"], 999)

                local PageIcons = {
                    Combat = "rbxassetid://6034509993",
                    Visuals = "rbxassetid://6031763426",
                    Players = "rbxassetid://6034287594",
                    Misc = "rbxassetid://6031280882",
                    Settings = "rbxassetid://6031280882",
                }
                Items["Icon"] = Library:Create("ImageLabel", {
                    Name = "\0",
                    Parent = Items["Inactive"].Instance,
                    BackgroundTransparency = 1,
                    Image = PageIcons[Page.Name] or "rbxassetid://6031280882",
                    ImageColor3 = Library.Theme["Inactive Text"],
                    ScaleType = Enum.ScaleType.Fit,
                    Position = UDim2.fromOffset(12, 8),
                    Size = UDim2.fromOffset(13, 13),
                }):AddToTheme({ImageColor3 = "Inactive Text"})

                Items["Title"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Inactive"].Instance,
                    Text = Page.Name,
                    TextColor3 = Library.Theme["Inactive Text"],
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Position = UDim2.fromOffset(32, 0),
                    Size = UDim2.new(1, -38, 1, 0)
                }):AddToTheme({TextColor3 = 'Inactive Text'})

                Items["Page"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Library.UnusedHolder.Instance,
                    BackgroundTransparency = 1,
                    Visible = false,
                    Position = UDim2.new(0, 0, 0, 30),
                    Size = UDim2.new(1, 0, 1, -30),
                    BorderSizePixel = 0
                })

                Items["SubPages"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Page.Window.Items["Pages"].Instance,
                    BackgroundTransparency = 1,
                    ClipsDescendants = true,
                    Size = UDim2.new(1, 0, 0, 0),
                    BorderSizePixel = 0,
                    Visible = false,
                    LayoutOrder = Order + 1
                })

                Items["SubHolder"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["SubPages"].Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BorderSizePixel = 0
                })

                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["SubHolder"].Instance,
                    PaddingLeft = UDim.new(0, 10),
                    PaddingRight = UDim.new(0, 4),
                    PaddingBottom = UDim.new(0, 4)
                })

                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["SubHolder"].Instance,
                    FillDirection = Enum.FillDirection.Vertical,
                    Padding = UDim.new(0, 1),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Items["Columns"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Page"].Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    ClipsDescendants = true
                })

                Page.Items = Items
            end

            function Page:subHeight()
                local Count = #Page.Pages
                if Count <= 0 then
                    return 0
                end
                return Count * 22 + (Count - 1) + 4
            end

            function Page:setSubs(Open, Animate)
                local Clip = Items["SubPages"].Instance
                local Holder = Items["SubHolder"].Instance
                local Height = Page:subHeight()
                local Info = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                if not Animate then
                    Clip.Visible = Open and Height > 0
                    Clip.Size = UDim2.new(1, 0, 0, Open and Height or 0)
                    Holder.Position = UDim2.new(0, 0, 0, 0)
                    return
                end
                if Open then
                    Clip.Visible = true
                    Clip.Size = UDim2.new(1, 0, 0, 0)
                    Holder.Position = UDim2.new(0, 0, 0, -Height)
                    Library:Tween({Size = UDim2.new(1, 0, 0, Height)}, Info, Clip)
                    Library:Tween({Position = UDim2.new(0, 0, 0, 0)}, Info, Holder)
                else
                    Library:Tween({Size = UDim2.new(1, 0, 0, 0)}, Info, Clip)
                    Library:Tween({Position = UDim2.new(0, 0, 0, -Height)}, Info, Holder)
                    task.delay(0.22, function()
                        if Page.Window.Current ~= Page then
                            Clip.Visible = false
                        end
                    end)
                end
            end

            function Page:Turn()
                local Old = Page.Window.Current

                if Old == Page then
                    return
                end

                if Page.Debounce then
                    return
                end

                if Old and Old.Debounce then
                    return
                end

                Page.Window:ClosePopups()

                if Old then
                    Old.Items["Title"]:ChangeItemTheme({TextColor3 = "Inactive Text"})
                    Old.Items["Title"].Instance.TextColor3 = Library.Theme["Inactive Text"]
                    Old.Items["Inactive"].Instance.BackgroundTransparency = 1
                    Old.Items["Icon"]:ChangeItemTheme({ImageColor3 = "Inactive Text"})
                    Old.Items["Icon"]:Tween({ImageColor3 = Library.Theme["Inactive Text"]})
                    Old.Items["Bar"]:Tween({Size = UDim2.new(0, 3, 0, 0)})
                    Old:setSubs(false, true)
                    local OldPage = Old.Items["Page"].Instance
                    OldPage.Visible = false
                    OldPage.Parent = Library.UnusedHolder.Instance
                end

                local NewPage = Items["Page"].Instance
                NewPage.Parent = Page.Window.Items["Content"].Instance
                NewPage.Visible = true
                NewPage.Size = UDim2.new(1, 0, 1, -36)
                NewPage.Position = UDim2.new(0, 0, 0, 36)

                Items["Title"]:ChangeItemTheme({TextColor3 = "Text"})
                Items["Title"].Instance.TextColor3 = Library.Theme.Text
                Items["Inactive"].Instance.BackgroundTransparency = 0.82
                Items["Inactive"].Instance.BackgroundColor3 = Library.Theme["Element"]
                Items["Icon"]:ChangeItemTheme({ImageColor3 = "Accent"})
                Items["Icon"]:Tween({ImageColor3 = Library.Theme["Accent"]})
                Items["Bar"]:Tween({Size = UDim2.new(0, 3, 0, 16)})
                Page:setSubs(true, Old ~= nil)

                Page.Window.Current = Page

                local First = Page.Pages[1]
                if First and Page.Current ~= First then
                    First:Turn()
                elseif Page.Current and Page.Current.Items and Page.Current.Items["Page"] then
                    Page.Current.Items["Page"].Instance.Parent = Items["Columns"].Instance
                    Page.Current.Items["Page"].Instance.Visible = true
                    Page.Window.Items["CurrentPath"].Instance.Text = Page.Name .. "  >  " .. Page.Current.Name
                end
            end

            Items["Inactive"]:Connect("MouseButton1Down", function()
                Page:Turn()
            end)

            Items["Inactive"]:OnHover(function()
                if Page.Window.Current ~= Page then
                    Items["Inactive"]:Tween({BackgroundTransparency = 0.9})
                    Items["Inactive"].Instance.BackgroundColor3 = Library.Theme["Element"]
                    Items["Title"]:Tween({TextColor3 = Library.Theme["Text"]})
                    Items["Bar"]:Tween({Size = UDim2.new(0, 3, 0, 10)})
                end
            end, function()
                if Page.Window.Current ~= Page then
                    Items["Inactive"]:Tween({BackgroundTransparency = 1})
                    Items["Title"]:Tween({TextColor3 = Library.Theme["Inactive Text"]})
                    Items["Bar"]:Tween({Size = UDim2.new(0, 3, 0, 0)})
                end
            end)

            if #Page.Window.Pages == 0 then 
                Page:Turn()
            end

            table.insert(Page.Window.Pages, Page)
            return setmetatable(Page, Library)
        end

        Library.SubPage = function(Self, Params)
            Params = Params or { }

            local Page = {
                Name = Params.Name or Params.name or "Page",

                Window = Self.Window,
                Page = Self,
                ColumnsData = { },
                Items = { },
                Active = false,
                Debounce = false
            }

            local Items = { } do 
                Items["Inactive"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Page.Page.Items["SubHolder"].Instance,
                    TextColor3 = Library.Theme["Inactive Text"],
                    Text = Page.Name,
                    AutoButtonColor = false,
                    Size = UDim2.new(1, 0, 0, 22),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    BorderSizePixel = 0,
                    ClipsDescendants = false
                }):AddToTheme({TextColor3 = 'Inactive Text'})
                Library:Corner(Items["Inactive"], 6)
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Inactive"].Instance,
                    PaddingLeft = UDim.new(0, 8),
                    PaddingRight = UDim.new(0, 4),
                })
                Items["Inactive"]:OnHover(function()
                    if Page.Page.Current ~= Page then
                        Items["Inactive"]:Tween({BackgroundTransparency = 0.9})
                        Items["Inactive"].Instance.BackgroundColor3 = Library.Theme["Element"]
                    end
                end, function()
                    if Page.Page.Current ~= Page then
                        Items["Inactive"]:Tween({BackgroundTransparency = 1})
                    end
                end)
                                
                Items["Page"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Library.UnusedHolder.Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Visible = false,
                    BorderSizePixel = 0
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["Page"].Instance,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                })
                
                Items["LeftColumn"] = Library:Create("ScrollingFrame", {
                    Name = "\0",
                    Parent = Items["Page"].Instance,
                    ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 0,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 100, 0, 100),
                    BorderSizePixel = 0,
                    CanvasSize = UDim2.new(0, 0, 0, 0)
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["LeftColumn"].Instance,
                    Padding = UDim.new(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["LeftColumn"].Instance,
                    PaddingTop = UDim.new(0, 8),
                    PaddingBottom = UDim.new(0, 8),
                    PaddingRight = UDim.new(0, 6),
                    PaddingLeft = UDim.new(0, 8)
                })
                
                Items["RightColumn"] = Library:Create("ScrollingFrame", {
                    Name = "\0",
                    Parent = Items["Page"].Instance,
                    ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 0,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 100, 0, 100),
                    BorderSizePixel = 0,
                    CanvasSize = UDim2.new(0, 0, 0, 0)
                })
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["RightColumn"].Instance,
                    PaddingTop = UDim.new(0, 8),
                    PaddingBottom = UDim.new(0, 8),
                    PaddingRight = UDim.new(0, 8),
                    PaddingLeft = UDim.new(0, 6)
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["RightColumn"].Instance,
                    Padding = UDim.new(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Page.ColumnsData[1] = Items["LeftColumn"]
                Page.ColumnsData[2] = Items["RightColumn"]

                Page.Items = Items
            end

            function Page:Turn()
                local Old = Page.Page.Current 

                if Old == Page then 
                    return 
                end

                if Page.Debounce then 
                    return
                end

                if Old and Old.Debounce then 
                    return 
                end

                Page.Window:ClosePopups()

                if Old then
                    Old.Items["Inactive"]:ChangeItemTheme({TextColor3 = "Inactive Text"})
                    Old.Items["Inactive"].Instance.TextColor3 = Library.Theme["Inactive Text"]
                    Old.Items["Inactive"].Instance.BackgroundTransparency = 1
                    local OldPage = Old.Items["Page"].Instance
                    OldPage.Visible = false
                    OldPage.Parent = Library.UnusedHolder.Instance
                    OldPage.Position = UDim2.new(0, 0, 0, 0)
                end

                local NewPage = Items["Page"].Instance
                NewPage.Parent = Page.Page.Items["Columns"].Instance
                NewPage.Visible = true
                NewPage.Position = UDim2.new(0, 0, 0, 0)

                Items["Inactive"]:ChangeItemTheme({TextColor3 = "Accent"})
                Items["Inactive"].Instance.TextColor3 = Library.Theme.Accent
                Items["Inactive"].Instance.BackgroundTransparency = 0.86
                Items["Inactive"].Instance.BackgroundColor3 = Library.Theme["Element"]

                Page.Page.Current = Page
                if Page.Page.Window.Current == Page.Page then
                    Page.Window.Items["CurrentPath"].Instance.Text = Page.Page.Name .. "  >  " .. Page.Name
                end
            end

            Items["Inactive"]:Connect("MouseButton1Down", function()
                Page:Turn()
            end)

            if #Page.Page.Pages == 0 then 
                Page:Turn()
            end

            table.insert(Page.Page.Pages, Page)
            if Page.Page.Window.Current == Page.Page then
                Page.Page:setSubs(true, false)
            end
            return setmetatable(Page, Library)
        end

        Library.Section = function(Self, Params)
            Params = Params or { } 

            local Section = {
                Name = Params.Name or Params.name or "Section",
                Side = Params.Side or Params.side or 1,

                Window = Self.Window,
                Page = Self,
                Items = { },
            }

            local Items = { } do 
                Items["Section"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Section.Page.ColumnsData[Section.Side].Instance,
                    Size = UDim2.new(1, 0, 0, 40),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = Library.Theme["Background"]
                }):AddToTheme({BackgroundColor3 = 'Background'})

                Library:Corner(Items["Section"], 8)
                Library:Stroke(Items["Section"], "Outline", 1, 0.45)

                local SectionIcons = {
                    aimbot = "rbxassetid://6034509993",
                    ["silent aim"] = "rbxassetid://6031280882",
                    manipulation = "rbxassetid://6034509993",
                    triggerbot = "rbxassetid://6034509993",
                    flick = "rbxassetid://6034509993",
                    ragebot = "rbxassetid://6034509993",
                    evasion = "rbxassetid://6031763426",
                    movement = "rbxassetid://6034287594",
                    extras = "rbxassetid://6031280882",
                    exploits = "rbxassetid://6034509993",
                    melee = "rbxassetid://6034509993",
                    players = "rbxassetid://6034287594",
                    colors = "rbxassetid://6031763426",
                    numbers = "rbxassetid://6031280882",
                    crosshair = "rbxassetid://6031280882",
                    ["ui settings"] = "rbxassetid://6031280882",
                }
                local SectionIcon = SectionIcons[string.lower(Section.Name)]
                local TextX = 12
                if SectionIcon then
                    local Icon = Library:Create("ImageLabel", {
                        Name = "\0",
                        Parent = Items["Section"].Instance,
                        BackgroundTransparency = 1,
                        Image = SectionIcon,
                        ImageColor3 = Library.Theme["Accent"],
                        ScaleType = Enum.ScaleType.Fit,
                        Position = UDim2.fromOffset(12, 11),
                        Size = UDim2.fromOffset(12, 12),
                        ZIndex = 2,
                    }):AddToTheme({ImageColor3 = "Accent"})
                    TextX = 30
                end
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.BoldFont,
                    TextSize = Library.FontSize,
                    Parent = Items["Section"].Instance,
                    TextColor3 = Library.Theme["Inactive Text"],
                    Text = string.upper(Section.Name),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Size = UDim2.new(1, -(TextX + 12), 0, 16),
                    Position = UDim2.fromOffset(TextX, 9),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    ZIndex = 2
                }):AddToTheme({TextColor3 = 'Inactive Text'})

                Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Section"].Instance,
                    Position = UDim2.new(0, 12, 0, 30),
                    Size = UDim2.new(1, -24, 0, 1),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 0.72,
                    BackgroundColor3 = Library.Theme["Outline"],
                    ZIndex = 2,
                }):AddToTheme({BackgroundColor3 = 'Outline'})

                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Section"].Instance,
                    PaddingBottom = UDim.new(0, 8)
                })

                Items["Content"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Section"].Instance,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 12, 0, 38),
                    Size = UDim2.new(1, -24, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["Content"].Instance,
                    Padding = UDim.new(0, Library.Pad.Row),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Section.Items = Items
            end 

            return setmetatable(Section, Library)
        end

        Library.Toggle = function(Self, Params)
            Params = Params or { }

            local Toggle = {
                Name = Params.Name or Params.name or "Toggle",
                Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
                Default = Params.Default or Params.default or false,
                Tooltip = Params.Tooltip or Params.tooltip or "",
                Callback = Params.Callback or Params.callback or function() end,

                Window = Self.Window,
                Page = Self.Page,
                Section = Self,

                Value = false,
                Items = { }
            }

            local Parent 

            if Params.Parent then 
                Parent = Params.Parent
            else
                Parent = Toggle.Section.Items["Content"]
            end

            local Items = { } do 
                Items["Toggle"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Parent.Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 22),
                    BorderSizePixel = 0
                })
                Library:Corner(Items["Toggle"], Library.Pad.Radius)

                Items["Toggle"]:Tooltip(Toggle.Tooltip)
                
                Items["Indicator"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Toggle"].Instance,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 2, 0.5, 0),
                    Size = UDim2.fromOffset(26, 14),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Element"]
                }):AddToTheme({BackgroundColor3 = 'Element'})
                Library:Corner(Items["Indicator"], 999)
                Library:Stroke(Items["Indicator"], "Outline", 1, 0.4)
                Items["Glow"] = Library:Glow(Items["Indicator"], "Accent", 2, 0.9)

                Items["Knob"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Indicator"].Instance,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 2, 0.5, 0),
                    Size = UDim2.fromOffset(10, 10),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(240, 244, 252),
                    ZIndex = 3,
                })
                Library:Corner(Items["Knob"], 999)
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Toggle"].Instance,
                    TextColor3 = Library.Theme["Inactive Text"],
                    Text = Toggle.Name,
                    Size = UDim2.new(1, -36, 1, 0),
                    Position = UDim2.new(0, 34, 0, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    BorderSizePixel = 0,
                }):AddToTheme({TextColor3 = 'Inactive Text'})
                
                Items["SubElements"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Toggle"].Instance,
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -4, 0.5, 0),
                    Size = UDim2.new(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["SubElements"].Instance,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    Padding = UDim.new(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })                
                Library:Pop(Items["Toggle"], 1.01, 0.98)
                Items["Toggle"]:OnHover(function()
                    if not Toggle.Value then
                        Items["Toggle"]:Tween({BackgroundTransparency = 0.82})
                        Items["Toggle"].Instance.BackgroundColor3 = Library.Theme["Element"]
                        Items["Text"]:Tween({TextColor3 = Library.Theme["Text"]})
                    end
                end, function()
                    if not Toggle.Value then
                        Items["Toggle"]:Tween({BackgroundTransparency = 1})
                        Items["Text"]:Tween({TextColor3 = Library.Theme["Inactive Text"]})
                    end
                end)
            
                Toggle.Items = Items
            end

            function Toggle:Set(Bool)
                Toggle.Value = Bool
                local OnColor = Bool and "Accent" or "Element"
                local TextColor = Bool and "Text" or "Inactive Text"
                Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = OnColor})
                Items["Text"]:ChangeItemTheme({TextColor3 = TextColor})
                local Slide = TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                local KnobX = Bool and UDim2.new(1, -12, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                if Library.LoadingConfig then
                    Items["Indicator"].Instance.BackgroundColor3 = Library.Theme[OnColor]
                    Items["Text"].Instance.TextColor3 = Library.Theme[TextColor]
                    Items["Knob"].Instance.Position = KnobX
                    Items["Glow"].Transparency = Bool and 0.8 or 1
                else
                    Items["Indicator"]:Tween({BackgroundColor3 = Library.Theme[OnColor]}, Slide)
                    Items["Text"]:Tween({TextColor3 = Library.Theme[TextColor]}, Slide)
                    Items["Knob"]:Tween({Position = KnobX}, Slide)
                    Items["Glow"]:Tween({Transparency = Bool and 0.8 or 1}, Slide)
                end

                Flags[Toggle.Flag] = Bool
                if Library.ActiveList and Toggle.Flag ~= "ShowActiveList" and Toggle.Flag ~= "ShowKeybindList" and Toggle.Flag ~= "ShowWatermark" then
                    Library.ActiveList:Set(Toggle.Flag, Toggle.Name, Bool)
                end
                Library:SafeCall(Toggle.Callback, Bool)
            end

            function Toggle:SetVisibility(Bool)
                Items["Toggle"].Instance.Visible = Bool 
            end

            function Toggle:SetText(Text)
                Items["Text"].Instance.Text = tostring(Text)
            end

            function Toggle:Colorpicker(Data)
                Data = Data or { }

                local Colorpicker = {
                    Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Toggle.Name),
                    Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                    Callback = Data.Callback or Data.callback or function() end,
                    Alpha = Data.Alpha or Data.alpha or 0,

                    Window = Toggle.Window,
                    Page = Toggle.Page,
                    Section = Toggle.Section,
                }

                local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
                    Parent = Items["SubElements"],
                    Page = Colorpicker.Page,
                    Section = Colorpicker.Section,
                    Flag = Colorpicker.Flag,
                    Default = Colorpicker.Default,
                    Callback = Colorpicker.Callback,
                    Alpha = Colorpicker.Alpha
                })

                return NewColorpicker
            end

            function Toggle:Keybind(Data)
                Data = Data or { }

                local Keybind = {
                    Name = Data.Name or Data.name or Toggle.Name,
                    Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Toggle.Name),
                    Default = Data.Default or Data.default or Enum.KeyCode.E,
                    Callback = Data.Callback or Data.callback or function() end,
                    Mode = Data.Mode or Data.mode or "Toggle",

                    Window = Toggle.Window,
                    Page = Toggle.Page,
                    Section = Toggle.Section,
                }

                local NewKeybind, KeybindItems = Library:CreateKeybind({
                    Parent = Items["SubElements"],
                    Name = Keybind.Name,
                    Page = Keybind.Page,
                    Section = Keybind.Section,
                    Flag = Keybind.Flag,
                    Default = Keybind.Default,
                    Mode = Keybind.Mode,
                    Callback = Keybind.Callback
                })

                return NewKeybind
            end

            Items["Toggle"]:Connect("MouseButton1Down", function()
                Toggle:Set(not Toggle.Value)
            end)

            Toggle:Set(Toggle.Default)

            SetFlags[Toggle.Flag] = function(Value)
                Toggle:Set(Value)
            end

            return setmetatable(Toggle, Library)
        end

        Library.Button = function(Self)
            local Button = {
                Window = Self.Window,
                Page = Self.Page,
                Section = Self,
                Items = { }
            }

            local Items = { } do 
                Items["Button"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Button.Section.Items["Content"].Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 22),
                    BorderSizePixel = 0
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["Button"].Instance,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = UDim.new(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                })

                Button.Items = Items
            end

            function Button:Add(Name, Callback)
                local NewButton = { }

                local NewItems = { } do
                    NewItems["Button"] = Library:Create("TextButton", {
                        Name = "\0",
                        FontFace = Library.Font,
                        TextSize = Library.FontSize,
                        Parent = Items["Button"].Instance,
                        TextColor3 = Color3.fromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        Size = UDim2.new(1, 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Library.Theme["Element"]
                    }):AddToTheme({BackgroundColor3 = 'Element'})
                    Library:Corner(NewItems["Button"], 6)
                    Library:Stroke(NewItems["Button"], "Outline", 1, 0.45)
                    NewItems["Glow"] = Library:Glow(NewItems["Button"], "Accent", 1, 1)

                    NewItems["Text"] = Library:Create("TextLabel", {
                        Name = "\0",
                        FontFace = Library.BoldFont,
                        TextSize = Library.FontSize,
                        Parent = NewItems["Button"].Instance,
                        TextColor3 = Library.Theme["Text"],
                        Text = Name,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Size = UDim2.new(1, -16, 1, 0),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        BorderSizePixel = 0,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                    }):AddToTheme({TextColor3 = 'Text'})

                    Library:Pop(NewItems["Button"], 1.02, 0.955)

                    NewItems["Button"]:OnHover(function()
                        NewItems["Button"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
                        NewItems["Glow"]:Tween({Transparency = 0.35})
                        NewItems["Text"]:Tween({TextColor3 = Color3.new(1, 1, 1)})
                    end, function()
                        NewItems["Button"]:Tween({BackgroundColor3 = Library.Theme["Element"]})
                        NewItems["Glow"]:Tween({Transparency = 1})
                        NewItems["Text"]:Tween({TextColor3 = Library.Theme["Text"]})
                    end)
                end

                function NewButton:Press()
                    local Flash = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local Fade = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    NewItems["Button"]:Tween({BackgroundColor3 = Library.Theme.Accent}, Flash)
                    NewItems["Glow"]:Tween({Transparency = 0.1}, Flash)
                    task.delay(0.09, function()
                        if not NewItems["Button"].Instance.Parent then
                            return
                        end
                        NewItems["Button"]:Tween({BackgroundColor3 = Library.Theme.Element}, Fade)
                        NewItems["Glow"]:Tween({Transparency = 1}, Fade)
                    end)

                    Library:SafeCall(Callback)
                end

                function NewButton:SetText(Text)
                    NewItems["Text"].Instance.Text = tostring(Text)
                end

                NewItems["Button"]:Connect("MouseButton1Down", function()
                    NewButton:Press()
                end)

                return Button, NewButton
            end

            function Button:SetVisibility(Bool)
                Items["Button"].Instance.Visible = Bool
            end

            return setmetatable(Button, Library)
        end

        Library.Slider = function(Self, Params)
            Params = Params or { }

            local Slider = {
                Name = Params.Name or Params.name or "Slider",
                Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
                Default = Params.Default or Params.default or 0,
                Min = Params.Min or Params.min or 0,
                Max = Params.Max or Params.max or 100,
                Tooltip = Params.Tooltip or Params.tooltip or "",
                Callback = Params.Callback or Params.callback or function() end,
                Decimals = Params.Decimals or Params.decimals or 0,
                Suffix = Params.Suffix or Params.suffix or "",

                Window = Self.Window,
                Page = Self.Page,
                Section = Self,

                Value = 0,
                Sliding = false,
                Items = { }
            }

            local Parent 

            if Params.Parent then 
                Parent = Params.Parent
            else
                Parent = Slider.Section.Items["Content"]
            end

            local Items = { } do 
                Items["Slider"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Parent.Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 28),
                    BorderSizePixel = 0
                })

                Items["Slider"]:Tooltip(Slider.Tooltip)
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Slider"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Slider.Name,
                    Size = UDim2.new(1, -76, 0, 16),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    BorderSizePixel = 0,
                }):AddToTheme({TextColor3 = 'Text'})
                
                Items["Value"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.BoldFont,
                    TextSize = Library.FontSize,
                    Parent = Items["Slider"].Instance,
                    TextColor3 = Library.Theme["Accent"],
                    Text = "...",
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, 0, 0, 0),
                    Size = UDim2.fromOffset(0, 16),
                    BackgroundColor3 = Library.Theme["Element"],
                    BackgroundTransparency = 0.35,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    BorderSizePixel = 0,
                    ZIndex = 3,
                }):AddToTheme({TextColor3 = 'Accent', BackgroundColor3 = 'Element'})
                Library:Corner(Items["Value"], 999)
                Library:Stroke(Items["Value"], "Outline", 1, 0.5)
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Value"].Instance,
                    PaddingLeft = UDim.new(0, 7),
                    PaddingRight = UDim.new(0, 7),
                })

                Items["RealSlider"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Slider"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 1, -2),
                    Size = UDim2.new(1, 0, 0, 6),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Element"]
                }):AddToTheme({BackgroundColor3 = 'Element'})
                Library:Corner(Items["RealSlider"], 999)
                Library:Stroke(Items["RealSlider"], "Outline", 1, 0.45)

                Items["Accent"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["RealSlider"].Instance,
                    Size = UDim2.new(0.5, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Accent"]
                }):AddToTheme({BackgroundColor3 = 'Accent'})
                Library:Corner(Items["Accent"], 999)
                Library:Glow(Items["Accent"], "Accent", 2, 0.65)
                Items["Gradient"] = Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["Accent"].Instance,
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 210, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
                    })
                })

                Items["Knob"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["RealSlider"].Instance,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    Size = UDim2.fromOffset(10, 10),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(250, 252, 255),
                    ZIndex = 4,
                })
                Library:Corner(Items["Knob"], 999)
                Library:Stroke(Items["Knob"], "Accent", 1.5, 0.15)
                Library:Pop(Items["Knob"], 1.15, 1)

                Items["RealSlider"]:OnHover(function()
                    Items["RealSlider"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
                end, function()
                    Items["RealSlider"]:Tween({BackgroundColor3 = Library.Theme["Element"]})
                end)

                Slider.Items = Items 
            end

            function Slider:Set(Value)
                Slider.Value = Library:Round(math.clamp(Value, Slider.Min, Slider.Max), Slider.Decimals)

                local Percent = math.clamp((Slider.Value - Slider.Min) / math.max(Slider.Max - Slider.Min, 0.0001), 0, 1)
                local FillInfo = TweenInfo.new(Library.Animation.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

                Items["Accent"]:Tween({Size = UDim2.new(Percent, 0, 1, 0)}, FillInfo)
                Items["Knob"]:Tween({Position = UDim2.new(Percent, 0, 0.5, 0)}, FillInfo)
                Items["Value"].Instance.Text = string.format("%s%s", Slider.Value, Slider.Suffix)

                Flags[Slider.Flag] = Slider.Value
                Library:SafeCall(Slider.Callback, Slider.Value)
            end

            function Slider:SetVisibility(Bool)
                Items["Slider"].Instance.Visible = Bool
            end

            function Slider:GetSize(Input)
                local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

                return Value
            end

            function Slider:SetText(Text)
                Items["Text"].Instance.Text = tostring(Text)
            end

            local InputChanged 
            
            Items["RealSlider"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Slider.Sliding = true

                    local Value = Slider:GetSize(Input)

                    Slider:Set(Value)

                    if InputChanged then
                        return
                    end

                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Slider.Sliding = false

                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Slider.Sliding then
                        local Value = Slider:GetSize(Input)

                        Slider:Set(Value)
                    end
                end
            end)

            Slider:Set(Slider.Default)

            SetFlags[Slider.Flag] = function(Value)
                Slider:Set(Value)
            end

            return setmetatable(Slider, Library)
        end

        Library.Dropdown = function(Self, Params)
            Params = Params or { }

            local Dropdown = {
                Name = Params.Name or Params.name or "Dropdown",
                OptionItems = Params.Items or Params.items or { },
                Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
                Default = Params.Default or Params.default or "",
                Tooltip = Params.Tooltip or Params.tooltip or "",
                Callback = Params.Callback or Params.callback or function() end,
                Multi = Params.Multi or Params.multi or false,
                MaxSize = Params.MaxSize or Params.maxsize or 240,

                Window = Self.Window,
                Page = Self.Page,
                Section = Self,

                Value = { },
                Options = { },
                IsOpen = false,
                Items = { }
            }

            local Parent 

            if Params.Parent then 
                Parent = Params.Parent
            else
                Parent = Dropdown.Section.Items["Content"]
            end

            local Items = { } do 
                Items["Dropdown"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Parent.Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 40),
                    BorderSizePixel = 0
                })

                Items["Dropdown"]:Tooltip(Dropdown.Tooltip)
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Dropdown"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Dropdown.Name,
                    Size = UDim2.new(0, 0, 0, 12),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X
                }):AddToTheme({TextColor3 = 'Text'})
                
                Items["RealDropdown"] = Library:Create("TextButton", {
                    Name = "\0",
                    Parent = Items["Dropdown"].Instance,
                    Active = false,
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 1, -1),
                    Size = UDim2.new(1, 0, 0, 22),
                    Selectable = false,
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Element"]
                }):AddToTheme({BackgroundColor3 = 'Element'})
                Library:Corner(Items["RealDropdown"], 6)
                Library:Stroke(Items["RealDropdown"], "Outline", 1, 0.45)
                Library:Pop(Items["RealDropdown"], 1.01, 0.985)
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["RealDropdown"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Items["Value"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["RealDropdown"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = "...",
                    Size = UDim2.new(1, -34, 0, 13),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 7, 0.5, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    TextTruncate = Enum.TextTruncate.AtEnd
                }):AddToTheme({TextColor3 = 'Text'})
                
                Items["Line"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["RealDropdown"].Instance,
                    Position = UDim2.new(1, -28, 0, 2),
                    Size = UDim2.new(0, 1, 1, -4),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    BackgroundColor3 = Library.Theme["Outline"]
                }):AddToTheme({BackgroundColor3 = 'Outline'})
                
                Items["Icon"] = Library:Create("ImageLabel", {
                    Name = "\0",
                    Parent = Items["RealDropdown"].Instance,
                    ImageColor3 = Library.Theme["Text"],
                    AnchorPoint = Vector2.new(1, 0.5),
                    Image = "rbxassetid://88670053799869",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -7, 0.5, 0),
                    Size = UDim2.new(0, 14, 0, 14),
                    BorderSizePixel = 0
                }):AddToTheme({ImageColor3 = 'Text'})         
                
                Items["OptionHolder"] = Library:Create("ScrollingFrame", {
                    Name = "\0",
                    Parent = Library.UnusedHolder.Instance,
                    Size = UDim2.new(0, 200, 0, 0),
                    Position = UDim2.new(0, 1009, 0, 100),
                    BorderSizePixel = 0,
                    Visible = false,
                    BackgroundColor3 = Library.Theme["Inline"],
                    ClipsDescendants = true,
                    Active = true,
                    ScrollingEnabled = true,
                    ScrollingDirection = Enum.ScrollingDirection.Y,
                    ElasticBehavior = Enum.ElasticBehavior.Never,
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 3,
                    ScrollBarImageColor3 = Library.Theme["Outline"],
                    VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
                }):AddToTheme({BackgroundColor3 = 'Inline', ScrollBarImageColor3 = 'Outline'})
                Library:Corner(Items["OptionHolder"], 8)
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["OptionHolder"].Instance,
                    PaddingTop = UDim.new(0, 5),
                    PaddingBottom = UDim.new(0, 5),
                    PaddingRight = UDim.new(0, 5),
                    PaddingLeft = UDim.new(0, 5)
                })

                Dropdown.OptionLayout = Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["OptionHolder"].Instance,
                    Padding = UDim.new(0, 3),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["OptionHolder"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})

                Items["RealDropdown"]:OnHover(function()
                    Items["RealDropdown"]:Tween({BackgroundColor3 = Library.Theme["Hovered Element"]})
                end, function()
                    Items["RealDropdown"]:Tween({BackgroundColor3 = Library.Theme["Element"]})
                end)

                Dropdown.Items = Items 
            end

            Dropdown.Holder = Items["OptionHolder"]

            function Dropdown:Set(Value)
                if Dropdown.Multi then 
                    if type(Value) ~= "table" then 
                        return
                    end

                    Dropdown.Value = Value

                    for Index, Value in Value do
                        local OptionData = Dropdown.Options[Value]
                         
                        if not OptionData then
                            continue
                        end

                        OptionData.IsSelected = true 
                        OptionData:ToggleState("Active")
                    end

                    Flags[Dropdown.Flag] = Value
                    Items["Value"].Instance.Text = table.concat(Value, ", ")
                else
                    if not Dropdown.Options[Value] then
                        return
                    end

                    local OptionData = Dropdown.Options[Value]

                    Dropdown.Value = Value

                    for Index, Value in Dropdown.Options do
                        if Value ~= OptionData then
                            Value.IsSelected = false 
                            Value:ToggleState("Inactive")
                        else
                            Value.IsSelected = true 
                            Value:ToggleState("Active")
                        end
                    end

                    Flags[Dropdown.Flag] = Value
                    Items["Value"].Instance.Text = Value
                end

                Library:SafeCall(Dropdown.Callback, Dropdown.Value)
            end

            function Dropdown:Add(Value)
                local Selected = { false }
                local OptionButton = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["OptionHolder"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 22),
                    BorderSizePixel = 0
                })
                Library:Corner(OptionButton, 999)
                
                local OptionText = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = OptionButton.Instance,
                    TextColor3 = Library.Theme["Inactive Text"],
                    Text = Value,
                    Size = UDim2.new(1, -18, 1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 12, 0, 0),
                    BorderSizePixel = 0,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                }):AddToTheme({TextColor3 = 'Inactive Text'})
                
                local OptionLiner = Library:Create("Frame", {
                    Name = "\0",
                    Parent = OptionButton.Instance,
                    BackgroundTransparency = 0,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 4, 0.5, 0),
                    Size = UDim2.new(0, 3, 0, 14),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Accent"]
                }):AddToTheme({BackgroundColor3 = 'Accent'})
                Library:Corner(OptionLiner, 999)

                OptionButton:OnHover(function()
                    OptionButton:Tween({BackgroundTransparency = 0.82})
                    OptionButton.Instance.BackgroundColor3 = Library.Theme["Element"]
                    OptionText:Tween({TextColor3 = Library.Theme["Text"]})
                end, function()
                    if not Selected[1] then
                        OptionButton:Tween({BackgroundTransparency = 1})
                        OptionText:Tween({TextColor3 = Library.Theme["Inactive Text"]})
                    end
                end)

                local OptionData = {
                    Button = OptionButton,
                    Text = OptionText,
                    Liner = OptionLiner,
                    Name = Value,
                    IsSelected = false
                }
                
                function OptionData:ToggleState(Value)
                    if Value == "Active" then
                        Selected[1] = true
                        OptionText:Tween({TextColor3 = Library.Theme["Text"]})
                        OptionLiner:Tween({Size = UDim2.new(0, 3, 0, 14)})
                    else
                        Selected[1] = false
                        OptionText:Tween({TextColor3 = Library.Theme["Inactive Text"]})
                        OptionLiner:Tween({Size = UDim2.new(0, 0, 0, 14)})
                    end
                end

                function OptionData:Set()
                    OptionData.IsSelected = not OptionData.IsSelected

                    if Dropdown.Multi then 
                        local Index = table.find(Dropdown.Value, OptionData.Name)

                        if Index then 
                            table.remove(Dropdown.Value, Index)
                        else
                            table.insert(Dropdown.Value, OptionData.Name)
                        end

                        OptionData:ToggleState(Index and "Inactive" or "Active")

                        Flags[Dropdown.Flag] = Dropdown.Value

                        local TextFormat = #Dropdown.Value > 0 and table.concat(Dropdown.Value, ", ") or "..."
                        Items["Value"].Instance.Text = TextFormat
                    else
                        if OptionData.IsSelected then 
                            Dropdown.Value = OptionData.Name
                            Flags[Dropdown.Flag] = OptionData.Name

                            OptionData.IsSelected = true
                            OptionData:ToggleState("Active")

                            for Index, Value in Dropdown.Options do 
                                if Value ~= OptionData then
                                    Value.IsSelected = false 
                                    Value:ToggleState("Inactive")
                                end
                            end

                            Items["Value"].Instance.Text = OptionData.Name
                        else
                            Dropdown.Value = nil
                            Flags[Dropdown.Flag] = nil

                            OptionData.IsSelected = false
                            OptionData:ToggleState("Inactive")

                            Items["Value"].Instance.Text = "..."
                        end
                    end

                    Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                end

                OptionData.Button:Connect("MouseButton1Down", function()
                    OptionData:Set()
                end)

                Dropdown.Options[OptionData.Name] = OptionData

                if Dropdown.IsOpen and Dropdown.Fit then
                    local Height = Dropdown:Fit()
                    Items["OptionHolder"].Instance.Size = UDim2.new(0, Items["RealDropdown"].Instance.AbsoluteSize.X, 0, Height)
                end

                return OptionData
            end

            function Dropdown:Remove(Option)
                if Dropdown.Options[Option] then
                    Dropdown.Options[Option].Button.Instance:Destroy()
                    Dropdown.Options[Option] = nil

                    if Dropdown.IsOpen and Dropdown.Fit then
                        local Height = Dropdown:Fit()
                        Items["OptionHolder"].Instance.Size = UDim2.new(0, Items["RealDropdown"].Instance.AbsoluteSize.X, 0, Height)
                    end
                end
            end

            function Dropdown:Refresh(List)
                for Index, Value in Dropdown.Options do 
                    Dropdown:Remove(Value.Name)
                end

                for Index, Value in List do 
                    Dropdown:Add(Value)
                end
            end

            function Dropdown:SetText(Text)
                Items["Text"].Instance.Text = tostring(Text)
            end

            function Dropdown:SetVisibility(Bool)
                Items["Dropdown"].Instance.Visible = Bool 
            end

            local Debounce = false 
            local OptionHolder = Items["OptionHolder"].Instance
            local RealDropdown = Items["RealDropdown"].Instance

            local IsSettings = Dropdown.Section and Dropdown.Section.IsSettings

            -- the panel is a scroll frame now: cap it to the room under the field (or over it when that
            -- side is taller) and let the wheel / bar scroll whatever doesn't fit.
            function Dropdown:Fit()
                local Layout = Dropdown.OptionLayout and Dropdown.OptionLayout.Instance
                local Content = (Layout and Layout.AbsoluteContentSize.Y or 0) + 10
                local Screen = Library.Holder.Instance.AbsoluteSize.Y
                local Top = RealDropdown.AbsolutePosition.Y + GuiInset
                local FieldBottom = Top + RealDropdown.AbsoluteSize.Y
                local Below = Screen - FieldBottom - 12
                local Above = Top - 12
                local Cap = tonumber(Dropdown.MaxSize) or 240
                local Height = math.min(Content, Cap)
                local Flip = Height > Below and Above > Below
                local Room = math.max(Flip and Above or Below, 40)
                Height = math.clamp(Height, math.min(Content, 40), Room)
                local TargetY = Flip and math.max(Top - Height - 6, 6) or (FieldBottom + 6)
                TargetY = math.clamp(TargetY, 6, math.max(Screen - Height - 6, 6))
                return Height, TargetY, Flip
            end

            function Dropdown:SetOpen(Bool)
                if Debounce then 
                    return 
                end

                Dropdown.IsOpen = Bool

                Debounce = true 
                
                if Dropdown.IsOpen then 
                    local Height, TargetY, Flip = Dropdown:Fit()
                    Dropdown.PanelY = TargetY
                    Dropdown.PanelFlip = Flip

                    Items["Icon"]:Tween({Rotation = -90})
                    OptionHolder.Size = UDim2.new(0, RealDropdown.AbsoluteSize.X, 0, Height)
                    OptionHolder.CanvasPosition = Vector2.new(0, 0)

                    OptionHolder.Parent = Library.Holder.Instance
                    OptionHolder.Position = UDim2.new(0, RealDropdown.AbsolutePosition.X, 0, TargetY + (Flip and -10 or 10))
                    Items["OptionHolder"]:Tween({Position = UDim2.new(0, RealDropdown.AbsolutePosition.X, 0, TargetY)})
                    
                    Items["OptionHolder"]:FadeDescendants(true, function()
                        Debounce = false 
                    end)

                    for Index, Value in Library.OpenFrames do 
                        if Value ~= IsSettings and not Params.Parent then
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Dropdown] = Dropdown 
                else
                    local TargetY = Dropdown.PanelY or (RealDropdown.AbsolutePosition.Y + RealDropdown.AbsoluteSize.Y + GuiInset)
                    local Flip = Dropdown.PanelFlip
                    Items["Icon"]:Tween({Rotation = 0})
                    Items["OptionHolder"]:Tween({Position = UDim2.new(0, RealDropdown.AbsolutePosition.X, 0, TargetY + (Flip and 10 or -10))})
                    Items["OptionHolder"]:FadeDescendants(false, function()
                        OptionHolder.Parent = Library.UnusedHolder.Instance
                        Debounce = false
                    end)

                    if Library.OpenFrames[Dropdown] then 
                        Library.OpenFrames[Dropdown] = nil
                    end
                end

                local Descendants = OptionHolder:GetDescendants()
                table.insert(Descendants, OptionHolder)

                for Index, Value in Descendants do 
                    if Value.ClassName:find("UI") then
                        continue
                    end

                    if not Params.Parent then
                        Value.ZIndex = Dropdown.IsOpen and Library.ZIndexOrder.OptionHolder or 1
                    else
                        Value.ZIndex = Dropdown.IsOpen and Library.ZIndexOrder.OptionHolder + 3 or 1
                    end
                end
            end

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if Dropdown.IsOpen and not Items["OptionHolder"]:IsMouseOverFrame() then
                        Dropdown:SetOpen(false)
                    end
                end
            end)

            Items["RealDropdown"]:Connect("MouseButton1Down", function()
                Dropdown:SetOpen(not Dropdown.IsOpen)
            end)

            for Index, Value in Dropdown.OptionItems do 
                Dropdown:Add(Value)
            end

            Dropdown:Set(Dropdown.Default)

            SetFlags[Dropdown.Flag] = function(Value)
                Dropdown:Set(Value)
            end

            return setmetatable(Dropdown, Library)
        end

        Library.Label = function(Self, Params)
            Params = Params or { }

            local Label = {
                Name = Params.Name or Params.name or "Label",
                Tooltip = Params.Tooltip or Params.tooltip or "",

                Window = Self.Window,
                Page = Self.Page,
                Section = Self,

                Items = { }
            }

            local Parent 

            if Params.Parent then 
                Parent = Params.Parent
            else
                Parent = Label.Section.Items["Content"]
            end

            local Items = { } do 
                Items["Label"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Parent.Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 20),
                    BorderSizePixel = 0
                })

                Items["Label"]:Tooltip(Label.Tooltip)
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Label"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Label.Name,
                    Size = UDim2.new(1, -92, 1, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    BorderSizePixel = 0,
                }):AddToTheme({TextColor3 = 'Text'})
                
                Items["SubElements"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Label"].Instance,
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, 0, 0.5, 0),
                    Size = UDim2.new(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X
                })
                
                Library:Create("UIListLayout", {
                    Name = "\0",
                    Parent = Items["SubElements"].Instance,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    Padding = UDim.new(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })                

                Label.Items = Items 
            end

            function Label:SetVisibility(Bool)
                Items["Label"].Instance.Visible = Bool 
            end

            function Label:SetText(Text)
                Items["Text"].Instance.Text = tostring(Text)
            end

            function Label:Colorpicker(Data)
                Data = Data or { }

                local Colorpicker = {
                    Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Label.Name),
                    Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                    Callback = Data.Callback or Data.callback or function() end,
                    Alpha = Data.Alpha or Data.alpha or 0,

                    Window = Label.Window,
                    Page = Label.Page,
                    Section = Label.Section,
                }

                local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
                    Parent = Items["SubElements"],
                    Page = Colorpicker.Page,
                    Section = Colorpicker.Section,
                    Flag = Colorpicker.Flag,
                    Default = Colorpicker.Default,
                    Callback = Colorpicker.Callback,
                    Alpha = Colorpicker.Alpha
                })

                return NewColorpicker
            end

            function Label:Keybind(Data)
                Data = Data or { }

                local Keybind = {
                    Name = Data.Name or Data.name or Label.Name,
                    Flag = Data.Flag or Data.flag or (Data.Name or Data.name or Label.Name),
                    Default = Data.Default or Data.default or Enum.KeyCode.E,
                    Callback = Data.Callback or Data.callback or function() end,
                    Mode = Data.Mode or Data.mode or "Toggle",

                    Window = Label.Window,
                    Page = Label.Page,
                    Section = Label.Section,
                }

                local NewKeybind, KeybindItems = Library:CreateKeybind({
                    Parent = Items["SubElements"],
                    Name = Keybind.Name,
                    Page = Keybind.Page,
                    Section = Keybind.Section,
                    Flag = Keybind.Flag,
                    Default = Keybind.Default,
                    Mode = Keybind.Mode,
                    Callback = Keybind.Callback
                })

                return NewKeybind
            end

            Label:SetText(Label.Name)

            return setmetatable(Label, Library)
        end

        Library.Paragraph = function(Self, Params)
            Params = Params or { }

            local Paragraph = {
                Name = Params.Name or Params.name or "Paragraph",
                Description = Params.Description or Params.description or "",
                Tooltip = Params.Tooltip or Params.tooltip or "",

                Window = Self.Window,
                Page = Self.Page,
                Section = Self,

                Items = { }
            }

            local Items = { } do 
                Items["Paragraph"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Paragraph.Section.Items["Content"].Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 15),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y
                })

                Items["Paragraph"]:Tooltip(Paragraph.Tooltip)
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Paragraph"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Paragraph.Name,
                    Size = UDim2.new(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X
                }):AddToTheme({TextColor3 = 'Text'})
                
                Items["Description"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Paragraph"].Instance,
                    TextColor3 = Library.Theme["Inactive Text"],
                    Text = Paragraph.Description,
                    Size = UDim2.new(1, 0, 0, 15),
                    Position = UDim2.new(0, 0, 0, 20),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    TextWrapped = true
                }):AddToTheme({TextColor3 = 'Inactive Text'})                

                Paragraph.Items = Items
            end 

            function Paragraph:SetDescription(Text)
                Items["Description"].Instance.Text = Text
            end

            function Paragraph:SetText(Text)
                Items["Text"].Instance.Text = Text
            end

            function Paragraph:SetVisibility(Bool)
                Items["Paragraph"].Instance.Visible = Bool
            end

            return setmetatable(Paragraph, Library)
        end

        Library.Divider = function(Self, Name)
            local Items = { } do
                Items["Divider"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Self.Items["Content"].Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 15),
                    BorderSizePixel = 0
                })
                
                Items["RealDivider"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Divider"].Instance,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    Size = UDim2.new(1, 0, 0, 3),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Element"]
                }):AddToTheme({BackgroundColor3 = 'Element'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["RealDivider"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["RealDivider"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145))
                }
                })
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.BoldFont,
                    TextSize = Library.FontSize,
                    Parent = Items["Divider"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Name,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Size = UDim2.new(0, 0, 0, 15),
                    Position = UDim2.new(0.5, 0, 0.5, -1),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = Library.Theme["Background"]
                }):AddToTheme({BackgroundColor3 = 'Background'})
                
                Library:Create("UIPadding", {
                    Name = "\0",
                    Parent = Items["Text"].Instance,
                    PaddingRight = UDim.new(0, 10),
                    PaddingLeft = UDim.new(0, 10)
                })                
            end

            return Items
        end

        Library.Textbox = function(Self, Params)
            Params = Params or { }

            local Textbox = {
                Name = Params.Name or Params.name or "Textbox",
                Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
                Default = Params.Default or Params.default or "",
                Callback = Params.Callback or Params.callback or function() end,
                Finished = Params.Finished or Params.finished or false,
                Placeholder = Params.Placeholder or Params.placeholder or "",
                Tooltip = Params.Tooltip or Params.tooltip or "",
                Numeric = Params.Numeric or Params.numeric or false,

                Window = Self.Window,
                Page = Self.Page,
                Section = Self,
                Value = "",

                Items = { },
            }

            local Parent 

            if Params.Parent then 
                Parent = Params.Parent
            else
                Parent = Textbox.Section.Items["Content"]
            end

            local Items = { } do 
                Items["Textbox"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Parent.Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 25),
                    BorderSizePixel = 0
                })

                Items["Textbox"]:Tooltip(Textbox.Tooltip)
                
                Items["Background"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Textbox"].Instance,
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Element"]
                }):AddToTheme({BackgroundColor3 = 'Element'})
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["Background"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145))
                }
                })
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Background"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Items["Input"] = Library:Create("TextBox", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["Background"].Instance,
                    Active = false,
                    Selectable = false,
                    AnchorPoint = Vector2.new(0, 0.5),
                    PlaceholderColor3 = Library.Theme["Inactive Text"],
                    PlaceholderText = Textbox.Placeholder,
                    Size = UDim2.new(1, -40, 0, 15),
                    TextColor3 = Library.Theme["Text"],
                    Text = "",
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2.new(0, 8, 0.5, 0),
                    BorderSizePixel = 0,
                    TextTruncate = Enum.TextTruncate.AtEnd
                }):AddToTheme({TextColor3 = 'Text', PlaceholderColor3 = 'Inactive Text'})
                
                Items["Line"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Background"].Instance,
                    Position = UDim2.new(1, -28, 0, 2),
                    Size = UDim2.new(0, 1, 1, -4),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Outline"]
                }):AddToTheme({BackgroundColor3 = 'Outline'})
                
                Items["Icon"] = Library:Create("ImageLabel", {
                    Name = "\0",
                    Parent = Items["Background"].Instance,
                    ImageColor3 = Library.Theme["Text"],
                    AnchorPoint = Vector2.new(1, 0.5),
                    Image = "rbxassetid://98091773290646",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -5, 0.5, 0),
                    Size = UDim2.new(0, 14, 0, 14),
                    BorderSizePixel = 0
                }):AddToTheme({ImageColor3 = 'Text'})                

                Textbox.Items = Items
            end

            function Textbox:SetVisibility(Bool)
                Items["Textbox"].Instance.Visible = Bool
            end

            function Textbox:SetText(Text)
                Items["Text"].Instance.Text = tostring(Text)
            end

            function Textbox:Set(Value)
                if Textbox.Numeric then
                    if (not tonumber(Value)) and string.len(tostring(Value)) > 0 then
                        Value = Textbox.Value
                    end
                end

                Textbox.Value = Value
                Items["Input"].Instance.Text = Value
                Flags[Textbox.Flag] = Value

                Library:SafeCall(Textbox.Callback, Value)
            end

            Items["Input"]:Connect("FocusLost", function(PressedEnterQuestionMark)
                Items["Icon"]:ChangeItemTheme({ImageColor3 = "Text"})
                Items["Icon"]:Tween({ImageColor3 = Library.Theme.Text})

                if PressedEnterQuestionMark and Textbox.Finished then 
                    Textbox:Set(Items["Input"].Instance.Text)
                end
            end)

            Items["Input"]:Connect("Focused", function()
                Items["Icon"]:ChangeItemTheme({ImageColor3 = "Accent"})
                Items["Icon"]:Tween({ImageColor3 = Library.Theme.Accent})
            end)

            if not Textbox.Finished then 
                Library:Connect(Items["Input"].Instance:GetPropertyChangedSignal("Text"), function()
                    Textbox:Set(Items["Input"].Instance.Text)
                end)
            end

            Textbox:Set(Textbox.Default)

            SetFlags[Textbox.Flag] = function(Value)
                Textbox:Set(Value)
            end
            
            return setmetatable(Textbox, Library)
        end

        Library.RangeSlider = function(Self, Params)
            Params = Params or { }

            local Slider = {
                Name = Params.Name or Params.name or "Slider",
                Flag = Params.Flag or Params.flag or (Params.Name or Params.name),
                Default = Params.Default or Params.default or {0, 100},
                Min = Params.Min or Params.min or 0,
                Max = Params.Max or Params.max or 100,
                Callback = Params.Callback or Params.callback or function() end,
                Tooltip = Params.Tooltip or Params.tooltip or "",
                Decimals = Params.Decimals or Params.decimals or 0,
                Suffix = Params.Suffix or Params.suffix or "",

                Window = Self.Window,
                Page = Self.Page,
                Section = Self,

                Value = { },
                Sliding = false,
                Items = { }
            }

            local Parent 

            if Params.Parent then 
                Parent = Params.Parent
            else
                Parent = Slider.Section.Items["Content"]
            end

            local Items = { } do 
                Items["RangeSlider"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Parent.Instance,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 35),
                    BorderSizePixel = 0
                })

                Items["RangeSlider"]:Tooltip(Slider.Tooltip)
                
                Items["Text"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["RangeSlider"].Instance,
                    TextColor3 = Library.Theme["Text"],
                    Text = Slider.Name,
                    Size = UDim2.new(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X
                }):AddToTheme({TextColor3 = 'Text'})
                
                Items["RealSlider"] = Library:Create("TextButton", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["RangeSlider"].Instance,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 1, 0),
                    Size = UDim2.new(1, 0, 0, 12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Element"]
                }):AddToTheme({BackgroundColor3 = 'Element'})
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["RealSlider"].Instance,
                    Rotation = 90,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145))
                }
                })
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["RealSlider"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Items["Accent"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["RealSlider"].Instance,
                    Position = UDim2.new(0, 50, 0, 0),
                    Size = UDim2.new(0.5, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Theme["Accent"]
                }):AddToTheme({BackgroundColor3 = 'Accent'})
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["Accent"].Instance,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145))
                }
                })
                
                Items["Value"] = Library:Create("TextLabel", {
                    Name = "\0",
                    FontFace = Library.Font,
                    TextSize = Library.FontSize,
                    Parent = Items["RealSlider"].Instance,
                    TextColor3 = Library.Theme["Inactive Text"],
                    Text = "30 - 70",
                    Size = UDim2.new(0, 0, 0, 15),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, -1),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 55,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X
                }):AddToTheme({TextColor3 = 'Inactive Text'})
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Value"].Instance,
                    LineJoinMode = Enum.LineJoinMode.Miter
                })
                
                Items["Max"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Accent"].Instance,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, 2, 0.5, 0),
                    Size = UDim2.new(0, 4, 1, 2),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                })
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["Max"].Instance,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145))
                }
                })
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Max"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})
                
                Items["Min"] = Library:Create("Frame", {
                    Name = "\0",
                    Parent = Items["Accent"].Instance,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, -2, 0.5, 0),
                    Size = UDim2.new(0, 4, 1, 2),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                })
                
                Library:Create("UIGradient", {
                    Name = "\0",
                    Parent = Items["Min"].Instance,
                    Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 145, 145))
                }
                })
                
                Library:Create("UIStroke", {
                    Name = "\0",
                    Parent = Items["Min"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    Color = Library.Theme["Outline"]
                }):AddToTheme({Color = 'Outline'})                

                Slider.Items = Items 
            end

            function Slider:Set(MinValue, MaxValue)
                if typeof(MinValue) == "table" then
                    MinValue, MaxValue = MinValue[1], MinValue[2]
                end
            
                MinValue = Library:Round(math.clamp(MinValue, Slider.Min, Slider.Max), Slider.Decimals)
                MaxValue = Library:Round(math.clamp(MaxValue, Slider.Min, Slider.Max), Slider.Decimals)
            
                if MinValue > MaxValue then
                    MinValue, MaxValue = MaxValue, MinValue
                end
            
                MinValue = Library:Round(math.clamp(MinValue, Slider.Min, Slider.Max), Slider.Decimals)
                MaxValue = Library:Round(math.clamp(MaxValue, Slider.Min, Slider.Max), Slider.Decimals)
            
                Slider.Value = { MinValue, MaxValue }
                Flags[Slider.Flag] = Slider.Value
            
                local MinPCT = (MinValue - Slider.Min) / (Slider.Max - Slider.Min)
                local MaxPCT = (MaxValue - Slider.Min) / (Slider.Max - Slider.Min)
            
                Items["Accent"]:Tween({Position = UDim2.fromScale(MinPCT, 0), Size = UDim2.fromScale(MaxPCT - MinPCT, 1)}, TweenInfo.new(Library.Animation.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
            
                Items["Min"].Instance.Position = UDim2.fromScale(0, 0.5)
                Items["Max"].Instance.Position = UDim2.fromScale(1, 0.5)

                Items["Value"].Instance.Text = string.format("%s - %s%s", MinValue, MaxValue, Slider.Suffix)
            
                if Slider.Callback then
                    Library:SafeCall(Slider.Callback, Slider.Value)
                end
            end

            function Slider:StartDrag(Handle)
                Slider.SlidingHandle = Handle 
            end

            function Slider:StopDrag()
                Slider.SlidingHandle = nil
            end

            function Slider:SetVisibility(Bool)
                Items["Slider"].Instance.Visible = Bool
            end

            function Slider:SetText(Text)
                Items["Text"].Instance.Text = tostring(Text)
            end

            Items["Min"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Slider:StartDrag(Items["Min"])
                end
            end)

            Items["Max"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Slider:StartDrag(Items["Max"])
                end
            end)

            Library:Connect(UserInputService.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    if Slider.SlidingHandle then
                        Slider:StopDrag()
                    end
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) and Slider.SlidingHandle then
                    local MouseX = Input.Position.X
                    local BarX = Items["RealSlider"].Instance.AbsolutePosition.X
                    local BarW = Items["RealSlider"].Instance.AbsoluteSize.X
            
                    local Scale = math.clamp((MouseX - BarX) / BarW, 0, 1)
                    local Value = Library:Round(
                        (Scale * (Slider.Max - Slider.Min)) + Slider.Min,
                        Slider.Decimals
                    )
            
                    if Slider.SlidingHandle == Items["Min"] then
                        Slider:Set(Value, Slider.Value[2])
                    else
                        Slider:Set(Slider.Value[1], Value)
                    end
                end
            end) 

            Slider:Set(Slider.Default[1], Slider.Default[2])

            SetFlags[Slider.Flag] = function(Value)
                Slider:Set(Value)
            end

            return setmetatable(Slider, Library)
        end

        Library.InitWindow = function(Self)
            local SettingsPage = Self:Page({Name = "Settings"})

            local GeneralSubPage = SettingsPage:SubPage({Name = "General"})

            local ConfigsSection = GeneralSubPage:Section({Name = "configs", Side = 1})
            local UISettingsSection = GeneralSubPage:Section({Name = "ui settings", Side = 1})
            local ThemesSection = GeneralSubPage:Section({Name = "themes", Side = 2})

            local ConfigsFolder = Library.Directory .. Library.Folders.Configs .. "/"
            local ThemesFolder = Library.Directory .. Library.Folders.Themes .. "/"
            local RefreshAutoloadLabel

            do 
                local ConfigName 
                local ConfigSelected 

                local ConfigsDropdown = ConfigsSection:Dropdown({
                    Name = "Configs",
                    Flag = "ConfigsDropdown",
                    Items = { },
                    Multi = false,
                    Callback = function(Value)
                        ConfigSelected = Value 
                    end
                })

                ConfigsSection:Textbox({
                    Name = "Config name",
                    Flag = "ConfigName",
                    Placeholder = "Config name",
                    Callback = function(Value)
                        ConfigName = Value 
                    end
                })

                ConfigsSection:Button():Add("Create", function()
                    if not ConfigName or ConfigName == "" then 
                        Library:Notification("Config name can't be empty", 3, Color3.fromRGB(255, 0, 0))
                        return
                    end

                    writefile(ConfigsFolder .. ConfigName .. ".json", Library:GetConfig())
                    Library:GetConfigsList(ConfigsDropdown)
                    Library:Notification("Succesfully created config", 3, Color3.fromRGB(0, 255, 0))
                end):Add("Delete", function()
                    if not ConfigSelected then 
                        Library:Notification("No config selected", 3, Color3.fromRGB(255, 0, 0))
                        return
                    end

                    if isfile(ConfigsFolder .. ConfigSelected .. ".json") then
                        delfile(ConfigsFolder .. ConfigSelected .. ".json")

                        if Library:GetAutoload() == ConfigSelected then
                            Library:SetAutoload("")
                            if RefreshAutoloadLabel then
                                RefreshAutoloadLabel()
                            end
                        end

                        Library:GetConfigsList(ConfigsDropdown)
                        Library:Notification("Succesfully deleted config", 3, Color3.fromRGB(0, 255, 0))
                    end
                end)

                ConfigsSection:Button():Add("Load", function()
                    if not ConfigSelected then 
                        Library:Notification("No config selected", 3, Color3.fromRGB(255, 0, 0))
                        return
                    end

                    if isfile(ConfigsFolder .. ConfigSelected .. ".json") then
                        local Success, Error = Library:LoadConfig(readfile(ConfigsFolder .. ConfigSelected .. ".json"))

                        if Success then 
                            Library:Notification("Succesfully loaded config", 3, Color3.fromRGB(0, 255, 0))
                        else
                            Library:Notification("Failed to load config: \n" .. Error, 3, Color3.fromRGB(255, 0, 0))
                        end
                    end
                end):Add("Save", function()
                    if not ConfigSelected then
                        Library:Notification("No config selected", 3, Color3.fromRGB(255, 0, 0))
                        return
                    end

                    if isfile(ConfigsFolder .. ConfigSelected .. ".json") then
                        local Success, Error = Library:SafeCall(function()
                            writefile(ConfigsFolder .. ConfigSelected .. ".json", Library:GetConfig())
                        end)

                        if Success then 
                            Library:Notification("Succesfully saved config", 3, Color3.fromRGB(0, 255, 0))
                        else
                            Library:Notification("Failed to save config: \n" .. Error, 3, Color3.fromRGB(255, 0, 0))
                        end
                    end
                end)

                ConfigsSection:Button():Add("Refresh", function()
                    Library:GetConfigsList(ConfigsDropdown)
                end)

                local AutoloadLabel = ConfigsSection:Label({Name = "Autoload: None"})

                RefreshAutoloadLabel = function()
                    local Name = Library:GetAutoload()
                    AutoloadLabel:SetText(Name ~= "" and ("Autoload: " .. Name) or "Autoload: None")
                end

                ConfigsSection:Button():Add("Set Autoload", function()
                    if not ConfigSelected or ConfigSelected == "" then
                        Library:Notification("No config selected", 3, Color3.fromRGB(255, 0, 0))
                        return
                    end

                    if not isfile(ConfigsFolder .. ConfigSelected .. ".json") then
                        Library:Notification("Config does not exist", 3, Color3.fromRGB(255, 0, 0))
                        return
                    end

                    Library:SetAutoload(ConfigSelected)
                    RefreshAutoloadLabel()
                    Library:Notification('Set "' .. ConfigSelected .. '" as autoload', 3, Color3.fromRGB(0, 255, 0))
                end):Add("Clear Autoload", function()
                    Library:SetAutoload("")
                    RefreshAutoloadLabel()
                    Library:Notification("Cleared autoload", 3, Color3.fromRGB(0, 255, 0))
                end)

                Library:GetConfigsList(ConfigsDropdown)
                RefreshAutoloadLabel()
            end

            do
                UISettingsSection:Dropdown({
                    Name = "Menu font",
                    Flag = "MenuFont",
                    Items = Library.FontNames,
                    Default = "Purrfect",
                    Callback = function(Value)
                        local Ok, Err = pcall(function()
                            Library:ApplyMenuFont(Value)
                        end)
                        if not Ok then
                            Library:Notification("font failed: " .. tostring(Err), 3, Color3.fromRGB(255, 80, 80))
                        end
                    end,
                })

                UISettingsSection:Label({Name = "Menu Bind"}):Keybind({
                    Flag = "MenuBind",
                    Mode = "Toggle",
                    Default = Enum.KeyCode.RightShift,
                    Callback = function()
                        Library.MenuKeybind = Flags["MenuBind"].Key
                    end
                })

                UISettingsSection:Toggle({
                    Name = "Show Keybind List",
                    Flag = "ShowKeybindList",
                    Default = true,
                    Callback = function(Value)
                        if Library.KeyList then
                            Library.KeyList:SetVisibility(Value)
                        end
                    end
                })

                UISettingsSection:Toggle({
                    Name = "Show Active List",
                    Flag = "ShowActiveList",
                    Default = true,
                    Callback = function(Value)
                        if Library.ActiveList then
                            Library.ActiveList:SetVisibility(Value)
                        end
                    end
                })

                UISettingsSection:Toggle({
                    Name = "Show Watermark",
                    Flag = "ShowWatermark",
                    Default = true,
                    Callback = function(Value)
                        local WatermarkObject = Self.WatermarkObject or Library.WatermarkObject

                        if WatermarkObject then
                            WatermarkObject:SetVisibility(Value)
                        end
                    end
                })

                UISettingsSection:Button():Add("Unload", function()
                    Library:Exit()
                end)
            end

            do
                local ThemeName
                local ThemeSelected

                ThemesSection:Dropdown({
                    Name = "Preset",
                    Flag = "ThemePreset",
                    Items = Library.ThemeOrder,
                    Default = "Default",
                    Multi = false,
                    Callback = function(Value)
                        if not Library:ApplyTheme(Value) then
                            Library:Notification("Failed to apply theme", 3, Color3.fromRGB(255, 0, 0))
                        end
                    end
                })

                for Index, Value in Library.Theme do 
                    ThemesSection:Label({Name = Index})
                    :Colorpicker({Flag = "Theme" .. Index, Default = Value, Callback = function(Color)
                        Library.Theme[Index] = Color
                        Library:ChangeTheme(Index, Color)
                    end})
                end

                ThemesSection:Divider("saved themes")

                local ThemesDropdown = ThemesSection:Dropdown({
                    Name = "Themes",
                    Flag = "ThemesDropdown",
                    Items = { },
                    Multi = false,
                    Callback = function(Value)
                        ThemeSelected = Value
                    end
                })

                ThemesSection:Textbox({
                    Name = "Theme name",
                    Flag = "ThemeName",
                    Placeholder = "Theme name",
                    Callback = function(Value)
                        ThemeName = Value
                    end
                })

                ThemesSection:Button():Add("Create", function()
                    if not ThemeName or ThemeName == "" then
                        Library:Notification("Theme name can't be empty", 3, Color3.fromRGB(255, 0, 0))
                        return
                    end

                    writefile(ThemesFolder .. ThemeName .. ".json", Library:GetTheme())
                    Library:GetThemesList(ThemesDropdown)
                    Library:Notification("Succesfully created theme", 3, Color3.fromRGB(0, 255, 0))
                end):Add("Delete", function()
                    if not ThemeSelected then
                        Library:Notification("No theme selected", 3, Color3.fromRGB(255, 0, 0))
                        return
                    end

                    if isfile(ThemesFolder .. ThemeSelected .. ".json") then
                        delfile(ThemesFolder .. ThemeSelected .. ".json")
                        Library:GetThemesList(ThemesDropdown)
                        Library:Notification("Succesfully deleted theme", 3, Color3.fromRGB(0, 255, 0))
                    end
                end)

                ThemesSection:Button():Add("Load", function()
                    if not ThemeSelected then
                        Library:Notification("No theme selected", 3, Color3.fromRGB(255, 0, 0))
                        return
                    end

                    if isfile(ThemesFolder .. ThemeSelected .. ".json") then
                        local Success, Error = Library:LoadTheme(readfile(ThemesFolder .. ThemeSelected .. ".json"))

                        if Success then
                            Library:Notification("Succesfully loaded theme", 3, Color3.fromRGB(0, 255, 0))
                        else
                            Library:Notification("Failed to load theme: \n" .. Error, 3, Color3.fromRGB(255, 0, 0))
                        end
                    end
                end):Add("Save", function()
                    if not ThemeSelected then
                        Library:Notification("No theme selected", 3, Color3.fromRGB(255, 0, 0))
                        return
                    end

                    if isfile(ThemesFolder .. ThemeSelected .. ".json") then
                        local Success, Error = Library:SafeCall(function()
                            writefile(ThemesFolder .. ThemeSelected .. ".json", Library:GetTheme())
                        end)

                        if Success then
                            Library:Notification("Succesfully saved theme", 3, Color3.fromRGB(0, 255, 0))
                        else
                            Library:Notification("Failed to save theme: \n" .. Error, 3, Color3.fromRGB(255, 0, 0))
                        end
                    end
                end)

                ThemesSection:Button():Add("Refresh", function()
                    Library:GetThemesList(ThemesDropdown)
                end)

                Library:GetThemesList(ThemesDropdown)
            end

            Library:Thread(function()
                local Success, Result = Library:LoadAutoload()

                if Success then
                    Library:Notification('Autoloaded config "' .. Result .. '"', 3, Color3.fromRGB(0, 255, 0))
                elseif Result == "missing" then
                    Library:Notification('Autoload config is missing', 3, Color3.fromRGB(255, 0, 0))
                elseif Result ~= "none" then
                    Library:Notification("Failed to autoload: \n" .. tostring(Result), 3, Color3.fromRGB(255, 0, 0))
                end
            end)
        end
    end
end

getgenv().Library = Library 
return Library