using Buk.Account.Modules.Users.Adapters.Database.Postgres.Entities;
using Buk.Account.Modules.Users.Adapters.Providers.Email.Brevo;
using Buk.Account.Modules.Users.Adapters.Providers.Email.Mock;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI.Services;

namespace Buk.Account.Modules.Users;

public class UsersModule;

public static class UsersModuleInjector
{
    public static IServiceCollection AddUsersModule(this IServiceCollection services)
    => services
       .AddIdentityConfig()
       .AddProviders()
    ;

    private static IServiceCollection AddIdentityConfig(this IServiceCollection services)
    {
        services
             .AddIdentityCore<PostgresUser>(o => o.User.RequireUniqueEmail = true)
             .AddEntityFrameworkStores<EfPostgresUserDbContext>()
             .AddApiEndpoints();

        return services;
    }

    private static IServiceCollection AddProviders(this IServiceCollection services)
    {
        AddEmailProviders(services);

        return services;
    }

    public static void AddEmailProviders(this IServiceCollection services)
    {
        var env = AppEnv.ASPNETCORE_ENVIRONMENT.GetDefault("Development");

        var useRealEmailProvider = AppEnv.EMAIL_SENDER.GLOBAL.USE_REAL_EMAIL_PROVIDER.GetDefault(false);

        if (env == "Development" && useRealEmailProvider is false)
        {
            services.AddTransient<IEmailSender, MockEmailProvider>();

            return;
        }

        services.AddBrevoEmailSender();

        return;
    }

    public static IServiceCollection AddBrevoEmailSender(this IServiceCollection services)
    {
        services.AddHttpClient<IEmailSender, BrevoEmailSender>(x =>
        {
            x.BaseAddress = new(AppEnv.EMAIL_SENDER.BREVO.BASE_URL.NotNull());

            x.DefaultRequestHeaders.Add("Api-Key", AppEnv.EMAIL_SENDER.BREVO.API_KEY.NotNull());
        });

        return services;
    }
}
