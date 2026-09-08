namespace Data;

public record Region(string Name, Country Country)
{
    public static Region Bordeaux { get; } = new Region("Bordeaux", Country.France);
    public static Region Bourgogne { get; } = new Region("Bourgogne", Country.France);
    public static Region ValleDuRhone { get; } = new Region("Valle Du Rhône", Country.France);
    public static Region Champagne { get; } = new Region("Champagne", Country.France);
    public static Region Toscana { get; } = new Region("Toscana", Country.Italy);
    public static Region Piemonte { get; } = new Region("Piemonte", Country.Italy);
    public static Region Veneto { get; } = new Region("Veneto", Country.Italy);
    public static Region Rioja { get; } = new Region("Rioja", Country.Spain);
    public static Region Douro { get; } = new Region("Douro", Country.Portugal);
    public static Region Alentejo { get; } = new Region("Alentejo", Country.Portugal);
    public static Region Santorini { get; } = new Region("Santorini", Country.Greece);
    public static Region Naoussa { get; } = new Region("Naoussa", Country.Greece);
    public static Region Nemea { get; } = new Region("Nemea", Country.Greece);
    public static Region Kakheti { get; } = new Region("Kakheti", Country.Georgia);
    public static Region Mendoza { get; } = new Region("Mendoza", Country.Argentina);
    public static Region Maipo { get; } = new Region("Maipo", Country.Chile);
    public static Region Colchagua { get; } = new Region("Colchagua", Country.Chile);
    public static Region ValeCentral { get; } = new Region("Vale Central", Country.Chile);
    public static Region NapaValley { get; } = new Region("Napa Valley", Country.UnitedStates);
    public static Region Sonoma { get; } = new Region("Sonoma", Country.UnitedStates);
    public static Region BarossaValley { get; } = new Region("Barossa Valley", Country.Australia);
    public static Region McLarenVale { get; } = new Region("McLaren Vale", Country.Australia);
    public static Region Marlborough { get; } = new Region("Marlborough", Country.NewZealand);
    public static Region Stellenbosch { get; } = new Region("Stellenbosch", Country.SouthAfrica);
    public static Region SerraGaucha { get; } = new Region("Serra Gaúcha", Country.Brazil);
    public static Region CampanhaGaucha { get; } = new Region("Campanha Gaúcha", Country.Brazil);
    public static Region ValeDoSaoFrancisco { get; } = new Region("Vale do São Francisco", Country.Brazil);

    public static IEnumerable<Region> All() =>
    [
        Bordeaux,
        Bourgogne,
        ValleDuRhone,
        Champagne,
        Toscana,
        Piemonte,
        Veneto,
        Rioja,
        Douro,
        Alentejo,
        Santorini,
        Naoussa,
        Nemea,
        Kakheti,
        Mendoza,
        Maipo,
        Colchagua,
        ValeCentral,
        NapaValley,
        Sonoma,
        BarossaValley,
        McLarenVale,
        Marlborough,
        Stellenbosch,
        SerraGaucha,
        CampanhaGaucha,
        ValeDoSaoFrancisco
    ];
}