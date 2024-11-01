state("Bejeweled3")
{
    int   ongoingGame     : 0x487F34, 0xBE0;
    int   ongoingGameMode : 0x487F34, 0xBE0, 0x0;
    int   skullsBusted    : 0x487F34, 0xBE0, 0x3964;
    float skullEliminator : 0x487F34, 0xBE0, 0x3974;
    float skullCreator    : 0x487F34, 0xBE0, 0x3984;
    int   coinFlips       : 0x487F34, 0xBE0, 0x39D4;
    int   pair            : 0x487F34, 0xBE0, 0x39D8;
    int   spectrum        : 0x487F34, 0xBE0, 0x39DC;
    int   twoPair         : 0x487F34, 0xBE0, 0x39E0;
    int   threeOfAKind    : 0x487F34, 0xBE0, 0x39E4;
    int   fullHouse       : 0x487F34, 0xBE0, 0x39E8;
    int   fourOfAKind     : 0x487F34, 0xBE0, 0x39EC;
    int   flush           : 0x487F34, 0xBE0, 0x39F0;
}

startup
{
    refreshRate = 10;

    vars.lines = new Dictionary<string, dynamic>();
    foreach (dynamic comp in timer.Layout.Components)
        if (comp.GetType().Name == "TextComponent")
            vars.lines[comp.Settings.Text1] = comp.Settings;
}

update
{
    bool gameActive = current.ongoingGame != 0 && current.ongoingGameMode == 0x81181C;

    float skullCreator = gameActive ? current.skullCreator * 100.0f : 0.0f;
    vars.lines["Skull Creator"].Text2 = skullCreator.ToString("F1") + "%";

    float skullEliminator = gameActive ? current.skullEliminator * 100.0f : 0.0f;
    vars.lines["Skull Eliminator"].Text2 = skullEliminator.ToString() + "%";

    int skullsBusted = gameActive ? current.skullsBusted : 0;
    vars.lines["Skulls Busted"].Text2 = skullsBusted.ToString();

    int coinFlips = gameActive ? current.coinFlips : 0;
    vars.lines["Skull Coin Flips"].Text2 = coinFlips.ToString() + "/3";

    int hands = 0;

    int flush = gameActive ? current.flush : 0;
    hands += flush;
    vars.lines["Flush"].Text2 = flush.ToString();

    int fourOfAKind = gameActive ? current.fourOfAKind : 0;
    hands += fourOfAKind;
    vars.lines["4 of a Kind"].Text2 = fourOfAKind.ToString();

    int fullHouse = gameActive ? current.fullHouse : 0;
    hands += fullHouse;
    vars.lines["Full House"].Text2 = fullHouse.ToString();

    int threeOfAKind = gameActive ? current.threeOfAKind : 0;
    hands += threeOfAKind;
    vars.lines["3 of a Kind"].Text2 = threeOfAKind.ToString();

    int twoPair = gameActive ? current.twoPair : 0;
    hands += twoPair;
    vars.lines["2 Pair"].Text2 = twoPair.ToString();

    int spectrum = gameActive ? current.spectrum : 0;
    hands += spectrum;
    vars.lines["Spectrum"].Text2 = spectrum.ToString();

    int pair = gameActive ? current.pair : 0;
    hands += pair;
    vars.lines["Pair"].Text2 = pair.ToString();

    vars.lines["Total Hands"].Text2 = hands.ToString();
}
