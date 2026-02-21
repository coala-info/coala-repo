---
name: perl-rest-client
description: The `perl-rest-client` (REST::Client) module is a lightweight wrapper around `LWP::UserAgent` designed to simplify RESTful interactions in Perl.
homepage: http://metacpan.org/pod/REST::Client
---

# perl-rest-client

## Overview
The `perl-rest-client` (REST::Client) module is a lightweight wrapper around `LWP::UserAgent` designed to simplify RESTful interactions in Perl. It is particularly useful for bioinformatics pipelines or system scripts that need to communicate with web services without the overhead of complex SOAP or manual HTTP header management. This skill covers object instantiation, request execution, and response handling.

## Core Usage Patterns

### Basic Request Execution
Initialize the client and perform a simple GET request.
```perl
use REST::Client;

my $client = REST::Client->new();
$client->GET('https://api.example.com/v1/resource');

print "Status: " . $client->responseCode() . "\n";
print "Content: " . $client->responseContent() . "\n";
```

### Working with JSON/XML APIs
When interacting with modern APIs, you must manually set the `Content-Type` and `Accept` headers.
```perl
$client->addHeader('Content-Type', 'application/json');
$client->addHeader('Accept', 'application/json');

# POST with body content
my $body = '{"key": "value"}';
$client->POST('/api/data', $body);
```

### Configuration and Persistence
Set a base host to use relative URLs for subsequent calls and configure timeouts.
```perl
my $client = REST::Client->new({
    host    => 'https://api.service.com',
    timeout => 30,
    follow  => 1, # Automatically follow redirects
});

$client->GET('/endpoint'); # Requests https://api.service.com/endpoint
```

### SSL and Authentication
For secure services requiring client-side certificates or specific CA verification:
```perl
$client->setCert('/path/to/client.crt');
$client->setKey('/path/to/client.key');
$client->setCa('/path/to/ca.file');
```

## Response Handling Methods
After any request method (GET, POST, etc.), use these methods to inspect the result:
- `responseCode()`: Returns the numeric HTTP status (e.g., 200, 404).
- `responseContent()`: Returns the raw string of the response body.
- `responseHeader($name)`: Returns a specific header value from the server.
- `responseHeaders()`: Returns a list of all header names received.
- `responseXpath()`: Returns an `XML::LibXML` context (requires the XML::LibXML module to be installed).

## Expert Tips
- **Chaining**: Request methods return the client object, allowing for concise code: 
  `print $client->GET('/info')->responseContent();`
- **Query Building**: Use `buildQuery` to safely encode URL parameters:
  `my $url = '/search' . $client->buildQuery(q => 'query term', limit => 10);`
- **LWP Access**: If you need advanced features like proxy settings not exposed by REST::Client, access the underlying user agent:
  `$client->getUseragent()->proxy(['http'], 'http://proxy.local:8080');`
- **File Downloads**: To save a large response directly to disk without loading it into memory, use `$client->setContentFile("output.dat")` before making the request.

## Reference documentation
- [REST::Client - Metacpan](./references/metacpan_org_pod_REST__Client.md)
- [Bioconda perl-rest-client Overview](./references/anaconda_org_channels_bioconda_packages_perl-rest-client_overview.md)