# Use the SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /MyApp

COPY MyApp/*.csproj .
RUN dotnet restore

COPY MyApp .

RUN dotnet publish -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0 as runtime

WORKDIR /publish

COPY --from=build-env /publish .

EXPOSE 80

ENTRYPOINT ["dotnet", "MyApp.dll"]