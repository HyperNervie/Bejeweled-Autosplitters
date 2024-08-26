[切换到中文](./readme-zh.md)

# Auto Splitters for Bejeweled Franchise

This repository holds auto splitters used for speedrun categories of ~~Bejeweled~~ (coming soon), ~~Bejeweled 2~~ (coming soon), Bejeweled Twist and Bejeweled 3. You can enable them in the Splits Editor.

## Bejeweled Twist

[Bejeweled Twist categories on speedrun.com](https://www.speedrun.com/bejeweledtwist)

This auto splitter only supports non-Steam version. If you can adapt it to Steam version, feel free to open a pull request.

* Timing starts upon entering any level.
* Split is triggered when you beat any level.
  * If you want to split upon beating a whole planet rather than beating a single challenge, check "Don't split upon beating challenges 1-6" in auto splitter settings.
* Timing resets upon returning to the main menu while you haven't got any stars in your profile (in favor of Unlock%).

This auto splitter doesn't support Boggy's Counterclockwise Extender. There's no plan to support it until there are CCW categories on speedrun.com.

## Bejeweled 3

[Bejeweled 3 categories on speedrun.com](https://www.speedrun.com/bejeweled3)

Whether this auto splitter supports Steam version is unknown. If it doesn't, and you can adapt it to Steam version, feel free to open a pull request.

This auto splitter doesn't support Bejeweled 3 Plus and Quest Mode Plus packs. There's no plan to support them until there are categories for them on speedrun.com.

### Classic & Zen

Check "Classic & Zen autosplit" in auto splitter settings to enable auto splitting in Classic and Zen modes.

* Timing starts when you enter Level 1 and haven't got any points.
* Split is triggered when you beat a level.
  * If you check "Score run instead of level run" in auto splitter settings, split is triggered when you reach certain scores instead. You must name your splits the score thresholds you want, and they have to be decimal positive integers in ascending order. If the split names don't obey this rule, timing will not start when you enter Level 1.
* Timing resets upon returning to the game mode menu or having No More Moves.

### Quest

Check "Quest autosplit" in auto splitter settings to enable auto splitting in Quest mode.

* Timing starts when you enter Quest mode and haven't beaten any quests.
* Split is triggered when beat a quest.
  * If you check "Split upon switching to a new relic" in auto splitter settings, split is triggered when you switch to a new relic instead.
  * The last split is triggered when the "50%" text appears if "50% instead of 100%" is checked, or when the "QUEST MODE COMPLETE" text appears if not. If you uncheck "Split upon switching to a new relic", beating your last quest doesn't immediately trigger a split.
* Timing resets when you quit Quest mode.

### Unlock All Modes

Check "Split upon unlocking a Secret Mode" in auto splitter settings to enable auto splitting for the "Unlock All Modes" category. If checked, the auto splitter will not work as above when you play Classic, Zen or Quest mode.

* Timing starts when you enter any mode.
* Split is triggered when you unlock a Secret Mode.
* Reset is not implemented yet. If you know how to detect if the player returns to the main menu, feel free to open a pull request.

### Badge Run

Auto splitting for "Bronze Badges" and "All Badges" categories is not implemented yet. If you know how to detect if a badge shows up, feel free to open a pull request.
