# genodsp CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| genodsp | PASS |  |

## genodsp

### Tool Description
General workbench for processing signals along genomic intervals.

### Metadata
- **Docker Image**: quay.io/biocontainers/genodsp:0.0.10--h7b50bb2_1
- **Homepage**: https://github.com/richard-burhans/genodsp
- **Package**: https://anaconda.org/channels/bioconda/packages/genodsp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: [cat <file>] | genodsp --chromosomes=<filename> [options] [operations]

  --chromosomes=<filename>  (required) read chromosome names and lengths from
                            a file
  --value=<col>             input intervals contain a value in the specified
                            column;  by default we assume this is in column 4
  --novalue                 input intervals have no value (value given is 1)
  --nooutputvalue           don't write value with output intervals
  --precision=<number>      number of digits to round output values to
                            (by default, output is rounded to integers)
  --nocollapse              in output, don't collapse runs of identical values
                            to intervals
  --uncovered:hide          don't output intervals that have no coverage
                            (this is the default)
  --uncovered:show          in output, include intervals that have no coverage
  --uncovered:NA            in output, mark uncovered intervals as NA
  --cliptochromosome        clip interals to chromosome length
                            (default is to report such intervals as errors)
  --origin=one              input/output intervals are origin-one, closed
  --origin=zero             input/output intervals are origin-zero, half-open
                            (this is the default)
  --nooutput                don't output the resulting intervals/values
                            (by default these are written to stdout)
  --window=<length>         (W=) size of window
                            (for operators that have a window size)
  --help[=<operator>]       get detail about a particular operator
  ?                         list available operators with brief descriptions
  ?<operator>               same as --help=<operator>
  --report=comments         copy comments from the input to stderr. Comments
                            are lines beginning with a "#". This can be
                            helpful in tracking progress during a long run.
  --progress=input:<n>      report processing of every nth input line
  --progress=operations     report each operation as it begins
  --version                 report the program version and quit

Note that if input intervals overlap, their values are summed.

Input is usually piped in on stdin. However, if the first operator is "input"
stdin is ignored.

For a list of available operations, do "genodsp ?".
For more detailed descriptions of the operations, do "genodsp --help".
```

## Metadata
- **Skill**: generated
