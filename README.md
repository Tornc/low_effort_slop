# Merl but in CC terminal!

![demo](demo.png)

From: https://help.minecraft.net/hc/en-us

Disclaimer: please follow [Microsoft's Terms of Use](https://www.microsoft.com/en-us/legal/terms-of-use).

# Payload

### initialize_conversation

Request URL:

```
https://xsva.support.xboxlive.com/initialize_conversation
```

Request payload:

```json
{
  "clientId": "MINECRAFT_HELP",
  "conversationId": null,
  "forceReset": false,
  "greeting": "Hi there! <br/><br/> I'm Merl, your helpful Minecraft Support Virtual Agent <i>(in Beta)</i>, powered by AI! <br/><br/> I can answer questions you have about the Help Articles on this site. <br/><br/> Let's get you back to crafting!", // you can change this to anything
  "locale": "en-US",
  "country": "US"
}
```

Request response:

```json
{
  "conversationId": "...", // omitted
  "eTag": "\"...\"", // omitted
  "history": [
    {
      "turnId": "...", // omitted
      "actor": "assistant",
      "response": [
        {
          "type": "Paragraph",
          "text": "Hi there! <br/><br/> I'm Merl, your helpful Minecraft Support Virtual Agent <i>(in Beta)</i>, powered by AI! <br/><br/> I can answer questions you have about the Help Articles on this site. <br/><br/> Let's get you back to crafting!" // This value depends on what you put in greeting.
        }
      ]
    }
  ],
  "customizationSelections": {
    "personaId": "..." // omitted
  },
  "clientRules": {
    "supportedPersonaIds": ["..."] // omitted
  }
}
```

### chat

Request URL:

```
https://xsva.support.xboxlive.com/chat
```

Request payload:

```json
{
  "conversationId": "...", // omitted
  "eTag": "\"...\"", // omitted
  "text": "How do I craft a shovel?", // The prompt you want to send to Merl.
  "customizationSelections": {
    "personaId": "..." // omitted
  }
}
```

Request response:

```json
{
  "conversationId": "...", // omitted
  "eTag": "\"...\"", // omitted
  "turnId": "...", // omitted
  "response": [
    {
      "voice": "happy",
      "animation": "wave",
      "type": "Paragraph",
      "text": "To craft a shovel in Minecraft, you'll need the following materials depending on the type of shovel you want (wooden, stone, iron, gold, or diamond):<br><br>1. 2 of the same material for the shovel head (e.g., 2 wooden planks for a wooden shovel).<br>2. 1 stick for the handle."
    },
    {
      "voice": "happy",
      "animation": "wave",
      "type": "UnorderedList",
      "list": [
        {
          "text": "Open your crafting table."
        },
        {
          "text": "Place the two materials in a vertical line in the first two slots of the crafting grid."
        },
        {
          "text": "Place the stick in the middle slot of the third column."
        },
        {
          "text": "Once crafted, drag the shovel to your inventory."
        }
      ]
    }
  ],
  "metadata": {
    "intent": "how do I craft a shovel",
    "overallIssue": "crafting a shovel",
    "chatLlmCall": {
      "callId": "...", // omitted
      "finishReason": "tool_calls",
      "promptTokens": 6583,
      "completionTokens": 186,
      "totalTokens": 6769,
      "maxTokens": 512,
      "statusCode": 200
    },
    "intentLlmCall": {
      "callId": "...", // omitted
      "finishReason": "tool_calls",
      "promptTokens": 2508,
      "completionTokens": 49,
      "totalTokens": 2557,
      "maxTokens": 100,
      "statusCode": 200
    }
  }
}
```

Note that `eTag` changes every message, so you have to always use the one from the last response. Also, there are 2 possible response types: just a single text and a list of texts.
