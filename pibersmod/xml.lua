PibersMod.XMLToTable = {}
PibersMod.XMLToTable[XMLNode.ENTITY] = {}
PibersMod.XMLToTable[XMLNode.ENTITY]["collectionsprite"] = PibersMod.CollectionPageIconOverridePickup
PibersMod.XMLToTable[XMLNode.ENTITY]["collectionframe"] = PibersMod.CollectionPageIconOverridePickup
PibersMod.XMLToTable[XMLNode.ITEM] = {}
PibersMod.XMLToTable[XMLNode.ITEM]["extracostume"] = PibersMod.ExtraCostumes
PibersMod.XMLToTable[XMLNode.ITEM]["collectionsprite"] = PibersMod.CollectionPageIconOverrideCollectibles
PibersMod.XMLToTable[XMLNode.ITEM]["collectionframe"] = PibersMod.CollectionPageIconOverrideCollectibles
PibersMod.XMLToTable[XMLNode.TRINKET] = {}
PibersMod.XMLToTable[XMLNode.TRINKET]["collectionsprite"] = PibersMod.CollectionPageIconOverrideTrinket
PibersMod.XMLToTable[XMLNode.TRINKET]["collectionframe"] = PibersMod.CollectionPageIconOverrideTrinket
PibersMod.XMLToTable[XMLNode.CARD] = {}
PibersMod.XMLToTable[XMLNode.CARD]["collectionsprite"] = PibersMod.CollectionPageIconOverrideCard
PibersMod.XMLToTable[XMLNode.CARD]["collectionframe"] = PibersMod.CollectionPageIconOverrideCard
PibersMod.XMLToTableUseAsID = {}
PibersMod.XMLToTableUseAsID[XMLNode.ENTITY] = "subtype"
PibersMod.XMLToTableIndex = {}
PibersMod.XMLToTableIndex[XMLNode.ENTITY] = {}
PibersMod.XMLToTableIndex[XMLNode.ENTITY]["collectionsprite"] = 1
PibersMod.XMLToTableIndex[XMLNode.ENTITY]["collectionframe"] = 2
PibersMod.XMLToTableIndex[XMLNode.ITEM] = {}
PibersMod.XMLToTableIndex[XMLNode.ITEM]["collectionsprite"] = 1
PibersMod.XMLToTableIndex[XMLNode.ITEM]["collectionframe"] = 2
PibersMod.XMLToTableIndex[XMLNode.TRINKET] = {}
PibersMod.XMLToTableIndex[XMLNode.TRINKET]["collectionsprite"] = 1
PibersMod.XMLToTableIndex[XMLNode.TRINKET]["collectionframe"] = 2
PibersMod.XMLToTableIndex[XMLNode.CARD] = {}
PibersMod.XMLToTableIndex[XMLNode.CARD]["collectionsprite"] = 1
PibersMod.XMLToTableIndex[XMLNode.CARD]["collectionframe"] = 2
PibersMod.XMLToTableVerifyCostume = {}
PibersMod.XMLToTableVerifyCostume["extracostume"] = "gfx/characters/"
PibersMod.XMLToTableVerifySprite = {}
PibersMod.XMLToTableVerifySprite["collectionsprite"] = "gfx/ui/"
PibersMod.XMLToTableVerifyNumber = {}
PibersMod.XMLToTableVerifyNumber["collectionframe"] = true
function PibersMod.ParseXMLNode(node)
	if PibersMod.XMLToTable[node] then
		for index=0, XMLData.GetNumEntries(node) do
			local data = XMLData.GetEntryByOrder(node, index)
			local useID = "id"
			if PibersMod.XMLToTableUseAsID[node] then
				useID = PibersMod.XMLToTableUseAsID[node]
			end
			if data and data[useID] then
				for xmlAttribute, addToTable in pairs(PibersMod.XMLToTable[node]) do
					if data[xmlAttribute] then
						local attribute = data[xmlAttribute]
						local goodToAdd = false
						local shouldForceNumber = false
						local shouldForceNoString = false

						if PibersMod.XMLToTableVerifyCostume[xmlAttribute] then
							attribute = Isaac.GetCostumeIdByPath(PibersMod.XMLToTableVerifyCostume[xmlAttribute] .. attribute .. ".anm2")
							shouldForceNoString = true
							shouldForceNumber = true

						elseif PibersMod.XMLToTableVerifySprite[xmlAttribute] then
							attribute = Sprite(PibersMod.XMLToTableVerifySprite[xmlAttribute] .. attribute .. ".anm2", true)
							attribute:SetFrame(attribute:GetDefaultAnimation(), 0)
							shouldForceNoString = true

						elseif PibersMod.XMLToTableVerifyNumber[xmlAttribute] then
							attribute = tonumber(attribute)
							shouldForceNoString = true
							shouldForceNumber = true
						end

						if type(attribute) == "string" and tonumber(attribute) then
							attribute = tonumber(attribute)
						end

						if shouldForceNoString then
							if type(attribute) ~= "string" then
								if shouldForceNumber then
									if type(attribute) == "number" then
										goodToAdd = true
									end
								else
									goodToAdd = true
								end
							end
						else
							goodToAdd = true
						end

						if goodToAdd then
							if PibersMod.XMLToTableIndex[node] and PibersMod.XMLToTableIndex[node][xmlAttribute] then
								addToTable[tonumber(data[useID])] = addToTable[tonumber(data[useID])] or {}
								addToTable[tonumber(data[useID])][PibersMod.XMLToTableIndex[node][xmlAttribute]] = attribute
							else
								addToTable[tonumber(data[useID])] = attribute
							end
						end
					end
				end
			end
		end
	end
end
function PibersMod:OnModsLoadedXML()
	PibersMod.ParseXMLNode(XMLNode.ENTITY)
	PibersMod.ParseXMLNode(XMLNode.ITEM)
	PibersMod.ParseXMLNode(XMLNode.TRINKET)
	PibersMod.ParseXMLNode(XMLNode.PILL)
	PibersMod.ParseXMLNode(XMLNode.CARD)
end
PibersMod:AddPriorityCallback(ModCallbacks.MC_POST_MODS_LOADED, CallbackPriority.LATE, PibersMod.OnModsLoadedXML)
