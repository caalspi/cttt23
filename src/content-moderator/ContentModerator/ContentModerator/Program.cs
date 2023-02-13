// Your Content Moderator subscription key is found in your Azure portal resource on the 'Keys' page.
using Microsoft.Azure.CognitiveServices.ContentModerator;
using System.Text;

#region variables

#region secrets
var subscriptionKey = "<subscription_key>";
#endregion

var endpoint = "https://westeurope.api.cognitive.microsoft.com/";
var inputFileTextRedaction = "TextFile.txt";
#endregion

#region initialization

var client = new ContentModeratorClient(new ApiKeyServiceClientCredentials(subscriptionKey))
{
    Endpoint = endpoint
};

#endregion

#region profanity check + text redaction

Console.WriteLine("--------------------------------------------------------------");
Console.WriteLine();
Console.WriteLine("TEXT REDACTION");
Console.WriteLine();

// Load the input text.
string text = File.ReadAllText(inputFileTextRedaction);

// Remove carriage returns
//text = text.Replace(Environment.NewLine, " ");
// Convert string to a byte[], then into a stream (for parameter in ScreenText()).
byte[] textBytes = Encoding.UTF8.GetBytes(text);
MemoryStream stream = new(textBytes);

Console.WriteLine("Screening {0}...", inputFileTextRedaction);
Console.WriteLine("\n");

var screenResult = await client.TextModeration.ScreenTextAsync("text/plain", stream, "eng", true, true, null, true);

var distinctTerms = screenResult.Terms.Distinct().OrderByDescending(t => t.Term.Length);
foreach (var term in distinctTerms)
{
    var replacement = string.Join(" ", term.Term.Split(" ").Select(s => new string('*', s.Length)));
    screenResult.OriginalText = screenResult.OriginalText.Replace(term.Term, replacement, ignoreCase: true, null);
}

Console.WriteLine(screenResult.OriginalText);
Console.WriteLine("\n");

var profanityDetected = screenResult.Classification.ReviewRecommended.HasValue && screenResult.Classification.ReviewRecommended.Value;
Console.WriteLine($"CHILDPROOF: {(profanityDetected ? "X" : "V")}");

Console.WriteLine();

#endregion


