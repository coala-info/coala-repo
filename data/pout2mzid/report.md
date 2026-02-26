# pout2mzid CWL Generation Report

## pout2mzid

### Tool Description
Converts Percolator output XML to MzIdentML format.

### Metadata
- **Docker Image**: quay.io/biocontainers/pout2mzid:0.3.03--boost1.62_2
- **Homepage**: https://github.com/percolator/pout2mzid
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pout2mzid/overview
- **Total Downloads**: 5.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/percolator/pout2mzid
- **Stars**: N/A
### Original Help Text
```text
pout2mzid V0.3.3
Options:
  -h [ --help ]                   Displays available commands
                                  
  -p [ --percolatorfile ] [Value] Percolator Out XML result file
                                  
  -m [ --mzidfile ] [Value]       MzIdentML input file
                                  
  -i [ --inputdir ] [Value]       Sets the mzIdentML input directory. All 
                                  mzIdentML inputfiles must be in that 
                                  directory
                                  
  -c [ --changeoutput ] [Value]   Change the outputfile to original 
                                  filename+[Value]+.mzid.
                                  DEFAULT: output to stdout
                                  
  -o [ --outputdir ] [Value]      Sets the output directory if none exist, it 
                                  will be created.
                                  
  -f [ --filesmzid ] [Value]      File containing a list of mzIdentML filenames
                                  
  -d [ --decoy ]                  Only adds results to entries with decoy set 
                                  to true. DEFAULT: false
                                  
  -v [ --validate ]               Sets that validation of XML schema should not
                                  be performed. Faster parsing.
                                  
  -w [ --warning ]                Sets that upon warning the software should 
                                  terminate.
```

