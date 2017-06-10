from os import listdir
from os.path import isfile, join, abspath, realpath, split, splitext, dirname

from PIL import Image

screen_size = (512, 256, )
pixel_size = 16

screen_dimensions = (screen_size[0] // pixel_size,
                     screen_size[1] // pixel_size, )
mem_start = 268500992  # lui 0x1001
root_path = dirname(realpath(__file__))
imgs_path = join(root_path, 'imgs/')
output_path = join(root_path, 'assembly/')


def rgb_to_hex(rgb_tuple):
    return "0x{0:02x}{1:02x}{2:02x}".format(*rgb_tuple)


def get_filename(path):
    path, filename = split(path)
    return splitext(filename)[0]


def convert_img_path_to_asm_path(img_path):
    filename = get_filename(img_path)
    newfilename = '{}.asm'.format(filename)
    return join(output_path, newfilename)


def process_image(img, out_path, title):

    def write_assembly(pixels):

        def gen_draw_pixel_code(pixel_address_tuple):
            return """
                addi $10, $0, {}
                sw $10, {}($0)
            """.format(*pixel_address_tuple)

        def write_file(strings):
            text_file = open(out_path, "w")
            text_file.write('.globl {0}\n{0}:'.format(title))
            for s in strings:
                text_file.write(s)
            text_file.close()

        args = ((pixels[i], mem_start + i * 4) for i in range(len(pixels)))
        pixels_code = map(gen_draw_pixel_code, args)
        write_file(pixels_code)

    all_cordinates = [(w, h, ) for h in range(screen_dimensions[1])
                      for w in range(screen_dimensions[0])]

    rgb_pixels = map(img.getpixel, all_cordinates)
    pixels = map(rgb_to_hex, rgb_pixels)
    write_assembly(list(pixels))


imgs_paths = (join(imgs_path, f) for f in listdir(imgs_path)
              if isfile(join(imgs_path, f)))

imgs = ((Image.open(path).resize(screen_dimensions).convert('RGB'),
         convert_img_path_to_asm_path(path),
         get_filename(path), )
        for path in imgs_paths)

for img in imgs:
    process_image(*img)
