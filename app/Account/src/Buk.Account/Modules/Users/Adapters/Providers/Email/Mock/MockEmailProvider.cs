using Buk.Account.Modules.Users.Adapters.Database.Postgres.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.UI.Services;

namespace Buk.Account.Modules.Users.Adapters.Providers.Email.Mock;

public class MockEmailProvider(
    ILogger<MockEmailProvider> logger
    ) : IEmailSender<PostgresUser>, IEmailSender
{
    private readonly ILogger<MockEmailProvider> logger = logger;

    public Task SendConfirmationLinkAsync(PostgresUser user, string email, string confirmationLink)
    {
        logger.LogInformation("SendConfirmationLinkAsync: {user}, {email}, {confirmationLink}", user, email, confirmationLink);

        return Task.CompletedTask;
    }

    public Task SendEmailAsync(string email, string subject, string message)
    {
        logger.LogInformation("SendEmailAsync: {email}, {subject}, {message}", email, subject, message);
        return Task.CompletedTask;
    }

    public Task SendPasswordResetCodeAsync(PostgresUser user, string email, string resetCode)
    {
        logger.LogInformation("SendPasswordResetCodeAsync: {user}, {email}, {resetCode}", user, email, resetCode);
        return Task.CompletedTask;
    }

    public Task SendPasswordResetLinkAsync(PostgresUser user, string email, string resetLink)
    {
        logger.LogInformation("SendPasswordResetLinkAsync: {user}, {email}, {resetLink}", user, email, resetLink);
        return Task.CompletedTask;
    }
}
