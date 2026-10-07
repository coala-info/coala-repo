# clearcnv CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| clearcnv_annotations | PASS |  |
| clearcnv_cnv_calling | PASS |  |
| clearcnv_coverage | PASS |  |
| clearcnv_matchscores | PASS |  |
| clearcnv_merge_bed | PASS |  |
| clearcnv_merge_coverages | PASS |  |
| clearcnv_prepare_reassignment | PASS |  |
| clearcnv_visualize | PASS |  |

## clearcnv_matchscores

### Tool Description
Matchscore calculation script.

### Metadata
- **Docker Image**: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clear-cnv
- **Package**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/clear-cnv
- **Stars**: N/A
### Original Help Text
```text
usage: clearCNV matchscores [-h] -p PANEL -c COVERAGES -m MATCHSCORES
                            [-x EXPECTED_ARTEFACTS] [--cores CORES] [--fast]

Matchscore calculation script.

options:
  -h, --help            show this help message and exit
  -p PANEL, --panel PANEL
                        Name of the data set (or panel)
  -c COVERAGES, --coverages COVERAGES
                        Coverages file in tsv format
  -m MATCHSCORES, --matchscores MATCHSCORES
                        Output matchscores.tsv file
  -x EXPECTED_ARTEFACTS, --expected_artefacts EXPECTED_ARTEFACTS
                        Expected ratio of CNVs or artefacs in target fragment
                        counts
  --cores CORES         Number of cpu cores used in parallel processing.
                        Default: determined automatically.
  --fast                If set, clearCNV will speed up matchscore calculation
                        by taking only at most 2.000 targets per sample into
                        account.
[D 261007 02:45:17 __main__:773] External executables present: bedops, bedtools, sort
```


## clearcnv_cnv_calling

### Tool Description
CNV calling script. Output is a single file in tsv format containing a list of CNV calls sorted by score. Some quality control plots are added to the analysis directory in the process.

### Metadata
- **Docker Image**: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clear-cnv
- **Package**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/clear-cnv
- **Stars**: N/A
### Original Help Text
```text
usage: clearCNV cnv_calling [-h] -p PANEL -c COVERAGES -a ANALYSIS_DIRECTORY
                            -m MATCHSCORES -C CNV_CALLS -r RATIO_SCORES -z
                            Z_SCORES [-x EXPECTED_ARTEFACTS]
                            [-u SAMPLE_SCORE_FACTOR] [-g MINIMUM_GROUP_SIZES]
                            [-s ZSCALE] [--del_cutoff DEL_CUTOFF]
                            [--dup_cutoff DUP_CUTOFF]
                            [--trans_prob TRANS_PROB] [--plot_regions]
                            [--cores CORES]

CNV calling script. Output is a single file in tsv format containing a list of
CNV calls sorted by score. Some quality control plots are added to the
analysis directory in the process.

options:
  -h, --help            show this help message and exit
  -p PANEL, --panel PANEL
                        Name of the data set(or panel)
  -c COVERAGES, --coverages COVERAGES
                        Coverages file in tsv format
  -a ANALYSIS_DIRECTORY, --analysis_directory ANALYSIS_DIRECTORY
                        Path to the directory, where analysis files are stored
  -m MATCHSCORES, --matchscores MATCHSCORES
                        matchscores.tsv file generated with matchscores.py
  -C CNV_CALLS, --cnv_calls CNV_CALLS
                        Output cnv_calls.tsv file formatted in tsv format
  -r RATIO_SCORES, --ratio_scores RATIO_SCORES
                        Output ratio scores file in tsv format. Best kept
                        together with cnv_calls.tsv
  -z Z_SCORES, --z_scores Z_SCORES
                        Output z-scores file in tsv format. Best kept together
                        with cnv_calls.tsv
  -x EXPECTED_ARTEFACTS, --expected_artefacts EXPECTED_ARTEFACTS
                        Expected ratio of CNVs or artefacs in target fragment
                        counts
  -u SAMPLE_SCORE_FACTOR, --sample_score_factor SAMPLE_SCORE_FACTOR
                        The factor u multiplied with the median sample score
                        to define sample groups. u should range between 1.0 <
                        u < 5.0. Default is 2.0.
  -g MINIMUM_GROUP_SIZES, --minimum_group_sizes MINIMUM_GROUP_SIZES
                        Group size per CNV calling group per match scores.
                        Default is 30.
  -s ZSCALE, --zscale ZSCALE
                        A higher z-scale results in more CNV calls. Should
                        only be 0.0 <= zscale <= 2.0. Default is 0.65.
  --del_cutoff DEL_CUTOFF
                        A hard threshold on the ratio score for deletions.
                        Default is 0.75.
  --dup_cutoff DUP_CUTOFF
                        A hard threshold on the ratio score for duplications.
                        Default is 1.35.
  --trans_prob TRANS_PROB
                        Transition probability of the HMM to change state from
                        WT to CNV. Default is 0.001. Lower values prefer
                        longer CNVs, higher values prefer shorter CNVs.
  --plot_regions        If set, the CNV calling script plots heatmaps of the
                        CNV called regions with the corresponding sample group
                        taken as background.
  --cores CORES         Number of cpu cores used in parallel processing.
                        Default: determined automatically.
[D 261007 02:45:24 __main__:773] External executables present: bedops, bedtools, sort
```


## clearcnv_visualize

### Tool Description
The visualization script creates html files containing heatmap-like matrices containing the ratios aligned with mappability, GC-content and target size so that CNVs can be visually identified and evaluated easily.

