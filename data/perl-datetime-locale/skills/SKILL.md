---
name: perl-datetime-locale
description: This tool provides localized date and time formatting for Perl applications using the Unicode Common Locale Data Repository. Use when user asks to localize date strings, retrieve regional month or day names, or format time data according to specific language and territory conventions.
homepage: http://metacpan.org/release/DateTime-Locale
metadata:
  docker_image: "quay.io/biocontainers/perl-datetime-locale:1.45--pl5321h9948957_1"
---

# perl-datetime-locale

## Overview
This skill provides guidance on using the `DateTime::Locale` Perl module to localize date and time information. It is essential for applications that need to display time data in multiple languages or follow specific regional formatting conventions (e.g., date ordering, month names, and era designations). It leverages the Unicode Common Locale Data Repository (CLDR) to ensure accuracy across hundreds of global locales.

## Usage Patterns

### Loading Locales
To work with a specific locale, you must first instantiate a locale object using its identifier (e.g., 'en-US', 'fr-FR', 'zh-Hant-TW').

```perl
use DateTime::Locale;

# Load a specific locale
my $locale = DateTime::Locale->load('en-GB');

# Get the default/current locale
my $current = DateTime::Locale->load('current');
```

### Retrieving Localized Names
Once a locale object is loaded, you can extract specific naming data for UI elements.

- **Month Names:** `$locale->month_names` (returns array ref)
- **Day Names:** `$locale->day_names` (returns array ref)
- **Abbreviated Names:** `$locale->month_abbreviations` or `$locale->day_abbreviations`
- **Narrow Names:** `$locale->month_narrow` (usually a single letter)

### Date and Time Formats
The module provides access to standard CLDR format strings (LDML patterns) for various lengths.

- **Date Formats:** `$locale->date_format_long`, `$locale->date_format_medium`, `$locale->date_format_short`
- **Time Formats:** `$locale->time_format_full`, `$locale->time_format_short`

### Integration with DateTime.pm
The most common use case is passing the locale object or ID directly to a `DateTime` constructor to automate formatting.

```perl
use DateTime;

my $dt = DateTime->now( locale => 'es-ES' );
print $dt->month_name(); # Outputs 'mayo' (if current month is May)
```

## Expert Tips
- **Locale Availability:** Use `DateTime::Locale->codes` to get a list of all supported locale identifiers on the system.
- **Case Sensitivity:** Locale IDs are generally case-insensitive in this module, but following the 'language-Territory' (e.g., 'en-US') convention is best practice.
- **Performance:** If your application switches locales frequently, cache the locale objects returned by `load()` to avoid repeated lookup overhead.
- **Aliases:** The module handles common aliases (e.g., 'en' maps to 'en-US' or a base English locale).

## Reference documentation
- [DateTime-Locale MetaCPAN](./references/metacpan_org_release_DateTime-Locale.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-datetime-locale_overview.md)