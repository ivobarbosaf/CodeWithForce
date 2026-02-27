# Nerd Fonts Setup for Powerlevel10k

This guide explains how to install the **MesloLGS NF** font required by [Powerlevel10k](https://github.com/romkatv/powerlevel10k) to display icons correctly in your terminal prompt.

Without this font you will see `?` or empty squares instead of icons.

---

## 1. Install MesloLGS NF Font

### Option A – Homebrew (recommended)

```bash
brew install --cask font-meslo-lg-nerd-font
```

### Option B – Manual Download

1. Download the four font files from the [Powerlevel10k GitHub repository](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k):
   - [MesloLGS NF Regular.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)
   - [MesloLGS NF Bold.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf)
   - [MesloLGS NF Italic.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf)
   - [MesloLGS NF Bold Italic.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf)
2. Double-click each file and click **Install Font** in Font Book.

---

## 2. Configure Your Terminal to Use the Font

### macOS Terminal

1. Open **Terminal** → **Settings** (or **Preferences**) → **Profiles**.
2. Select your active profile and click the **Text** tab.
3. Under **Font**, click **Change…**.
4. Search for **MesloLGS NF**, select it, choose a size (e.g. 13 pt), and click **OK**.
5. Restart Terminal.

### iTerm2

1. Open **iTerm2** → **Settings** (or **Preferences**) → **Profiles** → **Text**.
2. Under **Font**, click the font name to open the font picker.
3. Search for **MesloLGS NF**, select it, and close the picker.
4. Restart iTerm2.

---

## 3. Reconfigure Powerlevel10k

After setting the font, run the Powerlevel10k configuration wizard:

```bash
p10k configure
```

When prompted:

- **Character set:** select **Unicode**
- **Prompt style:** select a style that includes many icons (e.g. **Rainbow**)
- Complete the remaining prompts according to your preferences.

---

## Troubleshooting – `?` Glyphs in Prompt

| Symptom | Likely Cause | Fix |
|---------|--------------|-----|
| `?` characters everywhere | Font not installed | Follow [Step 1](#1-install-meslolgs-nf-font) |
| Font installed but `?` still appears | Terminal not configured to use the font | Follow [Step 2](#2-configure-your-terminal-to-use-the-font) |
| Font set but icons look wrong | p10k configured with ASCII mode | Re-run `p10k configure` and choose **Unicode** + **Many icons** |
| Changes have no effect | Old terminal session still open | Close all terminal windows and open a new one |

If the problem persists, verify the font name inside the terminal:

```bash
# Check the font your terminal is actually using
echo $TERM && fc-list | grep -i meslo
```

---

## References

- [Powerlevel10k – Font Installation](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)
- [Nerd Fonts](https://www.nerdfonts.com/)
- [Homebrew Cask Fonts](https://github.com/Homebrew/homebrew-cask-fonts)
