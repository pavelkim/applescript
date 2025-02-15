#!/usr/bin/osascript
--
-- Password generator for macos
-- ============================
--
--
-- GitHub repository: 
-- https://github.com/pavelkim/applescript
--
-- Community support:
-- https://github.com/pavelkim/applescript/issues
--
-- Copyright 2015-2025, Pavel Kim - All Rights Reserved
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--

on get_animals_password(number_of_animals)
	set the_numbers to "0123456789"
	set the_animals to {�
		"Alligator", "Cricket", "Grasshopper", "Monkey", "Salmon", �
		"Alpaca", "Crocodile", "Hamster", "Moose", "Sardine", �
		"Ant", "Deer", "Hare", "Mosquito", "Seahorse", �
		"Antelope", "Dog", "Hawk", "Moth", "Seal", �
		"Ape", "Dolphin", "Hedgehog", "Mouse", "Skink", �
		"Armadillo", "Donkey", "Hornet", "Octopus", "Skunk", �
		"Baboon", "Dove", "Horse", "Opossum", "Sloth", �
		"Badger", "Dragonfly", "Human", "Ostrich", "Snail", �
		"Bat", "Duck", "Hyena", "Otter", "Snake", �
		"Bear", "Eagle", "Ibex", "Owl", "Spider", �
		"Beaver", "Earthworm", "Iguana", "Ox", "Squirrel", �
		"Bedbug", "Eel", "Impala", "Oyster", "Starfish", �
		"Bee", "Elephant", "Jaguar", "Panda", "Swan", �
		"Beetle", "Emu", "Jellyfish", "Panther", "Termite", �
		"Bird", "Falcon", "Kitten", "Parrot", "Tick", �
		"Buffalo", "Ferret", "Koala", "Pelican", "Tiger", �
		"Bull", "Fish", "Ladybug", "Penguin", "Toad", �
		"Butterfly", "Flamingo", "Lemur", "Pig", "Toucan", �
		"Camel", "Flea", "Leopard", "Pigeon", "Turkey", �
		"Capybara", "Fly", "Lice", "Piglet", "Turtle", �
		"Cat", "Fox", "Lion", "Pony", "Walrus", �
		"Caterpillar", "Frog", "Lizard", "Porcupine", "Wasp", �
		"Cheetah", "Gazelle", "Llama", "Rabbit", "Weasel", �
		"Chicken", "Gecko", "Lobster", "Raccoon", "Whale", �
		"Cobra", "Giraffe", "Manatee", "Ram", "Wolf", �
		"Cockroach", "Goat", "Meerkat", "Rat", "Wombat", �
		"Cow", "Goose", "Mole", "Raven", "Worm", �
		"Crab", "Gorilla", "Mongoose", �
		"Salamander"}
	
	set return_list to {}
	set the_first_part to ""
	
	repeat number_of_animals - 1 times
		set random_animal_idx to random number from 1 to (count the_animals)
		set end of return_list to (item (random_animal_idx) of the_animals)
	end repeat
	
	set my text item delimiters to "+"
	set the_first_part to return_list as string
	
	set random_animal_idx to random number from 1 to (count the_animals)
	
	set my text item delimiters to "="
	return {the_first_part, (item (random_animal_idx) of the_animals) as string} as string
	
end get_animals_password

on get_password(password_lenght)
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
	
	set difficulties to {"Easy", "Regular", "Strong", "Strongest"}
	set modes to {"Animals", "Random"}
	
	set desired_mode to choose from list modes with title "Choose password mode" default items {"Animals"}
	set desired_strength to choose from list difficulties with title "Choose password strength" default items {"Regular"}
	
	set strengths to {|Animals|:{Easy:2, Regular:3, Strong:8, Strongest:32}, |Rubbish|:{Easy:6, Regular:10, Strong:16, Strongest:64}}
	
	if desired_mode = {"Animals"} then set strength_params to (get Animals of strengths)
	if desired_mode = {"Random"} then set strength_params to (get Rubbish of strengths)
	
	if desired_strength = {"Easy"} then set password_length to get Easy of strength_params
	if desired_strength = {"Regular"} then set password_length to get Regular of strength_params
	if desired_strength = {"Strong"} then set password_length to get Strong of strength_params
	if desired_strength = {"Strongest"} then set password_length to get Strongest of strength_params
	
	show_password_dialog(password_length as number, desired_mode as string)
	
end show_choose_password_length_dialog

on show_password_dialog(password_lenght, mode)
	if mode is missing value then set mode to "Animals"
	
	if mode is "Animals" then
		set random_password to get_animals_password(password_lenght)
	else
		set random_password to get_password(password_lenght)
	end if
	
	display dialog random_password buttons {"Make new", "To Clipboard", "OK"} with icon note default button 2
	
	if result = {button returned:"Make new"} then
		show_choose_password_length_dialog()
	else if result = {button returned:"To Clipboard"} then
		set the clipboard to random_password
	end if
	
end show_password_dialog

show_password_dialog(16, "Random")