---
name: perl-cgi
description: This tool facilitates the interface between web servers and Perl scripts to process user input and generate dynamic web content using the CGI.pm library. Use when user asks to create interactive web applications in Perl, handle web form parameters, manage cookies, or maintain legacy CGI systems.
homepage: https://metacpan.org/pod/distribution/CGI/lib/CGI.pod
---


# perl-cgi

## Overview
The `perl-cgi` skill provides guidance for utilizing the `CGI.pm` library, the legacy standard for creating interactive web applications in Perl. It facilitates the interface between web servers and Perl scripts, allowing for the processing of user input from web forms and the generation of dynamic web content. This skill is essential for maintaining legacy web systems or building lightweight, dependency-free web hooks where a full web framework is not required.

## Core Usage Patterns

### Basic Script Structure
Every CGI script must output a valid HTTP header before any content.
```perl
#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $q = CGI->new;

# Output header (defaults to text/html)
print $q->header();

# Output content
print $q->start_html("Page Title");
print $q->h1("Hello World");
print $q->end_html;
```

### Handling Input Parameters
Access named parameters from GET or POST requests using the `param()` method.
```perl
# Get a single value
my $user = $q->param('username');

# Get multiple values (e.g., from checkboxes)
my @colors = $q->multi_param('colors');

# List all parameter names
my @names = $q->param;
```

### Generating Form Elements
Use the functional or object-oriented interface to create HTML form components.
```perl
print $q->start_form;
print $q->textfield(-name => 'search', -default => 'type here');
print $q->submit(-value => 'Search');
print $q->end_form;
```

### Cookie Management
```perl
# Setting a cookie
my $cookie = $q->cookie(-name=>'sessionID', -value=>'12345', -expires=>'+1h');
print $q->header(-cookie=>$cookie);

# Retrieving a cookie
my $id = $q->cookie('sessionID');
```

## Best Practices
- **Security**: Always sanitize input obtained via `$q->param()`. Never pass raw CGI parameters directly to system calls or shell commands.
- **Modernization**: For new large-scale projects, consider modern frameworks like Mojolicious or Dancer2. Use `CGI.pm` primarily for maintenance or simple scripts.
- **Debugging**: Run scripts from the command line to check for syntax errors. You can simulate parameters by passing them as arguments: `perl script.pl name=value`.
- **STDOUT**: Ensure no warnings or random print statements occur before `$q->header()`, as this will cause a "500 Internal Server Error" in the browser.
- **File Uploads**: Use `$q->upload('field_name')` to handle file handles for uploaded content safely.

## Reference documentation
- [CGI.pm Specification](./references/metacpan_org_pod_distribution_CGI_lib_CGI.pod.md)