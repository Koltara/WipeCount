WipeCount = LibStub("AceAddon-3.0"):NewAddon("WipeCount", "AceConsole-3.0", "AceEvent-3.0")




function WipeCount:MySlashProcessorFunc(input)
	--Slash Function
end


function WipeCount:EncounterEndHandler(eventName, encounterID, encounterName, difficultyID, raidSize, endStatus)

end



function WipeCount:OnInitialize()

	WipeCount:RegisterChatCommand("myslash", "MySlashProcessorFunc")

	WipeCount:RegisterEvent("ENCOUNTER_END", "EncounterEndHandler")
	WipeCount:RegisterEvent("ENCOUNTER_START", "EncounterStartHandler")


	local options = {
    name = "MyAddon",
    handler = MyAddon,
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

end

function WipeCount:OnDisable()
	-- Lots of Kappa
	-- Never Disable
end

function
