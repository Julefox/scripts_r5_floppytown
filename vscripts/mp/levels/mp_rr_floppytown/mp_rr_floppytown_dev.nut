untyped

globalize_all_functions

void function PrinttDevFiles()
{
    printt( "|mp_rr_floppytown_dev.nut:                       file called.|" )
}


void function Floppytown_MapInit_Dev()
{
    if ( GetCurrentPlaylistVarBool( "ft_dev_enable", false ) ) // map editing, do not activate in normal use
    {
        EditorRefAreVisible()
        AreaBuildAreVisible()
        AddClientCommandCallback( "props",  ClientCommand_Props )
        AddClientCommandCallback( "god",    ClientCommand_Invulnerable )
        AddClientCommandCallback( "test",   ClientCommand_Test )
        AddClientCommandCallback( "asset",  ClientCommand_AssetViewerActive )
        AddClientCommandCallback( "fall",   ClientCommand_FallingObjectActiveThread )
        AddClientCommandCallback( "assettest", ClientCommand_AssetViewerTest )
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
/////   become useless since in dev mode we can see the number of entities on the map in real time   /////
//////////////////////////////////////////////////////////////////////////////////////////////////////////
    bool function ClientCommand_Props( entity player, array<string> args )
    {   PrinttPropsCount(); return true }

    int function PropsCount()
    {
        int count = 0
        foreach( EntitiesCount in GetPropsCount() )
        { count++ }
        return count
    }

    array< entity > function GetPropsCount()
    {
        array< entity > EntitiesCount = GetEntArrayByScriptName( "FloppytownEntities" )
        return EntitiesCount
    }

    void function PrinttPropsCount()
    {
        printt( "" )
        printt( "Models generated by Floppytown scripts: " + PropsCount() )
        printt( "" )
    }
//////////////////////////////////////////////////////////////////////////////////////////////////////////

bool function ClientCommand_Invulnerable( entity player, array<string> args )
{
    if ( player.IsInvulnerable() )
    {
        player.ClearInvulnerable()
        printt( player.GetPlayerName() + " is now vulnerable." )
    }
    else
    {
        player.SetInvulnerable()
        player.SetHealth( 100 )

        printt( player.GetPlayerName() + " is invulnerable !")
    }

return true }

bool function ClientCommand_Test( entity player, array<string> args )
{
    thread ListenSound( player )
return true }

bool function ClientCommand_AssetViewerActive( entity player, array<string> args )
{
    int j = 1
    int k = 1
    int l = 0
    int props_count = 0
    int max_props_count = ASSET_VIEWER_ARRAY.len() + 4


    CreateFloppytownModel( YUKI_MEMORIAL_02, FT_BUILD_AREA_POS + < -2000, 3000, 5480 >, < 0, 0, 0 >, "assetViewer" ).SetModelScale( 500 )
    CreateFloppytownModel( YUKI_MEMORIAL_03, FT_BUILD_AREA_POS + < 4600, 9000, 5480 >, < 0, 90, 0 >, "assetViewer" ).SetModelScale( 500 )
    CreateFloppytownModel( YUKI_MEMORIAL_04, FT_BUILD_AREA_POS + < 16600, 9758, 5480 >, < 0, -90, 0 >, "assetViewer" ).SetModelScale( 500 )

    for ( int i = 0 ; i < ASSET_VIEWER_ARRAY.len() ; i++ )
    {

        entity assets = CreateFloppytownModel( ASSET_VIEWER_ARRAY[i], FT_BUILD_AREA_POS + < 0, 0, 1000 > + < 800 * l, 800 * j, 800 * k >, < 0, 0, 0 >, "assetViewer" )

        k++

        if ( k == 11 )
        {
            j = j+1
            k = k-10

            if ( j >= 10 )
            {
                l = l+1
                j = 10
            }
        } 
    }

    foreach ( props in GetEntArrayByScriptName( "assetViewer" ) )
    { props_count++ }

    
    if ( props_count >= max_props_count )
    {
        foreach ( props in GetEntArrayByScriptName( "assetViewer" ) )
        {
            props.Destroy()
        }
        printt( "" )
        printt("Asset Viewer Closed")
        printt( "" )
    }
    else
    {
        printt( "" )
        printt("Asset Viewer Opened")
        printt( "" )
    }

return true }

bool function ClientCommand_FallingObjectActiveThread( entity player, array<string> args )
{
    if ( !Flag( "FallingObjectThread()_IsActive" ) ) // prevents it from being activated 2 times
    {
        printt( "|==========================================================|" )
        printt( "| FallingObjectThread(): Thread activate by client command" )
        printt( "|" )
        printt( "| Player: " + player )

        entity player_trigger = GetEnt( "player_trigger_01" )

        if ( IsValid( player_trigger ) )
        {
            player_trigger.Destroy()
        }

        FlagSet( "FallingObjectThread()_IsActive" )

        thread ChangePanelState()
        thread FallingObjectThread()
    }
    else
    {
        printt( "|==========================================================|" )
        printt( "| FallingObjectThread(): Thread is already activate" )
        printt( "|==========================================================|" )
    }

return true }

void function ListenSound( entity player )
{
    int i = 0
    while( i != SOUNDS_ARRAY.len() )
    {
        printt( "" )
        printt( "Sound played: " + SOUNDS_ARRAY[i] )
        printt( "" )

        EmitSoundOnEntity( player, SOUNDS_ARRAY[i] )
            wait 5
        StopSoundOnEntity( player, SOUNDS_ARRAY[i] )

        printt( "" )
        printt( "End of sound" )
        printt( "" )

        i++

        WaitFrame()
    }
    printt( "You have listened to everything !" )
}

bool function ClientCommand_AssetViewerTest( entity player, array<string> args )
{
    int j = 1
    int k = 1
    int l = 0
    int props_count = 0
    int max_props_count = ALL_MODELS.len() + 1

    for ( int i = 0 ; i < ALL_MODELS.len() ; i++ )
    {

        entity assets = CreateFloppytownModel( ALL_MODELS[i], < -18000, -20000, 5000 > + < 1400 * l, 2000 * j, 1000 * k >, < 0, 0, 0 >, "assetViewerTest" )

        k++

        if ( k == 11 )
        {
            j = j+1
            k = k-10

            if ( j >= 26 )
            {
                l = l+1
                j = 1
            }
        } 
    }

    foreach ( props in GetEntArrayByScriptName( "assetViewerTest" ) )
    { props_count++ }

    
    if ( props_count >= max_props_count )
    {
        foreach ( props in GetEntArrayByScriptName( "assetViewerTest" ) )
        {
            props.Destroy()
        }
        printt( "" )
        printt("Asset Viewer Closed")
        printt( "" )
    }
    else
    {
        printt( "" )
        printt("Asset Viewer Opened")
        printt( "" )
    }

return true }
