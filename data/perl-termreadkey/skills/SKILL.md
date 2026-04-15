---
name: perl-termreadkey
description: The perl-termreadkey module provides a low-level interface for controlling terminal input modes and retrieving hardware-level terminal information in Perl. Use when user asks to read passwords without echoing, perform non-blocking key presses, or determine terminal window dimensions.
homepage: http://metacpan.org/pod/TermReadKey
metadata:
  docker_image: "quay.io/biocontainers/perl-termreadkey:2.38--pl526h470a237_0"
---

# perl-termreadkey

## Overview
The `Term::ReadKey` module provides a low-level interface for controlling terminal behavior in Perl. It is essential for creating interactive command-line tools that need to go beyond standard line-buffered input. Key capabilities include switching between "cooked" and "raw" input modes, setting timeouts for user responses, and retrieving hardware-level terminal information like screen width and height.

## Usage Patterns

### Basic Input Modes
Use `ReadMode` to control how the terminal handles input:
- `ReadMode 0`: Reset to default (Restore).
- `ReadMode 1`: Standard terminal mode (Cooked).
- `ReadMode 2`: Disable echo (useful for passwords).
- `ReadMode 3`: Character-at-a-time (Cbreak).
- `ReadMode 4`: Raw mode (Full control).

### Reading Passwords
To read a password securely without displaying characters:
```perl
use Term::ReadKey;

print "Enter password: ";
ReadMode('noecho');
my $password = ReadLine(0);
chomp($password);
ReadMode('restore');
print "\n";
```

### Non-Blocking Key Press
To check if a key has been pressed without pausing script execution:
```perl
use Term::ReadKey;

ReadMode 4; # Turn off controls
while (1) {
    if (defined (my $key = ReadKey(-1))) {
        print "You pressed: $key\n";
        last if $key eq 'q';
    }
    # Perform other tasks here
}
ReadMode 0; # Reset terminal
```

### Getting Terminal Size
To format output dynamically based on the user's window size:
```perl
use Term::ReadKey;

my ($width, $height, $wpixels, $hpixels) = GetTerminalSize();
print "Terminal is $width columns wide and $height rows high.\n";
```

## Best Practices
- **Always Restore**: Use `ReadMode 0` or `ReadMode 'restore'` in an `END` block or before the script exits to ensure the user's terminal isn't left in a broken state (e.g., with echo disabled).
- **Portable Timeouts**: When using `ReadKey(seconds)`, a value of `0` performs a non-blocking read, while a positive value waits for that duration.
- **Error Handling**: Check if `GetTerminalSize` returns a valid list, as it may fail if the script is not running in a functional TTY (e.g., inside a pipe or cron job).

## Reference documentation
- [Term::ReadKey Documentation](./references/metacpan_org_pod_TermReadKey.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-termreadkey_overview.md)