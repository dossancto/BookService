using Microsoft.AspNetCore.Identity.UI.Services;
using static Buk.Account.Modules.Users.Adapters.Providers.Email.Brevo.BrevoSendEmailRequest;

namespace Buk.Account.Modules.Users.Adapters.Providers.Email.Brevo;

public class BrevoEmailSender(
    HttpClient httpClient
    ) : IEmailSender
{
    private readonly HttpClient httpClient = httpClient;

    public Task SendEmailAsync(string email, string subject, string htmlMessage)
    {
        var request = new BrevoSendEmailRequest(
            To: [
              new(
                Email: email,
                Name: email
              )
            ],
            Subject: subject,
            HtmlContent: htmlMessage,
            Sender: new(
                Email: AppEnv.EMAIL_SENDER.BREVO.SENDER.EMAIL.NotNull(),
                Name: AppEnv.EMAIL_SENDER.BREVO.SENDER.NAME.NotNull()
              )
            );

        return SendEmailAsync(request);
    }

    private async Task SendEmailAsync(BrevoSendEmailRequest request)
    {
        var res = await httpClient.PostAsJsonAsync("/v3/smtp/email", request);

        res.EnsureSuccessStatusCode();
    }
}


public record BrevoSendEmailRequest(
     EmailPerson Sender,
     List<EmailPerson> To,
     string Subject,
     string HtmlContent
    )
{
    public record EmailPerson(
        string Name,
        string Email
      );
}
