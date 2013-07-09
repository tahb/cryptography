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
    @answer = []

  # Import the tess27 file and count all characters  
    @file_letter_count = { "A" => 0, "B" => 0, "C" => 0, "D" => 0, "E" => 0, "F" => 0, "G" => 0, "H" => 0, "I" => 0, "J" => 0, "K" => 0, "L" => 0, "M" => 0, "N" => 0, "O" => 0, "P" => 0, "Q" => 0, "R" => 0, "S" => 0, "T" => 0, "U" => 0, "V" => 0, "W" => 0, "X" => 0, "Y" => 0, "Z" => 0, "|" => 0 }

    @file = File.read("/Users/tomhipkin/Desktop/tess27.txt")
    
    @file.chars.each do |char|
      @file_letter_count[char] += 1
    end

  # Sort the hash so that the most occuring letters are at the front
    @file_letter_count = @file_letter_count.sort{|a,b| b[1] <=> a[1]}
    
  # Input encrypted message
    @encrypted_message = "MHKYJHYWCHSLGQMUMCHKLQYHQYMHTOMWQMGQHWQQMUQLJUHGYMHOMAMWQMCHQYMHWOTEVMUQHWUCHCEORMODLSSMHQYJETYQFESSBHVEOVEOMCHQYMHKJOCGHWFQMOHYMOHWUBQYLUTHMSGMHYMHAOMGMUQSBHWG|MCHYMHGWLCHWQHWUJQYMOHQLVMHGJVMQYLUTHSL|MHQYLGHWUCHGYMHTWDMHWUJQYMOHKYLXYHVLTYQHAJGGLRSBHYWDMHRMMUHAWOWSSMSMCHLUHVWUBHWHKJO|HJFHQYMHAMCLTOMMHOWUTLUTHFOJVHQYMHCLXQLJUUWLOMHAYLSJGJAYLIEMHQJHYEPSMBGHMGGWBGHWYHYWHYJKHCJHBJEHOMVMVRMOHQYMVHLHKWUQMCHQJHRMSLMDMHKYWQHYMHRMSLMDMCHQYJETYHYMHCLCUQHKLGYHVMHQJHWUCHLHVWUWTMCHQJHXJWPHYLVHQJHQMSSHVMHWHFMKHJFHYLGHQYJETYQGHLHXWUQHGWBHLHIELQMHEUCMOGQWUCHQYWQHJUMHREQHLH|UJKHLQHLGHOLTYQHYVHFWUXBHBJEOHRMLUTHWRSMHQJHQMWXYHVMHKYWQHBJEHCJUQH|UJKHBJEOGMSFHYMHFMSSHLUQJHQYJETYQHWUCHGJHLHQYOMKHLUHVBHGALOLQEWSHSJQHKLQYHYLGHGYMHOMGEVMCHLHCLCUQHKLGYHLQHQJHRMHCLFFMOMUQHKYWQGHTJJCHMUJETYHFJOHYLVHLGHTJJCHMUJETYHFJOHVMHCJMGHYMH|UJKHQYWQHBJEHWOMHWGHRLTHWUHLU"
    
  # Convert the string to an array so that later I can replace each element via its index
    @encrypted_message_a = [] 
    @encrypted_message.chars.each do |char|
      @encrypted_message_a << char
    end

  # Count up all the letters in the cryption in the same was as the file 
    @letter_count = { "A" => 0, "B" => 0, "C" => 0, "D" => 0, "E" => 0, "F" => 0, "G" => 0, "H" => 0, "I" => 0, "J" => 0, "K" => 0, "L" => 0, "M" => 0, "N" => 0, "O" => 0, "P" => 0, "Q" => 0, "R" => 0, "S" => 0, "T" => 0, "U" => 0, "V" => 0, "W" => 0, "X" => 0, "Y" => 0, "Z" => 0, "|" => 0 }

    @encrypted_message_a.each do |char|
      @letter_count[char] += 1 
    end
    
  # Sort the messages characters in order of highest appearence, mirroring the file count 
    @letter_count = @letter_count.sort{|a,b| b[1] <=> a[1]}
    
    
  # Create a new array with only the characters
    my_order = []
    @letter_count.each do |array|
      my_order << array.first    
    end
    file_order = []
    @file_letter_count.each do |array|
      file_order << array.first
    end

  # Create change hash which contains the mappings that each character will go to
    change = {}
    my_order.each_with_index do |letter, index|
      key = letter
      value = file_order[index]
      change.merge!({key => value})
    end

  # Manually editing the hash map where frequency analysis doesn't cover.
  # Use a '+' symbol quickly analyse the decryption for un mapped chars.
    change["L"] = "I"
    change["U"] = "N"
    change["N"] = "+"
    change["W"] = "A"
    change["Y"] = "H"
    change["J"] = "O"
    change["K"] = "W"
    change["T"] = "G"
    change["F"] = "F"
    change["B"] = "Y"
    change["R"] = "B"
    change["X"] = "C"
    change["|"] = "K"
    change["D"] = "V"
    change["I"] = "Q"
    change["P"] = "X"
    
  # Go over each character in the encrypted message and replace it with the mapped element in the change hash
    @encrypted_message_a.each_with_index do |char, index|
      @encrypted_message_a[index] = change[char]
    end

    @answer = @encrypted_message_a.to_s
    
    logger.warn "ANSWER"
    logger.warn @answer
  end