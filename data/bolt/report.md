# bolt CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bolt_call | Failed | Tool bug: bolt 0.3.0 crashes on real nf-core BAMs (illegal instruction on SARS-CoV-2, segfault on human) and rejects every -t value. |

## bolt_call

### Tool Description
Call variants using the BOLT tool

### Metadata
- **Docker Image**: quay.io/biocontainers/bolt:0.3.0--h3889886_0
- **Homepage**: https://github.com/sakkayaphab/bolt
- **Package**: https://anaconda.org/channels/bioconda/packages/bolt/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bolt/overview
- **Total Downloads**: 14.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sakkayaphab/bolt
- **Stars**: N/A
### Original Help Text
```text
USAGE:
	bolt call [command options] [arguments...]

COMMAND OPTIONS:
	-b	sample file path (*required)
	-r	reference file path (*required)
	-o	output path (*required)
	-t	number of threads to use
```


## Metadata
- **Skill**: generated
