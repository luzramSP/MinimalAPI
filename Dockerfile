FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY *.sln .
RUN dotnet restore

COPY MinimalApi/. ./MinimalApi/
WORKDIR /app/MinimalApi
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish ./

EXPOSE 8080

ENTRYPOINT ["dotnet", "MinimalApi.dll"]
