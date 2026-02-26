# hmnrandomread CWL Generation Report

## hmnrandomread_HmnRandomRead

### Tool Description
Generate random reads from reference sequences with specified insert sizes and error profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/hmnrandomread:0.10.0--h9948957_4
- **Homepage**: https://github.com/guillaume-gricourt/HmnRandomRead
- **Package**: https://anaconda.org/channels/bioconda/packages/hmnrandomread/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hmnrandomread/overview
- **Total Downloads**: 4.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/guillaume-gricourt/HmnRandomRead
- **Stars**: N/A
### Original Help Text
```text
Error:   Unrecognized argument: -help

Use:   HmnRandomRead [options] 

Options:
    Name    Type    Default    Description
    -h/--help    None    None    Show this help and exit (optional)
        -v/--version    None    None    Show the version and exit (optional)

        -r/--reference    [string,double]    None    Reference(s) path with number sequence (required)
        -lengthReads/--length-reads    [int]    150    Reads Size (optional)
        -meanInsert/--mean-insert-size    [int]    500    Mean Insert Size (optional)
        -stdInsert/--std-insert-size    [int]    50    Standard Deviation Insert Size (optional)

        -r1/--read-forward    [string]        Name Read Forward output (required)
        -r2/--read-reverse    [string]        Name Read Reverse output (required)

    -profileDiversity/--profile-diversity    [string]    ""    Name file with profile diversity (optional)
    -profileError/--profile-error    [string]    ""    Name file with profile error (optional)
    -profileErrorId/--profile-error-id    [string]    ""    Id error profile to apply (optional, required if -profileError)
        -s/--seed    [int]    0    Seed number (optional)
```

