# Convert all images to webp format using the cwebp command line tool

import os
import subprocess

# Get all files in the current directory
files = os.listdir()

# Filter out all files that are not images
images = [
    file
    for file in files
    if file.endswith(".png")
    or file.endswith(".jpg")
    or file.endswith(".jpeg")
    or file.endswith(".tiff")
    or file.endswith(".gif")
]

if len(images) == 0:
    print("\nNo images found in current directory!")
    print("Exiting...\n")
    exit()
else:
    # Convert all images to webp format
    for image in images:
        if image.endswith(".png") or image.endswith(".jpg"):
            subprocess.run(
                ["cwebp", image, "-o", image[:-3] + "webp", "-q", "85"], shell=True
            )
        elif image.endswith(".jpeg") or image.endswith(".tiff"):
            subprocess.run(
                ["cwebp", image, "-o", image[:-4] + "webp", "-q", "85"], shell=True
            )
        elif image.endswith(".gif"):
            subprocess.run(
                ["gif2webp", image, "-o", image[:-3] + "webp", "-q", "85"], shell=True
            )
        # os.remove(image)

    print("\nConversion done!\n")
