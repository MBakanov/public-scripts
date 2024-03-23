script_author('JustFedot')
script_name('[JF] Taxes')
script_version('1.0.0')

require("moonloader")
require ("sampfuncs")
local sampev = require("samp.events")
local effil = require("effil")
local encoding = require("encoding")
encoding.default = 'CP1251'
u8 = encoding.UTF8
local imgui = require("imgui")
local f = require 'moonloader'.font_flag
local font = renderCreateFont('Trebuchet MS', 10, f.BOLD + f.SHADOW)

function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2
 
     style.WindowPadding = ImVec2(15, 15)
     style.WindowRounding = 15.0
     style.FramePadding = ImVec2(5, 5)
     style.ItemSpacing = ImVec2(12, 8)
     style.ItemInnerSpacing = ImVec2(8, 6)
     style.IndentSpacing = 25.0
     style.ScrollbarSize = 15.0
     style.ScrollbarRounding = 15.0
     style.GrabMinSize = 15.0
     style.GrabRounding = 7.0
     style.ChildWindowRounding = 8.0
     style.FrameRounding = 6.0
   
 
       colors[clr.Text] = ImVec4(0.95, 0.96, 0.98, 1.00)
       colors[clr.TextDisabled] = ImVec4(0.36, 0.42, 0.47, 1.00)
       colors[clr.WindowBg] = ImVec4(0.11, 0.15, 0.17, 1.00)
       colors[clr.ChildWindowBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
       colors[clr.PopupBg] = ImVec4(0.08, 0.08, 0.08, 0.94)
       colors[clr.Border] = ImVec4(0.43, 0.43, 0.50, 0.50)
       colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
       colors[clr.FrameBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
       colors[clr.FrameBgHovered] = ImVec4(0.12, 0.20, 0.28, 1.00)
       colors[clr.FrameBgActive] = ImVec4(0.09, 0.12, 0.14, 1.00)
       colors[clr.TitleBg] = ImVec4(0.09, 0.12, 0.14, 0.65)
       colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
       colors[clr.TitleBgActive] = ImVec4(0.08, 0.10, 0.12, 1.00)
       colors[clr.MenuBarBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
       colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.39)
       colors[clr.ScrollbarGrab] = ImVec4(0.20, 0.25, 0.29, 1.00)
       colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
       colors[clr.ScrollbarGrabActive] = ImVec4(0.09, 0.21, 0.31, 1.00)
       colors[clr.ComboBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
       colors[clr.CheckMark] = ImVec4(0.28, 0.56, 1.00, 1.00)
       colors[clr.SliderGrab] = ImVec4(0.28, 0.56, 1.00, 1.00)
       colors[clr.SliderGrabActive] = ImVec4(0.37, 0.61, 1.00, 1.00)
       colors[clr.Button] = ImVec4(0.20, 0.25, 0.29, 1.00)
       colors[clr.ButtonHovered] = ImVec4(0.28, 0.56, 1.00, 1.00)
       colors[clr.ButtonActive] = ImVec4(0.06, 0.53, 0.98, 1.00)
       colors[clr.Header] = ImVec4(0.20, 0.25, 0.29, 0.55)
       colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.80)
       colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
       colors[clr.ResizeGrip] = ImVec4(0.26, 0.59, 0.98, 0.25)
       colors[clr.ResizeGripHovered] = ImVec4(0.26, 0.59, 0.98, 0.67)
       colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
       colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
       colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
       colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
       colors[clr.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00)
       colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
       colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
       colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
       colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
       colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end
apply_custom_style()

do -- Xcfg Modified
    Xcfg = {
        _version    = 2.1,
        _author     = "Double Tap Inside",
        _modified   = "JustFedot",
        _email      = "double.tap.inside@gmail.com",
        _help = [[
            Module xcfg             = Xcfg()
            Создает и возвращает новый экземпляр модуля Xcfg.
    
            nil                     = xcfg.mkpath(Str filename)
            Создает необходимые директории для указанного пути файла.
    
            Table loaded / nil      = xcfg.load(Str filename, [Bool save = false])
            Загружает конфигурационный файл. Если 'save' установлено в true, автоматически сохраняет файл после загрузки.
    
            Bool result             = xcfg.save(Str filename, Table new)
            Сохраняет данные в конфигурационный файл.
    
            Bool result             = xcfg.insert(Str filename, (Value value or Int index), [Value value])
            Вставляет значение в конфигурационный файл. Если указан индекс, вставляет по индексу.
    
            Bool result             = xcfg.remove(Str filename, [Int index])
            Удаляет значение из конфигурационного файла. Если указан индекс, удаляет значение по индексу.
    
            Bool result             = xcfg.set(Str filename, (Int index or Str key), Value value)
            Устанавливает или обновляет значение в конфигурационном файле по ключу или индексу.
    
            Bool result             = xcfg.update(Table old, (Table new or StrFilename new), [Bool overwrite = true])
            Обновляет старую таблицу новыми значениями из другой таблицы или файла. 'overwrite' определяет, перезаписывать ли существующие значения.
    
            Bool result             = xcfg.write(Str filename, Str str)
            Пишет строку в файл, перезаписывая его содержимое.
    
            Bool result             = xcfg.append(Str filename, Str str)
            Добавляет строку в конец файла.
    
            Table                   = xcfg.setupImcfg(Table cfg)
            Создает и возвращает таблицу с элементами управления imgui на основе конфигурационной таблицы 'cfg'. Поддерживает различные типы данных, включая вложенные таблицы.
        ]]
    }
	function Xcfg.__init()
		local self = {}
		
		-- draw values
		local function draw_string(str)
			return string.format("%q", str)
		end
		
		local function is_var(key_or_index)
			if type(key_or_index) == "string" and key_or_index:match("^[_%a][_%a%d]*$") then
				return true
			
			else
				return false
			end
		end
		
		local function draw_table_key(key)
			if is_var(key) then
				return key
				
			else
				return "["..draw_key(key).."]"
			end
		end
		
		local function draw_table(tbl, tab)
			local tab = tab or ""
			local result = {}
			
			for key, value in pairs(tbl) do
				if type(value) == "string" then
					if type(key) == "number" and key <= #tbl then
						table.insert(result, draw_string(value))
						
					else
						table.insert(result, draw_table_key(key).." = "..draw_string(value))
					end
					
				elseif type(value) == "number" or type(value) == "boolean" then
					if type(key) == "number" and key <= #tbl then
						table.insert(result, tostring(value))
						
					else
						table.insert(result, draw_table_key(key).." = "..tostring(value))
					end
				
				elseif type(value) == "table" then
					if type(key) == "number" and key <= #tbl then
						table.insert(result, draw_table(value, tab.."\t"))
						
					else
						table.insert(result, draw_table_key(key).." = "..draw_table(value, tab.."\t"))
					end
					
				else
					if type(key) == "number" and key <= #tbl then
						table.insert(result, draw_string(tostring(value)))
						
					else
						table.insert(result, draw_table_key(key).." = "..draw_string(tostring(value)))
					end
				end
			end
			
			if #result == 0 and tab == "" then
				return ""
				
			elseif #result == 0 then
				return "{}"
			
			elseif tab == "" then
				return table.concat(result, ",\n")..",\n"
			
			else
				return "{\n"..tab..table.concat(result, ",\n"..tab)..",\n"..tab:sub(2).."}"
			end       
		end
		
		local function draw_value(value, tab)
			if type(value) == "string" then
				return draw_string(value)
			
			elseif type(value) == "number" or type(value) == "boolean" or type(value) == "nil" then
				return tostring(value)
			
			elseif type(value) == "table" then
				return draw_table(value, tab)
				
			else
				return draw_string(tostring(value))
			end
		end
		
		local function draw_key(key)
			if "string" == type(key) then
				return draw_string(key)
			
			elseif "number" == type(key) then
				return tostring(key)
			end
		end
		
		
		local function draw_config(tbl)
			local result = {}
		
			for key, value in pairs(tbl) do
				
				if type(key) == "number" then
					table.insert(result, "table.insert(tbl, "..draw_value(value, "\t")..")")
				
				elseif type(key) == "string" then			
					if is_var(key) then
						table.insert(result, "tbl."..draw_table_key(key).." = "..draw_value(value, "\t"))
					
					else
						table.insert(result, "tbl"..draw_table_key(key).." = "..draw_value(value, "\t"))
					end
				end
			end
			
			if #result == 0 then
				return ""
				
			else
				return table.concat(result, "\n").."\n"
			end
		end

		function self.load(filename, overwrite)
			assert(type(filename)=="string", ("bad argument #1 to 'load' (string expected, got %s)"):format(type(filename)))
			
			if overwrite == nil then
				overwrite = false
			end
			
			local file = io.open(filename, "r")
			
			if file then
				local text = file:read("*all")
				file:close()
				local lua_code = loadstring("local tbl = {}\n"..text.."\nreturn tbl")
				
				if lua_code then
					local result = lua_code()
					
					if type(result) == "table" then
						if overwrite then
							self.save(filename, result)
						end
						
						return result
					end
				end
			end
		end
		
		function self.save(filename, new)
			assert(type(filename)=="string", ("bad argument #1 to 'table_save' (string expected, got %s)"):format(type(filename)))
			assert(type(new)=="table", ("bad argument #2 to 'table_save' (table expected, got %s)"):format(type(new)))
		
			self.mkpath(filename)
			local file = io.open(filename, "w+")
			
			if file then
				local text = draw_config(new)
				file:write(text)
				file:close()
				
				return true
			else
				return false
			end
		end
		
		function self.insert(filename, value_or_index, value)
			assert(type(filename)=="string", ("bad argument #1 to 'insert' (string expected, got %s)"):format(type(filename)))
			
			if value then
				assert(type(value_or_index)=="number", ("bad argument #2 to 'insert' (number expected, got %s)"):format(type(value_or_index)))
			end
			
			local result
			
			if value then
				result = "table.insert(tbl, "..value_or_index..", "..draw_value(value, "\t")..")"
				
			else
				result = "table.insert(tbl, "..draw_value(value_or_index, "\t")..")"
			end
			
			self.mkpath(filename)
			local file = io.open(filename, "a+")
			
			if file then
				file:write(result.."\n")
				file:close()
				return true
				
			else
				return false
			end
		end
		
		function self.remove(filename, index)
			assert(type(filename)=="string", ("bad argument #1 to 'remove' (string expected, got %s)"):format(type(filename)))
			assert(type(index)=="number" or index == nil, ("bad argument #2 to 'remove' (number or nil expected, got %s)"):format(type(index)))
			local result
			
			if index then
				result = "table.remove(tbl, "..index..")"
				
			else
				result = "table.remove(tbl)"
			end
			
			self.mkpath(filename)
			local file = io.open(filename, "a+")
			
			if file then
				file:write(result.."\n")
				file:close()
				return true
				
			else
				return false
			end
		end
		
		function self.set(filename, key, value)
			assert(type(filename)=="string", ("bad argument #1 to 'set' (string expected, got %s)"):format(type(filename)))
			assert(type(key)=="number" or type(key)=="string", ("bad argument #2 to 'set' (number or string expected, got %s)"):format(type(key)))
			
			local result
					
			if is_var() then
				result = "tbl."..tostring(var).." = "..draw_value(value, "\t")
			
			else
				result = "tbl["..draw_key(key).."] = "..draw_value(value, "\t")
			end
			
			self.mkpath(filename)
			local file = io.open(filename, "a+")
			
			if file then
				file:write(result.."\n")
				file:close()
				return true
				
			else
				return false
			end
		end
		
		function self.mkpath(filename)
			assert(type(filename)=="string", ("bad argument #1 to 'mkpath' (string expected, got %s)"):format(type(filename)))
		
			local sep, pStr = package.config:sub(1, 1), ""
			local path = filename:match("(.+"..sep..").+$") or filename
			
			for dir in path:gmatch("[^" .. sep .. "]+") do
				pStr = pStr .. dir .. sep
				createDirectory(pStr)
			end
		end

		function self.update(old, new, overwrite)
			assert(type(old)=="table", ("bad argument #1 to 'update' (table expected, got %s)"):format(type(old)))
			assert(type(new)=="string" or type(new)=="table", ("bad argument #2 to 'update' (string or table expected, got %s)"):format(type(new)))
			
			if overwrite == nil then
				overwrite = true
			end
		
			if type(new) == "table" then
				if overwrite then
					for key, value in pairs(new) do
						old[key] = value
					end
					
				else
					for key, value in pairs(new) do
						if old[key] == nil then
							old[key] = value
						end
					end
				end
				
				return true
				
			elseif type(new) == "string" then
				local loaded = self.load(new)
				
				if loaded then
					if overwrite then
						for key, value in pairs(loaded) do
							old[key] = value
						end
						
					else
						for key, value in pairs(loaded) do
							if old[key] == nil then
								old[key] = value
							end
						end
					end
					
					return true
				end
			end
			
			return false
		end
		
		function self.append(filename, str)
			self.mkpath(filename)
			local file = io.open(filename, "a+")
			
			if file then
				file:write(str)
				file:close()
				return true
				
			else
				return false
			end
		end
		
		function self.write(filename, str)
			self.mkpath(filename)
			local file = io.open(filename, "w+")
			
			if file then
				file:write(str)
				file:close()
				return true
				
			else
				return false
			end
		end

        function self.setupImcfg(cfg)
            assert(type(cfg) == "table", ("bad argument #1 to 'setupImcfg' (table expected, got %s)"):format(type(cfg)))
            local function setupImcfgRecursive(cfg)
                local imcfg = {}
                for k, v in pairs(cfg) do
                    if type(v) == "table" then
                        imcfg[k] = setupImcfgRecursive(v)
                    elseif type(v) == "number" then
                        if v % 1 == 0 then
                            imcfg[k] = imgui.ImInt(v)
                        else
                            imcfg[k] = imgui.ImFloat(v)
                        end
                    elseif type(v) == "string" then
                        imcfg[k] = imgui.ImBuffer(256)
                        imcfg[k].v = u8(v)
                    elseif type(v) == "boolean" then
                        imcfg[k] = imgui.ImBool(v)
                    else
                        assert(false, ("Unsupported type for imcfg: %s"):format(type(v)))
                    end
                end
                return imcfg
            end
            return setupImcfgRecursive(cfg)
        end
		
		return self
	end
	setmetatable(Xcfg, {
	__call = function(self)
		return self.__init()
	end
})
end
local xcfg = Xcfg()

local filename = getWorkingDirectory()..'\\config\\'..thisScript().name..'\\config.cfg'

local imgui_windows = {
    main = imgui.ImBool(false),
}

local cfg = {
    pin = "0000",
    all = 0,
    everyPayDay = false,
    servers = {},
    notification = false,
    log = {},
    autoPay = false
}
xcfg.update(cfg,filename)

function saveConfig()
    xcfg.save(filename,cfg)
end

local imcfg = xcfg.setupImcfg(cfg)

function addChat(a)
    sampAddChatMessage('{ffa500}'..thisScript().name..'{ffffff}: '..a, -1)
end

function checkArizonaName()
    local name = sampGetCurrentServerName()
    if not (name:find('Arizona') or name:find('arizona')) then
        return false
    end
    return true
end

function saveDateLog(isCheck)
    local val = os.date("%d%m%Y")
    for k,v in ipairs(cfg.log) do
        if v == val then
            return true
        end
    end
    if not isCheck then
        table.insert(cfg.log, val)
        saveConfig()
    end
    return false
end

local state = {
    active = false,
    timer = 0,
}

function main()
    repeat wait(0) until isSampAvailable()
    while not isSampLoaded() do wait(0) end
    addChat('Загружен. Команда: {ffc0cb}/tx{ffffff}. Открыть меню: {ffc0cb}/txm{ffffff}.')
    addChat('{ff0000}Внимание! {ffffff}Скрипт работает только на серверах проэкта {99ff99}Arizona RolePlay{ffffff}.')
    sampRegisterChatCommand('tx',function()
        if state.active then state.active = false end
        if checkArizonaName() then
            state.active = true
            openBankMenu()
        else
            addChat('{ff0000}Ошибка! {ffffff}Скрипт работает только на серверах проэкта {99ff99}Arizona RolePlay{ffffff}.')
        end
    end)
    sampRegisterChatCommand('txm',function()
        imgui_windows.main.v = not imgui_windows.main.v
    end)
    while true do wait(0)
        imgui.Process = imgui_windows.main.v

        if cfg.notification then
            local input = sampGetInputInfoPtr()
            local input = getStructElement(input, 0x8, 4)
            local PosX = getStructElement(input, 0x8, 4)
            local PosY = getStructElement(input, 0xC, 4)
            renderFontDrawText(font, '[{ffa500}/tx{ffffff}]: Оплатите налоги{ffffff}.', PosX, PosY+160, 0xFFFFFFFF, 0x90000000)
        end
    end
end


function openBankMenu()
    local packets = {
        {220, 0, 80, 64},
        {220, 17, 0, 0, 0, 0, 255, 255, 255, 255},
        {220, 24, 0, 0, 0, 0, 128},
        {220, 24, 0, 0, 0, 0, 128},
        {220, 17, 0, 0, 0, 0, 10, 0, 0, 0},
        {220, 17, 0, 0, 0, 0, 10, 0, 0, 0},
        {220, 17, 0, 0, 0, 0, 10, 0, 0, 0},
        {220, 17, 0, 0, 0, 0, 10, 0, 0, 0},
        {220, 17, 0, 0, 0, 0, 10, 0, 0, 0},
        {220, 17, 0, 0, 0, 0, 10, 0, 0, 0},
        {220, 17, 0, 0, 0, 0, 10, 0, 0, 0},
        {220, 18, 25, 0, 0, 0, 111, 110, 65, 99, 116, 105, 118, 101, 86, 105, 101, 119, 67, 104, 97, 110, 103, 101, 100, 124, 80, 104, 111, 110, 101, 0, 0, 0, 0},
        {220, 18, 15, 0, 0, 0, 108, 97, 117, 110, 99, 104, 101, 100, 65, 112, 112, 124, 50, 53, 0, 0, 0, 0, 0},
        {220, 24, 0, 0, 0, 0, 0},
        {220, 0, 27, 0},
        {220, 17, 0, 0, 0, 0, 255, 255, 255, 255},
        {220, 17, 0, 0, 0, 0, 255, 255, 255, 255},
        {220, 17, 0, 0, 0, 0, 255, 255, 255, 255},
        {220, 24, 0, 0, 0, 0, 0},
        {220, 18, 20, 0, 0, 0, 111, 110, 65, 99, 116, 105, 118, 101, 86, 105, 101, 119, 67, 104, 97, 110, 103, 101, 100, 124, 0, 0, 0, 0}
    }
    local function sendPacket(packetData)
        local bs = raknetNewBitStream()
        for _, value in ipairs(packetData) do
            raknetBitStreamWriteInt8(bs, value)
        end
        raknetSendBitStreamEx(bs, 1, 7, 1)
        raknetDeleteBitStream(bs)
    end
    for _, packet in ipairs(packets) do
        sendPacket(packet)
    end
end

function sampev.onShowDialog(id, style, title, button1, button2, text)

    if state.active then
        if title:find('{BFBBBA}$') and text:find('{ffff00}Оплата всех налогов{FFFFFF}') then
            local n = 0
            for line in text:gmatch('[^\r\n]+') do
                if line:find('Оплата всех налогов') then
                    sampSendDialogResponse(id, 1, n, nil)
                    return false
                end
                n=n+1
            end
        elseif title:find('{BFBBBA}Оплата всех налогов') then
            sampSendDialogResponse(id, 1, nil, nil)
            state.active = false
            return false
        elseif title:find('{BFBBBA}{ffff00}Авторизация в банке') then
            if not text:find('Введите свой код в ниже указаную строку') then
                local n = 0
                for line in text:gmatch('[^\r\n]+') do
                    if line:find('Ввести PIN') then
                        sampSendDialogResponse(id, 1, n, nil)
                        return false
                    end
                    n=n+1
                end
            else
                sampSendDialogResponse(id, 1, nil, cfg.pin)
                return false
            end
        end
    end

end

local autopayThr = lua_thread.create_suspended(function()
    while cfg.everyPayDay do wait(0)
        if os.clock() - state.timer >= 3 then
            state.timer = 0
            state.active = true
            openBankMenu()
            return
        end
    end
end)

function sampev.onServerMessage(color, text)
    if text:find('^Вы оплатили все налоги на сумму: {ffffff}%$%d+$') then
        if checkArizonaName() then
            if cfg.autoPay then
                saveDateLog()
            end
            if cfg.notification then
                cfg.notification = false
            end
            cfg.all = cfg.all + tonumber(text:match('{ffffff}%$(%d+)$'))
            saveConfig()
        end
        return
    elseif (cfg.everyPayDay or cfg.autoPay) and text:find('^Депозит в банке. %$%d+') then
        if checkArizonaName() then
            if cfg.autoPay then
                if not saveDateLog(true) then
                    state.active = true
                    openBankMenu()
                end
            end
            if cfg.everyPayDay and not cfg.notification then
                cfg.notification = true
                saveConfig()
            end
        end
        return
    end
end

local isPass = nil

function imgui.OnDrawFrame()
    local w,h = getScreenResolution()

    if imgui_windows.main.v then


        imgui.SetNextWindowSize(imgui.ImVec2(320,220), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(w/2-320/2, h/2-220/2), imgui.Cond.FirstUseEver)
        imgui.Begin(u8(thisScript().name)..' Ver: '..thisScript().version.." ##main_window", imgui_windows.main, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar)

        if not checkArizonaName() then
            imgui.Text(u8'Внимание! Похоже вы не на Arizona.\nСкрипт работать не будет.')
        end

        imgui.Text(u8'Ваш Пин-Код:')
        if imgui.InputText('##pin_int', imcfg.pin, isPass) then
            cfg.pin = imcfg.pin.v
            saveConfig()
        end
        if imgui.IsItemActive() then
            isPass = nil
        else
            isPass = imgui.InputTextFlags.Password
        end
        imgui.Separator()

        imgui.Text(u8'Всего оплачено: '..simplify_number(cfg.all)..'$')

        imgui.Separator()

        if imgui.Checkbox(u8'Уведомление на экране', imcfg.everyPayDay) then
            cfg.everyPayDay = imcfg.everyPayDay.v
            saveConfig()
        end
        if imgui.IsItemHovered() then
            imgui.SetTooltip(u8('Если включено, то после каждого PayDay на экране будет уведомление.\n[/tx]: Оплатите налоги.\nСостояние уведомления сохраняется после перезахода.'))
        end

        if imgui.Checkbox(u8'Авто-Оплата', imcfg.autoPay) then
            cfg.autoPay = imcfg.autoPay.v
            saveConfig()
        end
        if imgui.IsItemHovered() then
            imgui.SetTooltip(u8('Если включено, то скрипт попытается оплачивать налоги раз в сутки автоматически.'))
        end

        imgui.End()

    end

end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    local roundedNum = math.floor(num * mult + 0.5) / mult

    -- Удаляем .0, если оно присутствует
    local roundedStr = tostring(roundedNum)
    if roundedStr:find("%.0$") then
        roundedStr = roundedStr:gsub("%.0$", "")
    end
    return roundedStr
end

function simplify_number(number)
    local K = 1000
    local M = 1000000
    local B = 1000000000
    local suffix, value
    if number >= B then
        suffix = "kkk"
        value = round(number / B, 3)
    elseif number >= M then
        suffix = "kk"
        value = round(number / M, 3)
    elseif number >= K then
        suffix = "k"
        value = round(number / K, 1)
    else
        return tostring(number)
    end

    return value .. suffix
end