class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(new_word)
    
    #if new_word == ''
    #  raise(ArgumentError)

    #end
    
    @word = new_word
    @guesses =""
    @wrong_guesses = ""
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
  
    if letter == '' || letter == nil
      raise ArgumentError
    end
    
    letter.downcase!
  
    if !(letter !~ /[^a-z]/)
      raise ArgumentError
    end
  
  
    guesses.each_char do |this_letter|
      
      if this_letter == letter
        return false
      end
      
    end  
  
    wrong_guesses.each_char do |this_letter|
      
      if this_letter == letter
        return false
      end
      
    end  
  
    word.each_char do |this_letter|
      
      if this_letter == letter
        @guesses << letter
        return true
      end
      
    end
    
    @wrong_guesses << letter
    return true
  end
  
  def word_with_guesses
  
    display = ''
    
    word.size.times do
      
      display << '-'
    end
  
    word.each_char.with_index do |this_letter,i|
      
      if guesses.include? this_letter
        display[i] = this_letter
      end
      
    end
    
    return display
    
  end
  
  def check_win_or_lose
    
    if self.word_with_guesses == word
      return :win
    end
    
    if wrong_guesses.size > 6
      return :lose
    end
    
    return :play
    
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses


end
