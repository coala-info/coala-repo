# nf-core/nf-test

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| nf-test_generate_function | Failed | tool bug: on real nf-core code it also generates bogus test cases for local variable assignments inside functions (7 of 10 tests), some uncompilable |
| nf-test_generate_pipeline | PASS |  |
| nf-test_generate_process | PASS |  |
| nf-test_generate_workflow | PASS |  |
| nf-test_init | PASS |  |
| nf-test_list | PASS |  |

## nf-test_generate_process

### Tool Description
Generate nf-test test files for Nextflow processes

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-test:0.9.4--h2a3209d_0
- **Homepage**: https://code.askimed.com/nf-test/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-test/overview
- **Validation**: PASS

### Original Help Text
```text
Unknown option: '--help'
Usage: nf-test generate process [<arg0>...]
      [<arg0>...]   source files
```

## nf-test_generate_workflow

### Tool Description
Generate nf-test test files for Nextflow workflows

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-test:0.9.4--h2a3209d_0
- **Homepage**: https://code.askimed.com/nf-test/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-test/overview
- **Validation**: PASS

### Original Help Text
```text
Unknown option: '--help'
Usage: nf-test generate workflow [<arg0>...]
      [<arg0>...]   source files
```

## nf-test_generate_pipeline

### Tool Description
Generate nf-test test files for Nextflow pipeline scripts

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-test:0.9.4--h2a3209d_0
- **Homepage**: https://code.askimed.com/nf-test/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-test/overview
- **Validation**: PASS

### Original Help Text
```text
Unknown option: '--help'
Usage: nf-test generate pipeline [<arg0>...]
      [<arg0>...]   source files
```

## nf-test_generate_function

### Tool Description
Generate nf-test test files for functions

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-test:0.9.4--h2a3209d_0
- **Homepage**: https://code.askimed.com/nf-test/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-test/overview
- **Validation**: PASS

### Original Help Text
```text
Unknown option: '--help'
Usage: nf-test generate function [<arg0>...]
      [<arg0>...]   source files
```

## nf-test_init

### Tool Description
Initialize an nf-test project

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-test:0.9.4--h2a3209d_0
- **Homepage**: https://code.askimed.com/nf-test/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-test/overview
- **Validation**: PASS

### Original Help Text
```text
Unknown option: '--help'
Usage: nf-test init [--silent] [--log=<logFilename>]
      --log=<logFilename>   Filename for log file
                              Default: .nf-test.log
      --silent              Hide header and program version
                              Default: false
```

## nf-test_list

### Tool Description
List all tests of an nf-test project

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-test:0.9.4--h2a3209d_0
- **Homepage**: https://code.askimed.com/nf-test/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-test/overview
- **Validation**: PASS

### Original Help Text
```text
Unknown option: '--help'
Usage: nf-test list [--debug] [--silent] [--tags] [--format=<format>]
                    [--log=<logFilename>] [<testPaths>...]
      [<testPaths>...]      list all tests
      --debug               Show debugging infos
                              Default: false
      --format=<format>     Output format
                              Default: PRETTY
      --log=<logFilename>   Filename for log file
                              Default: .nf-test.log
      --silent              Hide header and program version
                              Default: false
      --tags                Show all available tags
                              Default: false
```

## Metadata

- **Homepage:** https://nf-co.re/nf-test/
- **GitHub:** https://github.com/nf-core/nf-test
- **Total Downloads:** NA
- **Last updated:** NA
- **GitHub Stars:** NA
