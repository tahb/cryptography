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
    answer = []  
    
# Insert key range given
    key = 6
    
# Create array of common English word endings to pattern match against    
    common_endings = ["ING", "TION", "SION", "TH", "THE", "AGE", "DER", "TER", "THER", "ECT", "ELY", "LLY"]

# Input encrypted message
    @encrypted_message = "ODPOSEWIYMIINTLMDMONDIITLLBEASNFDEDRHTTLUNHDEPEHAHOSMLEONMTETUTDTTDSTTMSTDESNGSEFRLDEPDHBNOPHAHELPTREITGHMORPENEDNAIHRDODIMESVGRIUEHGSAAHOMNERTHTNWHEENDBUTTHOVEEQRIDDOTTLEWDATHENHRRFETSAHEATUONTEMCWATHEHOAHOCEGAAETUEIRIIWIHTSRMNETNSFDAITEHOMNIEVNEHTHDAVNAFHAAAGTIVEHARNOHISANNAEMOEFRSAATHEATIUEGAOLHBPLFEHEEEIYAEHNUUWLECFEFOISFRDNRNNDTWADEUHWEWEREREEDTEOREOUWHESNWDERLTHTSCKNTGEYARHCILKTSEAHUMCENEEHEOKCABRTVTOFUONTTSTLABYENDPICWENFHHIPTAFGINDHDRENTAEEEECOEAHEMCEFFAOONIGOEAOFHEHJTRHOHEGTHHIOHSGWJSETEEIAYPFEETSOINESDRLEFTILEAFAPMEGAGTORSTRLCAWIEAITPOAHATNEFPTAOIIHTHESDSIYNIEEKINDUEEAYPHOAWIBNHTAGOCETLHTGESCWPFDHREONNAONAFSEPKSEYTAHPENILRELEHAETEEWEWLTREENESWANTEGGOHIBNICTTONFIRYNIOEDSGNENENDTTIENROATYIHTRREEESHRTOAEPIIFAANDSAFTAHTGHOWIEOIRRSTSMEOEASHODOLSEHSSENTUWDWHHFORYNHETTTNIAOAWEOTHEEFASTROIKKOIHSRCANOONOESESNEHSLTEEINTLRDEOEHEL"
# For each key in the range, run the transposition method, which returns an answer based on that column count
    groups = transposition_decrypter(key)
    col_length = (@encrypted_message.length) / key
      
# Create an array with all different permutations of numbers 1-6 to use in moving the 'groups' columns around to find the correct order!
    permutations = [1,2,3,4,5,6].permutation.to_a

# For each permutation move all letters in all columns into a new order defined by permutation. Eg [2,5,4,6,1,3]
    permutations.each do |permutation|
      final_answer = []
      matches = []
      
      col_length.times do |i|
        answer = []
        
        answer << groups[permutation[0]][i]
        answer << groups[permutation[1]][i]
        answer << groups[permutation[2]][i]
        answer << groups[permutation[3]][i]
        answer << groups[permutation[4]][i]
        answer << groups[permutation[5]][i]

# Check the answer which is created and see how many word suffixes are included in it, store this value in a matches array
        common_endings.each do |ending|
          if answer.to_s.include?(ending)
            matches << ending
          end
        end
        
# If after all the word suffixes have been checked for, the found number is greater than 50 (this number will need to change for different decryptions)
# If this is the case compile this answer again and put it into a final answer and stop. Otherwise tell us what each permutations failed with how many matches.
        if matches.length > 50
          logger.warn "#{permutation} = CORRECT"
          col_length.times do |i|
            final_answer << groups[permutation[0]][i]
            final_answer << groups[permutation[1]][i]
            final_answer << groups[permutation[2]][i]
            final_answer << groups[permutation[3]][i]
            final_answer << groups[permutation[4]][i]
            final_answer << groups[permutation[5]][i]
          end
          logger.warn final_answer
          return 
        else
          logger.warn "#{permutation} = NOT ENOUGH MATCHES #{matches.length}"
        end
      end             
    end
      
  end
  
  
private  

  def transposition_decrypter(key) 
# Calculate the length of columns based on the message length and how many letters in this key attempt
    col_length = (@encrypted_message.length) / key

    answer = []
      
    group_count = 0
    groups = {}

# Create character groups for each column + 1 so we start at 1 for readability
    (key + 1).times do |n|
      groups.merge!({n => [] })
    end

# Split all characters into groups of the pre determined col_length using modulo, associated with their group number. 
# The first group of 168 chars have group number 1. When the chars index gets to 168, start adding the chars to the next group.
# Going along until all chars are grouped by their columns. In this case evenly with no remainder.
     @encrypted_message.chars.each_with_index do |char, index|
      if index.modulo(col_length) == 0
        group_count = group_count + 1
      end
      groups[group_count] << char
     end
     
    groups
  end