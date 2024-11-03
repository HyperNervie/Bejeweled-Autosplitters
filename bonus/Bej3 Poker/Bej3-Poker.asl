state("Bejeweled3")
{
    int   ongoingGame     : 0x487F34, 0xBE0;
    int   ongoingGameMode : 0x487F34, 0xBE0, 0x0;
    int   ticks           : 0x487F34, 0xBE0, 0x38;
    int   cardTraversed   : 0x487F34, 0xBE0, 0x3788;
    int   skullsBusted    : 0x487F34, 0xBE0, 0x3964;
    float skullBuster     : 0x487F34, 0xBE0, 0x3974;
    int   skulledHand     : 0x487F34, 0xBE0, 0x397C;
    float skullCountdown  : 0x487F34, 0xBE0, 0x3984;
    float countdownMult   : 0x487F34, 0xBE0, 0x3988;
    int   coinFlips       : 0x487F34, 0xBE0, 0x39D4;
    int   pair            : 0x487F34, 0xBE0, 0x39D8;
    int   spectrum        : 0x487F34, 0xBE0, 0x39DC;
    int   twoPair         : 0x487F34, 0xBE0, 0x39E0;
    int   threeOfAKind    : 0x487F34, 0xBE0, 0x39E4;
    int   fullHouse       : 0x487F34, 0xBE0, 0x39E8;
    int   fourOfAKind     : 0x487F34, 0xBE0, 0x39EC;
    int   flush           : 0x487F34, 0xBE0, 0x39F0;
    int   handPoints      : 0x487F34, 0xBE0, 0x3A1C;
    int   highlightedHand : 0x487F34, 0xBE0, 0x3A20;
}

startup
{
    refreshRate = 100;

    vars.lines = new Dictionary<string, dynamic>();
    foreach (dynamic comp in timer.Layout.Components)
        if (comp.GetType().Name == "TextComponent")
            vars.lines[comp.Settings.Text1] = comp.Settings;
    
    vars.addCountdown = 0f;
    vars.addBuster = 0f;
    vars.busters = null;
    vars.countdowns = null;
}

update
{
    var active = new Predicate<dynamic>(state =>
        state.ongoingGame != 0 && state.ongoingGameMode == 0x81181C && state.ticks > 0);
    bool oldActive = active(old);
    bool currentActive = active(current);

    int hands = 0;

    int flush = currentActive ? current.flush : 0;
    hands += flush;
    vars.lines["Flush"].Text2 = flush.ToString();

    int fourOfAKind = currentActive ? current.fourOfAKind : 0;
    hands += fourOfAKind;
    vars.lines["4 of a Kind"].Text2 = fourOfAKind.ToString();

    int fullHouse = currentActive ? current.fullHouse : 0;
    hands += fullHouse;
    vars.lines["Full House"].Text2 = fullHouse.ToString();

    int threeOfAKind = currentActive ? current.threeOfAKind : 0;
    hands += threeOfAKind;
    vars.lines["3 of a Kind"].Text2 = threeOfAKind.ToString();

    int twoPair = currentActive ? current.twoPair : 0;
    hands += twoPair;
    vars.lines["2 Pair"].Text2 = twoPair.ToString();

    int spectrum = currentActive ? current.spectrum : 0;
    hands += spectrum;
    vars.lines["Spectrum"].Text2 = spectrum.ToString();

    int pair = currentActive ? current.pair : 0;
    hands += pair;
    vars.lines["Pair"].Text2 = pair.ToString();

    vars.lines["Total Hands"].Text2 = hands.ToString();

    if ((!oldActive || vars.busters == null || vars.countdowns == null) && currentActive)
    {
        vars.busters = new float[7];
        vars.countdowns = new float[7];

        IntPtr handBusterBegin = memory.ReadPointer((IntPtr)(current.ongoingGame + 0x39B0));
        IntPtr handBusterEnd = handBusterBegin + 4;
        if (memory.ReadPointer(handBusterBegin) != memory.ReadPointer(handBusterEnd))
            for (int i = 0; i < 7; i++)
                vars.busters[i] = memory.ReadValue<float>(handBusterBegin + 4 * i);
        
        IntPtr handCountdownBegin = memory.ReadPointer((IntPtr)(current.ongoingGame + 0x39C8));
        IntPtr handCountdownEnd = handCountdownBegin + 4;
        if (memory.ReadPointer(handCountdownBegin) != memory.ReadPointer(handCountdownEnd))
            for (int i = 0; i < 7; i++)
                vars.countdowns[i] = memory.ReadValue<float>(handCountdownBegin + 4 * i);
    }
    if (oldActive && !currentActive)
    {
        vars.busters = null;
        vars.countdowns = null;
    }

    float skullCountdown = 0f;
    float skullBuster = 0f;
    if (oldActive && currentActive)
    {
        if (old.handPoints == 0 && current.handPoints > 0)
        {
            vars.addCountdown = vars.countdowns[current.highlightedHand] *
                (1f + hands * current.countdownMult);
            if (current.skulledHand >= 0)
                vars.addBuster = old.skullBuster + vars.busters[current.highlightedHand];
        }
        else if (old.cardTraversed == 5 && current.cardTraversed == -1)
        {
            vars.addCountdown = 0f;
            vars.addBuster = 0f;
        }
        skullCountdown = (current.skullCountdown + vars.addCountdown) * 100;
        skullBuster = (vars.addBuster == 0f ? current.skullBuster : vars.addBuster) * 100;
    }
    vars.lines["Skull Generator"].Text2 = skullCountdown.ToString("F1") + "%";
    vars.lines["Skull Eliminator"].Text2 = skullBuster.ToString() + "%";

    int skullsBusted = currentActive ? current.skullsBusted : 0;
    vars.lines["Skulls Busted"].Text2 = skullsBusted.ToString();

    int coinFlips = currentActive ? current.coinFlips : 0;
    vars.lines["Skull Coin Flips"].Text2 = coinFlips.ToString() + "/3";
}
