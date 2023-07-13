import subprocess

from libqtile import widget

class VolumeControl(widget.TextBox):
    def __init__(self, **config):
        super(VolumeControl, self).__init__(**config)

        self.refresh()

    def get_vol(self) -> int:
        """Get the volume value"""

        while True:
            try:
                output = subprocess.check_output(["pamixer --get-volume"], shell=True).decode("utf-8")
                return int(output)

            except:
                pass

    def get_mute(self) -> bool:
        """Get the whether or not it is muted"""

        while True:
            try:
                output = subprocess.check_output(["pamixer --get-volume"], shell=True).decode("utf-8")
                return output.strip() == "true"

            except:
                pass

    def cmd_increase_vol(self) -> None:
        """Increase the volume and refresh volume"""

        subprocess.call(["pamixer --increase 5"], shell=True)
        self.refresh()

    def cmd_decrease_vol(self) -> None:
        """Decrease the volume and refresh volume"""

        subprocess.call(["pamixer --decrease 5"], shell=True)
        self.refresh()

    def mute(self) -> None:
        """Toggle to mute/unmute volume and refresh"""

        subprocess.call(["pamixer --toggle-mute"], shell=True)
        self.refresh()

    def refresh(self) -> None:
        """Refresh widget"""

        volume = self.get_vol()
        is_muted = self.get_mute()

        self.text = 'Muted' if is_muted else f'{volume}%'
        self.draw()

