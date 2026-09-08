using Data;

namespace WinePlatform;

public static class GrapeEndpoints
{
    private static readonly IEnumerable<Grape> _grapes = Grape.All();

    public static IEndpointRouteBuilder MapGrapeEndpoints(this IEndpointRouteBuilder routes)
    {
        var group = routes.MapGroup("/grapes").WithTags("Grapes");

        group.MapGet("/", GetGrapes)
            .WithName("GetGrapes")
            .Produces<IEnumerable<Grape>>();

        return routes;
    }

    private static IEnumerable<Grape> GetGrapes(string? name, GrapeType? type) {
        var result = _grapes;
        if (!string.IsNullOrWhiteSpace(name))
        {
            result = result.Where(w => w.Name.StartsWith(name, StringComparison.InvariantCultureIgnoreCase));
        }

        if (type != null)
        {
            result = result.Where(w => w.Type == type);
        }

        return result;
    }
}