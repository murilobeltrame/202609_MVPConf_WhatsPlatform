namespace WinePlatform;

public static class WinePlatformEndpoints
{
    public static IEndpointRouteBuilder MapWinePlatformEndpoints(this IEndpointRouteBuilder routes)
    {
        var catalogGroup = routes.MapGroup("/catalogo").WithTags("Catalog");
        catalogGroup.MapGet("/vinhos", ListCatalogWines).WithName("ListCatalogWines");
        catalogGroup.MapGet("/indisponivel", GetUnavailableCatalog).WithName("GetUnavailableCatalog");

        var inventoryGroup = routes.MapGroup("/estoque").WithTags("Inventory");
        inventoryGroup.MapGet("/adegas", ListCellarInventory).WithName("ListCellarInventory");

        var wineriesGroup = routes.MapGroup("/wineries").WithTags("Wineries");
        wineriesGroup.MapGet("/", ListWineries).WithName("ListWineries");
        wineriesGroup.MapPost("/", CreateWinery).WithName("CreateWinery");
        wineriesGroup.MapGet("/{wineryId:guid}", GetWinery).WithName("GetWinery");
        wineriesGroup.MapPatch("/{wineryId:guid}", UpdateWinery).WithName("UpdateWinery");

        var vineyardsGroup = routes.MapGroup("/vineyards").WithTags("Vineyards");
        vineyardsGroup.MapGet("/", ListVineyards).WithName("ListVineyards");
        vineyardsGroup.MapPost("/", CreateVineyard).WithName("CreateVineyard");
        vineyardsGroup.MapGet("/{vineyardId:guid}", GetVineyard).WithName("GetVineyard");
        vineyardsGroup.MapPatch("/{vineyardId:guid}", UpdateVineyard).WithName("UpdateVineyard");

        var winesGroup = routes.MapGroup("/wines").WithTags("Wines");
        winesGroup.MapGet("/", ListWines).WithName("ListWines");
        winesGroup.MapPost("/", CreateWine).WithName("CreateWine");
        winesGroup.MapGet("/{wineId:guid}", GetWine).WithName("GetWine");
        winesGroup.MapPatch("/{wineId:guid}", UpdateWine).WithName("UpdateWine");

        return routes;
    }

    private static IResult ListCatalogWines(int? page, int? pageSize, Guid? wineryId, int? vintage)
    {
        throw new NotImplementedException();
    }

    private static IResult GetUnavailableCatalog()
    {
        throw new NotImplementedException();
    }

    private static IResult ListCellarInventory(int? page, int? pageSize, Guid? wineryId)
    {
        throw new NotImplementedException();
    }

    private static IResult ListWineries(int? page, int? pageSize)
    {
        throw new NotImplementedException();
    }

    private static IResult CreateWinery()
    {
        throw new NotImplementedException();
    }

    private static IResult GetWinery(Guid wineryId)
    {
        throw new NotImplementedException();
    }

    private static IResult UpdateWinery(Guid wineryId)
    {
        throw new NotImplementedException();
    }

    private static IResult ListVineyards(Guid? wineryId)
    {
        throw new NotImplementedException();
    }

    private static IResult CreateVineyard()
    {
        throw new NotImplementedException();
    }

    private static IResult GetVineyard(Guid vineyardId)
    {
        throw new NotImplementedException();
    }

    private static IResult UpdateVineyard(Guid vineyardId)
    {
        throw new NotImplementedException();
    }

    private static IResult ListWines(int? page, int? pageSize, Guid? wineryId)
    {
        throw new NotImplementedException();
    }

    private static IResult CreateWine()
    {
        throw new NotImplementedException();
    }

    private static IResult GetWine(Guid wineId)
    {
        throw new NotImplementedException();
    }

    private static IResult UpdateWine(Guid wineId)
    {
        throw new NotImplementedException();
    }
}
