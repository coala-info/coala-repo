# cloudspades CWL Generation Report

## cloudspades_spades.py

### Tool Description
SPAdes genome assembler v3.16.0-dev

### Metadata
- **Docker Image**: quay.io/biocontainers/cloudspades:3.16.0--haf24da9_3
- **Homepage**: https://github.com/ablab/spades
- **Package**: https://anaconda.org/channels/bioconda/packages/cloudspades/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cloudspades/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ablab/spades
- **Stars**: N/A
### Original Help Text
```text
SPAdes genome assembler v3.16.0-dev

Usage: spades.py [options] -o <output_dir>

Basic options:
  -o <output_dir>             directory to store all the resulting files (required)
  --isolate                   this flag is highly recommended for high-coverage isolate and multi-cell data
  --sc                        this flag is required for MDA (single-cell) data
  --meta                      this flag is required for metagenomic data
  --bio                       this flag is required for biosyntheticSPAdes mode
  --sewage                    this flag is required for sewage mode
  --corona                    this flag is required for coronaSPAdes mode
  --rna                       this flag is required for RNA-Seq data
  --plasmid                   runs plasmidSPAdes pipeline for plasmid detection
  --metaviral                 runs metaviralSPAdes pipeline for virus detection
  --metaplasmid               runs metaplasmidSPAdes pipeline for plasmid detection in metagenomic datasets (equivalent for --meta --plasmid)
  --rnaviral                  this flag enables virus assembly module from RNA-Seq data
  --iontorrent                this flag is required for IonTorrent data
  --test                      runs SPAdes on toy dataset
  -h, --help                  prints this usage message
  -v, --version               prints version

Input data:
  --12 <filename>             file with interlaced forward and reverse paired-end reads
  -1 <filename>               file with forward paired-end reads
  -2 <filename>               file with reverse paired-end reads
  -s <filename>               file with unpaired reads
  --merged <filename>         file with merged forward and reverse paired-end reads
  --aux <filename>            file with auxiliary reads (e.g. TELL-Seq library barcodes)
  --pe-12 <#> <filename>      file with interlaced reads for paired-end library number <#>.
                              Older deprecated syntax is -pe<#>-12 <filename>
  --pe-1 <#> <filename>       file with forward reads for paired-end library number <#>.
                              Older deprecated syntax is -pe<#>-1 <filename>
  --pe-2 <#> <filename>       file with reverse reads for paired-end library number <#>.
                              Older deprecated syntax is -pe<#>-2 <filename>
  --pe-s <#> <filename>       file with unpaired reads for paired-end library number <#>.
                              Older deprecated syntax is -pe<#>-s <filename>
  --pe-m <#> <filename>       file with merged reads for paired-end library number <#>.
                              Older deprecated syntax is -pe<#>-m <filename>
  --pe-or <#> <or>            orientation of reads for paired-end library number <#> 
                              (<or> = fr, rf, ff).
                              Older deprecated syntax is -pe<#>-<or>
  --s <#> <filename>          file with unpaired reads for single reads library number <#>.
                              Older deprecated syntax is --s<#> <filename>
  --mp-12 <#> <filename>      file with interlaced reads for mate-pair library number <#>.
                              Older deprecated syntax is -mp<#>-12 <filename>
  --mp-1 <#> <filename>       file with forward reads for mate-pair library number <#>.
                              Older deprecated syntax is -mp<#>-1 <filename>
  --mp-2 <#> <filename>       file with reverse reads for mate-pair library number <#>.
                              Older deprecated syntax is -mp<#>-2 <filename>
  --mp-s <#> <filename>       file with unpaired reads for mate-pair library number <#>.
                              Older deprecated syntax is -mp<#>-s <filename>
  --mp-or <#> <or>            orientation of reads for mate-pair library number <#> 
                              (<or> = fr, rf, ff).
                              Older deprecated syntax is -mp<#>-<or>
  --hqmp-12 <#> <filename>    file with interlaced reads for high-quality mate-pair library number <#>.
                              Older deprecated syntax is -hqmp<#>-12 <filename>
  --hqmp-1 <#> <filename>     file with forward reads for high-quality mate-pair library number <#>.
                              Older deprecated syntax is -hqmp<#>-1 <filename>
  --hqmp-2 <#> <filename>     file with reverse reads for high-quality mate-pair library number <#>.
                              Older deprecated syntax is -hqmp<#>-2 <filename>
  --hqmp-s <#> <filename>     file with unpaired reads for high-quality mate-pair library number <#>.
                              Older deprecated syntax is -hqmp<#>-s <filename>
  --hqmp-or <#> <or>          orientation of reads for high-quality mate-pair library number <#> 
                              (<or> = fr, rf, ff).
                              Older deprecated syntax is -hqmp<#>-<or>
  --gemcode-12 <#> <filename>
                              file with interlaced reads for 10x format linked-reads library number <#>.
                              Older deprecated syntax is -gemcode<#>-12 <filename>
  --gemcode-1 <#> <filename>  file with forward reads for 10x format linked-reads library number <#>.
                              Older deprecated syntax is -gemcode<#>-1 <filename>
  --gemcode-2 <#> <filename>  file with reverse reads for 10x format linked-reads library number <#>.
                              Older deprecated syntax is -gemcode<#>-2 <filename>
  --gemcode-s <#> <filename>  file with unpaired reads for 10x format linked-reads library number <#>.
                              Older deprecated syntax is -gemcode<#>-s <filename>
  --gemcode-or <#> <or>       orientation of reads for 10x format linked-reads library number <#> 
                              (<or> = fr, rf, ff).
                              Older deprecated syntax is -gemcode<#>-<or>
  --tellseq-12 <#> <filename>
                              file with interlaced reads for TELL-Seq format linked-reads library number <#>.
                              Older deprecated syntax is -tellseq<#>-12 <filename>
  --tellseq-1 <#> <filename>  file with forward reads for TELL-Seq format linked-reads library number <#>.
                              Older deprecated syntax is -tellseq<#>-1 <filename>
  --tellseq-2 <#> <filename>  file with reverse reads for TELL-Seq format linked-reads library number <#>.
                              Older deprecated syntax is -tellseq<#>-2 <filename>
  --tellseq-s <#> <filename>  file with unpaired reads for TELL-Seq format linked-reads library number <#>.
                              Older deprecated syntax is -tellseq<#>-s <filename>
  --tellseq-a <#> <filename>  file with read tags (e.g. TELL-Seq library barcodes) for TELL-Seq format linked-reads library number <#>.
                              Older deprecated syntax is -tellseq<#>-m <filename>
  --tellseq-or <#> <or>       orientation of reads for TELL-Seq format linked-reads library number <#> 
                              (<or> = fr, rf, ff).
                              Older deprecated syntax is -tellseq<#>-<or>
  --sanger <filename>         file with Sanger reads
  --pacbio <filename>         file with PacBio reads
  --nanopore <filename>       file with Nanopore reads
  --trusted-contigs <filename>
                              file with trusted contigs
  --untrusted-contigs <filename>
                              file with untrusted contigs

Pipeline options:
  --only-error-correction     runs only read error correction (without assembling)
  --only-assembler            runs only assembling (without read error correction)
  --careful                   tries to reduce number of mismatches and short indels
  --checkpoints <last or all>
                              save intermediate check-points ('last', 'all')
  --continue                  continue run from the last available check-point (only -o should be specified)
  --restart-from <cp>         restart run with updated options and from the specified check-point
                              ('ec', 'as', 'k<int>', 'mc', 'last')
  --disable-gzip-output       forces error correction not to compress the corrected reads
  --disable-rr                disables repeat resolution stage of assembling

Advanced options:
  --dataset <filename>        file with dataset description in YAML format
  -t, --threads <int>         number of threads. [default: 16]
  -m, --memory <int>          RAM limit for SPAdes in Gb (terminates if exceeded). [default: 250]
  --tmp-dir <dirname>         directory for temporary files. [default: <output_dir>/tmp]
  -k <int> [<int> ...]        list of k-mer sizes (must be odd and less than 128)
                              [default: 'auto']
  --cov-cutoff <float>        coverage cutoff value (a positive float number, or 'auto', or 'off')
                              [default: 'off']
  --phred-offset <33 or 64>   PHRED quality offset in the input reads (33 or 64),
                              [default: auto-detect]
  --custom-hmms <dirname>     directory with custom hmms that replace default ones,
                              [default: None]
  --gfa11                     use GFA v1.1 format for assembly graph
```

