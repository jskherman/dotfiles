import keyboard

# This script is used to listen for a key press and then write a character
# to the screen. I use Task Scheduler to run this script on startup.


# Define a function to be called when the Insert key is pressed
def on_insert_pressed():
    """
    This function is called when the Insert key is pressed. It writes
    the character Ṅ to the screen. This is used to trigger espanso
    snippets to work in as a replacement for modifier keys used in programs
    like AutoHotKey.
    """

    keyboard.write("Ṅ")


# Notify start of keyboard listener
print("Starting keyboard listener...")

# Add a hotkey for the Insert key
keyboard.add_hotkey("insert", on_insert_pressed)

# Keep the script running
keyboard.wait()
