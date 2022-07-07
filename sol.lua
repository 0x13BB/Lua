--@name sol
--@author
--@shared

if SERVER then

    function firstLoop()
    
    
    E = chip()
    O = owner()

    Opos = O:getPos()
    Oang = O:getEyeAngles()
    Epos = E:getPos()   
   -- P = prop.create( Epos + Vector(0, 0, 20) + O:getForward()*10 , Angle(0,Oang[2],0), "models/sprops/cuboids/height06/size_1/cube_6x6x6.mdl", true )
    Screen = prop.createComponent( Epos + Vector(0, 0, 30), Oang + Angle(90, 0, 180), "starfall_screen", "models/cheeze/pcb/pcb7.mdl", true )
    Screen:linkComponent( E )
    --H = holograms.create( P:getPos() + P:getForward()*2, P:getAngles(), "models/sprops/cuboids/height06/size_1/cube_6x6x6.mdl", Vector(0.5) )
    --H:setMaterial("debug/debugtexturealpha")
   -- Beam = holograms.create(Epos, Angle(0), "models/sprops/cuboids/height06/size_1/cube_6x6x6.mdl", Vector(0.1) )
    --Beam:setMaterial("debug/debugtexturealpha")
    --Beam:setColor(Color(0,150,256))





    end
    
    
    
    
firstLoop()

    
  
    function mainLoop()
        
        pPos = P:getPos()
        pAng = P:getAngles()
        pFw = P:getForward()
        tracePos = trace.trace( pPos, pPos + pFw*1000, P ,nil , 0).HitPos
        H:setPos(tracePos)
       
        
        
        Length = (trace.trace( pPos, pPos + pFw*1000, P ,nil , 0).Fraction)*1000
        Len = (pPos - tracePos):getLength()
        
        BeamPos =  (tracePos + pPos) / 2 
        
        
        
        Beam:setPos(BeamPos)
        Beam:setAngles(pAng)
        Beam:setScale(Vector(Length / 6,0.1,0.1) )
       
        
    
    
    
        --Length = (pPos - tracePos):getLength( )
        
        --print(Dist*1000)
        
        
        
        
        
        net.start("Length")
        net.writeFloat(Length)
        net.send()
    
    
    
    
    
    
    end  













--hook.add("Think", "Mainloop", mainLoop)


else
    
    local Length
    local A
    local r = 5
    local g = 0
    local g1 = 0
    local g3 = 0
    local g4 = 0
    local font = render.createFont("Default", 20, 10, false, false, false, true, false, false )
    
    
    
    
    net.receive("Length", function ()
        A = "Length " .. (net.readFloat())
        --Length = (A * 1000):toString()
        
    end)






    hook.add("render", "3dbox", function ()
    
    
    render.enableDepth(true)
    render.setColor(Color(255,255,255))
    render.draw3DWireframeBox( Vector(0), Angle(0), Vector(0), Vector(512) )
    render.setColor(Color(0,0,0))
    render.draw3DBox(Vector(-1), Angle(0), Vector(514), Vector(0) )
    render.setColor(Color(255,255,255))
    render.setFont(font)
   -- render.drawText(5 ,5 ,A)
    g = g + 0.001
    g1 = g1 + 0.002
    g3 = g3 +0.0015
    g4 = g4 +0.0008
    sin = math.sin(g)
    
   
    x = sin * 150
    y = math.cos(g) * 150
    
    x1 = math.sin(g1) * 30
    y1 = math.cos(g1) * 30
    
    x2 = math.sin(g1) * 80
    y2 = math.cos(g1) * 80
    
    x3 = math.sin(g3) * 110
    y3 = math.cos(g3) * 110
    
    x4 = math.sin(g4) * 220
    y4 = math.cos(g4) * 220
    
    
    render.setColor(Color(255,240,0))
    render.draw3DWireframeSphere( Vector(256,400,256), 50, 70, 70 )
    render.setColor(Color(170,150,70))
    render.draw3DWireframeSphere( Vector(x2+256,400,y2+256), 4, 50, 50 )
    render.setColor(Color(250,200,90))
    render.draw3DWireframeSphere( Vector(x3+256,400,y3+256), 6, 50, 50 )
    
    
    render.setColor(Color(0,50,255))
    render.draw3DWireframeSphere( Vector(x+256,400,y+256), 13, 50, 50 )
    render.setColor(Color(130,130,130))
    render.draw3DWireframeSphere( Vector(x+256+x1,400,y+256+y1), 2, 50, 50 )
    render.setColor(Color(250,90,90))
    render.draw3DWireframeSphere( Vector(x4+256,400,y4+256), 10, 50, 50 )
    
    
    
    
    
    
    
    
    
    
    
    end)









end
