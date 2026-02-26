# cyrcular CWL Generation Report

## cyrcular_plot

### Tool Description
Generates a circular plot from BAM data.

### Metadata
- **Docker Image**: quay.io/biocontainers/cyrcular:0.3.0--ha8ac579_1
- **Homepage**: https://github.com/tedil/cyrcular
- **Package**: https://anaconda.org/channels/bioconda/packages/cyrcular/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cyrcular/overview
- **Total Downloads**: 726
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tedil/cyrcular
- **Stars**: N/A
### Original Help Text
```text
Usage: cyrcular plot [OPTIONS] --region <REGION> <INPUT>

Arguments:
  <INPUT>  Input BAM file

Options:
  -r, --region <REGION>                        
  -o, --output <OUTPUT>                        
  -t, --threads <THREADS>                      [default: 0]
  -b, --bin-size <BIN_SIZE>                    
  -f, --flank <FLANK>                          
  -b, --breakpoint-margin <BREAKPOINT_MARGIN>  [default: 3]
  -h, --help                                   Print help
```


## cyrcular_graph

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/cyrcular:0.3.0--ha8ac579_1
- **Homepage**: https://github.com/tedil/cyrcular
- **Package**: https://anaconda.org/channels/bioconda/packages/cyrcular/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: cyrcular graph <COMMAND>

Commands:
  breakends  
  plot       
  annotate   
  table      
  help       Print this message or the help of the given subcommand(s)

Options:
  -h, --help  Print help
```

