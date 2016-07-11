local WipeCount = LibStub("AceAddon-3.0"):NewAddon("WipeCount", "AceConsole-3.0", "AceEvent-3.0")
local AceGUI = LibStub("AceGUI-3.0")




function WipeCount:MySlashProcessorFunc(input)
	--Slash Function
end


function WipeCount:EncounterEndHandler(eventName, encounterID, encounterName, difficultyID, raidSize, endStatus)

	--[[
	eventName: Name of the eventName

	encounterID: ID of the Encounter in the Instance

	encounterName: Name of Encounter

	difficultyID: Instance Difficulty
		0 - None; not in an Instance.
�		1 - 5-player Instance.
�		2 - 5-player Heroic Instance.
�		3 - 10-player Raid Instance.
�		4 - 25-player Raid Instance.
�		5 - 10-player Heroic Raid Instance.
�		6 - 25-player Heroic Raid Instance.
�		7 - Raid Finder Instance.
�		8 - Challenge Mode Instance.
�		9 - 40-player Raid Instance.
�		10 - Not used.
�		11 - Heroic Scenario Instance.
�		12 - Scenario Instance.
�		13 - Not used.
�		14 - Flexible Raid.
�		15 - Heroic Flexible Raid.

	raidSize: Number of Raiders in the Instance
	endStatus: How the fight ended.
		0. Wipe
		1. Success
	]]--

	if endStatus == 0 then
		wipeCountValue++
	end

end

function WipeCount:EncounterStartHandler(eventName, encounterID, encounterName, difficultyID, raidSize)
	--[[
	eventName: Name of the eventName

	encounterID: ID of the Encounter in the Instance

	encounterName: Name of Encounter

	difficultyID: Instance Difficulty
		0 - None; not in an Instance.
�		1 - 5-player Instance.
�		2 - 5-player Heroic Instance.
�		3 - 10-player Raid Instance.
�		4 - 25-player Raid Instance.
�		5 - 10-player Heroic Raid Instance.
�		6 - 25-player Heroic Raid Instance.
�		7 - Raid Finder Instance.
�		8 - Challenge Mode Instance.
�		9 - 40-player Raid Instance.
�		10 - Not used.
�		11 - Heroic Scenario Instance.
�		12 - Scenario Instance.
�		13 - Not used.
�		14 - Flexible Raid.
�		15 - Heroic Flexible Raid.

	raidSize: Number of Raiders in the Instance
	]]--

	if currentEncounterID != encounterID
		curentEncounterID = encounterID
		wipeCountValue = 0
	end

	currentEncounterName = encounterName
	currentRaidSize = raidSize

	if difficultyID == 0 then
		currentDifficulty = "N/A"
	elseif difficultyID == 1 then
		currentDifficulty = "5-Man Normal"
	elseif difficultyID == 2 then
		currentDifficulty = "5-Man Heroic"
	elseif difficultyID == 3 then
		currentDifficulty = "10-Man Normal"
	elseif difficultyID == 4 then
		currentDifficulty = "25-Man Normal"
	elseif difficultyID == 5 then
		currentDifficulty = "10-Man Heroic"
	elseif difficultyID == 6 then
		currentDifficulty = "25-Man Heroic"
	elseif difficultyID == 7 then
		currentDifficulty = "Looking for Retards"
	elseif difficultyID == 8 then
		currentDifficulty = "Challenge Mode"
	elseif difficultyID == 9 then
		currentDifficulty = "40-Man Raid"
	elseif difficultyID == 11 then
		currentDifficulty = "Heroic Scenario"
	elseif difficultyID == 12 then
		currentDifficulty = "Normal Scenario"
	elseif difficultyID == 14 then
		currentDifficulty = "Flex Normal"
	elseif difficultyID == 15 then
		currentDifficulty = "Flex Heroic"

	encounterNameLabel:SetText("Encounter Name: " .. encounterName)
	raidSizeLabel:SetText("Raid Size: " .. currentRaidSize)
	difficultyLabel:SetText("Raid Difficulty: " .. currentDifficulty)
	wipeCountLabel:SetText("Wipe Count: " .. wipeCountValue)

end



function WipeCount:OnInitialize()

	currentEncounterName = ""
	currentEncounterID = nil
	currentRaidSize = nil
	currentDifficulty = ""
	wipeCountValue = 0;

	mainWindow = AceGUI:Create("Frame")
	mainWindow:SetTitle("Wipe Count")
	mainWindow:SetStatusText("Wipe Count Main Window")
	encounterNameLabel:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
	mainWindow:SetLayout("List")

	encounterNameLabel = AceGUI:Create("Label")
	encounterNameLabel:SetLabel("Encounter Name: ")
	encounterNameLabel:SetWidth(200)

	raidSizeLabel = AceGUI:Create("Label")
	raidSizeLabel:SetLabel("Raid Size: ")
	raidSizeLabel:SetWidth(200)

	difficultyLabel = AceGUI:Create("Label")
	difficultyLabel:SetLabel("Raid Difficulty: ")
	difficultyLabel:SetWidth(200)

	wipeCountLabel = AceGUI:Create("Label")
	wipeCountLabel:SetLabel("Wipe Count: 0")
	wipeCountLabel:SetWidth(200)


	mainWindow:AddChild(encounterNameLabel)
	mainWindow:AddChild(raidSizeLabel)
	mainWindow.AddChild(difficultyLabel)
	mainWindow.AddChild(wipeCountLabel)


	WipeCount:RegisterChatCommand("myslash", "MySlashProcessorFunc")

	WipeCount:RegisterEvent("ENCOUNTER_END", "EncounterEndHandler")
	WipeCount:RegisterEvent("ENCOUNTER_START", "EncounterStartHandler")


	local options = {
    name = "WipeCount",
    handler = WipeCount,
    type = 'group',
    args = {
        msg = {
            type = 'input',
            name = 'My Message',
            desc = 'The message for my addon',
            set = 'SetMyMessage',
            get = 'GetMyMessage',
        },
    },
}



	self.db = LibStub("AceDB-3.0"):New("WipeCountDB")

	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(db)

	LibStub("AceConfig-3.0"):RegisterOptionsTable("WipeCount", options, {"myslash"})


end

function WipeCount:OnEnable()
	 mainWindow:SetDisabled(false)
end

function WipeCount:OnDisable()
	-- Lots of Kappa
	-- Never Disable
	mainWindow:SetDisabled(true)
end

