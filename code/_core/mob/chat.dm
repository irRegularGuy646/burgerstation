/proc/check_spam(var/client/C,var/text_to_check)

	if(!text_to_check)
		C.spam_protection_chat = min(C.spam_protection_chat+2,5)

	if(C.spam_protection_chat > 2)
		C.to_chat(span("warning","You can't talk this fast!"))
		return FALSE

	if(text_to_check)
		if(C.last_message == text_to_check)
			C.spam_protection_chat += 10
		else
			C.spam_protection_chat = min(C.spam_protection_chat+2+(length(text_to_check)*0.01),30)
		C.last_message = text_to_check

	/*
	if(C.spam_protection_chat > 3)
		C.to_chat(span("warning","You are nearing the spam filter check."))
	*/

	return TRUE

/mob/proc/mod_speech(var/text)
	return text

/mob/living/advanced/mod_speech(var/text)
	var/species/S = all_species[species]
	if(!S)
		return text
	return S.mod_speech(src,text)

/mob/proc/to_chat(var/text,var/chat_type = CHAT_TYPE_INFO)

	if(client)
		client.to_chat(text,chat_type)
		return TRUE

	return FALSE


/mob/proc/to_chat_language(var/text, var/chat_type=CHAT_TYPE_INFO, var/language = LANGUAGE_BASIC, var/language_text = "Blah blah blah.")
	if(!length(known_languages) || !known_languages[language])
		return to_chat(language_text,chat_type)
	return to_chat(text,chat_type)


