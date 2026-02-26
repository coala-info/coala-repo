# methplotlib CWL Generation Report

## methplotlib

### Tool Description
plotting nanopolish methylation calls or frequency

### Metadata
- **Docker Image**: quay.io/biocontainers/methplotlib:0.21.2--pyhdfd78af_0
- **Homepage**: https://github.com/wdecoster/methplotlib
- **Package**: https://anaconda.org/channels/bioconda/packages/methplotlib/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/methplotlib/overview
- **Total Downloads**: 40.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wdecoster/methplotlib
- **Stars**: N/A
### Original Help Text
```text
usage: methplotlib [-h] [-v] -m METHYLATION [METHYLATION ...] -n NAMES
                   [NAMES ...] -w WINDOW [-g GTF] [-b BED] [-f FASTA]
                   [--simplify] [--split] [--static STATIC] [--binary]
                   [--smooth SMOOTH] [--dotsize DOTSIZE] [--minqual MINQUAL]
                   [--example] [-o OUTFILE] [-q QCFILE]

plotting nanopolish methylation calls or frequency

options:
  -h, --help            show this help message and exit
  -v, --version         Print version and exit.
  -m METHYLATION [METHYLATION ...], --methylation METHYLATION [METHYLATION ...]
                        data in nanopolish, nanocompore, ont-cram or bedgraph
                        format
  -n NAMES [NAMES ...], --names NAMES [NAMES ...]
                        names of datasets in --methylation
  -w WINDOW, --window WINDOW
                        window (region) to which the visualisation has to be
                        restricted
  -g GTF, --gtf GTF     add annotation based on a gtf file
  -b BED, --bed BED     add annotation based on a bed file
  -f FASTA, --fasta FASTA
                        required when --window is an entire chromosome, contig
                        or transcript
  --simplify            simplify annotation track to show genes rather than
                        transcripts
  --split               split, rather than overlay the methylation tracks
  --static STATIC       Make a static image of the browser window
  --binary              Make the nanopolish plot ignorning log likelihood
                        nuances
  --smooth SMOOTH       Rolling window size for averaging frequency values
  --dotsize DOTSIZE     Control the size of dots in the per read plots
  --minqual MINQUAL     The minimal phred quality to show [for bam/cram input
                        only]
  --example             Show example command and exit.
  -o OUTFILE, --outfile OUTFILE
                        File to write results to. Default:
                        methylation_browser_{chr}_{start}_{end}.html. Use
                        {region} as a shorthand for {chr}_{start}_{end} in the
                        filename. Missing paths will be created.
  -q QCFILE, --qcfile QCFILE
                        File to write the qc report to. Default: The path in
                        outfile prefixed with qc_, default is qc_report_methyl
                        ation_browser_{chr}_{start}_{end}.html. Use {region}
                        as a shorthand for {chr}_{start}_{end} in the
                        filename. Missing paths will be created.
```

