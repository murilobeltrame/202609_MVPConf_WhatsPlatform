using Microsoft.OpenApi;

using WinePlatform;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddOpenApi(o => o.OpenApiVersion = OpenApiSpecVersion.OpenApi3_0);
builder.Services.AddHealthChecks();

builder.Services.AddCors(o => o
    .AddDefaultPolicy(p => p
        .AllowAnyOrigin()
        .AllowAnyHeader()
        .AllowAnyMethod()));

var app = builder.Build();

app.MapOpenApi();
app.MapGrapeEndpoints();
app.MapWinePlatformEndpoints();
app.MapHealthChecks("/health");

app.UseHttpsRedirection();

await app.RunAsync();
