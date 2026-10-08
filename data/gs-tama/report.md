# gs-tama CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gs-tama_tama_bed_extract_cds.py | PASS |  |
| gs-tama_tama_cds_regions_bed_add.py | PASS |  |
| gs-tama_tama_collapse.py | PASS |  |
| gs-tama_tama_convert_bed_gtf_ensembl_no_cds.py | PASS |  |
| gs-tama_tama_convert_nanopore_fastq_fasta.py | PASS |  |
| gs-tama_tama_degradation_signature.py | PASS |  |
| gs-tama_tama_fasta_splitter.py | PASS |  |
| gs-tama_tama_filter_primary_transcripts_orf.py | PASS |  |
| gs-tama_tama_find_model_changes.py | PASS |  |
| gs-tama_tama_flnc_polya_cleanup.py | PASS | reads taken from the mapped test SAM |
| gs-tama_tama_format_gff_to_bed12_cupcake.py | PASS |  |
| gs-tama_tama_format_gtf_to_bed12_ensembl.py | PASS |  |
| gs-tama_tama_format_gtf_to_bed12_ncbi.py | PASS |  |
| gs-tama_tama_format_gtf_to_bed12_stringtie.py | PASS |  |
| gs-tama_tama_format_id_filter.py | PASS |  |
| gs-tama_tama_mapped_sam_splitter.py | PASS | test SAM has one chromosome, so one output file |
| gs-tama_tama_merge.py | PASS |  |
| gs-tama_tama_orf_blastp_parser.py | PASS | blastp ran against a database of the same ORFs (no UniRef database) |
| gs-tama_tama_orf_seeker.py | PASS |  |
| gs-tama_tama_read_support_collapse_cluster.py | PASS | no cluster file: the trans_read.bed file served as cluster file |
| gs-tama_tama_read_support_levels.py | PASS |  |
| gs-tama_tama_read_support_merge_collapse.py | PASS |  |
| gs-tama_tama_remove_fragment_models.py | PASS |  |
| gs-tama_tama_remove_polya_models_levels.py | PASS |  |
| gs-tama_tama_remove_single_read_models_levels.py | PASS |  |
| gs-tama_tama_sampling_saturation_curve.py | PASS |  |
| gs-tama_tama_variant_caller.py | PASS |  |

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

## gs-tama_tama_bed_extract_cds.py

### Tool Description
This script takes a bed file with cds information and creates a bed file with only cds regions

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_bed_extract_cds.py [-h] [-b B] [-s S] [-o O]

This script takes a bed file with cds information and creates a bed file with
only cds regions

optional arguments:
  -h, --help  show this help message and exit
  -b B        Bed file (required)
  -s S        Stop codon include flag (required)
  -o O        Output file name (required)
```

## gs-tama_tama_convert_bed_gtf_ensembl_no_cds.py

### Tool Description
This script is used to convert the pacbio bed format file into a gtf file that mimics Ensembl's format, for use on bed files without CDS information (outputs of tama merge or tama collapse)

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_convert_bed_gtf_ensembl_no_cds.py input.bed output_file

This script is used to convert the pacbio bed format file into a gtf file that mimics Ensembl's format, for use on bed files without CDS information (outputs of tama merge or tama collapse)

(The script has no -h option; the usage line above is taken from its source.)
```

## gs-tama_tama_convert_nanopore_fastq_fasta.py

### Tool Description
This script converts nanopore fastq to fasta

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_convert_nanopore_fastq_fasta.py input.fastq output_file

This script converts nanopore fastq to fasta

(The script has no -h option; the usage line above is taken from its source.)
```

## gs-tama_tama_degradation_signature.py

### Tool Description
This script takes the tama collapse trans_read.bed files from a nocap run and a capped run to calculate degradation signature

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_degradation_signature.py [-h] [-c C] [-nc NC] [-o O]

This script takes the tama collapse trans_read.bed files from a nocap run and
a capped run to calculate degradation signature

optional arguments:
  -h, --help  show this help message and exit
  -c C        Bed file from capped TAMA Collapse run (required)
  -nc NC      Bed file from no_cap TAMA Collapse run (required)
  -o O        Output file name (required)
```

## gs-tama_tama_fasta_splitter.py

