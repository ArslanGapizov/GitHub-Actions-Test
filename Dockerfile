# Use the SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app

# Copy the .csproj and restore any dependencies (via dotnet restore)
COPY ["MyApp/MyApp.csproj", "MyApp/"]
RUN dotnet restore "MyApp/MyApp.csproj"

# Copy the rest of the app and build
COPY . ./
WORKDIR "/app/MyApp"
RUN dotnet publish -c Release -o out

# Use the runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build-env /app/MyApp/out .
ENTRYPOINT ["dotnet", "MyApp.dll"]
