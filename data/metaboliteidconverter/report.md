# metaboliteidconverter CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metaboliteidconverter | Failed | image problem: the entrypoint is java -jar phnmnl-enrichment.jar with a relative path (the jar is in /), so it cannot start in cwltool's work directory |

## metaboliteidconverter

### Tool Description
Converts metabolite IDs between different databases.

### Metadata
- **Docker Image**: biocontainers/metaboliteidconverter:phenomenal-v0.5.1_cv1.2.31
- **Homepage**: https://github.com/phnmnl/container-MetaboliteIDConverter
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metaboliteidconverter/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/phnmnl/container-MetaboliteIDConverter
- **Stars**: N/A
### Original Help Text
```text
Application Usage:
 -h              : Prints this help. (default: false)
 -headers        : use this if the input file has database names on the first
                   line (default: false)
 -inDB VAL       : [Required] Input database to convert from.
 -inFile VAL     : Input file in tsv file format.
 -inId VAL       : Input ID to convert.
 -outDB STRING[] : Output databases to convert to.
 -outFile VAL    : [Required] Output file name.
```

