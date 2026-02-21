---
name: perl-template-toolkit
description: The Perl Template Toolkit is a powerful and flexible engine for processing templates.
homepage: https://metacpan.org/pod/Template::Toolkit
---

# perl-template-toolkit

## Overview
The Perl Template Toolkit is a powerful and flexible engine for processing templates. It allows users to define a template structure with embedded directives that are populated with dynamic data at runtime. This skill provides guidance on using the `tpage` and `ttree` command-line utilities, as well as the core Template Toolkit syntax for variable interpolation, control structures, and plugin usage.

## Core Syntax and Directives
Template Toolkit directives are typically enclosed in `[% ... %]`.

- **Variable Interpolation**: `[% variable_name %]`
- **Variable Assignment**: `[% SET user = 'Alice' %]` or `[% user = 'Alice' %]`
- **Conditionals**:
  ```tt2
  [% IF user %]
    Hello [% user %]!
  [% ELSE %]
    Hello Guest!
  [% END %]
  ```
- **Loops**:
  ```tt2
  [% FOREACH item IN list %]
    * [% item %]
  [% END %]
  ```
- **Including Other Templates**: `[% INCLUDE header.tt2 %]`
- **Processing Templates (Local Scope)**: `[% PROCESS footer.tt2 %]`
- **Comments**: `[% # This is a comment %]`

## Command Line Usage

### Quick Processing with `tpage`
Use `tpage` to process a single template file quickly. It reads from STDIN or a file and sends the result to STDOUT.

```bash
# Process a template with environment variables
tpage my_template.tt2 > output.html
```

### Batch Processing with `ttree`
Use `ttree` to manage entire directories of templates. It is useful for generating static websites or large configuration sets.

```bash
# Initialize a ttree configuration file
ttree -f .ttreerc

# Process a source directory to a destination
ttree -src ./templates -dest ./output -lib ./lib
```

**Common `ttree` Options:**
- `-a`: Process all files regardless of modification time.
- `-r`: Recursively process sub-directories.
- `-v`: Verbose mode.
- `--ignore=regex`: Ignore files matching the regular expression.

## Best Practices
- **Keep Logic Simple**: Use templates for presentation. Complex data manipulation should be handled in the Perl script/driver before passing data to the template.
- **Use Virtual Methods**: TT2 supports "dot notation" for manipulating data types (e.g., `[% my_list.sort.join(', ') %]` or `[% my_string.upper %]`).
- **Filters**: Use filters for output formatting, such as `[% content | html %]` to escape HTML entities or `[% content | repeat(3) %]`.
- **Plugins**: Leverage standard plugins for advanced functionality:
  ```tt2
  [% USE date %]
  Current year: [% date.format(date.now, '%Y') %]
  ```

## Reference documentation
- [Template::Toolkit Documentation](./references/metacpan_org_pod_Template__Toolkit.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-template-toolkit_overview.md)