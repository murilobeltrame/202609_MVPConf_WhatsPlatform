using System.ComponentModel;

using Data;

using ModelContextProtocol.Server;

namespace WinePlatform.Tools;

internal class GrapeTools
{
    private readonly IEnumerable<Country> _countries = Country.All();
    private readonly IEnumerable<Region> _regions = Region.All();
    private readonly IEnumerable<Grape> _grapes = Grape.All();
    
    [McpServerTool]
    [Description("List all Countries that produces wine Grapes")]
    public IEnumerable<Country> AllCountries() => _countries;
    
    [McpServerTool]
    [Description("List all Countries that produces wine Grapes by name")]
    public IEnumerable<Country> CountriesByName(string name) => _countries.Where(w => w.Name.StartsWith(name, StringComparison.InvariantCultureIgnoreCase));
    
    [McpServerTool]
    [Description("List all Regions that produces wine Grapes")]
    public IEnumerable<Region> AllRegions() => _regions;

    [McpServerTool]
    [Description("List all Regions that produces wine Grapes by name")]
    public IEnumerable<Region> RegionsByNameOrCountry(string name, string countryName)
    {
        var result = _regions;
        if (!string.IsNullOrWhiteSpace(name))
        {
            result = result.Where(w => w.Name.StartsWith(name, StringComparison.InvariantCultureIgnoreCase));
        }
        if (!string.IsNullOrWhiteSpace(countryName))
        {
            result = result.Where(w => w.Country.Name.StartsWith(countryName, StringComparison.InvariantCultureIgnoreCase));
        }
        return result;
    }
    
    [McpServerTool]
    [Description("List all Grapes that produces wine")]
    public IEnumerable<Grape> AllGrapes() => _grapes;

    [McpServerTool]
    [Description("List all Grapes that produces wine by name or type")]
    public IEnumerable<Grape> GrapesByNameOrType(string? name, GrapeType? type)
    {
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