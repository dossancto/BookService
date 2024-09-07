namespace Anv;
public static partial class AppEnv
{
    public static readonly AnvEnv ASPNETCORE_ENVIRONMENT = new("ASPNETCORE_ENVIRONMENT");
    public static partial class DATABASE
    {
        public static partial class POSTGRES
        {
            public static readonly AnvEnv CONNECTION_STRING = new("DATABASE__POSTGRES__CONNECTION_STRING");
        }
    }
public static partial class EMAIL_SENDER {
public static partial class GLOBAL {
public static readonly AnvEnv USE_REAL_EMAIL_PROVIDER = new("EMAIL_SENDER__GLOBAL__USE_REAL_EMAIL_PROVIDER");
}
public static partial class BREVO {
public static readonly AnvEnv BASE_URL = new("EMAIL_SENDER__BREVO__BASE_URL");
public static readonly AnvEnv API_KEY = new("EMAIL_SENDER__BREVO__API_KEY");
public static partial class SENDER {
public static readonly AnvEnv NAME = new("EMAIL_SENDER__BREVO__SENDER__NAME");
public static readonly AnvEnv EMAIL = new("EMAIL_SENDER__BREVO__SENDER__EMAIL");
}
}
}
}
