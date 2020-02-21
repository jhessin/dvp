Programmer Dvorak Layout
-------------------------

dvp.map - [Programmer Dvorak](http://www.kaufmann.no/roland/dvorak/) with
`<Caps_Lock>` replaced with `<Escape>`

dvpx.map - Programmer Dvorak with `<Escape>` and `<Caps_Lock>` exchanged.

Usage
-----

One liner:
```bash
curl -L -o dvp bit.ly/jhessindvp && bash dvp
```

Tips
----

1. Keymaps directory

        Gentoo:    /usr/share/keymaps/i386/dvorak
        ArchLinux: /usr/share/kbd/keymaps/i386/dvorak

2. Load Keymap

        loadkeys dvp

3. Gentoo Keymap Configure

        File: /etc/conf.d/keymaps
        Code: keymap="dvpx"

4. Xorg keymap setting

        It doesn't use dvp.map, just a remark.

        Keymap: /usr/share/X11/xkb/symbols/us
        Rules:  /usr/share/X11/xkb/rules/xorg.lst

        File: /etc/X11/[Your Keyboard Configure File]
        Code:

            Section "InputClass"
                Identifier "Keyboard"
                MatchIsKeyboard "on"
                MatchDevicePath "/dev/input/event*"
                Driver "evdev"
                Option "XkbLayout" "us"
                Option "XkbVariant" "dvp"
                Option "XkbOptions" "caps:escape"
            EndSection
