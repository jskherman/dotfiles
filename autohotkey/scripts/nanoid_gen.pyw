import nanoid
import pyperclip

if __name__ == "__main__":
    random_id = nanoid.generate(size=12)  # Change the length as needed
    pyperclip.copy(random_id)  # Copy the random string to clipboard
    print(random_id)