### Tool Description
This script is used to split fasta files for running blastp in parallel

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_fasta_splitter.py fasta_file output_prefix number_of_files

This script is used to split fasta files for running blastp in parallel

(The script has no -h option; the usage line above is taken from its source.)
```

## gs-tama_tama_find_model_changes.py

### Tool Description
This script looks at read support files and finds reads that have mapped to different genes

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_find_model_changes.py [-h] [-b B] [-r R] [-o O] [-ref REF]
                                  [-alt ALT]

This script looks at read support files and finds reads that have mapped to
different genes

optional arguments:
  -h, --help  show this help message and exit
  -b B        Annotation bed file
  -r R        Read support file
  -o O        Output file prefix
  -ref REF    Reference source
  -alt ALT    Alternative source
```

## gs-tama_tama_flnc_polya_cleanup.py

### Tool Description
This script removes tailing poly A from FLNC fasta files

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_flnc_polya_cleanup.py [-h] [-f F] [-p P]

This script removes tailing poly A from FLNC fasta files

optional arguments:
  -h, --help  show this help message and exit
  -f F        FLNC Fasta file
  -p P        Output prefix
```

## gs-tama_tama_format_gff_to_bed12_cupcake.py

### Tool Description
This script converts Cupcake collapsed.gff to bed12 format

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_format_gff_to_bed12_cupcake.py cupcake_collapsed.gff output_file

This script converts Cupcake collapsed.gff to bed12 format

(The script has no -h option; the usage line above is taken from its source.)
```

## gs-tama_tama_format_gtf_to_bed12_ensembl.py

### Tool Description
This script converts ensembl gtf to bed format. It is designed to work with all current versions. It includes CDS boundaries for the 7th and 8th columns of the bed file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_format_gtf_to_bed12_ensembl.py ensembl.gtf output_file

This script converts ensembl gtf to bed format. It is designed to work with all current versions. It includes CDS boundaries for the 7th and 8th columns of the bed file.

(The script has no -h option; the usage line above is taken from its source.)
```

## gs-tama_tama_format_gtf_to_bed12_ncbi.py

### Tool Description
This script converts NCBI gtf to bed format. It is designed to work with all current versions. It includes CDS boundaries for the 7th and 8th columns of the bed file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_format_gtf_to_bed12_ncbi.py ncbi.gtf output_file

This script converts NCBI gtf to bed format. It is designed to work with all current versions. It includes CDS boundaries for the 7th and 8th columns of the bed file.

(The script has no -h option; the usage line above is taken from its source.)
```

## gs-tama_tama_format_gtf_to_bed12_stringtie.py

### Tool Description
This script converts cufflinks/stringtie gtf into bed format file

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_format_gtf_to_bed12_stringtie.py stringtie.gtf output_file

This script converts cufflinks/stringtie gtf into bed format file

(The script has no -h option; the usage line above is taken from its source.)
```

## gs-tama_tama_format_id_filter.py

### Tool Description
This script makes the Ensembl IDs the primary IDs and allows for filtering

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_format_id_filter.py [-h] [-b B] [-o O] [-f F] [-s S] [-r R] [-d D]

This script makes the Ensembl IDs the primary IDs and allows for filtering

optional arguments:
  -h, --help  show this help message and exit
  -b B        bed file (required)
  -o O        Output file name (required)
  -f F        Filter level (default "none", use "only_match" to only include
              models with a match)
  -s S        Sub-field management method (default "ensembl_merge" for
              restructuring sub-fields from Ensembl ID, use "custom" to define
              sub-field shuffling)
  -r R        Sub-field reshuffle parameter (default "none")
  -d D        Sub-field reshuffle delimiters (default ";")
```

## gs-tama_tama_mapped_sam_splitter.py

### Tool Description
This script splits mapped sam files by chromosome

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_mapped_sam_splitter.py sam_file number_of_files output_prefix

This script splits mapped sam files by chromosome

(The script has no -h option; the usage line above is taken from its source.)
```

## gs-tama_tama_orf_blastp_parser.py

### Tool Description
This script parses information from the default output of blastp

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_orf_blastp_parser.py [-h] [-b B] [-o O] [-f F]

This script parses information from the default output of blastp

optional arguments:
  -h, --help  show this help message and exit
  -b B        blastp file (required)
  -o O        Output file name (required)
  -f F        Format of input DB ID (default is UniRef, use "ensembl" for
              Ensembl generated DB)
```

