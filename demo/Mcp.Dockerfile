FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY Data/ ./Data/
COPY mcp/WinePlatform/ ./mcp/WinePlatform/

RUN dotnet publish -c Release -o /app mcp/WinePlatform/

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app

COPY --from=build /app .

ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000

ENTRYPOINT ["dotnet", "WinePlatform.dll"]