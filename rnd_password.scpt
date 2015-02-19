#!/usr/bin/osascript
#
# Small random_password_generator
#

on get_password(password_lenght)
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
	repeat password_lenght times
		set end of return_list to (item (random number from 1 to (count random_pool)) of random_pool)
	end repeat
	
	return return_list as string
	
end get_password

on show_choose_password_length_dialog()
	
	set difficulties to {"Easy", "Regular", "Strong", "64"}
	
	choose from list difficulties with title "Choose password length" default items {"Regular"}
	
	if result = {"Easy"} then
		show_password_dialog(6)
	else if result = {"Regular"} then
		show_password_dialog(10)
	else if result = {"Strong"} then
		show_password_dialog(16)
	else if result = {"64"} then
		show_password_dialog(64)
	end if
	
end show_choose_password_length_dialog

on show_password_dialog(password_lenght)
	
	set random_password to get_password(password_lenght)
	
	display dialog random_password buttons {"Make new", "To Clipboard", "OK"} with icon note default button 2
	
	if result = {button returned:"Make new"} then
		show_password_dialog(password_lenght)
	else if result = {button returned:"To Clipboard"} then
		set the clipboard to random_password
	end if
	
end show_password_dialog

show_choose_password_length_dialog()