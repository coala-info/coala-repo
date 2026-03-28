# elprep CWL Generation Report

## elprep_filter

### Tool Description
Filter SAM/BAM/CRAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/elprep:5.1.3--he881be0_2
- **Homepage**: https://github.com/ExaScience/elprep
- **Package**: https://anaconda.org/channels/bioconda/packages/elprep/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/elprep/overview
- **Total Downloads**: 64.1K
- **Last updated**: 2025-09-16
- **GitHub**: https://github.com/ExaScience/elprep
- **Stars**: N/A
### Original Help Text
```text
elprep version 5.1.3 compiled with go1.25.1 - see http://github.com/exascience/elprep for more information.

Incorrect number of parameters.

filter parameters:
elprep filter sam-file sam-output-file
[--output-type [sam | bam]]
[--replace-reference-sequences sam-file]
[--filter-unmapped-reads]
[--filter-unmapped-reads-strict]
[--filter-mapping-quality mapping-quality]
[--filter-non-exact-mapping-reads]
[--filter-non-exact-mapping-reads-strict]
[--filter-non-overlapping-reads bed-file]
[--replace-read-group read-group-string]
[--mark-duplicates]
[--mark-optical-duplicates file]
[--optical-duplicates-pixel-distance nr]
[--remove-duplicates]
[--remove-optional-fields [all | list]]
[--keep-optional-fields [none | list]]
[--sorting-order [keep | unknown | unsorted | queryname | coordinate]]
[--clean-sam]
[--reference elfasta]
[--bqsr recal-file]
[--quantize-levels nr]
[--sqq list]
[--max-cycle nr]
[--known-sites list]
[--haplotypecaller vcf-file]
[--reference-confidence [GVCF | BP_RESOLUTION | NONE]
[--sample-name sample-name]
[--activity-profile igv-file]
[--assembly-regions igv-file]
[--assembly-region-padding nr]
[--target-regions]
[--nr-of-threads nr]
[--timed]
[--log-path path]
```


## elprep_sfm

### Tool Description
sfm parameters:

### Metadata
- **Docker Image**: quay.io/biocontainers/elprep:5.1.3--he881be0_2
- **Homepage**: https://github.com/ExaScience/elprep
- **Package**: https://anaconda.org/channels/bioconda/packages/elprep/overview
- **Validation**: PASS

### Original Help Text
```text
elprep version 5.1.3 compiled with go1.25.1 - see http://github.com/exascience/elprep for more information.

Incorrect number of parameters.

sfm parameters:
elprep sfm sam-file sam-output-file
[--output-type [sam | bam]]
[--replace-reference-sequences sam-file]
[--filter-unmapped-reads]
[--filter-unmapped-reads-strict]
[--filter-mapping-quality mapping-quality]
[--filter-non-exact-mapping-reads]
[--filter-non-exact-mapping-reads-strict]
[--filter-non-overlapping-reads bed-file]
[--replace-read-group read-group-string]
[--mark-duplicates]
[--mark-optical-duplicates file]
[--optical-duplicates-pixel-distance nr]
[--remove-duplicates]
[--remove-optional-fields [all | list]]
[--keep-optional-fields [none | list]]
[--sorting-order [keep | unknown | unsorted | queryname | coordinate]]
[--clean-sam]
[--bqsr]
[--reference elfasta]
[--quantize-levels nr]
[--sqq list]
[--max-cycle nr]
[--known-sites list]
[--haplotypecaller vcf-file]
[--reference-confidence [GVCF | BP_RESOLUTION | NONE]
[--sample-name sample-name]
[--activity-profile igv-file]
[--assembly-regions igv-file]
[--assembly-region-padding nr]
[--target-regions bed-file]
[--nr-of-threads nr]
[--timed]
[--log-path path]
[--intermediate-files-output-prefix name]
[--intermediate-files-output-type [sam | bam]]
[--tmp-path path]
[--single-end]
[--contig-group-size nr]
```


## elprep_vcf-to-elsites

### Tool Description
Converts a VCF file to an ELSIF sites file.

### Metadata
- **Docker Image**: quay.io/biocontainers/elprep:5.1.3--he881be0_2
- **Homepage**: https://github.com/ExaScience/elprep
- **Package**: https://anaconda.org/channels/bioconda/packages/elprep/overview
- **Validation**: PASS

### Original Help Text
```text
elprep version 5.1.3 compiled with go1.25.1 - see http://github.com/exascience/elprep for more information.

Incorrect number of parameters.
vcf-to-elsites parameters:
elprep vcf-to-elsites vcf-file elsites-file
[--log-path path]
```


## elprep_bed-to-elsites

### Tool Description
Convert BED file to ELSIngleSite format.

### Metadata
- **Docker Image**: quay.io/biocontainers/elprep:5.1.3--he881be0_2
- **Homepage**: https://github.com/ExaScience/elprep
- **Package**: https://anaconda.org/channels/bioconda/packages/elprep/overview
- **Validation**: PASS

### Original Help Text
```text
elprep version 5.1.3 compiled with go1.25.1 - see http://github.com/exascience/elprep for more information.

Incorrect number of parameters.

bed-to-elsites parameters:
elprep bed-to-elsites bed-file elsites-file
[--log-path path]
```


## elprep_fasta-to-elfasta

### Tool Description
Converts a FASTA file to an elFASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/elprep:5.1.3--he881be0_2
- **Homepage**: https://github.com/ExaScience/elprep
- **Package**: https://anaconda.org/channels/bioconda/packages/elprep/overview
- **Validation**: PASS

### Original Help Text
```text
elprep version 5.1.3 compiled with go1.25.1 - see http://github.com/exascience/elprep for more information.

Incorrect number of parameters.
fasta-to-elfasta parameters:
elprep fasta-to-elfasta fasta-file elfasta-file
[--log-path path]
```


## Metadata
- **Skill**: generated
