using Buk.Account.Modules.Users.Adapters.Database.Postgres.Entities;
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

    private static void AddEmailProviders(IServiceCollection services)
    {
        // services.AddTransient<IEmailSender<PostgresUser>, MockEmailProvider>();
        services.AddTransient<IEmailSender, MockEmailProvider>();
    }
}
