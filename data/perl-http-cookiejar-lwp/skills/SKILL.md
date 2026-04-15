---
name: perl-http-cookiejar-lwp
description: This tool provides a minimalist, thread-safe cookie store for Perl applications using the HTTP::CookieJar module. Use when user asks to manage HTTP cookies with minimal dependencies, integrate a cookie jar with LWP::UserAgent, or handle RFC 6265 compliant cookies in concurrent environments.
homepage: https://github.com/dagolden/HTTP-CookieJar
metadata:
  docker_image: "quay.io/biocontainers/perl-http-cookiejar-lwp:0.014--pl5321hdfd78af_0"
---

# perl-http-cookiejar-lwp

## Overview
The `perl-http-cookiejar-lwp` skill provides guidance on utilizing the `HTTP::CookieJar` Perl module, a minimalist and thread-safe cookie store. This tool is designed as a lightweight alternative to more complex cookie managers, focusing on high performance and strict adherence to RFC 6265. It is commonly used in environments where minimal dependencies are required, such as bioinformatics pipelines or containerized Perl applications.

## Installation and Environment Setup

### Bioconda (Recommended for Data Science/Bioinformatics)
If you are working within a Conda environment, install the package directly from the Bioconda channel:
```bash
conda install bioconda::perl-http-cookiejar-lwp
```

### CPAN/Source Installation
For standard Perl environments, use `cpanm` to handle dependencies automatically:
```bash
cpanm --installdeps .
# Or install the module directly
cpanm HTTP::CookieJar
```

## Testing and Development
The module uses `Dist::Zilla` for management, but standard testing can be performed using the `prove` tool.

### Running Tests
Always run tests from the root of the distribution to ensure the environment is correctly configured:
```bash
# Run all tests
prove -l

# Run a specific test file with verbose output
prove -lv t/some_test_file.t
```

### Development Workflow
If you are contributing to the source or modifying the package:
- **Code Style**: Use `perltidy` with the provided `.perltidyrc` to maintain consistency.
- **Tidying**: If `Code::TidyAll` is installed, run `tidyall -a`.
- **Authoring**: `Dist::Zilla` is required for creating tarballs or managing releases (`dzil build`, `dzil test`).

## Best Practices
- **Minimalism**: Use this module when you need a cookie jar that does not have a large dependency chain (like `HTTP::Cookies`).
- **LWP Integration**: When using with `LWP::UserAgent`, ensure you use the `HTTP::CookieJar::LWP` wrapper to provide the interface LWP expects.
- **Public Suffix List**: For production use, ensure a public suffix list provider is available to prevent "supercookies" from being set across top-level domains.
- **Thread Safety**: Leverage the fact that `HTTP::CookieJar` is designed to be thread-safe for concurrent web scraping or API requests.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-http-cookiejar-lwp_overview.md)
- [GitHub Repository and Contribution Guide](./references/github_com_dagolden_HTTP-CookieJar.md)