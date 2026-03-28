# handyreadgenotyper CWL Generation Report

## handyreadgenotyper_train

### Tool Description
Classify reads in BAM file using existing model or train a model from bam files

### Metadata
- **Docker Image**: quay.io/biocontainers/handyreadgenotyper:0.1.24--pyhdfd78af_0
- **Homepage**: https://github.com/AntonS-bio/HandyReadGenotyper
- **Package**: https://anaconda.org/channels/bioconda/packages/handyreadgenotyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/handyreadgenotyper/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/AntonS-bio/HandyReadGenotyper
- **Stars**: N/A
### Original Help Text
```text
usage: train [-h] -t TARGET_REGIONS -r REFERENCE -p POSITIVE_BAMS
             [-n NEGATIVE_BAMS] -v VCF [-s SPECIAL_CASES] -o OUTPUT_DIR
             [--cpus CPUS] [-m BAMS_MATRIX]

Classify reads in BAM file using existing model or train a model from bam
files

options:
  -h, --help            show this help message and exit
  -t TARGET_REGIONS, --target_regions TARGET_REGIONS
                        Bed file that specifies reference intervals to which
                        reads where mapped
  -r REFERENCE, --reference REFERENCE
                        FASTA file with the reference to which reads where
                        mapped
  -p POSITIVE_BAMS, --positive_bams POSITIVE_BAMS
                        Directory with or list of NON-target BAM files and
                        corresponding BAM index files (.bai)
  -n NEGATIVE_BAMS, --negative_bams NEGATIVE_BAMS
                        Directory with or list of TARGET BAM files and
                        corresponding BAM index files (.bai)
  -v VCF, --vcf VCF     VCF file containing positions that will be excluded
                        from training as well as genotype defining SNPs (also
                        excluded)
  -s SPECIAL_CASES, --special_cases SPECIAL_CASES
                        Tab delimited file specifying amplicon for which
                        presence/absense should be reported
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Directory for output files
  --cpus CPUS           Directory for output files
  -m BAMS_MATRIX, --bams_matrix BAMS_MATRIX
                        Matrix with precalculated BAM matrices ()
usage: train [-h] -t TARGET_REGIONS -r REFERENCE -p POSITIVE_BAMS
             [-n NEGATIVE_BAMS] -v VCF [-s SPECIAL_CASES] -o OUTPUT_DIR
             [--cpus CPUS] [-m BAMS_MATRIX]

Classify reads in BAM file using existing model or train a model from bam
files

options:
  -h, --help            show this help message and exit
  -t TARGET_REGIONS, --target_regions TARGET_REGIONS
                        Bed file that specifies reference intervals to which
                        reads where mapped
  -r REFERENCE, --reference REFERENCE
                        FASTA file with the reference to which reads where
                        mapped
  -p POSITIVE_BAMS, --positive_bams POSITIVE_BAMS
                        Directory with or list of NON-target BAM files and
                        corresponding BAM index files (.bai)
  -n NEGATIVE_BAMS, --negative_bams NEGATIVE_BAMS
                        Directory with or list of TARGET BAM files and
                        corresponding BAM index files (.bai)
  -v VCF, --vcf VCF     VCF file containing positions that will be excluded
                        from training as well as genotype defining SNPs (also
                        excluded)
  -s SPECIAL_CASES, --special_cases SPECIAL_CASES
                        Tab delimited file specifying amplicon for which
                        presence/absense should be reported
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Directory for output files
  --cpus CPUS           Directory for output files
  -m BAMS_MATRIX, --bams_matrix BAMS_MATRIX
                        Matrix with precalculated BAM matrices ()
```


## handyreadgenotyper_classify

### Tool Description
Classify reads in BAM file using existing model or train a model from bam files

### Metadata
- **Docker Image**: quay.io/biocontainers/handyreadgenotyper:0.1.24--pyhdfd78af_0
- **Homepage**: https://github.com/AntonS-bio/HandyReadGenotyper
- **Package**: https://anaconda.org/channels/bioconda/packages/handyreadgenotyper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: classify [-h] [-f FASTQS] -b BAMS -m MODEL [-d SAMPLE_DESCRIPTIONS]
                [-c DESCRIPTION_COLUMN] [--column_separator COLUMN_SEPARATOR]
                [--cpus CPUS] -o OUTPUT_FILE
                [--target_reads_bams TARGET_READS_BAMS] [-s MAX_SOFT_CLIP]
                [-l MAX_READ_LEN_DIFF]
                [--organism_presence_cutoff ORGANISM_PRESENCE_CUTOFF] [-v]

Classify reads in BAM file using existing model or train a model from bam
files

options:
  -h, --help            show this help message and exit
  -f FASTQS, --fastqs FASTQS
                        Directory with ONT run results or individual FASTQ
                        file
  -b BAMS, --bams BAMS  Directory with, list of, or individual BAM and
                        corresponding BAM index files (.bai)
  -m MODEL, --model MODEL
                        Pickle (.pkl) file containing pretrained model. Model
                        must be trained on same reference
  -d SAMPLE_DESCRIPTIONS, --sample_descriptions SAMPLE_DESCRIPTIONS
                        File with sample descriptions (tab delimited), first
                        column must be the BAM file name without .bam
  -c DESCRIPTION_COLUMN, --description_column DESCRIPTION_COLUMN
                        Column in sample description file to use to augmnet
                        samples descriptions
  --column_separator COLUMN_SEPARATOR
                        The column separator for the sample descriptions file
  --cpus CPUS           Number of CPU cores to use
  -o OUTPUT_FILE, --output_file OUTPUT_FILE
                        File to store classification results
  --target_reads_bams TARGET_READS_BAMS
                        Directory to which to write reads classified as target
                        organism
  -s MAX_SOFT_CLIP, --max_soft_clip MAX_SOFT_CLIP
                        Specifies maximum permitted soft-clip (length of read
                        before first and last mapped bases) of mapped read
  -l MAX_READ_LEN_DIFF, --max_read_len_diff MAX_READ_LEN_DIFF
                        Specifies maximum nucleotide difference between mapped
                        portion of read and target amplicon
  --organism_presence_cutoff ORGANISM_PRESENCE_CUTOFF
                        Sample is reported as having target organism if at
                        least this percentage of non-transient amplicons have
                        >10 reads. Values 0-100.
  -v, --version         show program's version number and exit
```


## Metadata
- **Skill**: generated
