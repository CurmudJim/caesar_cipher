require 'sinatra'
require 'sinatra/reloader' if development?
enable :sessions

def caesar_cipher(word,offset)
  wordIndex = 0
  rangeCap = (65..90).to_a
  rangeLow = (97..122).to_a
  newWord = ""

  def offsetNumber(array , string , index, number)
    return array.rotate(string[index].ord-array[0]).rotate(number)[0]
  end

  while wordIndex < word.length do
    if rangeCap.include?(word[wordIndex].ord)
      newWord += offsetNumber(rangeCap , word , wordIndex, offset).chr
    else if rangeLow.include?(word[wordIndex].ord)
      newWord += offsetNumber(rangeLow , word , wordIndex, offset).chr
    else
      newWord += word[wordIndex]
    end
    end
      wordIndex += 1
  end

  return(newWord)


  # (word.scan /\w/).each { |x| x.replace (x.ord + (0..25).to_a.rotate(offset)[0]).chr unless (x.scan /\w/)[0].nil?  }.join("")

end



get '/' do
  phrase = params['phrase']
  shift = params['shift'].to_i
  if shift == 0
    @result = nil
  else
    @result = caesar_cipher(phrase,shift)
  end
  erb :index
end
