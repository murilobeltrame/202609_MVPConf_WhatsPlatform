using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

using WinePlatform.Tools;

var builder = WebApplication.CreateBuilder(args);

// Configure all logs to go to stderr (stdout is used for the MCP protocol messages).
builder.Logging.AddConsole(o => o.LogToStandardErrorThreshold = LogLevel.Trace);

// Add the MCP services: the transport to use (stdio) and the tools to register.
builder.Services
    .AddMcpServer()
    .WithHttpTransport()
    .WithTools<GrapeTools>();

builder.Services.AddCors(o => o
    .AddDefaultPolicy(p => p
        .AllowAnyOrigin()
        .AllowAnyHeader()
        .AllowAnyMethod()));

var app = builder.Build();

app.UseCors();
app.MapGet("/health", () => Results.Ok("OK"));
app.MapMcp("/mcp");

await app.RunAsync();
