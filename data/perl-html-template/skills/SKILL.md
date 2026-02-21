---
name: perl-html-template
description: HTML::Template is a lightweight Perl module designed to separate application logic from presentation.
homepage: https://metacpan.org/pod/HTML::Template
---

# perl-html-template

## Overview

HTML::Template is a lightweight Perl module designed to separate application logic from presentation. It uses an HTML-like syntax for placeholders and control structures, allowing designers to work on templates without needing to understand Perl code. The module is particularly effective for CGI scripts and web applications where data-driven HTML generation is required.

## Core Template Tags

The module uses specific tags to define where data should be inserted:

- `<TMPL_VAR NAME="parameter_name">`: Replaced by the value assigned in the Perl script.
- `<TMPL_LOOP NAME="loop_name">`: Iterates over an array of hashes. Each hash in the array represents a row in the loop.
- `<TMPL_IF NAME="parameter_name">`: Renders content only if the parameter is true.
- `<TMPL_ELSE>`: Used within IF or UNLESS blocks.
- `<TMPL_UNLESS NAME="parameter_name">`: Renders content only if the parameter is false.
- `<TMPL_INCLUDE NAME="filename.tmpl">`: Includes the contents of another template file.

## Perl Implementation Pattern

To use the module in a Perl script:

```perl
use HTML::Template;

# Initialize the template
my $template = HTML::Template->new(filename => 'example.tmpl');

# Assign parameters
$template->param(
    HOME => $ENV{HOME},
    PATH => $ENV{PATH},
    USER_LIST => [
        { name => 'Alice', id => 1 },
        { name => 'Bob',   id => 2 },
    ]
);

# Generate output
print "Content-Type: text/html\n\n";
print $template->output;
```

## Expert Tips and Best Practices

### Security and Escaping
Always use the `ESCAPE` attribute for variables that contain user-provided data to prevent XSS or broken layouts:
- `<TMPL_VAR NAME="VAR" ESCAPE="HTML">`: Converts `&`, `"`, `'`, `<`, `>` to entities.
- `<TMPL_VAR NAME="VAR" ESCAPE="JS">`: Escapes characters for use in JavaScript strings.
- `<TMPL_VAR NAME="VAR" ESCAPE="URL">`: URL-encodes the value.

### Scope Management
By default, variables in the main template are not visible inside a `<TMPL_LOOP>`. To make them accessible globally, initialize the object with `global_vars`:
```perl
my $template = HTML::Template->new(
    filename    => 'file.tmpl',
    global_vars => 1
);
```

### Handling Missing Parameters
If you want the script to ignore tags in the template that aren't set in the Perl code (rather than crashing), use:
```perl
my $template = HTML::Template->new(
    filename           => 'file.tmpl',
    die_on_bad_params => 0
);
```

### Performance
In persistent environments (like mod_perl), enable caching to avoid re-parsing the template on every request:
```perl
my $template = HTML::Template->new(
    filename => 'file.tmpl',
    cache    => 1
);
```

### Lazy Values
You can pass a code reference to `param()`. The subroutine will only be executed if the variable is actually used in the template:
```perl
$template->param(HEAVY_DATA => sub { return fetch_expensive_data() });
```

## Reference documentation
- [HTML::Template - Perl module to use HTML-like templating language](./references/metacpan_org_pod_HTML__Template.md)
- [HTML::Template::FAQ - Frequently Asked Questions about HTML::Template](./references/metacpan_org_pod_HTML__Template__FAQ.md)