state("BejeweledTwist")
{
    uint ongoingGame : 0x45AEF4;
    int ongoingChallenge : 0x45AEF4, 0x2678;
    float logoOpacity : 0xA0B698, 0xC70, 0x3C8, 0x15C;
    int stars : 0xA0B698, 0x7EC, 0x160;
}

startup
{
    refreshRate = 100;
    settings.Add("per_planet", false, "Don't split upon beating challenges 1-6");
}

start
{
    if (!(old.ongoingGame == 0U && current.ongoingGame != 0U)) return false;

    vars.challenge = current.ongoingChallenge != 0;
    return true;
}

split
{
    return current.stars > old.stars && (!vars.challenge || !settings["per_planet"] || old.ongoingChallenge == 7);
}

reset
{
    return old.logoOpacity == 0f && current.logoOpacity > 0f;
}
