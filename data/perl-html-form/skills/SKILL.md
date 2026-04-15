---
name: perl-html-form
description: This tool provides a programmatic interface to parse, manipulate, and generate requests from HTML form elements. Use when user asks to parse HTML forms, fill out form fields, or generate HTTP requests for form submission.
homepage: https://metacpan.org/pod/HTML::Form
metadata:
  docker_image: "quay.io/biocontainers/perl-html-form:6.11--pl5321hdfd78af_0"
---

# perl-html-form

## Overview
The `perl-html-form` skill provides a programmatic interface to HTML `<form>` elements. Instead of manually constructing query strings or POST bodies, this tool allows you to treat a form as an object. You can "fill out" fields by name or ID, handle different input types (hidden, text, radio, etc.) correctly, and generate valid requests that respect the form's `action`, `method`, and `enctype`. This is essential for web scraping, automated testing, or creating bots that need to log in or submit data to websites.

## Core Workflows

### Parsing Forms
To begin, you must parse HTML content to identify the forms within it.
```perl
use HTML::Form;
use HTTP::Response;

# From a raw HTML string and base URI
my @forms = HTML::Form->parse($html_content, base => "http://example.com/");

# From an LWP::UserAgent response (most common)
my @forms = HTML::Form->parse($response);

# Get a specific form by index or attribute
my $form = $forms[0]; 
my $login_form = grep { $_->attr("id") eq "login" } @forms;
```

### Manipulating Inputs
Locate inputs using selectors and update their values.
- **Selectors**: Use `#id` for IDs, `.class` for classes, and `name` or `^name` for names.
- **Strict Mode**: Enable `strict(1)` to catch errors when trying to set read-only fields or invalid values for selects/radios.

```perl
$form->strict(1);

# Find and set a text field
$form->value(username => "my_user");

# Find a specific input object for advanced control
my $input = $form->find_input('#password_field');
$input->value("secret123");

# Handle checkboxes/radio buttons
$form->value(remember_me => "on");
```

### Submitting the Form
The tool does not send the request itself; it generates an `HTTP::Request` object that you then pass to a user agent.

```perl
use LWP::UserAgent;
my $ua = LWP::UserAgent->new;

# click() generates the request for the default submit button
my $request = $form->click;

# Submit and get the response
my $res = $ua->request($request);
```

## Expert Tips
- **Hidden Fields**: `HTML::Form` automatically includes hidden fields in the generated request. Do not manually add them unless you are intentionally overriding site logic.
- **Multiple Submit Buttons**: If a form has multiple buttons (e.g., "Save" vs "Delete"), pass the name of the button to `click()`: `$form->click("save_button_name")`.
- **Dynamic Inputs**: If a form is modified via JavaScript after page load, use `push_input` to manually add the missing fields to the Perl object so they are included in the final submission.
- **Character Sets**: Always specify the charset during parsing if the site uses something other than UTF-8 to ensure data is encoded correctly for the server: `HTML::Form->parse($html, base => $url, charset => 'ISO-8859-1')`.

## Reference documentation
- [HTML::Form Documentation](./references/metacpan_org_pod_HTML__Form.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-html-form_overview.md)