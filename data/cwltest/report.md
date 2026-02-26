# cwltest CWL Generation Report

## cwltest

### Tool Description
Common Workflow Language testing framework

### Metadata
- **Docker Image**: quay.io/biocontainers/cwltest:2.2.20220521103021--pyhdfd78af_0
- **Homepage**: https://github.com/common-workflow-language/cwltest
- **Package**: https://anaconda.org/channels/bioconda/packages/cwltest/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cwltest/overview
- **Total Downloads**: 47.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/common-workflow-language/cwltest
- **Stars**: N/A
### Original Help Text
```text
usage: cwltest [-h] --test TEST [--basedir BASEDIR] [-l] [-n N] [-s S] [-N N]
               [-S S] [--tool TOOL] [--only-tools] [--tags TAGS] [--show-tags]
               [--junit-xml JUNIT_XML] [--junit-verbose]
               [--test-arg cache==--cache-dir] [-j J] [--verbose]
               [--classname CLASSNAME] [--timeout TIMEOUT]
               [--badgedir BADGEDIR] [--version]
               ...

Common Workflow Language testing framework

positional arguments:
  args                  arguments to pass first to tool runner

options:
  -h, --help            show this help message and exit
  --test TEST           YAML file describing test cases
  --basedir BASEDIR     Basedir to use for tests
  -l                    List tests then exit
  -n N                  Run specific tests, format is 1,3-6,9
  -s S                  Run specific tests using their short names separated
                        by comma
  -N N                  Exclude specific tests by number, format is 1,3-6,9
  -S S                  Exclude specific tests by short names separated by
                        comma
  --tool TOOL           CWL runner executable to use (default 'cwl-runner'
  --only-tools          Only test CommandLineTools
  --tags TAGS           Tags to be tested
  --show-tags           Show all Tags.
  --junit-xml JUNIT_XML
                        Path to JUnit xml file
  --junit-verbose       Store more verbose output to JUnit xml file
  --test-arg cache==--cache-dir
                        Additional argument given in test cases and required
                        prefix for tool runner.
  -j J                  Specifies the number of tests to run simultaneously
                        (defaults to one).
  --verbose             More verbose output during test run.
  --classname CLASSNAME
                        Specify classname for the Test Suite.
  --timeout TIMEOUT     Time of execution in seconds after which the test will
                        be skipped. Defaults to 600 seconds (10.0 minutes).
  --badgedir BADGEDIR   Directory that stores JSON files for badges.
  --version             show program's version number and exit
```

