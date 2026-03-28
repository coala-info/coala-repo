# ivar CWL Generation Report

## ivar_trim

### Tool Description
Trim primers and quality from aligned reads in a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/ivar:1.4.4--h077b44d_0
- **Homepage**: https://andersen-lab.github.io/ivar/html/
- **Package**: https://anaconda.org/channels/bioconda/packages/ivar/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ivar/overview
- **Total Downloads**: 113.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gkarthik/ivar
- **Stars**: N/A
### Original Help Text
```text
Usage: ivar trim -i [<input.bam>] -b <primers.bed> [-p <prefix>] [-m <min-length>] [-q <min-quality>] [-s <sliding-window-width>]

Input Options    Description
           -i    BAM file, with aligned reads, to trim primers and quality. If not specified will use standard in
           -b    BED file with primer sequences and positions. If no BED file is specified, only quality trimming will be done.
           -f    [EXPERIMENTAL] Primer pair information file containing left and right primer names for the same amplicon separated by a tab
                 If provided, reads that do not fall within atleat one amplicon will be ignored prior to primer trimming.
           -x    Primer position offset (Default: 0). Reads that occur at the specified offset positions relative to primer positions will also be trimmed.
           -m    Minimum length of read to retain after trimming (Default: 50% average length of the first 1000 reads)
           -q    Minimum quality threshold for sliding window to pass (Default: 20)
           -s    Width of sliding window (Default: 4)
           -e    Include reads with no primers. By default, reads with no primers are excluded
           -k    Keep reads to allow for reanalysis: keep reads which would be dropped by
                 alignment length filter or primer requirements, but mark them QCFAIL

Output Options   Description
           -p    Prefix for the output BAM file. If none is specified output will go to std out
```


## ivar_variants

### Tool Description
Call variants from a mpileup file

### Metadata
- **Docker Image**: quay.io/biocontainers/ivar:1.4.4--h077b44d_0
- **Homepage**: https://andersen-lab.github.io/ivar/html/
- **Package**: https://anaconda.org/channels/bioconda/packages/ivar/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: samtools mpileup -aa -A -d 0 -B -Q 0 --reference [<reference-fasta] <input.bam> | ivar variants -p <prefix> [-q <min-quality>] [-t <min-frequency-threshold>] [-m <minimum depth>] [-r <reference-fasta>] [-g GFF file]

Note : samtools mpileup output must be piped into ivar variants

Input Options    Description
           -q    Minimum quality score threshold to count base (Default: 20)
           -t    Minimum frequency threshold(0 - 1) to call variants (Default: 0.03)
           -m    Minimum read depth to call variants (Default: 0)
           -G    Count gaps towards depth. By default, gaps are not counted
           -r    Reference file used for alignment. This is used to translate the nucleotide sequences and identify intra host single nucleotide variants
           -g    A GFF file in the GFF3 format can be supplied to specify coordinates of open reading frames (ORFs). In absence of GFF file, amino acid translation will not be done.

Output Options   Description
           -p    (Required) Prefix for the output tsv variant file
```


## ivar_filtervariants

### Tool Description
Filters variant TSV files across multiple replicates.

### Metadata
- **Docker Image**: quay.io/biocontainers/ivar:1.4.4--h077b44d_0
- **Homepage**: https://andersen-lab.github.io/ivar/html/
- **Package**: https://anaconda.org/channels/bioconda/packages/ivar/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ivar filtervariants -p <prefix> replicate-one.tsv replicate-two.tsv ... OR ivar filtervariants -p <prefix> -f <text file with one variant file per line> 
Input: Variant tsv files for each replicate/sample

Input Options    Description
           -t    Minimum fraction of files required to contain the same variant. Specify value within [0,1]. (Default: 1)
           -f    A text file with one variant file per line.

Output Options   Description
           -p    (Required) Prefix for the output filtered tsv file
```


## ivar_consensus

### Tool Description
Generates a consensus sequence from pileup data.

