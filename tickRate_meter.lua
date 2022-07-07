--@name tickRate meter
--@author
--@shared

if SERVER then




    function firstLoop()

        E = chip()
        Epos = E:getPos()   
        Screen = prop.createComponent( Epos + Vector(0,0, 30), Angle(90, 0, 0), "starfall_screen", "models/cheeze/pcb/pcb4.mdl", true )
        Screen:linkComponent( E )
        A = timer.curtime()
        
   
        
        
    
    end  
    firstLoop()
    
    
    
    
    function mainLoop()
        
   
    B = (timer.curtime() - A)
    A = timer.curtime()
    
   
    
    
    
    net.start("B")
        net.writeFloat(B)
        net.send()
    
    end
    hook.add("Think", "Mainloop", mainLoop)
    
    
    
    
    else

    local B
    local C
    local font = render.createFont("Default", 60)


    net.receive("B", function ()
        B = (net.readFloat())
        C = (1/B)
    end)

    hook.add("render", "weight_render", function ()

        render.setColor(Color(255, 256, 255, 255))
        render.setFont(font)     
        render.drawText(0, 196, (B) .. "\n" .. (C))

    end)
    
    
    
end  
