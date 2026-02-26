---
name: perl-file-touch
description: This tool manages file timestamps and creates new files using the Perl File::Touch module. Use when user asks to update file access or modification times, synchronize timestamps with a reference file, or set specific epoch times with sub-second resolution.
homepage: https://github.com/neilb/File-Touch
---


# perl-file-touch

## Overview
The `perl-file-touch` skill provides a specialized interface for managing file timestamps through the `File::Touch` Perl module. While it mimics the standard Unix `touch` utility, it offers enhanced programmatic control, such as the ability to apply timestamps from a reference file or specify exact epoch times with sub-second resolution. This tool is essential for workflows where file metadata must be precisely synchronized or manipulated as part of data processing pipelines.

## Common CLI Patterns

### Basic File Touching
To update the access and modification times of a file to the current time (or create it if it doesn't exist):
```bash
perl -MFile::Touch -e 'touch("filename.txt")'
```

### Using a Reference File
To synchronize a file's timestamp with another "reference" file:
```bash
perl -MFile::Touch -e 'File::Touch->new(reference => "ref_file.txt")->touch("target_file.txt")'
```

### Setting a Specific Timestamp
To set a file to a specific Unix epoch time:
```bash
perl -MFile::Touch -e 'File::Touch->new(time => 1616250000)->touch("file.txt")'
```

### Sub-second Precision
The tool utilizes `Time::HiRes` to handle high-resolution timestamps. This is handled automatically when providing fractional epoch values:
```bash
perl -MFile::Touch -e 'File::Touch->new(time => 1616250000.5).touch("file.txt")'
```

### Modifying Only Access or Modification Time
You can restrict the update to only the access time (`atime`) or modification time (`mtime`):
```bash
# Update only access time
perl -MFile::Touch -e 'File::Touch->new(atime_only => 1)->touch("file.txt")'

# Update only modification time
perl -MFile::Touch -e 'File::Touch->new(mtime_only => 1)->touch("file.txt")'
```

## Expert Tips
- **Non-Creation**: If you want to update the timestamp of a file only if it already exists (without creating a new one), use the `no_create` option:
  `perl -MFile::Touch -e 'File::Touch->new(no_create => 1)->touch("maybe_exists.txt")'`
- **Batch Processing**: You can pass multiple filenames to the `touch` method to process them in a single invocation:
  `perl -MFile::Touch -e 'File::Touch->new(reference => "ref.txt")->touch("file1.txt", "file2.txt", "file3.txt")'`
- **Error Handling**: When using this in scripts, `File::Touch` will return the number of files successfully touched. Check this value to ensure your pipeline step succeeded.

## Reference documentation
- [Bioconda perl-file-touch Overview](./references/anaconda_org_channels_bioconda_packages_perl-file-touch_overview.md)
- [File-Touch Changes](./references/github_com_neilb_File-Touch_blob_master_Changes.md)
- [File-Touch Repository](./references/github_com_neilb_File-Touch.md)