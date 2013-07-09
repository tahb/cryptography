#########################
### AUTHOR TOM HIPKIN 2012 ### 
#########################

##### This Ruby code was created and tested in a Rails environment
##### To test you would need to install ruby, rails and rubygems. 
##### Create a rails application and configure it (see link) 
##### Start a local server and put this code into the application controller and check
##### the server logs for the decryptions on GET request to that action
##### http://rubyonrails.org/download 

##### Using one method

#   Assign variables
alphabet = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
letter_count = { "A" => 0, "B" => 0, "C" => 0, "D" => 0, "E" => 0, "F" => 0, "G" => 0, "H" => 0, "I" => 0, "J" => 0, "K" => 0, "L" => 0, "M" => 0, "N" => 0, "O" => 0, "P" => 0, "Q" => 0, "R" => 0, "S" => 0, "T" => 0, "U" => 0, "V" => 0, "W" => 0, "X" => 0, "Y" => 0, "Z" => 0 }

@answer = []

# Input encrypted message
encryption = "KAXKLTRBGZPBMAMXGWXKKTBEEXKRPARFTBWRAXYKXJNXGMERPBMANGVHGLVBHNLBKHGRZTOXAXKMABLIXMGTFXMAXIKXMMBXLMFBEDXKBOXZHMBGFRWTBKRRHNFNLMGMZXMLHYTZZXWTLMABLTMMAXYBKLMUKXTMAHYLNFFXKPXTMAXKHKPXLATEEUXYBGXERINMMHYHKPTGMHYXXURWHZWTRLLATGMPXFKVETKXBPTLYTBGMTGWBMABGDBTFUXMMXKHNMHWHHKLLAXLTBWFXVATGBVTEERTGWWBLTIIXTKXWHNMLBWXYHKMNGTMXERYHKAXKMAXFBEDBGMAXKXOHEOBGZVANKGTMMATMFHFXGMVATGZXWBMLLJNTLABGZYHKTWXVBWXWYEBVDYETVDMBLVHFBGZVKBXWFKLVKBVDTGWMAXTMMXGMBHGHYTEEPTLVTEEXWHYYYKHFMXLLMATMYTBKLNYYXKXKLHHGKXVHOXKXWAXKLXEYXQMXKGTEERUNMLAXKXFTBGXWFNVAWXIKXLLXWTEEMAXTYMXKGHHGPAXGMAXXOXGBGZFBEDBGZPTLWHGXLAXWBWGHMVTKXMHUXPBMAMAXKXLMHYMAXFTGWPXGMHNMHYWHHKLPTGWXKBGZTEHGZLAXDGXPGHMPABMAXKLAXPTLPKXMVAXWHLHPKXMVAXWTMMAXIXKVXIMBHGMATMMHAXKVHFITGBHGLMAXWTBKRFTGLLMHKRATWUXXGKTMAXKTANFHKHNLGTKKTMBHGMATGHMAXKPBLXGHGXHYMAXFUNMAXKLXEYLXXFXWMHLXXMAXLHKKHPHYBMMHTVXKMTBGMRG"

#  Frequency Analysis - Find the most common letter and calc distance to E and assign as shift
sorted_message = encryption.chars.sort { |a,b| a <=> b}

sorted_message.each do |char|
    letter_count[char] += 1
end

most_common_index = alphabet.index(letter_count.sort{|a,b| a[1] <=> b[1]}.last[0])
shift = most_common_index -  (alphabet.index("E"))

# Using the shift amount go over each letter and move it to the left that amount
encryption.each_char do |letter|
    current_index = alphabet.index(letter)
    new_letter = alphabet.fetch(((current_index) - shift).modulo(alphabet.length))
    @answer << new_letter
end

# Print out the answer
logger.warn "DECRYPTION IS: #{@answer}"