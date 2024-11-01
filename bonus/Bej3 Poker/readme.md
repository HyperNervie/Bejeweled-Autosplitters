[切换到中文](./readme-zh.md)

# Stats Displayer for Poker Mode in Bejeweled 3

(This script is only for vanilla Bejeweled 3 and mods that are based on it. The name of the executable file must be `Bejeweled3.exe` or the script won't work.)

Instead of an auto splitter, this is a tool that shows your Poker Mode stats on LiveSplit. It doesn't need splits.

To use it, open the layout file `Bejeweled 3 Poker.lsl` in LiveSplit, then choose "Scriptable Auto Splitter" in layout settings, and set the script path to `Bej3-Poker.asl`. You may change other layout settings to your preference, as long as you don't change texts of the left column.

## Shown stats

When you're playing Poker Mode, LiveSplit shows these stats:

* **Skull Generator:** When this fills to 100% and the Skull Eliminator doesn't, create a skull.
* **Skull Eliminator:** When this fills to 100%, remove a skull.
* The number of **Skulls Busted**.
* The number of **Skull Coin Flips**. Without hacking, the third coin flip in a game is destined to land on skull, so you'll see "/3" appended to the number of flips.
* The number of hands of each type (**Flush**, **4 of a Kind**, **Full House**, **3 of a Kind**, **2 Pair**, **Spectrum** and **Pair**) and **Total Hands**.

When you're not playing Poker Mode, these numbers are 0.
