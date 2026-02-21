---
name: perl-email-simple
description: The `perl-email-simple` skill provides a streamlined approach to handling email messages in the RFC2822 format.
homepage: https://github.com/rjbs/Email-Simple
---

# perl-email-simple

## Overview

The `perl-email-simple` skill provides a streamlined approach to handling email messages in the RFC2822 format. Unlike more complex MIME-handling suites, this tool focuses on the core components of an email: the header block and the body. It is particularly useful for bioinformaticians or system administrators who need to programmatically process mail queues, extract metadata from archived communications, or inject custom headers into existing messages using Perl one-liners or scripts.

## Installation

The package is available via the Bioconda channel:

```bash
conda install bioconda::perl-email-simple
```

## Common Usage Patterns

### Parsing Emails via CLI One-liners

`Email::Simple` is frequently used in shell pipelines to extract information from saved email files or streams.

**Extract a specific header:**
```bash
perl -MEmail::Simple -e 'my $mail = Email::Simple->new(join "", <>); print $mail->header("Subject")' < message.eml
```

**List all header names present in a message:**
```bash
perl -MEmail::Simple -e 'my $mail = Email::Simple->new(join "", <>); print join("\n", $mail->header_names)' < message.eml
```

**Print the message body only:**
```bash
perl -MEmail::Simple -e 'my $mail = Email::Simple->new(join "", <>); print $mail->body' < message.eml
```

### Modifying and Creating Messages

**Add or replace a header:**
```bash
perl -MEmail::Simple -e '
    my $mail = Email::Simple->new(join "", <>);
    $mail->header_set("X-Processed-By" => "Bio-Pipeline");
    print $mail->as_string;
' < input.eml > output.eml
```

**Prepend a raw header (useful for trace headers):**
```bash
perl -MEmail::Simple -e '
    my $mail = Email::Simple->new(join "", <>);
    $mail->header_raw_prepend("X-Custom-Trace: " . time);
    print $mail->as_string;
' < input.eml
```

**Rename an existing header:**
```bash
perl -MEmail::Simple -e '
    my $mail = Email::Simple->new(join "", <>);
    $mail->header_rename("Old-Header", "New-Header");
    print $mail->as_string;
' < input.eml
```

## Expert Tips and Best Practices

*   **Slurping Input**: When using `Email::Simple->new()`, ensure you provide the entire message as a single string. In one-liners, `join "", <>` is the standard way to "slurp" STDIN.
*   **Raw vs. Folded Headers**: Use `header_raw()` when you need to access the header exactly as it appears in the source, including any folding whitespace. Use `header()` for the unfolded, cleaned value.
*   **Handling Multiple Headers**: If a header appears multiple times (like `Received`), `header("Name")` returns the first instance in scalar context and all instances in list context.
*   **Line Endings**: `Email::Simple` is sensitive to line endings. If you are creating messages from scratch, ensure your body and headers use consistent CRLF (`\r\n`) if strict RFC compliance is required for downstream MTAs.
*   **Memory Efficiency**: For extremely large mailboxes, avoid slurping the entire file. Process messages one by one by splitting the mailbox file (e.g., using `formail` or a custom separator) before passing individual messages to `Email::Simple`.

## Reference documentation

- [perl-email-simple - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-email-simple_overview.md)
- [rjbs/Email-Simple: the Email-Simple perl distribution](./references/github_com_rjbs_Email-Simple.md)
- [Commits · rjbs/Email-Simple · GitHub](./references/github_com_rjbs_Email-Simple_commits_main.md)