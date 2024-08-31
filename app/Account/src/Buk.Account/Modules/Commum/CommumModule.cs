using Buk.Account.Modules.Commum.Adapters.Database.Posgres;

namespace Buk.Account.Modules.Commum;

public static class CommumModuleInjector
{
    public static IServiceCollection AddCommumModule(this IServiceCollection services)
    {
        services.AddPosgresDatabase();

        return services;
    }
}
