import re

words = []

def add_to_bank(file_name: str):
    global words
    word_bank = []
    unwanted_chars = [".",",",":","?",";","!","&","-","/","\"","—"]

    file = open(file_name, "r")
    quotes = file.read()
    file.close()

    # Get rid of bad characters
    word_bank = re.split("\s", quotes)
    word_bank = [x for x in word_bank if x != "@"]
    word_bank = [x for x in word_bank if x != ""]
    word_bank = [x for x in word_bank if x != "—"]
    for index in range(len(word_bank)):
        for c in unwanted_chars:
            word_bank[index] = word_bank[index].replace(c,"")
		# Lowercase
        word_bank[index] = word_bank[index].lower()
    words.extend(word_bank)

def array_unique(array: list) -> list:
	unique: list = []

	for item in array:
		if item not in unique:
			unique.append(item)
	return unique

add_to_bank("quotes1.txt")
add_to_bank("quotes2.txt")
add_to_bank("quotes3.txt")
add_to_bank("quotes4.txt")
add_to_bank("quotes5.txt")
add_to_bank("quotes6.txt")

words = array_unique(words)
words.sort()
print(words)
output_file = open("temp_dictionary.txt", "w")
for word in words:
      output_file.write(word + '\n')