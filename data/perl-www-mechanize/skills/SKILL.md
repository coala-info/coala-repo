---
name: perl-www-mechanize
description: WWW::Mechanize (often called "Mech") is a powerful Perl module designed for automated web browsing.
homepage: https://metacpan.org/pod/WWW::Mechanize
---

# perl-www-mechanize

## Overview
WWW::Mechanize (often called "Mech") is a powerful Perl module designed for automated web browsing. It maintains state, handles cookies, manages a history stack (back/forward), and provides high-level methods to interact with page elements like links and forms. This skill is ideal for web scraping, automated testing of web applications, and interacting with sites that require multi-step navigation or session management.

## Core Usage Patterns

### Basic Navigation and Extraction
The most common workflow involves fetching a page and then acting on its content.

```perl
use WWW::Mechanize;
my $mech = WWW::Mechanize->new( autocheck => 1 );

$mech->get("https://example.com/login");

# Extract all links
my @links = $mech->links();

# Find a specific link by text and click it
$mech->follow_link( text => "Contact Us" );

# Get the raw HTML content
my $html = $mech->content();
```

### Form Submission
Mech excels at identifying and filling out forms without needing to know the exact HTML structure of the `<form>` tag.

```perl
# List all forms on the current page to identify the right one
# print $mech->dump_forms(); 

# Select the first form or find by name/id
$mech->form_number(1); 

# Set field values
$mech->set_fields(
    user_id  => "my_username",
    password => "secret_pass",
);

# Submit the form
$mech->click();
```

### Handling Images and Links
You can filter for specific resources using regex or attributes.

```perl
# Find all images with "logo" in the filename
my @logos = $mech->find_all_images( url_regex => qr/logo/i );

# Follow the third link on the page
$mech->follow_link( n => 3 );
```

## Expert Tips and Best Practices

- **Enable Autocheck**: Always use `autocheck => 1` in the constructor. This causes Mech to `die` if a request fails (e.g., 404 or 500), saving you from writing manual error checks after every `get()` or `click()`.
- **User Agent Spoofing**: Some sites block the default "WWW-Mechanize/x.xx" agent. Change it to look like a standard browser:
  `$mech->agent_alias('Windows IE 6');` or `$mech->agent('Mozilla/5.0...');`
- **Caching for Politeness**: When scraping, use `WWW::Mechanize::Cached` to avoid hitting the server repeatedly for the same content during development.
- **Content Handling**: Use `$mech->content( format => 'text' )` to get a stripped, text-only version of the page, which is often easier for regex-based data extraction than raw HTML.
- **Debugging**: Use `$mech->dump_links()`, `$mech->dump_images()`, and `$mech->dump_forms()` to quickly inspect the state of the current page in your terminal.

## Common CLI Usage (via WWW::Mechanize::Shell)
If you have `WWW::Mechanize::Shell` installed, you can interact with sites via a command-line interface to test your logic before writing the script:

```bash
# Start the shell
perl -MWWW::Mechanize::Shell -e shell

# Inside the shell:
> get https://metacpan.org
> fillform
> submit
> content
```

## Reference documentation
- [WWW::Mechanize](./references/metacpan_org_pod_WWW__Mechanize.md)
- [WWW::Mechanize::Cached](./references/metacpan_org_pod_WWW__Mechanize__Cached.md)
- [WWW::Mechanize::Shell](./references/metacpan_org_pod_WWW__Mechanize__Shell.md)