state("Bejeweled3")
{
    byte40 completedQuests        : 0x487F34, 0xB78, 0x158;
    byte4  unlockedSecrets        : 0x487F34, 0xB78, 0x180;
    uint   questMode              : 0x487F34, 0xBD0;
    int    questRelic             : 0x487F34, 0xBD0, 0x14C;
    uint   questCaption           : 0x487F34, 0xBD0, 0x178;
    double questCaptionScale      : 0x487F34, 0xBD0, 0x178, 0xE0;
    double questCompletionOpacity : 0x487F34, 0xBD0, 0x308;
    uint   ongoingGame            : 0x487F34, 0xBE0;
    uint   ongoingGameMode        : 0x487F34, 0xBE0, 0x0;
    uint   gemGrid                : 0x487F34, 0xBE0, 0xF4;
    int    score                  : 0x487F34, 0xBE0, 0xD20;
    int    shownScore             : 0x487F34, 0xBE0, 0xD60;
    bool   gameOver               : 0x487F34, 0xBE0, 0xD88;
    bool   toBeComplete           : 0x487F34, 0xBE0, 0x288C;
}

startup
{
    refreshRate = 100;

    settings.Add("secret", false, "Split upon unlocking a Secret Mode");
    settings.SetToolTip("secret", "Disables all options below if checked");

    settings.Add("quest", true, "Quest autosplit");
    settings.Add("quest.50%", false, "50% instead of 100%", "quest");
    settings.Add("quest.per_relic", true, "Split upon switching to a new relic", "quest");
    settings.SetToolTip("quest.per_relic", "Uncheck to split upon beating a quest (except your last one)");

    settings.Add("classic_zen", true, "Classic & Zen autosplit");
    settings.Add("classic_zen.point", false, "Score attack", "classic_zen");
    settings.SetToolTip("classic_zen.point", "Uncheck to split upon beating a level");

    vars.count = new Func<byte[], int>(arr => Array.FindAll(arr, new Predicate<byte>(b => b != 0)).Length);
    vars.modeChecker = new Func<uint[], Predicate<dynamic>>(modes =>
        new Predicate<dynamic>(state =>
            state.ongoingGame != 0U && state.gemGrid != 0U
            && modes.Contains((uint)state.ongoingGameMode)
        )
    );
}

init
{
    vars.CLASSIC   = (uint)(modules.First().BaseAddress + 0x40D644);
    vars.ZEN       = (uint)(modules.First().BaseAddress + 0x40F05C);
    vars.LIGHTNING = (uint)(modules.First().BaseAddress + 0x40EABC);
}

start
{
    bool questStarted = old.questMode == 0U && current.questMode != 0U;
    dynamic started;

    if (settings["secret"])
    {
        vars.category = "secret";
        started = vars.modeChecker(new uint[]{vars.CLASSIC, vars.ZEN, vars.LIGHTNING});
        return (questStarted || !started(old) && started(current))
            && vars.count(current.unlockedSecrets) == 0;
    }

    if (settings["quest"] && questStarted)
    {
        vars.category = "quest";
        vars.relic = 0;
        return true;
    }

    started = vars.modeChecker(new uint[]{vars.CLASSIC, vars.ZEN});
    if (settings["classic_zen"] && !started(old) && started(current) && current.score == 0)
    {
        if (settings["classic_zen.point"])
        {
            if (timer.Run.Count == 0) return false;
            vars.point_split = new List<int>{};
            int prev_point = 0;
            foreach (Segment seg in timer.Run)
            {
                int next_point;
                if (!int.TryParse(seg.Name, out next_point)) return false;
                if (next_point <= prev_point) return false;
                vars.point_split.Add(next_point);
                prev_point = next_point;
            }
        }
        vars.category = "classic_zen";
        return true;
    }

    return false;
}

split
{
    if (vars.category == "secret")
        return vars.count(current.unlockedSecrets) == vars.count(old.unlockedSecrets) + 1;

    if (vars.category == "quest")
    {
        int questCount = vars.count(current.completedQuests);
        bool captionPopup = old.questCaption != 0U &&
            old.questCaptionScale == 0.0 && current.questCaptionScale > 0.0;
        
        if (settings["quest.per_relic"])
        {
            if (current.questRelic > vars.relic)
            {
                vars.relic = current.questRelic;
                return true;
            }
        }
        else
        {
            if (questCount != (settings["quest.50%"] ? 19 : 39))
                return captionPopup;
        }

        if (settings["quest.50%"])
            return old.questCompletionOpacity == 0.0 && current.questCompletionOpacity > 0.0;
        else
            return questCount == 40 && captionPopup;
    }

    if (vars.category == "classic_zen")
    {
        if (settings["classic_zen.point"])
            return current.shownScore >= vars.point_split[timer.CurrentSplitIndex];
        else
            return old.toBeComplete && !current.toBeComplete;
    }

    return false;
}

reset
{
    if (vars.category == "quest") return old.questMode != 0U && current.questMode == 0U;
    if (vars.category == "classic_zen") return current.ongoingGame == 0U || current.gameOver;
    return false;
}

onReset
{
    vars.category = "";
}
