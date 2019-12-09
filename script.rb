require "mini_magick"

image = MiniMagick::Image.open("ascii-pineapple.jpg")

puts "Successfully loaded image!"
puts "Image size: #{image.width} x #{image.height}"
puts

pixel_matrix = image.get_pixels

puts "Successfully constructed pixel matrix!"
puts "Pixel matrix size: #{pixel_matrix[0].length} x #{pixel_matrix.length}"
puts

# puts "Iterating through pixel contents:"
# for row in pixel_matrix do
#     for col in row do
#         p col
#     end
# end

brightness_matrix = Array.new
for row in pixel_matrix do
    new_col = Array.new

    for col in row do
        new_col.push col.reduce(:+) / col.length
    end

    brightness_matrix.push new_col
end

puts "Successfully constructed brightness matrix!"
puts "Brightness matrix size: #{brightness_matrix[0].length} x #{brightness_matrix.length}"
puts

brightness_repr_chars = "`^\",:;Il!i~+_-?][}{1)(|\\/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$"

ascii_matrix = Array.new
for row in brightness_matrix do
    new_col = Array.new

    for col in row do
        char_idx = (col / (256 / brightness_repr_chars.length.to_f)).ceil
        new_col.push brightness_repr_chars[char_idx]
    end

    ascii_matrix.push new_col
end

puts "Successfully constructed ASCII matrix!"
puts "ASCII matrix size: #{ascii_matrix[0].length} x #{ascii_matrix.length}"
puts
