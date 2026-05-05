-- Função auxiliar reaproveitável (Clean Architecture style)
-- Recebe a lista de apps, o título da janela (opcional), e as teclas que devem ser enviadas
local function triggerAppShortcut(appNames, checkTitle, targetMods, targetKey)
    local currentApp = hs.application.frontmostApplication()
    local toggledSomething = false

    for _, appName in ipairs(appNames) do
        local app = hs.application.get(appName)
        
        if app ~= nil then
            local shouldToggle = true
            
            -- Validação de título da janela (útil para navegadores)
            if checkTitle then
                local win = app:mainWindow()
                if win then
                    local title = win:title()
                    if not string.find(title, checkTitle) then
                        shouldToggle = false
                    end
                else
                    shouldToggle = false
                end
            end

            -- Executa a injeção de atalho
            if shouldToggle then
                app:activate() -- Traz para o topo
                hs.timer.usleep(50000) -- Pausa de 50ms para o macOS registrar o foco
                
                hs.eventtap.keyStroke(targetMods, targetKey, 10000)
                toggledSomething = true
            end
        end
    end

    -- Devolve o foco para a sua IDE/janela original
    if toggledSomething and currentApp then
        hs.timer.usleep(50000) 
        currentApp:activate()
    end
end


-------------------------------------------------------------------------
-- MAPEAMENTO DOS ATALHOS GLOBAIS
-------------------------------------------------------------------------

-- 1. GOOGLE MEET (Chrome e Helium)
-- Gatilho Global: Cmd + Shift + E
-- O que ele faz: Envia Cmd + E para o Chrome ou Helium (se a janela contiver "Meet")
hs.hotkey.bind({"cmd", "shift"}, "e", function()
    triggerAppShortcut({"Google Chrome", "Helium"}, "Meet", {"cmd"}, "e")
end)

-- 2. MICROSOFT TEAMS (Exemplo de como adicionar)
-- Gatilho Global: Cmd + Shift + T
-- O que ele faz: Envia Cmd + Shift + O para o Teams
hs.hotkey.bind({"cmd", "shift"}, "t", function()
    triggerAppShortcut({"Microsoft Teams"}, nil, {"cmd", "shift"}, "o")
end)

-- 3. SLACK (Exemplo de como adicionar)
-- Gatilho Global: Cmd + Shift + S
-- O que ele faz: Envia Cmd + Shift + V para o Slack
hs.hotkey.bind({"cmd", "shift"}, "s", function()
    triggerAppShortcut({"Slack"}, nil, {"cmd", "shift"}, "v")
end)

hs.alert.show("Hammerspoon: Atalhos Modulares Carregados")