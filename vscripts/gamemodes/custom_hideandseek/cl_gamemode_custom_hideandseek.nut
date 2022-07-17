// Credits Time !
// 𝕮𝖗𝖎𝖔𝖘𝕮𝖍𝖆𝖓 クリオスちゃん#0221 -- Mode Main + Map Builder
// Julefox#0050 -- Floppytown Map Builder
// sal#3261 -- CUSTOM TDM Main
// @Shrugtal -- CUSTOM TDM score ui

global function Cl_CustomHideAndSeek_Init

global function ServerCallback_HideAndSeek_DoAnnouncement
global function ServerCallback_HideAndSeek_PlayerKilled

struct {
    var PlayerList
} file;

void function Cl_CustomHideAndSeek_Init()
{

}

void function MakePlayerListRUI()
{
    if (file.PlayerList != null)
    {
        RuiSetString( file.PlayerList, "messageText", "Hidden team: " + GameRules_GetTeamPlayers(TEAM_HIDE) " || Seeker team: " + GameRules_GetTeamPlayers(TEAM_SEEK))
        return
    }
    clGlobal.levelEnt.EndSignal( "ClosePlayerListRUI" )
    var screenAlignmentTopo = RuiTopology_CreatePlane( <( screenSize.width * 0.25),( screenSize.height * 0.31 ), 0>, <float( screenSize.width ), 0, 0>, <0, float( screenSize.height ), 0>, false )
    var rui = RuiCreate( $"ui/announcement_quick_right.rpak", screenAlignmentTopo, RUI_DRAW_HUD, RUI_SORT_SCREENFADE + 1 )

    RuiSetGameTime( rui, "startTime", Time() )
    RuiSetString( rui, "messageText", "Hidden team: " + GameRules_GetTeamPlayers(TEAM_HIDE) " || Seeker team: " + GameRules_GetTeamPlayers(TEAM_SEEK) )
    RuiSetString( rui, "messageSubText", "Playlist created by CriosChan" )
    RuiSetFloat( rui, "duration", 9999999 )
    RuiSetFloat3( rui, "eventColor", SrgbToLinear( <128, 188, 255> ) )

    file.PlayerList = rui

    OnThreadEnd(
        function(): ( rui )
        {
            RuiDestroy( rui )
            file.PlayerList = null
        }
    )

    WaitForever
}

void function ServerCallback_HideAndSeek_DoAnnouncement(float duration, int type)
{
    string message = ""
    string subtext = ""
    switch(type)
    {
        case eHASAnnounce.ROUND_START_SEEKER:
        {
            thread MakeScoreRUI();
            message = "Round start"
            subtext = "You are a Seeker"
            break
        }
        case eHASAnnounce.ROUND_START_HIDDEN:
        {
            thread MakeScoreRUI();
            message = "Round start"
            subtext = "You are part of the hidden team"
            break
        }
        case eHASAnnounce.HIDETOSEEK:
        {
            message = "You are now a Seeker"
            break
        }
        case eHASAnnounce.END_SEEKER:
        {
            clGlobal.levelEnt.Signal( "ClosePlayerListRUI" )
                message = "The seekers won!"
            break
        }
        case eHASAnnounce.END_HIDDEN:
        {
            clGlobal.levelEnt.Signal( "ClosePlayerListRUI" )
                message = "The hidden team won!"
            break
        }
    }
    AnnouncementData announcement = Announcement_Create( message )
    Announcement_SetSubText(announcement, subtext)
    Announcement_SetStyle(announcement, ANNOUNCEMENT_STYLE_CIRCLE_WARNING)
    Announcement_SetPurge(announcement, true)
    Announcement_SetOptionalTextArgsArray(announcement, ["true"])
    Announcement_SetPriority(announcement, 200)
    announcement.duration = duration
    AnnouncementFromClass( GetLocalViewPlayer(), announcement)
}

void function ServerCallback_HideAndSeek_PlayerKilled()
{
    if(file.PlayerList)
        RuiSetString( file.PlayerList, "messageText", "Hidden team: " + GameRules_GetTeamPlayers(TEAM_HIDE) + "  ||  Seeker team: " + GameRules_GetTeamPlayers(TEAM_SEEK) );
}