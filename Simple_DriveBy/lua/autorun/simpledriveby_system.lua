AddCSLuaFile()
print( "Simple DriveBy: Activated!" )

CreateConVar( "driveby_enabled", "1", 256, "Enables the driveby feature while in vehicles!" )
Driveby_enabled = GetConVar( "driveby_enabled" )

if SERVER then
	
	function WeaponAllowSpawn8659( Ply )
		if Driveby_enabled:GetInt() == 1 then
			Ply:SetAllowWeaponsInVehicle( true )
		end
	end
	hook.Add( "PlayerInitialSpawn", "WeaponAllowSpawn8659", WeaponAllowSpawn8659 )

	function WeaponAllowCanEnterVeh8659( Ply, Vehicle )
		if Driveby_enabled:GetInt() == 1 then
			Ply:SetAllowWeaponsInVehicle( true )
			Ply:SetCollisionGroup( COLLISION_GROUP_WEAPON )
			CosMin, CosMax = Vehicle:GetCollisionBounds()
			Vehicle:SetCollisionBounds( CosMin, Vector( CosMax.x, CosMax.y, 10 ) )
		else Ply:SetAllowWeaponsInVehicle( false ) end
	end
	hook.Add( "PlayerEnteredVehicle", "WeaponAllowCanEnterVeh8659", WeaponAllowCanEnterVeh8659 )
	
end

if CLIENT then
	
	WeaponThirdPerson = false
	function WeaponAllowMyCalcView8659( Ply, Pos, Angles, Fov )
		if Driveby_enabled:GetInt() == 1 then
			local CalcView = {}

			CalcView.origin = Pos
			if Ply:InVehicle() and WeaponThirdPerson then
				CalcDistance = Ply:GetVehicle():BoundingRadius()
				CalcView.origin = Ply:GetVehicle():GetPos() -( Angles:Forward()*(CalcDistance*2)) + Vector( 0, 0, CalcDistance/2 )
				CalcView.drawviewer = true
			end
		
			CalcView.angles = Angles
			CalcView.fov = Fov

		return CalcView
		end
	end
	hook.Add( "CalcView", "WeaponAllowMyCalcView8659", WeaponAllowMyCalcView8659 )
	
	function WeaponAllowKeyPress8659( Ply, Key )
		if Ply:InVehicle() and ( Key == IN_DUCK ) then
			if WeaponThirdPerson then WeaponThirdPerson = false
			else WeaponThirdPerson = true end
		else WeaponThirdPerson = false end
	end
	hook.Add( "KeyPress", "WeaponAllowKeyPress8659", WeaponAllowKeyPress8659 )
	
end
