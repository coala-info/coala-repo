---
name: perl-mime-tools
description: This skill provides guidance on using the `MIME::Tools` suite to handle email structures.
homepage: https://metacpan.org/pod/MIME-tools
---

# perl-mime-tools

## Overview
This skill provides guidance on using the `MIME::Tools` suite to handle email structures. It is particularly useful for backend mail processing tasks where you need to "explode" a MIME message into its constituent parts (headers, body, and attachments) or rebuild a message from scratch. It excels at handling nested multi-part messages and decoding various transfer encodings (Base64, Quoted-Printable) automatically.

## Core Workflows

### Parsing and Decomposing Messages
The most common use case is using `MIME::Parser` to extract data from an existing email file.

```perl
use MIME::Parser;

my $parser = new MIME::Parser;
# Configure where to store attachments
$parser->output_under("/tmp/mimemail");

# Parse an input file handle or file
my $entity = $parser->parse_open("test.msg");

# Access parts
my $head = $entity->head;
print "Subject: ", $head->get('Subject');

# Iterate through parts to find attachments
foreach my $part ($entity->parts) {
    if ($part->mime_type eq 'image/jpeg') {
        my $path = $part->bodyhandle->path;
        print "Saved image to: $path\n";
    }
}
```

### Creating Multi-part Messages
Use `MIME::Entity` to build complex messages programmatically.

```perl
use MIME::Entity;

my $top = MIME::Entity->build(
    Type    => "multipart/mixed",
    From    => "sender@example.com",
    To      => "recipient@example.com",
    Subject => "Report and Data"
);

# Add a text part
$top->attach(
    Data => "Please find the attached CSV file.",
    Type => "text/plain"
);

# Attach a file
$top->attach(
    Path     => "data.csv",
    Type     => "text/csv",
    Encoding => "base64"
);

# Output the result
$top->print(\*STDOUT);
```

## Best Practices
- **Memory Management**: For large messages, always use `output_under` or `output_dir` to force the parser to write attachments to disk rather than keeping them in RAM.
- **Header Decoding**: Use `MIME::Words` to decode encoded headers (e.g., `=?UTF-8?B?...?=`). The parser does not always decode these automatically in the `head` object.
- **Cleaning Up**: When using disk-based parsing, remember to call `$entity->purge` to delete the temporary files created during decomposition once processing is finished.
- **Strictness**: If dealing with malformed emails from the wild, use `$parser->ignore_errors(1)` to attempt to extract as much data as possible despite RFC violations.

## Reference documentation
- [MIME-tools Documentation](./references/metacpan_org_pod_MIME-tools.md)