### Metadata
- **Docker Image**: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clear-cnv
- **Package**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/clear-cnv
- **Stars**: N/A
### Original Help Text
```text
usage: clearCNV visualize [-h] -a ANALYSIS_DIRECTORY -r RATIO_SCORES -z
                          Z_SCORES -n ANNOTATED [-s SIZE]

The visualization script creates html files containing heatmap-like matrices
containing the ratios aligned with mappability, GC-content and target size so
that CNVs can be visually identified and evaluated easily.

options:
  -h, --help            show this help message and exit
  -a ANALYSIS_DIRECTORY, --analysis_directory ANALYSIS_DIRECTORY
                        Path to the directory, where analysis files are stored
  -r RATIO_SCORES, --ratio_scores RATIO_SCORES
                        Ratio scores file in tsv format, generated in
                        cnv_calling.py
  -z Z_SCORES, --z_scores Z_SCORES
                        Z-scores file in tsv format, generated in
                        cnv_calling.py
  -n ANNOTATED, --annotated ANNOTATED
                        BED-formatted annotatins file generated with clearCNV
                        annotations. E.g. annotations.bed.
  -s SIZE, --size SIZE  Rough number of targets in each visualization.
                        Defaults at 1000.
[D 261007 02:45:31 __main__:773] External executables present: bedops, bedtools, sort
```


## clearcnv_merge_bed

### Tool Description
Merges bed files to non-overlapping intervals.

### Metadata
- **Docker Image**: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clear-cnv
- **Package**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/clear-cnv
- **Stars**: N/A
### Original Help Text
```text
usage: clearCNV merge_bed [-h] -i INFILE -o OUTFILE

Merges bed files to non-overlapping intervals.

options:
  -h, --help            show this help message and exit
  -i INFILE, --infile INFILE
                        Path to the original .bed file.
  -o OUTFILE, --outfile OUTFILE
                        Output path to the merged .bed file.
[D 261007 02:45:40 __main__:773] External executables present: bedops, bedtools, sort
```


## clearcnv_prepare_reassignment

### Tool Description
Prepares the necessary files to perform panel reassignment on a set of .bed files and corresponding .bam file data sets.

### Metadata
- **Docker Image**: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clear-cnv
- **Package**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/clear-cnv
- **Stars**: N/A
### Original Help Text
```text
usage: clearCNV prepare_reassignment [-h] -m METAFILE -b BAMSFILE -d BEDFILE

Prepares the necessary files to perform panel reassignment on a set of .bed
files and corresponding .bam file data sets.

options:
  -h, --help            show this help message and exit
  -m METAFILE, --metafile METAFILE
                        Path to the file containing the meta information. It
                        is a .tsv of the scheme -panel bams.txt bed.bed. It
                        aligns each desired panel name with the corresponding
                        .bam files and the .bed file.
  -b BAMSFILE, --bamsfile BAMSFILE
                        Output .txt file. It will contain the distinct set of
                        all given .bam file paths.
  -d BEDFILE, --bedfile BEDFILE
                        Output .bed file. It will contain the merged union of
                        all given .bed files.
[D 261007 02:45:48 __main__:773] External executables present: bedops, bedtools, sort
```


## clearcnv_coverage

### Tool Description
wrapper for bedtools multicov. Creates an .rtbed file which contains the read depth coverage per target.

### Metadata
- **Docker Image**: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clear-cnv
- **Package**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/clear-cnv
- **Stars**: N/A
### Original Help Text
```text
usage: clearCNV coverage [-h] -i INBAM -b BEDFILE -r RTBED

wrapper for bedtools multicov. Creates an .rtbed file which contains the read
depth coverage per target.

options:
  -h, --help            show this help message and exit
  -i INBAM, --inbam INBAM
                        Path to the .bam file of the sample.
  -b BEDFILE, --bedfile BEDFILE
                        Path to the merged .bed file.
  -r RTBED, --rtbed RTBED
                        Output file in .rtbed format.
[D 261007 02:45:56 __main__:773] External executables present: bedops, bedtools, sort
```


## clearcnv_merge_coverages

### Tool Description
Merges all .rtbed files into one table in .tsv format.

### Metadata
- **Docker Image**: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clear-cnv
- **Package**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/clear-cnv
- **Stars**: N/A
### Original Help Text
```text
usage: clearCNV merge_coverages [-h] -b BEDFILE -r RTBEDS [RTBEDS ...] -c
                                COVERAGES

Merges all .rtbed files into one table in .tsv format.

options:
  -h, --help            show this help message and exit
  -b BEDFILE, --bedfile BEDFILE
                        Path to the merged .bed file.
  -r RTBEDS [RTBEDS ...], --rtbeds RTBEDS [RTBEDS ...]
                        Input .rtbed file paths.
  -c COVERAGES, --coverages COVERAGES
                        Output table in .tsv format.
[D 261007 02:46:03 __main__:773] External executables present: bedops, bedtools, sort
```


## clearcnv_annotations

### Tool Description
Creates annotations file.

### Metadata
- **Docker Image**: quay.io/biocontainers/clearcnv:0.306--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/clear-cnv
- **Package**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clearcnv/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/clear-cnv
- **Stars**: N/A
### Original Help Text
```text
usage: clearCNV annotations [-h] -r REFERENCE -b BEDFILE -k KMER_ALIGN -a
                            ANNOTATIONS

Creates annotations file.

options:
  -h, --help            show this help message and exit
  -r REFERENCE, --reference REFERENCE
                        Path to the genomic reference.
  -b BEDFILE, --bedfile BEDFILE
                        Path to the merged .bed file.
  -k KMER_ALIGN, --kmer_align KMER_ALIGN
                        Path to aligned k-mers (mappability) file in .bed
                        format.
  -a ANNOTATIONS, --annotations ANNOTATIONS
                        Output file in .bed format.
[D 261007 02:46:10 __main__:773] External executables present: bedops, bedtools, sort
```


