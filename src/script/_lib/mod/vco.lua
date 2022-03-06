local vco = {};

function vco:get_faction_keys()
    return ipairs(cm:get_human_factions());
end

function vco:show_how_to_play_message(faction_key)
    local title = "event_feed_strings_text_vco_how_how_to_play_title";                   -- Victory Conditions Overhaul
	local primary_detail = "event_feed_strings_text_vco_how_how_to_play_primary_detail"; -- How To Play
    local secondary_detail = "event_feed_strings_text_vco_how_how_to_play_body";         -- <Custom body>
    local pic = 599;

    cm:show_message_event(faction_key, title, primary_detail, secondary_detail, true, pic);
end

function vco:trigger_faction_missions(mod_name, faction_key)
    local campaign_name = cm:get_campaign_name();

    local status, missions = pcall(require, "script/"..mod_name.."/"..campaign_name.."/"..faction_key.."/missions")
    if status then
        for _, mission in ipairs(missions) do
            if mission and mission ~= "" then
                cm:trigger_custom_mission_from_string(faction_key, mission);
            end
        end

        -- vco:show_how_to_play_message(faction_key);
    end
end

function vco:trigger_custom_missions(mod_name)
    if cm:is_new_game() then
        for _, faction_key in vco:get_faction_keys() do
            vco:trigger_faction_missions(mod_name, faction_key);
        end
    end
end

core:add_static_object("vco", vco);