require "mini_magick"

def load_image(img_path)
    MiniMagick::Image.open(img_path)
end

def resize_image(image, new_width=100)
    old_width, old_height = image.dimensions
    aspect_ratio = old_width.to_f / old_height
    new_height = (new_width / aspect_ratio).to_int
    image.resize "#{new_width}x#{new_height}"
end

def get_pixel_matrix(image)
    image.colorspace "Gray"
    pixel_matrix = image.get_pixels

    pixel_matrix.each do |row|
        row.map! { |col| col[0] }
    end

    pixel_matrix
end

def generate_ascii_matrix(pixel_matrix)
    brightness_repr_chars = ".,:;Il!#&8%@$"
    brightness_repr_chars.reverse!

    pixel_matrix.each do |row|
        row.map! do |pixel|
            bucket = (pixel / (255 / brightness_repr_chars.length.to_f)).floor
            brightness_repr_chars[bucket]
        end
    end

    pixel_matrix
end

def print_ascii_matrix(ascii_matrix)
    ascii_matrix.each_with_index do |row, index|
        row.each do |char|
            print "#{char}#{char}#{char}"
        end
        puts
    end
end


def asciify(img_path)
    image = load_image(img_path)
    resize_image(image)
    pixel_matrix = get_pixel_matrix(image)
    ascii_matrix = generate_ascii_matrix(pixel_matrix)
    print_ascii_matrix(ascii_matrix)
end

# asciify("ascii-pineapple.jpg")
# asciify("octocat.png")
# asciify("test-1.jpg")
asciify("test-2.jpg")
