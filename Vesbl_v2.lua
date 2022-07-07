--@name Vesbl v2
--@author
--@shared


if SERVER then

--wire.adjustOutputs({ "A" }, { "String"})


    function firstLoop()

        E = chip()
        Epos = E:getPos()   
        P = prop.create( Epos + Vector(60,0, 30), Angle(0, 0, 0), "models/sprops/rectangles_thin/size_4/rect_36x36x1_5.mdl", false )
        --P = prop.create( Epos + Vector(60,0, 30), Angle(0, 0, 0), "models/sprops/cuboids/height12/size_1/cube_12x12x12.mdl", false )
        Screen = prop.createComponent( Epos + Vector(0,0, 30), Angle(90, 0, 0), "starfall_screen", "models/cheeze/pcb/pcb4.mdl", true )
        Screen:linkComponent( E )
        H = 50
    
    end  
    firstLoop()
  
    function mainLoop()      
    
        D = H - (P:getPos()[3] - E:getPos()[3])
        X = P:getPos()[1]-E:getPos()[1]
        Y = P:getPos()[2]-E:getPos()[2]
        Dd = D*math.abs(D)
    
    
    
        Pvel = P:getVelocity()
        Fvec = Vector(0, 0, 1)*Dd
        PangVel = P:getAngleVelocityAngle()
        Pang = P:getAngles(  )
    
    
    
        P:applyAngForce(-PangVel*10)
        P:applyAngForce(-Pang*30)
        P:applyForceCenter(Fvec)
        P:applyForceCenter(-Pvel*5)
        P:applyForceCenter(Vector(60-X, -0-Y, 0)*50)
    
        G = (Dd / 9.013562958523667 - P:getMass())
    
        --wire.ports.A = tostring(G)
    

    
    
        net.start("G")
        net.writeFloat(G)
        net.send()
    
    
   
    end

    hook.add("Think", "Mainloop", mainLoop)


else

    local G
    local font = render.createFont("Default", 60)


    net.receive("G", function ()
        G = net.readFloat()
    end)

    hook.add("render", "weight_render", function ()

        render.setColor(Color(255, 256, 255, 255))
        render.setFont(font)     
        render.drawText(0, 196, tostring(G))

    end)


end



