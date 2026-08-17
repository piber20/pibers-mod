local mod = PibersMod

mod.XMLToTable = {}
mod.XMLToTable[XMLNode.ENTITY] = {}
mod.XMLToTable[XMLNode.ENTITY]["collectionsprite"] = mod.CollectionPageIconOverridePickup
mod.XMLToTable[XMLNode.ENTITY]["collectionframe"] = mod.CollectionPageIconOverridePickup
mod.XMLToTable[XMLNode.ITEM] = {}
mod.XMLToTable[XMLNode.ITEM]["extracostume"] = mod.ExtraCostumes
mod.XMLToTable[XMLNode.ITEM]["collectionsprite"] = mod.CollectionPageIconOverrideCollectibles
mod.XMLToTable[XMLNode.ITEM]["collectionframe"] = mod.CollectionPageIconOverrideCollectibles
mod.XMLToTable[XMLNode.TRINKET] = {}
mod.XMLToTable[XMLNode.TRINKET]["collectionsprite"] = mod.CollectionPageIconOverrideTrinket
mod.XMLToTable[XMLNode.TRINKET]["collectionframe"] = mod.CollectionPageIconOverrideTrinket
mod.XMLToTable[XMLNode.CARD] = {}
mod.XMLToTable[XMLNode.CARD]["collectionsprite"] = mod.CollectionPageIconOverrideCard
mod.XMLToTable[XMLNode.CARD]["collectionframe"] = mod.CollectionPageIconOverrideCard
mod.XMLToTableUseAsID = {}
mod.XMLToTableUseAsID[XMLNode.ENTITY] = "subtype"
mod.XMLToTableIndex = {}
mod.XMLToTableIndex[XMLNode.ENTITY] = {}
mod.XMLToTableIndex[XMLNode.ENTITY]["collectionsprite"] = 1
mod.XMLToTableIndex[XMLNode.ENTITY]["collectionframe"] = 2
mod.XMLToTableIndex[XMLNode.ITEM] = {}
mod.XMLToTableIndex[XMLNode.ITEM]["collectionsprite"] = 1
mod.XMLToTableIndex[XMLNode.ITEM]["collectionframe"] = 2
mod.XMLToTableIndex[XMLNode.TRINKET] = {}
mod.XMLToTableIndex[XMLNode.TRINKET]["collectionsprite"] = 1
mod.XMLToTableIndex[XMLNode.TRINKET]["collectionframe"] = 2
mod.XMLToTableIndex[XMLNode.CARD] = {}
mod.XMLToTableIndex[XMLNode.CARD]["collectionsprite"] = 1
mod.XMLToTableIndex[XMLNode.CARD]["collectionframe"] = 2
mod.XMLToTableVerifyCostume = {}
mod.XMLToTableVerifyCostume["extracostume"] = "gfx/characters/"
mod.XMLToTableVerifySprite = {}
mod.XMLToTableVerifySprite["collectionsprite"] = "gfx/ui/"
mod.XMLToTableVerifyNumber = {}
mod.XMLToTableVerifyNumber["collectionframe"] = true
function mod.ParseXMLNode(node)
	if mod.XMLToTable[node] then
		for index=0, XMLData.GetNumEntries(node) do
			local data = XMLData.GetEntryByOrder(node, index)
			local useID = "id"
			if mod.XMLToTableUseAsID[node] then
				useID = mod.XMLToTableUseAsID[node]
			end
			if data and data[useID] then
				for xmlAttribute, addToTable in pairs(mod.XMLToTable[node]) do
					if data[xmlAttribute] then
						local attribute = data[xmlAttribute]
						local goodToAdd = false
						local shouldForceNumber = false
						local shouldForceNoString = false

						if mod.XMLToTableVerifyCostume[xmlAttribute] then
							attribute = Isaac.GetCostumeIdByPath(mod.XMLToTableVerifyCostume[xmlAttribute] .. attribute .. ".anm2")
							shouldForceNoString = true
							shouldForceNumber = true

						elseif mod.XMLToTableVerifySprite[xmlAttribute] then
							attribute = Sprite(mod.XMLToTableVerifySprite[xmlAttribute] .. attribute .. ".anm2", true)
							attribute:SetFrame(attribute:GetDefaultAnimation(), 0)
							shouldForceNoString = true

						elseif mod.XMLToTableVerifyNumber[xmlAttribute] then
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
							if mod.XMLToTableIndex[node] and mod.XMLToTableIndex[node][xmlAttribute] then
								addToTable[tonumber(data[useID])] = addToTable[tonumber(data[useID])] or {}
								addToTable[tonumber(data[useID])][mod.XMLToTableIndex[node][xmlAttribute]] = attribute
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
function mod.OnModsLoadedXML()
	mod.ParseXMLNode(XMLNode.ENTITY)
	mod.ParseXMLNode(XMLNode.ITEM)
	mod.ParseXMLNode(XMLNode.TRINKET)
	mod.ParseXMLNode(XMLNode.PILL)
	mod.ParseXMLNode(XMLNode.CARD)
end
mod.AddPriorityCallback(ModCallbacks.MC_POST_MODS_LOADED, CallbackPriority.LATE, mod.OnModsLoadedXML)
