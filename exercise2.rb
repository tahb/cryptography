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

alphabet = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
@answer = []

key = "TESSOFTHEDURBERVILLES"
message =  "BSFZOIULIQAIBRKZLTYSTXHAWBHXAS"

# Create new key that repeats over the whole length of the encrypted text    
new_key = ""
(message.length / key.length).times { |x| new_key << key }
key[0, (message.length.modulo(key.length))].map{|x| new_key << x}    

# Count is -1 because we want the first iteration to be 0
count = -1
shift = 0

# As key and message are the same length, iterate over the key and find each chars index. Then find the same index in the message and shift that character left by that amount
new_key.each_char do |key_letter|
  count += 1
  shift = alphabet.index(key_letter)
  current_index = alphabet.index(message[count].chr)
  new_letter = alphabet.fetch(((current_index) - shift).modulo(alphabet.length))
  @answer << new_letter
end

# Print out the answer
logger.warn "DECRYPTION IS: #{@answer}"