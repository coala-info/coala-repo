# bio-vcf CWL Generation Report

## bio-vcf

### Tool Description
Vcf parser

### Metadata
- **Docker Image**: quay.io/biocontainers/bio-vcf:0.9.5--hdfd78af_0
- **Homepage**: https://github.com/vcflib/bio-vcf
- **Package**: https://anaconda.org/channels/bioconda/packages/bio-vcf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bio-vcf/overview
- **Total Downloads**: 27.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vcflib/bio-vcf
- **Stars**: N/A
### Original Help Text
```text
Usage: bio-vcf [options] filename
e.g.  bio-vcf < test/data/input/somaticsniper.vcf
    -i, --ignore-missing             Ignore missing data
        --filter cmd                 Evaluate filter on each record
        --sfilter cmd                Evaluate filter on each sample
        --sfilter-samples list       Filter on selected samples (e.g., 0,1
        --ifilter, --if cmd          Include filter
        --ifilter-samples list       Include set - implicitely defines exclude set
        --efilter, --ef cmd          Exclude filter
        --efilter-samples list       Exclude set - overrides exclude set
        --add-filter name            Set/add filter field to name
        --bed bedfile                Filter on BED elements
    -e, --eval cmd                   Evaluate command on each record
        --eval-once cmd              Evaluate command once (usually for header info)
        --seval cmd                  Evaluate command on each sample
        --rewrite eval               Rewrite INFO
        --samples list               Output selected samples
        --rdf                        Generate Turtle RDF (also check out --template!)
        --num-threads [num]          Multi-core version (default ALL)
        --thread-lines num           Fork thread on num lines (default 40000)
        --skip-header                Do not output VCF header info
        --set-header list            Set a special tab delimited output header (#samples expands to sample names)
    -t, --template erb               Use ERB template for output
        --add-header-tag             Add bio-vcf status tag to header output
        --timeout [num]              Timeout waiting for thread to complete (default 180)
        --names                      Output sample names
        --statistics                 Output statistics
    -q, --quiet                      Run quietly
    -v, --verbose                    Run verbosely
        --debug                      Show debug messages and keep intermediate output

        --id name                    Identifier
        --tags list                  Add tags
    -h, --help                       display this help and exit
Vcf parser
```