## gs-tama_tama_orf_seeker.py

### Tool Description
This script finds open reading frames from transcript sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_orf_seeker.py [-h] [-f F] [-o O]

This script finds open reading frames from transcript sequences

optional arguments:
  -h, --help  show this help message and exit
  -f F        Fasta file (required)
  -o O        Output file name (required)
```

## gs-tama_tama_read_support_collapse_cluster.py

### Tool Description
This script gets all read support for TAMA collapse transcripts from clustering output

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_read_support_collapse_cluster.py prefix_trans_read.bed cluster_file output_file

This script gets all read support for TAMA collapse transcripts from clustering output

(The script has no -h option; the usage line above is taken from its source.)
```

## gs-tama_tama_read_support_levels.py

### Tool Description
This script produces a read support file for identifying what models are supported by which reads

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_read_support_levels.py [-h] [-f F] [-m M] [-o O] [-d D] [-mt MT]

This script produces a read support file for identifying what models are
supported by which reads

optional arguments:
  -h, --help  show this help message and exit
  -f F        Filelist file with pre-merge trans_read.bed file names
  -m M        Merge.txt file from after merging. Use "no_merge" if there is no
              merge file.
  -o O        Output file prefix
  -d D        Ignore duplicate read name warning with -d dup_ok, default is to
              flag duplicates and terminate early.
  -mt MT      Merge type flag indicates the type of merge file used. Use -mt
              cupcake for cupcake file. Default is TAMA output.
```

## gs-tama_tama_read_support_merge_collapse.py

### Tool Description
This script finds all read support for transcripts in tama merge output

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_read_support_merge_collapse.py merge_file filelist_file output_file

This script finds all read support for transcripts in tama merge output

(The script has no -h option; the usage line above is taken from its source.)
```

## gs-tama_tama_remove_polya_models_levels.py

### Tool Description
This script uses the TAMA collapse and TAMA merge outputs to remove Poly-A models

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_remove_polya_models_levels.py [-h] [-b B] [-f F] [-r R] [-o O]
                                          [-p P] [-l L] [-a A] [-k K]

This script uses the TAMA collapse and TAMA merge outputs to remove Poly-A
models

optional arguments:
  -h, --help  show this help message and exit
  -b B        Annotation bed file
  -f F        Filelist file with Poly-A file names
  -r R        Read support file
  -o O        Output prefix (required)
  -p P        Percent poly-A threshold (default of 75.0)
  -l L        Level of removal (gene or transcript level)
  -a A        Remove all models with Poly-A (all_polya or singleton_polya).
              Default is singleton_polya.
  -k K        Keep all multi-exon models (keep_multi or remove_multi)
```

## gs-tama_tama_sampling_saturation_curve.py

### Tool Description
This script uses the TAMA read support levels file to create a saturation curve

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_sampling_saturation_curve.py [-h] [-r R] [-b B] [-o O]

This script uses the TAMA read support levels file to create a saturation
curve

optional arguments:
  -h, --help  show this help message and exit
  -r R        Read support file
  -b B        Read bin size
  -o O        Output file name
```

## gs-tama_tama_variant_caller.py

### Tool Description
This script collapses mapped transcript models

### Metadata
- **Docker Image**: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
- **Homepage**: https://github.com/sguizard/gs-tama
- **Package**: https://anaconda.org/channels/bioconda/packages/gs-tama/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tama_variant_caller.py [-h] [-s S] [-f F] [-p P] [-x X] [-e E] [-c C]
                              [-i I] [-icm ICM] [-a A] [-m M] [-z Z] [-d D]
                              [-sj SJ] [-sjt SJT] [-lde LDE] [-ses SES] [-b B]
                              [-log LOG] [-v V] [-rm RM] [-vc VC] [-cv CV]

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
  -vc VC      Variation covwerage threshold: Default 5 reads
  -cv CV      Clipped mapping variant calling: Default "clip_variants" and set
              to "no_clips_var" to ignore soft and hard clipping for variant
              detection
```

## Metadata
- **Skill**: generated
