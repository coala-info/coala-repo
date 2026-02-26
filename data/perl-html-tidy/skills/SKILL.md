---
name: perl-html-tidy
description: This tool validates, cleans, and repairs HTML and XHTML markup using the Perl interface or the webtidy command-line utility. Use when user asks to clean up messy HTML, identify syntax errors, or programmatically ensure documents adhere to specific web standards.
homepage: http://github.com/petdance/html-tidy
---


# perl-html-tidy

## Overview

The `perl-html-tidy` skill provides access to the `HTML::Tidy` and `HTML::Tidy5` Perl modules and their associated command-line utility, `webtidy`. This tool acts as a wrapper for the `tidyp` and `tidy-html5` C libraries, allowing for robust validation and repair of web markup. Use this skill when you need to programmatically clean up messy HTML, identify syntax errors, or ensure that documents adhere to specific (X)HTML standards.

## Installation

The package is available via Bioconda:

```bash
conda install bioconda::perl-html-tidy
```

## Command Line Usage (webtidy)

The `webtidy` script is the primary CLI interface provided by this package.

### Basic Validation
To check a file for errors and warnings:
```bash
webtidy index.html
```

### Processing via Standard Input
You can pipe HTML content directly into the tool by using the `-` filename convention:
```bash
cat snippet.html | webtidy -
```

## Perl API Usage

For more complex workflows, use the Perl object interface.

### Basic Cleaning Pattern
```perl
use HTML::Tidy;

my $tidy = HTML::Tidy->new();
my $html = '<html><title>Test</title><body><h1>Unclosed tag</body>';

# Clean and repair the HTML
my $cleaned = $tidy->clean($html);

# Check for errors/warnings
for my $message ($tidy->messages) {
    print $message->as_string, "\n";
}
```

### Working with HTML5
If you are working with modern web standards, ensure you use the `HTML::Tidy5` module, which is specifically designed for HTML5 support.

```perl
use HTML::Tidy5;
my $tidy = HTML::Tidy5->new();
```

## Expert Tips

- **Configuration Files**: While the Perl object can take a hash of options, it is often cleaner to use a standard Tidy configuration file:
  ```perl
  my $tidy = HTML::Tidy->new({ config_file => 'path/to/tidy.conf' });
  ```
- **Message Filtering**: The `messages()` method returns a list of `HTML::Tidy::Message` objects. You can filter these by type (e.g., only showing errors and ignoring warnings) to reduce noise in automated CI/CD pipelines.
- **Legacy Support**: `HTML::Tidy` (the original) is no longer actively maintained in favor of `HTML::Tidy5`. For new projects, prefer the HTML5-compatible version unless you are specifically targeting legacy XHTML/HTML4 environments.

## Reference documentation
- [Anaconda Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-html-tidy_overview.md)
- [HTML::Tidy GitHub Repository](./references/github_com_petdance_html-tidy.md)
- [HTML::Tidy5 GitHub Repository](./references/github_com_petdance_html-tidy5.md)
- [HTML::Tidy Pull Requests (webtidy stdin info)](./references/github_com_petdance_html-tidy_pulls.md)