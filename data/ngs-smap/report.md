# ngs-smap CWL Generation Report

## ngs-smap_smap

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/truttink/smap
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-smap/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/ngs-smap/overview
- **Total Downloads**: 16.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
16:44:58
```


## ngs-smap_smap delineate

### Tool Description
Create a bed file with clusters of Stacks using a set of bam files containing aligned GBS reads. The Stack Mapping Anchor Points "SMAP" within clustersof Stacks are listed 0-based. The position of the clusters of Stacks themselves are 0-based according to BED format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/truttink/smap
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-smap/overview
- **Validation**: PASS

### Original Help Text
```text
16:45:08
[0m2026-02-26 16:45:09,429 root - INFO: This is SMAP 5.0.1[0m
[0m2026-02-26 16:45:09,430 Delineate - INFO: SMAP-delineate started.[0m
usage: delineate [-h] [-v] -r MAPPING_ORIENTATION
                 [-read_type {separate,merged}] [-n LABEL] [-p PROCESSES]
                 [--plot {all,summary,nothing}] [-t {png,pdf}]
                 [-q MAPPING_QUALITY] [-x MIN_STACK_DEPTH]
                 [-y MAX_STACK_DEPTH] [-f MIN_CLUSTER_LENGTH]
                 [-g MAX_CLUSTER_LENGTH] [-l MAX_STACK_NUMBER]
                 [-b MIN_STACK_DEPTH_FRACTION] [-c MIN_CLUSTER_DEPTH]
                 [-d MAX_CLUSTER_DEPTH] [-s MAX_SMAP_NUMBER] [-w COMPLETENESS]
                 alignments_dir

Create a bed file with clusters of Stacks using a set of bam files containing
aligned GBS reads. The Stack Mapping Anchor Points "SMAP" within clustersof
Stacks are listed 0-based. The position of the clusters of Stacks themselves
are 0-based according to BED format.

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit

In- and output information:
  alignments_dir        Path to the directory containing BAM and BAI alignment
                        files. All BAM files should be in the same directory
                        [current directory].
  -r MAPPING_ORIENTATION, -mapping_orientation MAPPING_ORIENTATION
                        Specify strandedness of read mapping should be
                        considered for haplotyping. When specifying "ignore",
                        reads are collected per locus independent of the
                        strand that the reads are mapped on (i.e. ignoring
                        their mapping orientation). "stranded" means that only
                        those reads will be considered that map on the same
                        strand as indicated per locus in the BED file. For
                        more information on which option to choose, please
                        consult the manual.
  -read_type {separate,merged}
                        Deprecated option: please use --mapping_orientation. "
                        --read_type merged" should be replaced by "--
                        mapping_orientation ignore", and "--read_type merged"
                        by "--mapping_orientation stranded".
  -n LABEL, --name LABEL
                        Label to describe the sample set, will be added to the
                        last column in the final stack BED file and is used by
                        SMAP-compare [Set1].

System resources.:
  -p PROCESSES, --processes PROCESSES
                        Number of parallel processes [1].

Graphical output options:
  --plot {all,summary,nothing}
                        Select which plots are to be generated. Choosing
                        "nothing" disables plot generation. Passing "summary"
                        only generates graphs with information for all samples
                        while "all" will also enable generate per-sample plots
                        [default "summary"].
  -t {png,pdf}, --plot_type {png,pdf}
                        Choose the file type for the plots [png].

Read filtering options:
  -q MAPPING_QUALITY, --minimum_mapping_quality MAPPING_QUALITY
                        Minimum bam mapping quality to retain reads for
                        analysis [30].

Stack filtering options.:
  -x MIN_STACK_DEPTH, --min_stack_depth MIN_STACK_DEPTH
                        Minimum number of reads per Stack per sample. A good
                        reference value could be 3 [0].
  -y MAX_STACK_DEPTH, --max_stack_depth MAX_STACK_DEPTH
                        Maximum total number of reads per Stack per sample
                        [inf].

Cluster filtering options:
  -f MIN_CLUSTER_LENGTH, --min_cluster_length MIN_CLUSTER_LENGTH
                        Minimum cluster length. Can be used to remove
                        artifacts that arise from read merging [0].
  -g MAX_CLUSTER_LENGTH, --max_cluster_length MAX_CLUSTER_LENGTH
                        Maximum cluster length. Can be used to remove
                        artifacts that arise from read merging [inf].
  -l MAX_STACK_NUMBER, --max_stack_number MAX_STACK_NUMBER
                        Maximum number of Stacks per StackCluster, may be 2 in
                        diploid individuals, 4 for tetraploid individuals, 20
                        for Pool-Seq [inf].
  -b MIN_STACK_DEPTH_FRACTION, --min_stack_depth_fraction MIN_STACK_DEPTH_FRACTION
                        Threshold (%) for minimum relative Stack depth per
                        StackCluster. Removes spuriously mapped reads from
                        StackClusters, and controls for noise in the number of
                        SMAPs per locus. The StackCluster total read depth and
                        number of SMAPs is recalculated based on the retained
                        Stacks per sample [0].
  -c MIN_CLUSTER_DEPTH, --min_cluster_depth MIN_CLUSTER_DEPTH
                        Minimal total number of reads per StackCluster per
                        sample. The total number of reads in a StackCluster is
                        calculated after filtering out the Stacks using
                        --min_stack_depth_fraction. A good reference value is
                        10 for individual diploid samples, 20 for tetraploids,
                        and 30 for Pool-Seq [0].
  -d MAX_CLUSTER_DEPTH, --max_cluster_depth MAX_CLUSTER_DEPTH
                        Maximal total number of reads per StackCluster per
                        sample. The total number of reads in a StackCluster is
                        calculated after filtering out the Stacks using
                        --min_stack_depth_fraction [inf].

Merging clusters filtering options:
  -s MAX_SMAP_NUMBER, --max_smap_number MAX_SMAP_NUMBER
                        Maximum number of SMAPs per MergedCluster across the
                        sample set. Can be used to remove loci with excessive
                        MergedCluster complexity before downstream analysis
                        [inf].
  -w COMPLETENESS, --completeness COMPLETENESS
                        Completeness, minimal percentage of samples that
                        contains an overlapping StackCluster for a given
                        MergedCluster. May be used to select loci with enough
                        read mapping data across the sample set for downstream
                        analysis [0].
```


## ngs-smap_smap haplotype

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/truttink/smap
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-smap/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
16:46:37
```


## ngs-smap_smap grm

### Tool Description
Convert the haplotype table from SMAP haplotype-sites or SMAP haplotype-windows into a genetic similarity/distance matrix and/or a locus information matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/truttink/smap
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-smap/overview
- **Validation**: PASS

### Original Help Text
```text
16:46:50
[0m2026-02-26 16:46:51,672 root - INFO: This is SMAP 5.0.1[0m
[0m2026-02-26 16:46:51,672 root - INFO: Parsing arguments.[0m
usage: smap [-h] -t TABLE [-i INPUT_DIRECTORY] [-n SAMPLES] [-l LOCI]
            [-lc LOCUS_COMPLETENESS] [-sc SAMPLE_COMPLETENESS] [-p PROCESSES]
            [--excel] [--distance {d,i}] [-o OUTPUT_DIRECTORY]
            [--prefix PREFIX] [--informative_loci]
            [--plot_format {pdf,png,svg,jpg,jpeg,tif,tiff}]
            [--mask {none,upper,lower}] [--cluster] [--debug]

Convert the haplotype table from SMAP haplotype-sites or SMAP haplotype-
windows into a genetic similarity/distance matrix and/or a locus information
matrix.

options:
  -h, --help            show this help message and exit
  -t TABLE, --table TABLE
                        Name of the haplotypes table retrieved from SMAP
                        haplotype-sites or SMAP haplotype-windows in the input
                        directory.
  -i INPUT_DIRECTORY, --input_directory INPUT_DIRECTORY
                        Input directory containing the haplotypes table, the
                        --samples text file, and/or the --loci text file
                        (default = current directory).
  -n SAMPLES, --samples SAMPLES
                        Name of a tab-delimited text file in the input
                        directory defining the order of the (new) sample IDs
                        in the matrix: first column = old IDs, second column
                        (optional) = new IDs (default = no list provided, the
                        order of sample IDs in the matrix equals their order
                        in the haplotypes table).
  -l LOCI, --loci LOCI  Name of a tab-delimited text file in the input
                        directory containing a one-column list of locus IDs
                        formatted as in the haplotypes table (default = no
                        list provided).
  -lc LOCUS_COMPLETENESS, --locus_completeness LOCUS_COMPLETENESS
                        Minimum proportion of samples with haplotype data in a
                        locus. Loci with less data are removed (default = all
                        loci are included).
  -sc SAMPLE_COMPLETENESS, --sample_completeness SAMPLE_COMPLETENESS
                        Minimum number of loci with haplotype data in a
                        sample. Samples with less data are removed (default =
                        all samples are included).
  -p PROCESSES, --processes PROCESSES
                        Number of processes used by the script (default = 1).
  --excel               Write the GRM output to excel
  --distance {d,i}      Convert genetic similarity estimates into genetic
                        distances (default = no conversion to distances). Type
                        'd' for normal distance and 'i' for inversed distance
  -o OUTPUT_DIRECTORY, --output_directory OUTPUT_DIRECTORY
                        Output directory (default = current directory).
  --prefix PREFIX       Prefix added to all output file names (default = no
                        prefix added).
  --informative_loci    Print locus information to the output directory.
  --plot_format {pdf,png,svg,jpg,jpeg,tif,tiff}
                        File format of plots (default = pdf, other options are
                        png, svg, jpg, jpeg, tif, and tiff).
  --mask {none,upper,lower}
                        Mask values on the main diagonal of each matrix and
                        above (upper) or below (lower) the main diagonal
                        (default = Lower, other options are: upper (mask upper
                        half) and None (No masking).
  --cluster             Create a clustered matrix. The order provided in the
                        samples file is ignored.
  --debug               Enable verbose logging
```


## ngs-smap_smap snp-seq

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/truttink/smap
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-smap/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
16:48:22
```


## ngs-smap_smap compare

### Tool Description
Compare merged clusters of two SMAP outputs.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/truttink/smap
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-smap/overview
- **Validation**: PASS

### Original Help Text
```text
16:48:36
[0m2026-02-26 16:48:38,295 root - INFO: This is SMAP 5.0.1[0m
[0m2026-02-26 16:48:38,296 Compare - INFO: SMAP compare started.[0m
usage: compare [-h] smap_set1 smap_set2

Compare merged clusters of two SMAP outputs.

positional arguments:
  smap_set1   SMAP delineate output BED file for set 1
  smap_set2   SMAP delineate output BED file for set 2.

options:
  -h, --help  show this help message and exit
```


## ngs-smap_smap target-selection

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/truttink/smap
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-smap/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
16:50:22
```


## Metadata
- **Skill**: generated
