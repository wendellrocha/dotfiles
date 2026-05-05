-- Define a sua combinação de teclas do teclado de macros
local hyper = {"cmd", "alt", "ctrl", "shift"}

hs.hotkey.bind(hyper, "v", function()
    -- 1. Salva a aplicação que está em foco no momento
    local currentApp = hs.application.frontmostApplication()
    local toggledSomething = false
    
    -- 2. Tabela com os apps alvo. 
    -- Para navegadores, adicionamos a propriedade 'checkTitle'
    local targets = {
        { name = "Microsoft Teams", key = "o", mods = {"cmd", "shift"} },
        { name = "Slack", key = "v", mods = {"cmd", "shift"} },
        { name = "Google Chrome", key = "e", mods = {"cmd"}, checkTitle = "Meet" },
        { name = "Helium", key = "e", mods = {"cmd"}, checkTitle = "Meet" }
    }

    -- 3. Itera sobre a lista procurando os apps abertos
    for _, target in ipairs(targets) do
        local app = hs.application.get(target.name)
        
        if app ~= nil then
            local shouldToggle = true
            
            -- Se for um navegador, verifica se a janela ativa é o Google Meet
            if target.checkTitle then
                local win = app:mainWindow()
                if win then
                    local title = win:title()
                    -- Se a palavra "Meet" não estiver no título da janela, ignora este app
                    if not string.find(title, target.checkTitle) then
                        shouldToggle = false
                    end
                else
                    shouldToggle = false
                end
            end

            -- Se passou pelas validações, faz o toggle da câmera
            if shouldToggle then
                app:activate() -- Puxa o app para frente
                
                -- Pausa de 50ms para o macOS registrar a troca de foco
                hs.timer.usleep(50000) 
                
                -- Dispara o atalho de teclado
                hs.eventtap.keyStroke(target.mods, target.key, 10000)
                toggledSomething = true
            end
        end
    end

    -- 4. Devolve o foco instantaneamente para onde você estava
    if toggledSomething and currentApp then
        hs.timer.usleep(50000) -- Pausa para garantir o processamento
        currentApp:activate()
    end
end)

hs.alert.show("Hammerspoon: Toggle de Câmera Atualizado")