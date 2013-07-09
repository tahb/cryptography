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
    key_range = [4,5,6,7,8]
    
# Create array of common English words to pattern match against
    english_common_words = ["HAVE", "WITH", "BACK", "AFTER", "USE", "TWO", "HOW", "OUR", "WORK", "FIRST", "WELL", "WAY", "EVEN", "NEW", "WANT", "BECAUSE", "ANY", "THESE", "GIVE", "DAY", "MOST", "PEOPLE", "INTO", "YEAR", "YOUR", "GOOD", "SOME", "COULD", "THEM", "SEE", "OTHER", "THAN", "THEN", "NOW", "LOOK", "ONLY", "COME", "ITS", "OVER", "THINK", "ALSO"]
    
# Input encrypted message
    @encrypted_message = "TAEEEHDESTNUNOAINSAOILETCCTEOTADYTMANPDOLMANIBADIAIRMTEROETXOEUASTGQRLWESEEDHBLEOAAFNEEDWEHNRLISATNXGNNSCUHIENIUSEMSMGACLESGLEAFTAFOMTOAPSALSIYRNEETAYTTGUISETNISTCYOIHTUTDEHHADOATUEMCTGARSNNNIUHSKTXHTBDIMAATUOAHPETCEAEEDUSSTDRAIAXIAHFSELHOTADIAOCILOESLOIIIAERRIVEAEARSMTTRAIRNAWTYODLIODDTCMHHLTLBSRDNHTEOMNAHLOINITREFSHLSOEHILKCGHTTSEOSETAISANIPIOAFNIRDTORTRLANWAHDVCNSESMIAHTLETRNENNNTSYNWWYNNNNRSIANERSTBATOIHKGOTDREUIMMENRETLOAEOAOOUSIIGEHSFMGNADOLTMHTSTTADSNTENDWOFOHIEPFDDILNCNELPNTREDCOTLNEDVONDENEUICGADOEMNEEYWAATDTDSIFTTBARAFGTRASTKRTIIONRDOIOINEHERRNEONTTCOEUNSFNFFSDCNTFESREWATNRYIWETMHATBCPHOASONOUESUAWETNFCUDDIEIHTNIHPOESDUIODELYMRLOLNTWFSDIRYANVMMHITNARHASEBRHEINTISIINTVKIENSFNPSENEAISNDHHISANIOEDHHIITDHENIENIMWOEIFISRAENWEOLARLTRNRRBHMGOVOCETRRFERNEEGNHOSHITRLKSDLOABLRYNONOEHRNESEAIAINRGMEESDALAIRADOCNNNGLEOCROWIAOSRTNLG"
      
# For each key in the range, run the transposition method, which returns an answer based on that column count
    key_range.each do |key|
      answer = transposition_decrypter(key)
      matches = 0
      
# With this answer check to see how many of the most common words appear within it
      english_common_words.each do |word|
        if answer.to_s.include?(word)
          matches += 1
        end
      end
      
# If there are more than 3 matches in the potential answer then we can assume it is the correct answer
      if matches > 3 
        logger.warn "KEY #{key} = Matches"
        final_answer = answer
        logger.warn "DECRYPTION: #{final_answer}"
        return 
      else
        logger.warn "KEY #{key} = No matches"
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
     
# As each group has an even amount of chars, we can iterate over that many times (168). Each iteration pulls out the same char from each group, adding it to the answer which at the end is the answer.  
     col_length.times do |i|
      (key + 1).times do |j|
        answer << groups[j][i]
      end
     end

    answer
  end
