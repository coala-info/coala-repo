# imfusion CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| imfusion_build_star | PASS | Built the STAR-indexed augmented reference from a real 200 kb mouse chr16 region (Cblb), its Ensembl GTF and the real T2onc transposon. |
| imfusion_build_tophat | Failed | image problem: tophat2 in the image is a Python 2 script run by Python 3 and crashes (can't have unbuffered text I/O). |
| imfusion_ctg | Failed | image problem: pandas in the image is too new for imfusion-ctg (Series has no attribute clip_upper), so no CTG file is written. |
| imfusion_expression | PASS | Exon counts for Cblb from the insertions_star sample (synthetic reads) look right. |
| imfusion_insertions_star | PASS | synthetic data: simulated reads with a T2onc SD-Cblb fusion gave the expected sense SD insertion in Cblb; plain (not gzipped) FASTQ crashes (tool bug), gzipped works. |
| imfusion_insertions_tophat | Failed | image problem: tophat2 in the image is a Python 2 script run by Python 3 and crashes (can't have unbuffered text I/O). |
| imfusion_merge | PASS | Merged the two real sample insertion files from the imfusion tests (18 rows). |

## imfusion_expression

### Tool Description
imfusion-expression: error: the following arguments are required: --sample_dir, --reference

### Metadata
- **Docker Image**: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
- **Homepage**: https://github.com/NKI-CCB/imfusion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: imfusion-expression [-h] [--version] --sample_dir SAMPLE_DIR
                           --reference REFERENCE [--output OUTPUT] [--paired]
                           [--stranded {stranded,reverse,unstranded}]
imfusion-expression: error: the following arguments are required: --sample_dir, --reference
```


## imfusion_ctg

### Tool Description
imfusion-ctg: error: the following arguments are required: --insertions, --reference, --output

### Metadata
- **Docker Image**: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
- **Homepage**: https://github.com/NKI-CCB/imfusion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: imfusion-ctg [-h] [--version] --insertions INSERTIONS --reference
                    REFERENCE [--gene_ids GENE_IDS [GENE_IDS ...]] --output
                    OUTPUT [--threshold THRESHOLD] [--pattern PATTERN]
                    [--window WINDOW WINDOW]
                    [--chromosomes CHROMOSOMES [CHROMOSOMES ...]]
                    [--min_depth MIN_DEPTH] [--expression EXPRESSION]
                    [--de_threshold DE_THRESHOLD]
imfusion-ctg: error: the following arguments are required: --insertions, --reference, --output
```


## imfusion_merge

### Tool Description
Merges multiple samples into a single imfusion object.

### Metadata
- **Docker Image**: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
- **Homepage**: https://github.com/NKI-CCB/imfusion
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: imfusion-merge [-h] [--version] --sample_dirs SAMPLE_DIRS
                      [SAMPLE_DIRS ...] --output OUTPUT
                      [--names NAMES [NAMES ...]]
                      [--output_expression OUTPUT_EXPRESSION]
imfusion-merge: error: the following arguments are required: --sample_dirs, --output
```


## imfusion_build_star

### Tool Description
Build an augmented reference (reference plus transposon sequence) with a STAR index for IM-Fusion.

### Metadata
- **Docker Image**: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
- **Homepage**: https://github.com/NKI-CCB/imfusion
- **Package**: https://anaconda.org/channels/bioconda/packages/imfusion/overview
- **Validation**: PASS

### Original Help Text
```text
usage: imfusion-build star [-h] --reference_seq REFERENCE_SEQ --reference_gtf
                           REFERENCE_GTF --transposon_seq TRANSPOSON_SEQ
                           --transposon_features TRANSPOSON_FEATURES
                           --output_dir OUTPUT_DIR
                           [--blacklist_regions BLACKLIST_REGIONS [BLACKLIST_REGIONS ...]]
                           [--blacklist_genes BLACKLIST_GENES [BLACKLIST_GENES ...]]
                           [--skip_index] [--star_overhang STAR_OVERHANG]
                           [--star_threads STAR_THREADS]

optional arguments:
  -h, --help            show this help message and exit

Basic arguments:
  --reference_seq REFERENCE_SEQ
                        Path to the reference sequence (in Fasta format).
  --reference_gtf REFERENCE_GTF
                        Path to the reference gtf file.
  --transposon_seq TRANSPOSON_SEQ
                        Path to the transposon sequence (in Fasta format).
  --transposon_features TRANSPOSON_FEATURES
                        Path to the transposon features (tsv).
  --output_dir OUTPUT_DIR
                        Path to write the built reference.

Blacklist arguments:
  --blacklist_regions BLACKLIST_REGIONS [BLACKLIST_REGIONS ...]
                        Regions of the reference to blacklist. Should be
                        specified as 'chromosome:start-end'.
  --blacklist_genes BLACKLIST_GENES [BLACKLIST_GENES ...]
                        Genes to blacklist. Should correspond with the gene
                        ids used in the reference gtf file.

Debugging:
  --skip_index          Whether to skip the building of the genome indices.
                        Mainly used for debugging purposes.

STAR arguments:
  --star_overhang STAR_OVERHANG
  --star_threads STAR_THREADS
```


## imfusion_build_tophat

### Tool Description
Build an augmented reference (reference plus transposon sequence) with a Tophat2/bowtie index for IM-Fusion.

### Metadata
- **Docker Image**: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
- **Homepage**: https://github.com/NKI-CCB/imfusion
- **Package**: https://anaconda.org/channels/bioconda/packages/imfusion/overview
- **Validation**: PASS

### Original Help Text
```text
usage: imfusion-build tophat [-h] --reference_seq REFERENCE_SEQ
                             --reference_gtf REFERENCE_GTF --transposon_seq
                             TRANSPOSON_SEQ --transposon_features
                             TRANSPOSON_FEATURES --output_dir OUTPUT_DIR
                             [--blacklist_regions BLACKLIST_REGIONS [BLACKLIST_REGIONS ...]]
                             [--blacklist_genes BLACKLIST_GENES [BLACKLIST_GENES ...]]
                             [--skip_index]

optional arguments:
  -h, --help            show this help message and exit

Basic arguments:
  --reference_seq REFERENCE_SEQ
                        Path to the reference sequence (in Fasta format).
  --reference_gtf REFERENCE_GTF
                        Path to the reference gtf file.
  --transposon_seq TRANSPOSON_SEQ
                        Path to the transposon sequence (in Fasta format).
  --transposon_features TRANSPOSON_FEATURES
                        Path to the transposon features (tsv).
  --output_dir OUTPUT_DIR
                        Path to write the built reference.

Blacklist arguments:
  --blacklist_regions BLACKLIST_REGIONS [BLACKLIST_REGIONS ...]
                        Regions of the reference to blacklist. Should be
                        specified as 'chromosome:start-end'.
  --blacklist_genes BLACKLIST_GENES [BLACKLIST_GENES ...]
                        Genes to blacklist. Should correspond with the gene
                        ids used in the reference gtf file.

Debugging:
  --skip_index          Whether to skip the building of the genome indices.
                        Mainly used for debugging purposes.
```


## imfusion_insertions_star

### Tool Description
Identify transposon insertions from gene-transposon fusions in RNA-seq reads aligned with STAR.

### Metadata
- **Docker Image**: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
- **Homepage**: https://github.com/NKI-CCB/imfusion
- **Package**: https://anaconda.org/channels/bioconda/packages/imfusion/overview
- **Validation**: PASS

### Original Help Text
```text
usage: imfusion-insertions star [-h] --fastq FASTQ [--fastq2 FASTQ2]
                                --reference REFERENCE --output_dir OUTPUT_DIR
                                [--star_threads STAR_THREADS]
                                [--star_min_flank STAR_MIN_FLANK]
                                [--star_external_sort] [--star_args STAR_ARGS]
                                [--merge_junction_dist MERGE_JUNCTION_DIST]
                                [--max_spanning_dist MAX_SPANNING_DIST]
                                [--max_junction_dist MAX_JUNCTION_DIST]
                                [--assemble] [--no_filter_orientation]
                                [--no_filter_feature]
                                [--blacklisted_genes BLACKLISTED_GENES [BLACKLISTED_GENES ...]]
                                [--star_fusion_reference STAR_FUSION_REFERENCE]

optional arguments:
  -h, --help            show this help message and exit

Basic arguments:
  --fastq FASTQ         Path(s) to the samples fastq files.
  --fastq2 FASTQ2       Paths to the second pair fastq files (for paired-end
                        sequencing data). Should be given in the same order as
                        for fastq.
  --reference REFERENCE
                        Path to the index of the augmented reference generated
                        by imfusion-build.
  --output_dir OUTPUT_DIR
                        The samples output directory.

STAR arguments:
  --star_threads STAR_THREADS
                        Number of threads to use when running STAR.
  --star_min_flank STAR_MIN_FLANK
                        Minimum mapped length of the two segments on each side
                        of the fusion.
  --star_external_sort  Use samtools/sambamba for sorting, rather than STAR.
                        Takes longer, but results in lower memory usage for
                        large bam files.
  --star_args STAR_ARGS
                        Additional args to pass to STAR.
  --merge_junction_dist MERGE_JUNCTION_DIST
                        Maximum distance within which fusions supported by
                        split reads (overlapping the junction, so that the
                        exact breakpoint is known) are merged. This merging
                        avoids calling multiple fusions due to slight
                        variations in the alignment, although this value
                        should not be chosen too large to avoid merging
                        distinct insertions.
  --max_spanning_dist MAX_SPANNING_DIST
                        Maximum distance within which spanning mate pairs
                        (mates that do not overlap the fusion junction) are
                        grouped when summarizing spanning chimeric reads. Both
                        mates from two pairs need to be within this distance
                        of each other to be merged. The value should be chosen
                        to reflect the expected or emprical insert size.
  --max_junction_dist MAX_JUNCTION_DIST
                        Maximum distance within which groups of spanning mates
                        are assigned to a junction fusion (which is supported
                        by split reads, so that its exact position is known).
                        Groups that cannot be assigned to a junction fusion
                        are considered to arise from a separate insertion.

Assembly:
  --assemble            Perform de-novo transcript assembly using StringTie.

Filtering:
  --no_filter_orientation
                        Don't filter fusions with transposon features and
                        genes in opposite (incompatible) orientations.
  --no_filter_feature   Don't filter fusions with non-SA/SD features.
  --blacklisted_genes BLACKLISTED_GENES [BLACKLISTED_GENES ...]
                        Blacklisted genes to filter.

STAR-Fusion:
  --star_fusion_reference STAR_FUSION_REFERENCE
                        Path to a STAR-Fusion reference. If given, STAR-Fusion
                        is used to identify endogenous gene fusions from IM-
                        Fusions alignment. Identified gene fusions are written
                        to a gene_fusions.txt file in the output directory.
                        Note that the STAR-Fusion reference should use the
                        same reference genome as IM-Fusions reference to avoid
                        compatability issues.Requires STAR-Fusion to be
                        installed.
```


## imfusion_insertions_tophat

### Tool Description
Identify transposon insertions from gene-transposon fusions in RNA-seq reads aligned with Tophat2.

### Metadata
- **Docker Image**: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
- **Homepage**: https://github.com/NKI-CCB/imfusion
- **Package**: https://anaconda.org/channels/bioconda/packages/imfusion/overview
- **Validation**: PASS

### Original Help Text
```text
usage: imfusion-insertions tophat [-h] --fastq FASTQ [--fastq2 FASTQ2]
                                  --reference REFERENCE --output_dir
                                  OUTPUT_DIR [--tophat_threads TOPHAT_THREADS]
                                  [--tophat_min_flank TOPHAT_MIN_FLANK]
                                  [--tophat_args TOPHAT_ARGS] [--assemble]
                                  [--no_filter_orientation]
                                  [--no_filter_feature]
                                  [--blacklisted_genes BLACKLISTED_GENES [BLACKLISTED_GENES ...]]

optional arguments:
  -h, --help            show this help message and exit

Basic arguments:
  --fastq FASTQ         Path(s) to the samples fastq files.
  --fastq2 FASTQ2       Paths to the second pair fastq files (for paired-end
                        sequencing data). Should be given in the same order as
                        for fastq.
  --reference REFERENCE
                        Path to the index of the augmented reference generated
                        by imfusion-build.
  --output_dir OUTPUT_DIR
                        The samples output directory.

Tophat2 arguments:
  --tophat_threads TOPHAT_THREADS
                        Number of threads to use when running Tophat2.
  --tophat_min_flank TOPHAT_MIN_FLANK
                        Minimum mapped length of the two segments on each side
                        of the fusion.
  --tophat_args TOPHAT_ARGS
                        Additional args to pass to Tophat2.

Assembly:
  --assemble            Perform de-novo transcript assembly using StringTie.

Filtering:
  --no_filter_orientation
                        Don't filter fusions with transposon features and
                        genes in opposite (incompatible) orientations.
  --no_filter_feature   Don't filter fusions with non-SA/SD features.
  --blacklisted_genes BLACKLISTED_GENES [BLACKLISTED_GENES ...]
                        Blacklisted genes to filter.
```


## Metadata
- **Skill**: not generated
