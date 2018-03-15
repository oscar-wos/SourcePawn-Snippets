// 306036-Berva-Request

// Compiler Info: Pawn 1.8 - build 6041

#define PLUGIN_VERSION "1.00.3"

public Plugin myinfo = {
	name = "Night Vision Goggles",
	author = "TummieTum | Oscar Wos (OSWO)",
	description = "CS:GO Night Vision",
	version = PLUGIN_VERSION,
	url = "https://www.team-secretforce.com | https://github.com/OSCAR-WOS / https://steamcommunity.com/id/OSWO",
}

public void OnPluginStart() {
	RegConsoleCmd("sm_nvg", Command_NightVision);
	HookEvent("player_spawn", Event_PlayerSpawn, EventHookMode_Post);
}

public Action Event_PlayerSpawn(Event eEvent, const char[] cName, bool bDontBroadcast) {
	int iClient = GetClientOfUserId(eEvent.GetInt("userid"));

	if (IsFakeClient(iClient) || !IsPlayerAlive(iClient) || GetClientTeam(iClient) != 2) return;
	SetEntProp(iClient, Prop_Send, "m_bNightVisionOn", 1);
}

public Action Command_NightVision(int iClient, int iArgs) {
	int iClientTeam = GetClientTeam(iClient);

	if (iClientTeam != 2) {
		PrintToChat(iClient, "[Night Vision] Invalid Team");
		return Plugin_Handled;
	}

	if (!IsPlayerAlive(iClient)) {
		PrintToChat(iClient, "[Night Vision] Dead");
		return Plugin_Handled;
	}

	int iNightVision = GetEntProp(iClient, Prop_Send, "m_bNightVisionOn");
	SetEntProp(iClient, Prop_Send, "m_bNightVisionOn", (iNightVision + 1) % 2);

	return Plugin_Handled;
}
