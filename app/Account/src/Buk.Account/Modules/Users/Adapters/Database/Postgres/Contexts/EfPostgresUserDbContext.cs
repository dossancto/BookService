using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Buk.Account.Modules.Users.Adapters.Database.Postgres.Entities;

public class EfPostgresUserDbContext(DbContextOptions options) : IdentityDbContext<PostgresUser>(options)
{
    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        builder.ApplyConfigurationsFromAssembly(typeof(UsersModule).Assembly);
    }

}
