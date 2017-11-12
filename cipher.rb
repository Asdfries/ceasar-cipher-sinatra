require 'sinatra'
require 'sinatra/reloader'

def caesar_cipher(code, key)
  ####this makes a hash to use as a cypher###
  @keygen = ("a".."z").to_a
  
  #changes one letter to the desired coded letter check for punctuation and CAPS###
  def codex(x, y)
    if x == " " || x == "." || x == "!" || x== "?" ||x== "," || x == "  " || x == "'"
      return x 
    else
      if x === x.upcase
        itscaps = true
        x.downcase!
      end
      
      changer = @keygen.index(x) + y
        while changer > 25
          changer -= 26
        end
    end
    if itscaps == true
      return @keygen[changer].upcase
      itscaps = false
    else
      return @keygen[changer]
    end
  end
  
  @answer = Array.new
  
  ###takes the coded message from an array and creates a string###
  code.each_char do |i|
    @answer.push(codex(i,key))
  end
  
  @answer.join()
end
def unciipher(code, key)
   key = key - key - key
   caesar_cipher(code,key)
end

get '/' do
  message = params["message"]
  key = params["key"]
  secret = params["secret"]
  solver = params["solver"]
  encript = caesar_cipher(message.to_s, key.to_i)
  decript = unciipher(secret.to_s, solver.to_i)
  erb :index, :locals =>{:message => message, :key => key, :encript => encript, :secret => secret, :solver => solver, :decript => decript}
end