### Metadata
- **Docker Image**: quay.io/biocontainers/ivar:1.4.4--h077b44d_0
- **Homepage**: https://andersen-lab.github.io/ivar/html/
- **Package**: https://anaconda.org/channels/bioconda/packages/ivar/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: samtools mpileup -aa -A -d 0 -Q 0 <input.bam> | ivar consensus -p <prefix> 

Note : samtools mpileup output must be piped into `ivar consensus`

Input Options    Description
           -q    Minimum quality score threshold to count base (Default: 20)
           -t    Minimum frequency threshold(0 - 1) to call consensus. (Default: 0)
                 Frequently used thresholds | Description
                 ---------------------------|------------
                                          0 | Majority or most common base
                                        0.2 | Bases that make up atleast 20% of the depth at a position
                                        0.5 | Strict or bases that make up atleast 50% of the depth at a position
                                        0.9 | Strict or bases that make up atleast 90% of the depth at a position
                                          1 | Identical or bases that make up 100% of the depth at a position. Will have highest ambiguities
           -c    Minimum insertion frequency threshold(0 - 1) to call consensus. (Default: 0.8)
                 Frequently used thresholds | Description
                 ---------------------------|------------
                                          0 | Allow insertion if it appears even once
                                        0.2 | Insertions with at least 20% of the depth at a position
                                        0.5 | Insertion with at least 50% of the depth at a position
                                        0.9 | Insertions with at least 90% of the depth at a position
                                          1 | Insertion with 100% of the depth at a position. Will have highest ambiguities
           -m    Minimum depth to call consensus(Default: 10)
           -k    If '-k' flag is added, regions with depth less than minimum depth will not be added to the consensus sequence. Using '-k' will override any option specified using -n 
           -n    (N/-) Character to print in regions with less than minimum coverage(Default: N)

Output Options   Description
           -p    (Required) Prefix for the output fasta file and quality file
           -i    (Optional) Name of fasta header. By default, the prefix is used to create the fasta header in the following format, Consensus_<prefix>_threshold_<frequency-threshold>_quality_<minimum-quality>_<min-insert-threshold>
```


## ivar_getmasked

### Tool Description
This step is used only for amplicon-based sequencing.

### Metadata
- **Docker Image**: quay.io/biocontainers/ivar:1.4.4--h077b44d_0
- **Homepage**: https://andersen-lab.github.io/ivar/html/
- **Package**: https://anaconda.org/channels/bioconda/packages/ivar/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ivar getmasked -i <input-filtered.tsv> -b <primers.bed> -f <primer_pairs.tsv> -p <prefix>
Note: This step is used only for amplicon-based sequencing.

Input Options    Description
           -i    (Required) Input filtered variants tsv generated from `ivar filtervariants`
           -b    (Required) BED file with primer sequences and positions
           -f    (Required) Primer pair information file containing left and right primer names for the same amplicon separated by a tab
Output Options   Description
           -p    (Required) Prefix for the output text file
```


## ivar_removereads

### Tool Description
This step is used only for amplicon-based sequencing.

### Metadata
- **Docker Image**: quay.io/biocontainers/ivar:1.4.4--h077b44d_0
- **Homepage**: https://andersen-lab.github.io/ivar/html/
- **Package**: https://anaconda.org/channels/bioconda/packages/ivar/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ivar removereads -i <input.trimmed.bam> -p <prefix> -t <text-file-with-primer-indices> -b <primers.bed> 
Note: This step is used only for amplicon-based sequencing.

Input Options    Description
           -i    (Required) Input BAM file  trimmed with ‘ivar trim’. Must be sorted which can be done using `samtools sort`.
           -t    (Required) Text file with primer indices separated by spaces. This is the output of `getmasked` command.
           -b    (Required) BED file with primer sequences and positions.

Output Options   Description
           -p    (Required) Prefix for the output filtered BAM file
```


## ivar_version

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/ivar:1.4.4--h077b44d_0
- **Homepage**: https://andersen-lab.github.io/ivar/html/
- **Package**: https://anaconda.org/channels/bioconda/packages/ivar/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
iVar version 1.4.4

Please raise issues and bug reports at https://github.com/andersen-lab/ivar/
```


## Metadata
- **Skill**: generated
