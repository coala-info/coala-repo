---
name: perl-mime-types
description: The `perl-mime-types` skill provides a programmatic interface for handling the official IANA list of media types.
homepage: http://metacpan.org/pod/MIME-Types
---

# perl-mime-types

## Overview
The `perl-mime-types` skill provides a programmatic interface for handling the official IANA list of media types. It allows Perl scripts to translate between file extensions and MIME types (e.g., `.html` to `text/html`) and provides metadata about those types, such as whether they are considered "text" or "binary." This is essential for web servers, mail clients, and file processing utilities built in Perl.

## Usage Patterns

### Basic Object Initialization
To use the library, you must first create a `MIME::Types` singleton or instance.
```perl
use MIME::Types;
my $mt = MIME::Types->new;
```

### Mapping Extensions to MIME Types
To find the MIME type associated with a specific file extension:
```perl
# Returns a MIME::Type object
my $type = $mt->mimeTypeOf('png'); 

# Get the string representation
print $type->type; # "image/png"
```

### Querying MIME Type Properties
Once you have a `MIME::Type` object, you can inspect its characteristics:
```perl
my $type = $mt->mimeTypeOf('txt');

if ($type->isText) {
    print "This is a text format";
}

if ($type->encoding eq 'base64') {
    print "Requires base64 encoding for mail";
}
```

### Handling Multiple Extensions
Some MIME types map to multiple extensions. You can retrieve the full list:
```perl
my $type = $mt->type('image/jpeg');
my @extensions = $type->extensions; # ('jpeg', 'jpg', 'jpe')
```

### Best Practices
- **Singleton Usage**: For performance in long-running scripts, use `MIME::Types->new` once and pass the object around, or use the exportable functions if only simple lookups are needed.
- **Case Sensitivity**: Extension lookups are generally case-insensitive within the library, but it is best practice to pass lowercase extensions.
- **Validation**: Always check if `mimeTypeOf` returns a defined value before calling methods on the resulting object to avoid "member function on undefined value" errors.

## Reference documentation
- [MIME-Types Documentation](./references/metacpan_org_pod_MIME-Types.md)