using AspNetCore.Scalar;
using Buk.Account.Modules.Commum;
using Buk.Account.Modules.Users;
using Buk.Account.Modules.Users.Adapters.Database.Postgres.Entities;
using DotNetEnv;
using FastEndpoints;
using FastEndpoints.Swagger;
using Microsoft.AspNetCore.Identity;

var builder = WebApplication.CreateBuilder(args);

Env.TraversePath().Load();

builder.Services.Configure<IdentityOptions>(options =>
{
    options.SignIn.RequireConfirmedEmail = true;
    options.User.RequireUniqueEmail = true;

    options.Password.RequireDigit = true;
    options.Password.RequireLowercase = true;
    options.Password.RequireUppercase = true;
    options.Password.RequireNonAlphanumeric = true;
    options.Password.RequiredLength = 8;
});

builder.Services
  .AddAuthentication()
  .AddBearerToken(IdentityConstants.BearerScheme)
  ;
builder.Services.AddAuthorizationBuilder();

builder.Services
  .AddCommumModule()
  .AddUsersModule()
  ;

/* builder.Services */
/*    .AddFastEndpoints() */
/*    .SwaggerDocument(); //define a swagger document */

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseScalar(o =>
{

});

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

using (var serviceScope = app.Services.GetRequiredService<IServiceScopeFactory>().CreateScope())
{
    var context = serviceScope.ServiceProvider.GetRequiredService<EfPostgresUserDbContext>();
    context.Database.EnsureCreated();
}

/*
app
   .UseApplicationErrorHandler()
   .UseFastEndpoints(c =>
{
    c.Endpoints.RoutePrefix = "api";
})
.UseSwaggerGen(); //add this
*/

app.MapIdentityApi<PostgresUser>();

app.UseHttpsRedirection();

app.Run();
