namespace Data;

public record Country(string Name)
{
    public static Country France { get; } = new Country("France");
    public static Country Italy { get; } = new Country("Italy");
    public static Country Spain { get; } = new Country("Spain");
    public static Country Portugal { get; } = new Country("Portugal");
    public static Country Greece { get; } = new Country("Greece");
    public static Country Georgia { get; } = new Country("Georgia");
    public static Country Argentina { get; } = new Country("Argentina");
    public static Country Chile { get; } = new Country("Chile");
    public static Country UnitedStates { get; } = new Country("United States");
    public static Country Australia { get; } = new Country("Australia");
    public static Country NewZealand { get; } = new Country("New Zealand");
    public static Country SouthAfrica { get; } = new Country("South Africa");
    public static Country Brazil { get; } = new Country("Brazil");
    
    public static IEnumerable<Country> All() =>
        [
            France,
            Italy,
            Spain,
            Portugal,
            Greece,
            Georgia,
            Argentina,
            Chile,
            UnitedStates,
            Australia,
            NewZealand,
            SouthAfrica,
            Brazil
        ];
};