#########################
### AUTHOR TOM HIPKIN 2012 ### 
#########################

##### This Ruby code was created and tested in a Rails environment
##### To test you would need to install ruby, rails and rubygems. 
##### Create a rails application and configure it (see link) 
##### Start a local server and put this code into the application controller and check
##### the server logs for the decryptions on GET request to that action
##### http://rubyonrails.org/download 

##### Using multiple methods

  def index
# Assign variables  
    @alphabet = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
    
    @key = ""
    @key_length = 7
    @answer = []

# Input encrypted message
    @encrypted_message = "WICTJQLUCSWRNAWMCXFNGGQEGGQRKZOUUNUGRNHRGEWDNVBODOVRBGQDFYSIENQYOHFHRWWPNJFDDDXUGVXXKGYDINUHJWTERQYOHTYNVKROGGQBXZMXARQWAETYRQYNOUFYLLZACQALNVLGLFLLCAUVWDDOUVNWGLJURUQHJZACQJVDDGWGKUMNHIUNUWOHTLUHLCEGTXDFYSWRFDKVBHBAEWYICGXWZZPTNAOQVIGBOWZZFDENGSRNIUNBZZAGQQHJAODGBWWKSINYDDJNVGQHZVRSEXDVVSHUNVLZPERMRMOTDUNUXPLACJFWZVTARCRCOERMVZZWDHUGODNPAMWZJUVUFLLCOJGJQQKAGGRFMGAGENVHZCISXUZZRDJWYAMTJROHDOGANMWZVTHUNKSYBTRWSJZVTACHVRRDAPLFBHTEOUAZNSJQHFHOBRWWSMIALCHEKTTQKBUGAGRRWOVSPLNDJVGDNUOTPTPQJBLCAIPUDJZHPQVDJMITQCHKNACQXQDTAURFGSTSARBVLCACNHHSMTWNCKWCASONHFVBHRWWXMOBUNUKOIAYCRKOAGGXQSWRXFTZSGKPAMRFNURUJQWMRPAMDKCEGFXQSYRNPUHSMWXACUQHOGARQYOHGBDJZOHTEJUWAITQJLJJFIUNVWXHPYTBZJGHOJFCNWPFWRLYEEENVKDNVNWGLCEGRRVFJDDHKWLCAIUNUVMEPZJWKOAGGRQYRAHGXZAITWRQHSMTDSQHJHOIUNUAILPJCHDGHTEFKGGEWVBWGMYIBCKSOLPQHHFGIHGQHJJNWRAVAYEPAMVGBAXAKDUFTWRCUMVNIVWW"

# Split the message into equal sections of key length
    grouped_encryption = @encrypted_message.chars.each_slice(@key_length).to_a 
    groups = {}

# Create character groups for each element in key
    @key_length.times do |n|
      groups.merge!({n => "" })
    end
    groups = groups.sort_by { |key, value| key }

# For each section of encrypted text, go over each character and group them all by index
    grouped_encryption.each do |sub_array|
      sub_array.each_with_index do |character, index|
        groups[index].last << character
      end
    end
    
# For each group find the shift amount for each place in the key using most_common 
    key_shift = []
    groups.each do |key, value|
      key_shift << most_common(value.to_s)
    end
    
# The most probable key based on frequency analysis 
    possible_key = ""
    key_shift.each do |index|
      possible_key << @alphabet.fetch(index)
    end
    
#  Tweak the key visually from the answer for full correctness
    possible_key[2] = "A"
    possible_key[3] = "P"
    logger.warn "KEY: " + possible_key
    vinegar_decrypter(possible_key)
  end
  
  
private  
  def cesear_decrypter(encryption, shift)
  # Using the shift amount go over each letter and move it to the left that amount
    encryption.each_char do |letter|
        current_index = @alphabet.index(letter)
        @answer << @alphabet.fetch(((current_index) - shift).modulo(@alphabet.length))
    end  
  end

  def most_common(encryption)
  # Frequency analysis
    @letter_count = { "A" => 0, "B" => 0, "C" => 0, "D" => 0, "E" => 0, "F" => 0, "G" => 0, "H" => 0, "I" => 0, "J" => 0, "K" => 0, "L" => 0, "M" => 0, "N" => 0, "O" => 0, "P" => 0, "Q" => 0, "R" => 0, "S" => 0, "T" => 0, "U" => 0, "V" => 0, "W" => 0, "X" => 0, "Y" => 0, "Z" => 0 }

    sorted_message = encryption.chars.sort { |a,b| a <=> b }
    sorted_message.each do |char|
      @letter_count[char] += 1
    end
    
# Take the most common character's index, and minus it from the index of E to give the shift amount
    shift = @alphabet.index(@letter_count.sort{|a,b| a[1] <=> b[1]}.last[0]) - (@alphabet.index("E"))
    shift = shift.modulo(@alphabet.length)
    
    shift
  end
  
  def vinegar_decrypter(key)
    # Create new key that repeats over the whole length of the encrypted text    
    new_key = ""
    (@encrypted_message.length / key.length).times { |x| new_key << key }
    key[0, (@encrypted_message.length.modulo(key.length))].map{|x| new_key << x}    
    
    count = -1
    shift = 0
    
    # As key and message are the same length, iterate over the key and find each chars index. Then find the same index in the message and shift that character left by that amount
    new_key.each_char do |key_letter|
      count += 1
      shift = @alphabet.index(key_letter)
      current_index = @alphabet.index(@encrypted_message[count].chr)
      new_letter = @alphabet.fetch(((current_index) - shift).modulo(@alphabet.length))
      @answer << new_letter
    end
    
    # Print out the answer
    logger.warn "DECRYPTION: #{@answer}"
  end
end