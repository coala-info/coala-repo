[Eidos](/)   [Download](/download) [Pricing](/pricing)

Services

[Relay Beta](/relay)

Sync Soon

Publish Soon

[Extensions](/extensions) [Docs](https://docs.eidos.space) Account    Open main menu

[Download](/download) [Pricing](/pricing)

Services

 [Relay Beta](/relay)

Sync Soon

Publish Soon

[Extensions](/extensions) [Docs](https://docs.eidos.space) [Account](/account)

# Relay

Designed for local-first applications.

Collect data from anywhere, anytime.

Message Queue Offline-First Webhook

## Why Relay?

Your apps run locally — but data comes from everywhere.
Telegram bots, webhooks, IoT sensors, mobile shortcuts.

Relay bridges this gap. It's a message queue that holds your data
in the cloud until your local app is ready to process it.

* No need to keep your device online 24/7
* No server setup or database maintenance
* Process data on your own terms

#### Without Relay

Webhook fails when your device is offline. Data lost.

→

#### With Relay

Webhook queued. Delivered when you're back online.

## Send & Process

HTTP in. Script or HTTP out. Your choice.

Send HTTP POST

```
curl -X POST https://api.eidos.space/v1/relay/channels/daily-log/messages \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  -d '{
    "body": {
      "text": "Buy groceries from supermarket"
    }
  }'
```

Relay

Process  Eidos Script HTTP Pull

```
// In Eidos Desktop
export const meta = {
  type: "relayHandler",
  funcName: "handleDailyLog",
  relayHandler: {
    name: "Daily Log",
    channel: "daily-log"
  }
}

export async function handleDailyLog(batch) {
  const date = new Date().toISOString().split('T')[0]
  const filePath = "~/notes/${date}.md"

  for (const message of batch.messages) {
    const entry = `- [ ] ${message.body.text}\n`
    try {
      const existing = await eidos.space.fs.readFile(filePath, 'utf-8')
      await eidos.space.fs.writeFile(filePath, existing + entry)
    } catch {
      await eidos.space.fs.writeFile(filePath, entry)
    }
  }
}
```

```
// Pull messages
curl -X POST https://api.eidos.space/v1/relay/channels/my-channel/messages/pull \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  -d '{"batch_size": 10}'

// Process messages
for (const msg of result.messages) {
  await processMessage(msg.body)
}

// Acknowledge with lease_ids
curl -X POST https://api.eidos.space/v1/relay/channels/my-channel/messages/ack \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  -d '{"lease_ids": ["..."]}'
```

## Use Cases

### Daily Log

Send quick notes from your phone. Append to daily markdown files automatically.

### Bookmark Archiving

Save URLs from any app. Process metadata and store in your local knowledge base.

### IoT Collection

Sensor data from edge devices. Batch process when your analysis station is ready.

### Webhook Aggregation

Github, Stripe, Slack events. One endpoint, batch processing.

## How it works

1

### Send

HTTP POST from anywhere — curl, webhook, mobile apps.

2

### Queue

Messages stored in cloud buffer. Device can be offline.

3

### Pull

Your app pulls in batches when ready. Or via HTTP API.

4

### Process

Handle in Eidos script or your own code. Full control.

## Start collecting your data

[Get API Key](https://eidos.space/account?tab=api-keys) [Documentation](https://docs.eidos.space/services/relay)

[Eidos](/)

An extensible framework for personal data management.

© 2026 Eidos

### Product

* [Download](/download)
* [Pricing](/pricing)
* [Changelog](/changelog)

### Services

* [Relay](/relay)
* Sync Soon
* Publish Soon

### Resources

* [Documentation](https://docs.eidos.space)
* [Extensions](/extensions)
* [GitHub](https://github.com/mayneyao/eidos)
* [Discord](https://discord.gg/cGQqjeFpZq)
* Support

### Legal

* [Privacy Policy](/privacy)
* [Terms of Service](/terms)