# rabix-bunny CWL Generation Report

## rabix-bunny_rabix

### Tool Description
Executes CWL application with provided inputs.

### Metadata
- **Docker Image**: quay.io/biocontainers/rabix-bunny:1.0.4--0
- **Homepage**: https://github.com/rabix/bunny
- **Package**: https://anaconda.org/channels/bioconda/packages/rabix-bunny/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rabix-bunny/overview
- **Total Downloads**: 44.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rabix/bunny
- **Stars**: N/A
### Original Help Text
```text
Usage:
    rabix [OPTIONS]... <app> <inputs> [-- input_parameters...]
    rabix [OPTIONS]... <app> -- input_parameters...

where:
 <app>               is the path to a CWL document that describes the app.
 <inputs>            is the JSON or YAML file that provides the values of app inputs.
 input_parameters... are the app input values specified directly from the command line

Executes CWL application with provided inputs.

Options:
 -b,--basedir <arg>             execution directory
 -c,--configuration-dir <arg>   configuration directory
    --cache-dir <arg>           basic tool result caching (experimental)
 -h,--help                      print this help message and exit
    --no-container              don't use containers
    --outdir <arg>              legacy compatibility parameter, doesn't do anything
    --quiet                     don't print anything except final result on standard
                                output
 -r,--resolve-app               resolve all referenced fragments and print application
                                as a single JSON document
    --tes-storage <arg>         path to the storage used by the ga4gh tes server
                                (currently supports locall dirs and google storage
                                cloud paths)
    --tes-url <arg>             url of the ga4gh task execution server instance
                                (experimental)
    --tmp-outdir-prefix <arg>   legacy compatibility parameter, doesn't do anything
    --tmpdir-prefix <arg>       legacy compatibility parameter, doesn't do anything
 -v,--verbose                   print more information on the standard output
    --version                   print program version and exit

Input parameters are specified at the end of the command, after the -- delimiter. You
can specify values for each input, using the following format:
  --<input_port_id> <value>

Rabix suite homepage: http://rabix.io
Source and issue tracker: https://github.com/rabix/bunny.
```

