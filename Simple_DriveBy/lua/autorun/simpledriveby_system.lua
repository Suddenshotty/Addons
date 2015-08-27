AddCSLuaFile()
print( "Simple DriveBy: Activated!" )

if SERVER then
	function WeaponAllowSpawn8659( Ply )
		Ply:SetAllowWeaponsInVehicle( true )
	end
	hook.Add( "PlayerInitialSpawn", "WeaponAllowSpawn8659", WeaponAllowSpawn8659 )

	function WeaponAllowCanEnterVeh8659( Ply, Vehicle )
		Ply:SetAllowWeaponsInVehicle( true )
		Ply:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		CosMin, CosMax = Vehicle:GetCollisionBounds()
		Vehicle:SetCollisionBounds( CosMin, Vector( CosMax.x, CosMax.y, 10 ) )
	end
	hook.Add( "PlayerEnteredVehicle", "WeaponAllowCanEnterVeh8659", WeaponAllowCanEnterVeh8659 )
end