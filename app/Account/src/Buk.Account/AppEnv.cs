namespace Anv;
public static partial class AppEnv {
public static readonly AnvEnv ASPNETCORE_ENVIRONMENT = new("ASPNETCORE_ENVIRONMENT");
public static partial class DATABASE {
public static partial class POSTGRES {
public static readonly AnvEnv CONNECTION_STRING = new("DATABASE__POSTGRES__CONNECTION_STRING");
}
}
}
