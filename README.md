# Plumber Vult
Angry Birds like game, made is MIPS Assembly Code. (School Project)
Runs in MARS MIPS Simulator (http://courses.missouristate.edu/KenVollmar/mars/)

[Slides telling the development process](https://drive.google.com/open?id=195wEksp_nAkrR0fNE8y3qUSPdFWbs7IEfEEVJVl_0cU) (Prof asked)

### Gameplay Video
<a href="http://www.youtube.com/watch?feature=player_embedded&v=-dT7sHjod_w" target="_blank"><img src="http://img.youtube.com/vi/-dT7sHjod_w/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>

# How to Compile and Run
* Download Java (https://www.java.com/en/download/) 
* clone this repository and go to its root dir
* java -jar Mars4_5.jar
* [Enable] Settings > Assemble All Files in Directory
* [Enable] Settings > Initialize Program Counter to global 'main' if defined
* Tools > Keyboard and Display MMIO Simulator > Connect to MIPS
* Tools > Bitmap Display > Connect to MIPS

    | Option                   | Value |
    | ------------------------ | ----- |
    | Unit Width in Pixels     |  4    |
    | Unit Height in Pixels    |  4    |
    | Display Width in Pixels  | 512   |
    | Display Height in Pixels | 256   |
    | Base address for display | 0x10010000 (static data) |

* File > Open > code/assembly/main.asm > Open
* Run > Assemble (Takes a While)
* Run > Go

# The Image to MIPS Assembly Code Generator 
The professor allowed us to write a high level application which reads a image and generate the assembly code to print it to the screen.

* I wrote this script in Python. 
* It is located at /code/
* It will take all images in the /code/imgs folder, and create assembly files at /code/assembly/
* Each file will have a 'label' and a 'jr $ra', 
   * so It can be called with 'jal' from main.asm
* the main.asm file was hand written by me. It has all game logic written in assembly.


# How to Use the image to assembly code conversor
In these instructions we will be using Docker and Docker-Compile to make sure everything will work.
Nonetheless, if are a intermediary+ Python programmer, making this simple script work without docker.

* [Install Docker](https://docs.docker.com/engine/installation/)
* [Install Docker-Composer](https://docs.docker.com/compose/install/)
* In the project root, run:
    sudo docker-compose run python python img_to_asm.py


## How to Change the images for new ones :
* delete all files under /code/imgs/
* delete all files, BUT main.asm, under /code/assembly/
 * the main.asm contains all the game logic, and you may want to keep it.
* put the new images you want to use in /code/imgs
* In the project root, run:
 * sudo docker-compose run python python img_to_asm.py

# How to Change the Game Logic
All the game code is in the file /code/assembly/main.asm
Change it as you wish.
