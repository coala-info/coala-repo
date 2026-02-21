---
name: mercat
description: The mercat skill provides specialized knowledge for the GNU Core Utilities, the fundamental tools of the GNU operating system.
homepage: https://www.gnu.org/software/coreutils/
---

# mercat

## Overview
The mercat skill provides specialized knowledge for the GNU Core Utilities, the fundamental tools of the GNU operating system. It helps navigate the nuances of these essential CLI tools, ensuring efficient command construction while avoiding common pitfalls and "gotchas" associated with legacy Unix behavior versus modern GNU extensions.

## Core Utility Best Practices

### File Management (ls, cp, mv, rm)
- **Handling special filenames**: To remove or manipulate files starting with a dash (e.g., `-f`), use the `--` delimiter to signal the end of options: `rm -- -f`. Alternatively, use a relative path: `rm ./-f`.
- **Recursive operations**: GNU `rm` and `cp` support `-r` or `-R`. For complex filtering during deletion, combine `find` with `rm`: `find . -name "*.tmp" -delete`.
- **Preserving metadata**: Use `cp -a` (archive) to preserve structure, permissions, and timestamps.
- **Directory listing**: Use `ls -d` when you want to list the directory itself rather than its contents.

### Text Processing (sort, cut, join)
- **Sorting logic**: `sort` behavior is heavily influenced by the `LC_ALL` or `LANG` environment variables. For traditional byte-order sorting, use `LC_ALL=C sort`.
- **Human-readable sorting**: Use `sort -h` to correctly order values like "2K", "1G", and "500M".
- **Field delimiters**: 
  - `cut` uses a single character delimiter (`-d`). For multiple spaces, preprocess with `tr -s ' '`.
  - `join` requires input files to be sorted on the join field. Use `join -t $'\t'` for tab-delimited files in modern shells.

### System & Disk Information (df, du, stat)
- **Disk usage**: `df` and `du` may report different values because `df` reflects the filesystem state (including deleted but open files), while `du` traverses the directory tree.
- **Human-readable output**: Use the `-h` flag with `df` and `du` for power-of-1024 units (K, M, G).
- **File metadata**: Use `stat` for detailed inode information, including access/modify/change times and filesystem-specific attributes.

### Common Gotchas
- **Argument list too long**: When processing thousands of files, avoid `ls *`. Use `find . -maxdepth 1 -exec ... +` or `printf '%s\0' * | xargs -0`.
- **Date manipulation**: GNU `date` supports powerful relative strings: `date -d "last Friday"` or `date -d "2 weeks ago"`.
- **Symlink permissions**: On most systems, you cannot change the permissions of a symlink itself; `chmod` operates on the target.

## Reference documentation
- [GNU Coreutils FAQ](./references/www_gnu_org_software_coreutils_faq_coreutils-faq.html.md)
- [Rejected Feature Requests](./references/www_gnu_org_software_coreutils_rejected_requests.html.md)
- [Coreutils Manual](./references/www_gnu_org_software_coreutils_manual.md)