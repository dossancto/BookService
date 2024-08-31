using Anv;
using Buk.Account.Modules.Users.Adapters.Database.Postgres.Entities;
using Microsoft.EntityFrameworkCore;

namespace Buk.Account.Modules.Commum.Adapters.Database.Posgres;

public static class PosgresInjector
{
    public static IServiceCollection AddPosgresDatabase(this IServiceCollection services)
    {
        services
          .AddDbContext<EfPostgresUserDbContext>(options =>
            {
                options.UseNpgsql(AppEnv.DATABASE.POSTGRES.CONNECTION_STRING.NotNull());
            }
          );

        return services;
    }
}
