--@name dome
--@author
--@shared

if SERVER then


    function firstLoop()
        
        arr = {}
            
        E = chip()
        O = owner()
            
        Opos = O:getPos()
        Oang = O:getEyeAngles()
        Epos = E:getPos()
        Eang = E:getAngles() 
    
        h   = holograms.create(Epos + Vector (0,0,40), Eang , "models/holograms/icosphere2.mdl" , Vector(30))  
        h1  = holograms.create(Epos + Vector (0,0,40), Eang , "models/holograms/icosphere2.mdl" , Vector(-30)) 
       
        h:setMaterial( "models/wireframe" )
        h1:setMaterial( "models/wireframe" )
        h:setParent( E )
        h1:setParent (E )
         
    end
    
    
    firstLoop()

    function RSI(Start, Dir, Pos, Radius)
               
        local A = 2 * Dir:getLength() ^ 2
        local B = 2 * Dir:dot(Start - Pos)
        local C = Pos:getLength() ^ 2 + Start:getLength() ^ 2 - 2 * Pos:dot( Start ) - Radius ^     2
        local BAC4 = B^2 - (2 * A * C)
        
        if (BAC4 >= 0 and B < 0) then  
                 
            return Start + ((-math.sqrt(BAC4) - B) / A) * Dir -- , Start + ((math.sqrt(BAC4) - B) / A)*Dir}
            
        else    
        
            return nil
            
        end
    end
    
    function holo(index, pos, ang, model, scale) 
    
        if arr[index] ~= nil then
        
            arr[index]:setPos( pos )
            arr[index]:setAngles( ang )    
                      
        else
        
            arr[index] = prop.create(pos, ang, model, scale)
            
        end
    end    
    
    function holoRemove( index )
       
        if isValid(arr[index]) then
        
            arr[index]:remove()
            arr[index] = nil
                        
        end        
    end
    
    
    function Count( Tab )
                
        local c = 0
        for _, i in pairs( Tab ) do
        
            c = c + 1
            
        end
        
        return c
    end
    
    function mainLoop() 
    
        Epos = E:getPos()
    
        local IN  
        local ArrPos  = {}
        local ArrayGre = {}
        local ent
        local str = "1"
        local ArrayGre = find.inSphere(Epos,400)
        
        for cvk, cvv in pairs(ArrayGre) do
        
            if  ArrayGre[cvk]:getClass() == "prop_physics"  or 
                ArrayGre[cvk]:getClass() == "crossbow_bolt" or
                ArrayGre[cvk]:getClass() == "npc_grenade_frag" or
                ArrayGre[cvk]:getClass() == "npc_grenade_bugbait" or
                ArrayGre[cvk]:getClass() == "rpg_missile" or
                ArrayGre[cvk]:getClass() == "grenade_ar2" or
                ArrayGre[cvk]:getClass() == "prop_combine_ball" or
                ArrayGre[cvk]:getClass() == "acf_missle" or
                ArrayGre[cvk]:getClass() == "npc_satchel" 
    
                then
                else          

                ArrayGre[cvk] = nil
            end
        end
             
        for k , v in pairs(ArrayGre) do
    
            ArrPos[k] = RSI(v:getPos(), v:getVelocity(),Epos + Vector(0,0,40),200)
        
            if prop.canSpawn() then
            
                if ArrPos[k] ~= nil  then 
                                                            
                    ent = holo(k, ArrPos[k], (ArrPos[k] - Epos -Vector(0,0,40)):getAngle()  +Angle(90,0,0) , "models/hunter/plates/plate1x1.mdl" , 1 )                    
                    
                else
                
                    if ent~= nil then
                    
                        ent:remove()
        
                    end
                    
                    
                    for ck , cv in pairs(arr) do 
                        if isValid(arr[ck]) then   
                            arr[ck]:remove()
                            arr[ck] = nil
                        end
                    end   
                                            
                    holoRemove(k)
                               
                end
             
            end
                       
            if Count(ArrPos) > 0 then  
                
                h:setMaterial("models/wireframe")           
                h1:setColor(Color(255,0,0))
                h:setColor(Color(255,0,0))
                               
            else   
            
                h:setMaterial("models/wireframe") 
                h1:setColor(Color(0,255,0))
                h:setColor(Color(0,255,0))

            end
        end
    end
    
    hook.add("Think", "Mainloop", mainLoop)

end