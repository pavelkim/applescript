#!/usr/bin/osascript

on get_password()
	set randomString to ""
	set the_captials to "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	set the_lowers to "abcdefghijklmnopqrstuvwxyz"
	set the_numbers to "0123456789"
	
	set random_pool to {}
	set end of random_pool to the_captials
	set end of random_pool to the_lowers
	set end of random_pool to the_numbers
	
	set random_pool to characters of (random_pool as string)
	
	set return_list to {}
	repeat 12 times
		set end of return_list to (item (random number from 1 to (count random_pool)) of random_pool)
	end repeat
	
	return return_list as string
	
end get_password

on show_password_dialog()
	
	set random_password to get_password()
	
	display dialog random_password buttons {"Make new", "To Clipboard", "OK"} with icon note default button 2
	
	if result = {button returned:"Make new"} then
		show_password_dialog()
	else if result = {button returned:"To Clipboard"} then
		set the clipboard to random_password
	end if
	
end show_password_dialog

show_password_dialog()