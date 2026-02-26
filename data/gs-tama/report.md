# gs-tama CWL Generation Report

## gs-tama_tama_collapse.py

### Tool Description
This script collapses mapped transcript models

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Total Downloads**: 11.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sguizard/gs-tama
- **Stars**: N/A
### Original Help Text
```text
usage: tama_collapse.py [-h] [-s S] [-f F] [-p P] [-x X] [-e E] [-c C] [-i I]
                        [-icm ICM] [-a A] [-m M] [-z Z] [-d D] [-sj SJ]
                        [-sjt SJT] [-lde LDE] [-ses SES] [-b B] [-log LOG]
                        [-v V] [-rm RM] [-vc VC]

This script collapses mapped transcript models

optional arguments:
  -h, --help  show this help message and exit
  -s S        Sorted sam file (required)
  -f F        Genome fasta file (required)
  -p P        Output prefix (required)
  -x X        Capped flag: capped or no_cap
  -e E        Collapse exon ends flag: common_ends or longest_ends (default
              common_ends)
  -c C        Coverage (default 99)
  -i I        Identity (default 85)
  -icm ICM    Identity calculation method (default ident_cov for including
              coverage) (alternate is ident_map for excluding hard and soft
              clipping)
  -a A        5 prime threshold (default 10)
  -m M        Exon/Splice junction threshold (default 10)
  -z Z        3 prime threshold (default 10)
  -d D        Flag for merging duplicate transcript groups (default is
              merge_dup will merge duplicates ,no_merge quits when duplicates
              are found)
  -sj SJ      Use error threshold to prioritize the use of splice junction
              information from collapsing transcripts(default no_priority,
              activate with sj_priority)
  -sjt SJT    Threshold for detecting errors near splice junctions (default is
              10bp)
  -lde LDE    Threshold for amount of local density error near splice
              junctions that is allowed (default is 1000 errors which
              practically means no threshold is applied)
  -ses SES    Simple error symbol. Use this to pick the symbol used to
              represent matches in the simple error string for LDE output.
  -b B        Use BAM instead of SAM
  -log LOG    Turns off log output to screen of collapsing process. (default
              on, use log_off to turn off)
  -v V        Prints out version date and exits.
  -rm RM      Run mode allows you to use original or low_mem mode, default is
              original
  -vc VC      Variation coverage threshold: Default 5 reads
```


## gs-tama_tama_merge.py

### Tool Description
This script merges transcriptomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_merge.py [-h] [-f F] [-p P] [-e E] [-a A] [-m M] [-z Z] [-d D]
                     [-s S] [-cds CDS] [-v V]

This script merges transcriptomes.

optional arguments:
  -h, --help  show this help message and exit
  -f F        File list
  -p P        Output prefix
  -e E        Collapse exon ends flag: common_ends or longest_ends (Default is
              common_ends)
  -a A        5 prime threshold (Default is 10)
  -m M        Exon ends threshold/ splice junction threshold (Default is 10)
  -z Z        3 prime threshold (Default is 10)
  -d D        Flag for merging duplicate transcript groups (default no_merge
              quits when duplicates are found, merge_dup will merge
              duplicates)
  -s S        Use gene and transcript ID from a merge source. Specify source
              name from filelist file here.
  -cds CDS    Use CDS from a merge source. Specify source name from filelist
              file here.
  -v V        Prints out version date and exits.
```


## gs-tama_tama_remove_fragment_models.py

### Tool Description
This script absorbs transcriptomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_remove_fragment_models.py [-h] [-f F] [-o O] [-m M] [-e E] [-s S]
                                      [-id ID] [-cds CDS]

This script absorbs transcriptomes.

optional arguments:
  -h, --help  show this help message and exit
  -f F        Bed file
  -o O        Output file prefix
  -m M        Exon ends threshold/ splice junction threshold (Default is 10)
  -e E        Trans ends wobble threshold (Default is 500)
  -s S        Single exon overlap percent threshold (Default is 20 percent)
  -id ID      Use original ID line original_id (Default is tama_id line based
              on gene_id;transcript_id structure
  -cds CDS    Pull CDS option. Default is tama_cds where CDS regions matching
              TSS and TTS are ignored if another CDS is found. Use longest_cds
              to pick the longest CDS
```


## gs-tama_tama_remove_single_read_models_levels.py

### Tool Description
This script uses the TAMA collapse and TAMA merge outputs to remove single read models

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_remove_single_read_models_levels.py [-h] [-b B] [-r R] [-o O]
                                                [-l L] [-k K] [-s S] [-n N]

This script uses the TAMA collapse and TAMA merge outputs to remove single
read models

optional arguments:
  -h, --help  show this help message and exit
  -b B        Annotation bed file
  -r R        Read support file
  -o O        Output prefix (required)
  -l L        Level of removal (gene or transcript level). Gene level will
              only remove genes with a single read, transcript level will
              remove all singleton transcripts.
  -k K        Default to keep all multi-exon models (keep_multi or
              remove_multi)
  -s S        Requires models to have support from at least this number of
              sources. Default is 1
  -n N        Requires models to have support from at least this number of
              reads. Default is 2
```


## gs-tama_tama_filter_primary_transcripts_orf.py

### Tool Description
This script uses the ORF/NMD output bed file and filters to have only 1
transcript per gene

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_filter_primary_transcripts_orf.py [-h] [-b B] [-o O]

This script uses the ORF/NMD output bed file and filters to have only 1
transcript per gene

optional arguments:
  -h, --help  show this help message and exit
  -b B        bed file (required)
  -o O        Output file name (required)
```


## gs-tama_tama_format_gtf_to_bed12_ncbi.py

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
opening gtf file
```


## gs-tama_tama_cds_regions_bed_add.py

### Tool Description
This script uses data from the blastp parse file and the original annotation to assign the locations of the UTR/CDS regions to the bed file

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_cds_regions_bed_add.py [-h] [-p P] [-a A] [-f F] [-o O] [-s S]
                                   [-d D]

This script uses data from the blastp parse file and the original annotation
to assign the locations of the UTR/CDS regions to the bed file

optional arguments:
  -h, --help  show this help message and exit
  -p P        Blastp parse file (required)
  -a A        Annotation bed file (required)
  -f F        Fasta for annotation file (required)
  -o O        Output file name (required)
  -s S        Include stop codon in CDS region (include_stop), default is to
              remove stop codon from CDS region
  -d D        Distance from last splice junction to call NMD (default 50bp)
```

