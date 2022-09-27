global function CodeCallback_PreMapInit
global function ClientCodeCallback_MapInit

const JUMP_PAD_LAUNCH_SOUND_1P = "Geyser_LaunchPlayer_1p"

void function CodeCallback_PreMapInit()
{
	Desertlands_PreMapInit_Common()
}

void function ClientCodeCallback_MapInit()
{
	// DesertlandsTrainAnnouncer_Init()
	ClLaserMesh_Init()
	Desertlands_MapInit_Common()
	MapZones_RegisterDataTable( $"datatable/map_zones/zones_mp_rr_desertlands_64k_x_64k.rpak")

	AddCreateCallback( "trigger_cylinder_heavy", Geyser_OnJumpPadCreated )

	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_6_NEW_SPRINGFIELD", 0.56, 0.42, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_11_THERMAL_STATION",  0.28, 0.73, 0.5)
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_7_SNOW_FIELD", 0.85, 0.40, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_2_CAP_CITY", 0.35, 0.22, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_15_LAVA_CITY", 0.80, 0.80, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_5_LAVA_FISSURE", 0.18, 0.43, 0.5)
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_4_BURIED_REFINERY", 0.72, 0.19, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_4_GROUND_ZERO", 0.63, 0.30, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_10_RESEARCH_STATION_BRAVO", 0.77, 0.60, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_12_RESEARCH_STATION_ALPHA", 0.41, 0.84, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_16_MT", 0.72, 0.92, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_5_TRAINYARD", 0.36, 0.46, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_13_REFINERY", 0.57, 0.74, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_1_DRILL_SITE", 0.29, 0.35, 0.5 )
	SURVIVAL_AddMinimapLevelLabel( "#DES_ZONE_9_FUEL", 0.52, 0.60, 0.5 )
	
	if ( GetMapName() == "mp_rr_desertlands_64k_x_64k_tt" )
		SURVIVAL_AddMinimapLevelLabel( "Mirage Voyage", 0.23, 0.54, 0.5 )

	//SURVIVAL_AddMinimapLevelLabel( "Tunnel", 0.52, 0.64, 0.3)
//
	//SURVIVAL_AddMinimapLevelLabel( "Tunnel", 0.74, 0.51, 0.3)
//
	//SURVIVAL_AddMinimapLevelLabel( "Tunnel", 0.48, 0.18, 0.3)
//
	//SURVIVAL_AddMinimapLevelLabel( "Tunnel", 0.41, 0.51, 0.3)
//
	//SURVIVAL_AddMinimapLevelLabel( "Tunnel", 0.67, 0.75, 0.3)
//
	//SURVIVAL_AddMinimapLevelLabel( "Tunnel", 0.43, 0.32, 0.3)


	//SURVIVAL_AddMinimapLevelLabel( "`1*", 0.70, 0.57, 1.0)
	//SURVIVAL_AddMinimapLevelLabel( "`1*", 0.77, 0.65, 1.0)
	//SURVIVAL_AddMinimapLevelLabel( "`1*", 0.18, 0.37, 1.0)
	//SURVIVAL_AddMinimapLevelLabel( "`1*", 0.37, 0.58, 1.0)
	//SURVIVAL_AddMinimapLevelLabel( "`1*", 0.20, 0.47, 1.0)
//
	////Legand
	//SURVIVAL_AddMinimapLevelLabel( "`1Elevators", 0.12, 0.95, 0.5)
	//SURVIVAL_AddMinimapLevelLabel( "`1*", 0.05, 0.85, 1.0)


	//SURVIVAL_AddMinimapLevelLabel( "%$r2_ui/menus/loadout_icons/attachments/energy_ar_quick_charge%", 0.60, 0.20, 2.0 )
	//SURVIVAL_AddMinimapLevelLabel( "Cave", 0.85, 0.55, 0.5 )
	//SURVIVAL_AddMinimapLevelLabel( "Bridge", 0.75, 0.80, 0.5 )
//
	//SURVIVAL_AddMinimapLevelLabel( "Elevator", 0.22, 0.57, 0.3)
	//SURVIVAL_AddMinimapLevelLabel( "Elevator", 0.80, 0.87, 0.3)
	//SURVIVAL_AddMinimapLevelLabel( "Gandola", 0.20, 0.75, 0.3)
	//SURVIVAL_AddMinimapLevelLabel( "Gandola", 0.30, 0.93, 0.3)
}

void function Geyser_OnJumpPadCreated( entity trigger )
{
	if ( trigger.GetTriggerType() != TT_JUMP_PAD )
		return

	if ( trigger.GetTargetName() != "geyser_trigger" )
		return

	trigger.SetClientEnterCallback( Geyser_OnJumpPadAreaEnter )
}

void function Geyser_OnJumpPadAreaEnter( entity trigger, entity player )
{
	entity localViewPlayer = GetLocalViewPlayer()
	if ( player != localViewPlayer )
		return

	if ( !IsPilot( player ) )
		return

	if ( trigger.GetTargetName() != "geyser_trigger" )
		return

	EmitSoundOnEntity( player, JUMP_PAD_LAUNCH_SOUND_1P )
	EmitSoundOnEntity( player, "JumpPad_Ascent_Windrush" )
}