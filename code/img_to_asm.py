from PIL import Image

screen_size = (512, 256, )
pixel_size = 2

screen_dimensions = (screen_size[0] // pixel_size,
                     screen_size[1] // pixel_size, )
mem_start = 268500992  # lui 0x1001
base_image_path = 'image.jpg'
output_file = 'code.asm'


def rgb_to_hex(rgb_tuple):
    return "0x{0:02x}{1:02x}{2:02x}".format(*rgb_tuple)


def write_assembly(pixels):

    def gen_draw_pixel_code(pixel_address_tuple):
        return """
            addi $10, $0, {}
            sw $10, {}($0)
        """.format(*pixel_address_tuple)

    def write_file(strings):
        text_file = open(output_file, "w")
        for s in strings:
            text_file.write(s)
        text_file.close()

    args = ((pixels[i], mem_start + i * 4) for i in range(len(pixels)))
    pixels_code = map(gen_draw_pixel_code, args)
    write_file(pixels_code)


img = Image.open(base_image_path).resize(screen_dimensions).convert('RGB')
all_cordinates = [(w, h, ) for h in range(screen_dimensions[1])
                  for w in range(screen_dimensions[0])]

rgb_pixels = map(img.getpixel, all_cordinates)
pixels = map(rgb_to_hex, rgb_pixels)
write_assembly(list(pixels))
