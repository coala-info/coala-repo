---
name: perl-mailtools
description: This tool provides a collection of Perl modules for parsing, manipulating, and sending RFC822 compliant email messages. Use when user asks to parse email addresses, manage email headers, filter message content, or send mail through backends like SMTP and sendmail.
homepage: https://metacpan.org/pod/MailTools
metadata:
  docker_image: "quay.io/biocontainers/perl-mailtools:2.22--pl5321hdfd78af_0"
---

# perl-mailtools

## Overview
This skill facilitates the use of the `perl-mailtools` distribution, a collection of classic Perl modules for email handling. While considered "ancient" by its maintainers, it remains a standard for simple email tasks, legacy system maintenance, and educational examples. It is best used for parsing RFC822 addresses, filtering email content, and providing a high-level interface for sending mail through various backends.

## Core Components and Usage

### Email Address Parsing (Mail::Address)
Use this to extract and manipulate email addresses from header strings.
```perl
use Mail::Address;
my @addrs = Mail::Address->parse($line);
foreach my $addr (@addrs) {
    print $addr->format, "\n";
    print $addr->address, "\n"; # user@host.com
    print $addr->phrase, "\n";  # Real Name
}
```

### Header Manipulation (Mail::Header)
Manage email headers as a collection of `Mail::Field` objects.
```perl
use Mail::Header;
my $head = Mail::Header->new(\*STDIN);
$head->replace('Subject', 'New Subject');
$head->remove('X-Mailer');
$head->print();
```

### Message Handling (Mail::Internet)
Represents a full email (header + body). Useful for basic filtering and processing.
```perl
use Mail::Internet;
my $msg = Mail::Internet->new(\*STDIN);
my $header = $msg->head;
my $body = $msg->body; # Array ref of lines
```

### Sending Email (Mail::Mailer & Mail::Send)
`Mail::Mailer` is the engine, while `Mail::Send` provides a friendlier interface for building and dispatching.

**Using Mail::Mailer:**
Supported types: `smtp`, `sendmail`, `qmail`, `testfile`.
```perl
use Mail::Mailer;
my $mailer = Mail::Mailer->new('smtp', Server => 'smtp.example.com');
$mailer->open({
    To      => 'recipient@example.com',
    Subject => 'Hello World',
});
print $mailer "This is the body of the email.\n";
$mailer->close;
```

**Using Mail::Send:**
```perl
use Mail::Send;
my $msg = Mail::Send->new(Subject => 'Test', To => 'user@example.com');
my $fh = $msg->open('sendmail'); # Specify backend here
print $fh "Body content...";
$fh->close;
```

## Best Practices
- **Backend Selection**: When using `Mail::Mailer`, explicitly define the backend (e.g., `smtp` or `sendmail`) to avoid reliance on environment-dependent defaults.
- **Legacy Warning**: For complex modern email requirements (MIME, attachments, Unicode), consider newer alternatives like `Email::Stuffer` or `MIME::Entity`, as `MailTools` is primarily for simple, plain-text RFC822 messages.
- **Address Validation**: `Mail::Address` is excellent for parsing but does not verify if an address is deliverable; it only checks if the string conforms to basic syntax.

## Reference documentation
- [MailTools - bundle of ancient email modules](./references/metacpan_org_pod_MailTools.md)
- [perl-mailtools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-mailtools_overview.md)