namespace Data;

public record Grape(
    string Name,
    GrapeType Type,
    IEnumerable<GrapeRegion> Regions
    )
{
    public static Grape CabernetSauvignon() => new(
           "Cabernet Sauvignon",
           GrapeType.Red,
           [
               new(Region.Bordeaux, Native: true),
               new(Region.ValeCentral, Native: false),
               new(Region.Maipo, Native: false),
               new(Region.NapaValley, Native: false),
               new(Region.Sonoma, Native: false),
               new(Region.BarossaValley, Native: false),
               new(Region.Stellenbosch, Native: false),
               new(Region.CampanhaGaucha, Native: false)
           ]);
   
       public static Grape Merlot() => new(
           "Merlot",
           GrapeType.Red,
           [
               new(Region.Bordeaux, Native: true),
               new(Region.SerraGaucha, Native: false)
           ]);
   
       public static Grape PinotNoir() => new(
           "Pinot Noir",
           GrapeType.Red,
           [
               new(Region.Bourgogne, Native: true),
               new(Region.NapaValley, Native: false),
               new(Region.Marlborough, Native: false),
               new(Region.SerraGaucha, Native: false),
           ]);
   
       public static Grape Chardonnay() => new(
           "Chardonnay",
           GrapeType.White,
           [
               new(Region.Bourgogne, Native: true),
               new(Region.NapaValley, Native: false),
               new(Region.BarossaValley, Native: false),
               new(Region.SerraGaucha, Native: false)
           ]);
   
       public static Grape Syrah() => new(
           "Syrah / Shiraz",
           GrapeType.Red,
           [
               new(Region.ValleDuRhone, Native: true),
               new(Region.BarossaValley, Native: false),
               new(Region.McLarenVale, Native: false),
               new(Region.ValeDoSaoFrancisco, Native: false)
           ]);
   
       public static Grape Sangiovese() => new(
           "Sangiovese",
           GrapeType.Red,
           [
               new(Region.Toscana, Native: true)
           ]);
   
       public static Grape Nebbiolo() => new(
           "Nebbiolo",
           GrapeType.Red,
           [
               new(Region.Piemonte, Native: true)
           ]);
   
       public static Grape Tempranillo() => new(
           "Tempranillo / Tinta Roriz",
           GrapeType.Red,
           [
               new(Region.Rioja, Native: true),
               new(Region.Douro, Native: true),
               new(Region.Alentejo, Native: true)
           ]);
   
       public static Grape TourigaNacional() => new(
           "Touriga Nacional",
           GrapeType.Red,
           [
               new(Region.Douro, Native: true),
               new(Region.Alentejo, Native: true)
           ]);
   
       public static Grape Xinomavro() => new(
           "Xinomavro",
           GrapeType.Red,
           [
               new(Region.Naoussa, Native: true)
           ]);
   
       public static Grape Assyrtiko() => new(
           "Assyrtiko",
           GrapeType.White,
           [
               new(Region.Santorini, Native: true)
           ]);
   
       public static Grape Saperavi() => new(
           "Saperavi",
           GrapeType.Red,
           [
               new(Region.Kakheti, Native: true)
           ]);
   
       public static Grape Rkatsiteli() => new(
           "Rkatsiteli",
           GrapeType.White,
           [
               new(Region.Kakheti, Native: true)
           ]);
       
       public static Grape Torrontes() => new(
           "Torrontés",
           GrapeType.White,
           [
               new(Region.Mendoza, Native: true) // Criada na Argentina por cruzamento natural
           ]);
   
       public static Grape Pinotage() => new(
           "Pinotage",
           GrapeType.Red,
           [
               new(Region.Stellenbosch, Native: true) // Criada na África do Sul em laboratório (Pinot Noir x Cinsault)
           ]);
};
