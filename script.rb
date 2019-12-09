require "mini_magick"

image = MiniMagick::Image.open("ascii-pineapple.jpg")

puts "Successfully loaded image!"
puts "Image size: #{image.width} x #{image.height}"
