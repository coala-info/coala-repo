# ngs-smap CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ngs-smap_smap_compare | PASS |  |
| ngs-smap_smap_delineate | PASS |  |
| ngs-smap_smap_design | PASS |  |
| ngs-smap_smap_effect-prediction | Not completed | needs a haplotype-window output table; only rendered documentation tables found, no real input |
| ngs-smap_smap_grm | Not completed | only a three-sample toy haplotype table is available and the clustering step crashes on it; no larger real haplotype table |
| ngs-smap_smap_haplotype-sites | PASS |  |
| ngs-smap_smap_haplotype-window | Not completed | needs HiPlex FASTQ and BAM files and a reference; no usable test data found |

## ngs-smap_smap_delineate

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

## ngs-smap_smap_grm

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

## ngs-smap_smap_compare

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

## ngs-smap_smap_haplotype-sites

### Tool Description
Create haplotypes using a VCF file containing variant positions and a BED file containing SMAPs.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/truttink/smap
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-smap/overview
- **Validation**: PASS

### Original Help Text
```text
00:19:50
2026-10-11 00:19:51,672 root - INFO: This is SMAP 5.0.1
2026-10-11 00:19:51,672 Haplotype - INFO: SMAP haplotype-sites started.
usage: haplotype-sites [-h] [-v] [-o OUT] -r MAPPING_ORIENTATION
                       [-read_type {separate,merged}] [--cervus]
                       [-e {dominant,dosage}]
                       [-i FREQUENCY_BOUNDS [FREQUENCY_BOUNDS ...]]
                       [-z DOSAGE_FILTER]
                       [--locus_correctness LOCUS_CORRECTNESS_FILTER]
                       [--plot {all,summary,nothing}] [-t {png,pdf}]
                       [-m MASK_FREQUENCY] [-u UNDEFINED_REPRESENTATION]
                       [--no_indels] -a {exclude,include}
                       [-q MINIMUM_MAPPING_QUALITY]
                       [-j MIN_DISTINCT_HAPLOTYPES]
                       [-k MAX_DISTINCT_HAPLOTYPES] [-c MIN_READ_COUNT]
                       [-d MAX_READ_COUNT] [-f MIN_HAPLOTYPE_FREQUENCY]
                       [-p PROCESSES]
                       alignments_dir bed vcf

Create haplotypes using a VCF file containing variant positions and a BED file
containing SMAPs.

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit

Input and output information:
  alignments_dir        Path to the directory containing BAM and BAI alignment
                        files. All BAM files should be in the same directory.
  bed                   BED file containing sites for which haplotypes will be
                        reconstructed. For GBS experiments, the BED file
                        should be generated using SMAP delineate. For HiPlex
                        data, a BED6 file can be provided, with the reference
                        sequence ID in the 1st column, the locus start and end
                        site in the 2nd and 3rd column, the HiPlex_locus_name
                        in the 4th column, the strand orientation ("+") in the
                        5th column, the SMAPs listed in the 6th column, the
                        7th and 8th columns may be left blank (or ".") and the
                        9th column contains the name of the sample set,
                        respectively.
  vcf                   VCF file containing variant positions. It should
                        contain at least the first 9 columns.
  -o OUT, --out OUT     Basename of the output file without extension
                        (default: "").
  -r MAPPING_ORIENTATION, -mapping_orientation MAPPING_ORIENTATION
                        Specify if strandedness of read mapping should be
                        considered for haplotyping. When specifying "ignore",
                        reads are collected per locus independent of the
                        strand that the reads are mapped on (i.e. ignoring
                        their mapping orientation). "stranded" means that only
                        those reads will be considered that map on the same
                        strand as indicated per locus in the BED file. For
                        more information on which option to choose, please
                        consult the manual. (https://ngs-smap.readthedocs.io/e
                        n/latest/sites/sites_scope_usage.html#commands-
                        options)
  -read_type {separate,merged}
                        Deprecated option: please use --mapping_orientation. "
                        --read_type merged" should be replaced by "--
                        mapping_orientation ignore", and "--read_type
                        separate" should be replaced by "--mapping_orientation
                        stranded".
  --cervus              Transform discrete calls table to an multi-allelic
                        format that can be used with Cervus. Haplotypes are
                        transformed to letters of the alphabet (a-z).

Discrete calls options:
  Use thresholds to transform haplotype frequencies into discrete calls
  using fixed intervals. The assigned intervals are indicated by a running
  integer. This is only informative for individual samples and not for Pool-
  Seq data.

  -e {dominant,dosage}, --discrete_calls {dominant,dosage}
                        Set to "dominant" to transform haplotype frequency
                        values into presence(1)/absence(0) calls per allele,
                        or "dosage" to indicate the allele copy number.
  -i FREQUENCY_BOUNDS [FREQUENCY_BOUNDS ...], --frequency_interval_bounds FREQUENCY_BOUNDS [FREQUENCY_BOUNDS ...]
                        Frequency interval bounds for transforming haplotype
                        frequencies into discrete calls. Custom thresholds can
                        be defined by passing one or more space-separated
                        values (relative frequencies in percentage). For
                        dominant calling, one value should be specified. For
                        dosage calling, an even total number of four or more
                        thresholds should be specified. Default values are
                        invoked by passing either "diploid" or "tetraploid".
                        The default value for dominant calling (see
                        discrete_calls argument) is 10, both for "diploid" and
                        "tetraploid". For dosage calling, the default for
                        diploids is "10, 10, 90, 90" and for tetraploids
                        "12.5, 12.5, 37.5, 37.5, 62.5, 62.5, 87.5, 87.5".
  -z DOSAGE_FILTER, --dosage_filter DOSAGE_FILTER
                        Mask dosage calls in the loci for which the total
                        allele count for a given locus at a given sample
                        differs from the defined value. For example, in
                        diploid organisms the total allele copy number must be
                        2, and in tetraploids the total allele copy number
                        must be 4. (default no filtering).
  --locus_correctness LOCUS_CORRECTNESS_FILTER
                        Create a new .bed file defining only the loci that
                        were correctly dosage called (-z) in at least the
                        defined percentage of samples.

Graphical output options:
  --plot {all,summary,nothing}
                        Select which plots are to be generated. Choosing
                        "nothing" disables plot generation. Passing "summary"
                        only generates graphs with information for all samples
                        while "all" will also generate per-sample plots
                        [default "summary"].
  -t {png,pdf}, --plot_type {png,pdf}
                        Choose the file type for the plots [png].

File formatting options:
  -m MASK_FREQUENCY, --mask_frequency MASK_FREQUENCY
                        Mask haplotype frequency values below MASK_FREQUENCY
                        for individual samples to remove noise from the final
                        output. Haplotype frequency values below
                        MASK_FREQUENCY are set to UNDEFINED_REPRESENTATION
                        (see -u). Haplotypes are not removed based on this
                        value, use --min_haplotype_frequency for this purpose
                        instead.
  -u UNDEFINED_REPRESENTATION, --undefined_representation UNDEFINED_REPRESENTATION
                        Value to use for non-existing or masked data [NaN].

Filtering options:
  --no_indels           Use this option if you want to exclude haplotypes that
                        contain an indel at the given SNP positions. These
                        reads are then also ignored to evaluate the minimum
                        read count (default off: haplotypes with indels co-
                        localising at SNP positions are included in output).
  -a {exclude,include}, -partial {exclude,include}
                        Choose to include or exclude haplotypes that contain
                        partial alignments. For GBS data, choose "include",
                        for HiPlex data, choose "exclude".
  -q MINIMUM_MAPPING_QUALITY, --min_mapping_quality MINIMUM_MAPPING_QUALITY
                        Minimum bam mapping quality to retain reads for
                        analysis [30].
  -j MIN_DISTINCT_HAPLOTYPES, --min_distinct_haplotypes MIN_DISTINCT_HAPLOTYPES
                        Minimum number of distinct haplotypes per locus across
                        all samples. Loci that do not fit this criterium are
                        removed from the final output [0].
  -k MAX_DISTINCT_HAPLOTYPES, --max_distinct_haplotypes MAX_DISTINCT_HAPLOTYPES
                        Maximal number of distinct haplotypes per locus across
                        all samples. Loci that do not fit this criterium are
                        removed from the final output [inf].
  -c MIN_READ_COUNT, --min_read_count MIN_READ_COUNT
                        Minimum total number of reads per locus per sample,
                        read depth is calculated after filtering out the low
                        frequency haplotypes (-f) [0].
  -d MAX_READ_COUNT, --max_read_count MAX_READ_COUNT
                        Maximal total number of reads per locus per sample,
                        read depth is calculated after filtering out the low
                        frequency haplotypes (-f) [inf].
  -f MIN_HAPLOTYPE_FREQUENCY, --min_haplotype_frequency MIN_HAPLOTYPE_FREQUENCY
                        Minimum haplotype frequency (in %) to retain the
                        haplotype in the genotype table. If in at least one
                        sample the haplotype frequency is above
                        MIN_HAPLOTYPE_FREQUENCY, the haplotype is retained.
                        Haplotypes for which MIN_HAPLOTYPE_FREQUENCY is never
                        reached in any of the samples are removed [0].

System resources:
  -p PROCESSES, --processes PROCESSES
                        Number of parallel processes [1].
```

## ngs-smap_smap_haplotype-window

### Tool Description
Create haplotypes of HiPlex amplicon windows from FASTQ files, BAM files and a GFF file with Borders (SMAP haplotype-window).

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/truttink/smap
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-smap/overview
- **Validation**: PASS

### Original Help Text
```text
00:19:54
2026-10-11 00:19:55,230 root - INFO: This is SMAP 5.0.1
usage: haplotype-window [-h] [--write_sorted_sequences] [-o OUT]
                        [-e {dominant,dosage}]
                        [-i FREQUENCY_BOUNDS [FREQUENCY_BOUNDS ...]]
                        [-z DOSAGE_FILTER]
                        [--locus_correctness LOCUS_CORRECTNESS_FILTER]
                        [--plot {all,summary,nothing}] [-t {png,pdf}]
                        [-m MASK_FREQUENCY] [-u UNDEFINED_REPRESENTATION]
                        [-q MINIMUM_MAPPING_QUALITY]
                        [-j MIN_DISTINCT_HAPLOTYPES]
                        [-k MAX_DISTINCT_HAPLOTYPES] [-c MIN_READ_COUNT]
                        [-d MAX_READ_COUNT] [-f MIN_HAPLOTYPE_FREQUENCY]
                        [--max_error MAX_ERROR] [-p PROCESSES]
                        [--memory_efficient]
                        genome borders alignments_dir sample_dir [guides]

options:
  -h, --help            show this help message and exit

input and output information.:
  genome                FASTA file with the reference genome sequence.
  borders               GFF file with the coordinates of pairs of Borders that
                        enclose a Window. Must contain NAME=<> in column 9 to
                        denote the Window name.
  alignments_dir        Directory containing BAM and BAM index files. All BAM
                        files should be in the same directory (default current
                        directory)
  sample_dir            Directory containing .fastq files that were mapped
                        onto the reference genome to create the .bam files.
                        The .fastq file names must have the same prefix as the
                        .bam files specified in --dir.
  guides                Optional fasta file containing the sequences from
                        gRNAs used in CRISPR genome editing. Useful when
                        primers against the delivery vector are included in
                        the HiPlex amplicon mixture. In multiplex setting,
                        this list of sequences can be used to identify exactly
                        which gRNA(s) were used in the CRISPR-Cas/gRNA
                        delivery vector.
  --write_sorted_sequences
                        Write .fastq files containing the reads for each
                        Window in a separate file per input sample.
  -o OUT, --out OUT     Basename of the output file without extension
                        (default: "").

Discrete calls options:
  Use thresholds to transform haplotype frequencies into discrete calls
  using fixed intervals. The assigned intervals are indicated by a running
  integer. This is only informative for individual samples and not for Pool-
  Seq data.

  -e {dominant,dosage}, --discrete_calls {dominant,dosage}
                        Set to "dominant" to transform haplotype frequency
                        values into presence(1)/absence(0) calls per allele,
                        or "dosage" to indicate the allele copy number.
  -i FREQUENCY_BOUNDS [FREQUENCY_BOUNDS ...], --frequency_interval_bounds FREQUENCY_BOUNDS [FREQUENCY_BOUNDS ...]
                        Frequency interval bounds for transforming haplotype
                        frequencies into discrete calls. Custom thresholds can
                        be defined by passing one or more space-separated
                        values (relative frequencies in percentage). For
                        dominant calling, one value should be specified. For
                        dosage calling, an even total number of four or more
                        thresholds should be specified. Default values are
                        invoked by passing either "diploid" or "tetraploid".
                        The default value for dominant calling (see
                        discrete_calls argument) is 10, both for "diploid" and
                        "tetraploid". For dosage calling, the default for
                        diploids is "10, 10, 90, 90" and for tetraploids
                        "12.5, 12.5, 37.5, 37.5, 62.5, 62.5, 87.5, 87.5".
  -z DOSAGE_FILTER, --dosage_filter DOSAGE_FILTER
                        Mask dosage calls in the loci for which the total
                        allele count for a given locus at a given sample
                        differs from the defined value. For example, in
                        diploid organisms the total allele copy number must be
                        2, and in tetraploids the total allele copy number
                        must be 4. (default no filtering).
  --locus_correctness LOCUS_CORRECTNESS_FILTER
                        Create a new .gff file defining only the loci that
                        were correctly dosage called (-z) in at least the
                        defined percentage of samples.

Graphical output options:
  --plot {all,summary,nothing}
                        Select which plots are generated. Choosing "nothing"
                        disables plot generation. Passing "summary" only
                        generates graphs with information for all samples,
                        while "all" will also generate per-sample plots
                        [default "summary"].
  -t {png,pdf}, --plot_type {png,pdf}
                        Choose the file type for the plots [png].

File formatting options:
  -m MASK_FREQUENCY, --mask_frequency MASK_FREQUENCY
                        Mask haplotype frequency values below MASK_FREQUENCY
                        for individual samples to remove noise from the final
                        output. Haplotype frequency values below
                        MASK_FREQUENCY are set to UNDEFINED_REPRESENTATION
                        (see -u). Haplotypes are not removed based on this
                        value, use '--min_haplotype_frequency' for this
                        purpose instead.
  -u UNDEFINED_REPRESENTATION, --undefined_representation UNDEFINED_REPRESENTATION
                        Value to use for non-existing or masked data [NaN].

Filtering options:
  -q MINIMUM_MAPPING_QUALITY, --min_mapping_quality MINIMUM_MAPPING_QUALITY
                        Minimum bam mapping quality to retain reads for
                        analysis [30].
  -j MIN_DISTINCT_HAPLOTYPES, --min_distinct_haplotypes MIN_DISTINCT_HAPLOTYPES
                        Minimal number of distinct haplotypes per locus across
                        all samples. Loci that do not fit this criterium are
                        removed from the final output [0].
  -k MAX_DISTINCT_HAPLOTYPES, --max_distinct_haplotypes MAX_DISTINCT_HAPLOTYPES
                        Maximal number of distinct haplotypes per locus across
                        all samples. Loci that do not fit this criterium are
                        removed from the final output [inf].
  -c MIN_READ_COUNT, --min_read_count MIN_READ_COUNT
                        Minimal total number of reads for a locus in each
                        sample [0].
  -d MAX_READ_COUNT, --max_read_count MAX_READ_COUNT
                        Maximal number of reads per locus per sample, read
                        depth is calculated after filtering out the low
                        frequency haplotypes (-f) [inf].
  -f MIN_HAPLOTYPE_FREQUENCY, --min_haplotype_frequency MIN_HAPLOTYPE_FREQUENCY
                        Minimal haplotype frequency (in %) to retain the
                        haplotype in the genotyping table. If in at least one
                        sample the haplotype frequency is above
                        MIN_HAPLOTYPE_FREQUENCY, the haplotype is retained.
                        Haplotypes for which MIN_HAPLOTYPE_FREQUENCY is never
                        reached in any of the samples are removed [0].
  --max_error MAX_ERROR
                        The maximum error rate (between 0 and 1; but not
                        exactly 1) for finding the border sequences in the
                        reads.

System resources:
  -p PROCESSES, --processes PROCESSES
                        Number of parallel processes [1].
  --memory_efficient    Reduces the memory load significantly, but increases
                        time to calculate results.
```

## ngs-smap_smap_effect-prediction

### Tool Description
Predict the effect of CRISPR-Cas haplotypes on the protein from a SMAP haplotype-window frequency table.

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/truttink/smap
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-smap/overview
- **Validation**: PASS

### Original Help Text
```text
00:19:44
2026-10-11 00:19:45,184 root - INFO: This is SMAP 5.0.1
usage: effect-prediction [-h] [-a LOCAL_GFF_FILE] [--debug] [-u GRNAS] [-g]
                         [-p {CAS9} | -f CAS_OFFSET] [-s CUT_SITE_RANGE]
                         [-r CUT_SITE_RANGE_LOWER] [-c CPU]
                         [--match_score MATCH_SCORE]
                         [--mismatch_penalty MISMATCH_PENALTY]
                         [--gap_open_penalty GAP_OPEN_PENALTY]
                         [--gap_extension GAP_EXTENSION]
                         [-e {dominant,dosage}]
                         [-i FREQUENCY_BOUNDS [FREQUENCY_BOUNDS ...]]
                         [--disable_protein_prediction] [-t EFFECT_THRESHOLD]
                         frequency_table genome borders

options:
  -h, --help            show this help message and exit

Input and output information:
  frequency_table       Tab-delimited file containing haplotype frequencies
                        per locus, as generated by SMAP haplotype-window.
  genome                Reference genome sequence (in .fasta format) onto
                        which the .fastq files were mapped.
  borders               .gff file containing the border coordinates, must
                        contain NAME=<> in column 9.
  -a LOCAL_GFF_FILE, --gene_annotation LOCAL_GFF_FILE
                        .gff file containing the gene and CDS annotation. Must
                        be provided unless you use
                        --disable_protein_prediction.
  --debug               Enable verbose logging.

gRNA information:
  -u GRNAS, --gRNAs GRNAS
                        .gff file containing the gRNA coordinates, must
                        contain NAME=<> in column 9.
  -g, --no_gRNA_relative_naming
                        .gff file containing the gRNA coordinates, must
                        contain NAME=<> in column 9.
  -p {CAS9}, --cas_protein {CAS9}
                        Name of the nucluease used in the experiment. Used to
                        select a predefined offset.
  -f CAS_OFFSET, --cas_offset CAS_OFFSET
                        Cas offset

Filtering parameters:
  -s CUT_SITE_RANGE, --cut_site_range_upper_bound CUT_SITE_RANGE
                        Upper bound for selecting variations from a range
                        around the cut site. Defined in the direction from the
                        cut-site towards the PAM.
  -r CUT_SITE_RANGE_LOWER, --cut_site_range_lower_bound CUT_SITE_RANGE_LOWER
                        Lower bound for selecting variations from the a range
                        around the cut site. Defined in the direction from the
                        cut-site towards the start of the gRNA binding site.

System resources:
  -c CPU, --cpu CPU     Maximum number of allowed processes.

Alignment parameters:
  Define the parameters to align the haplotype sequences to the reference
  sequence.

  --match_score MATCH_SCORE
  --mismatch_penalty MISMATCH_PENALTY
  --gap_open_penalty GAP_OPEN_PENALTY
  --gap_extension GAP_EXTENSION

Discrete calls options:
  Use thresholds to transform haplotype frequencies into discrete calls
  using fixed intervals. The assigned intervals are indicated by a running
  integer. This is only informative for individual samples and not for Pool-
  Seq data.

  -e {dominant,dosage}, --discrete_calls {dominant,dosage}
                        Set to "dominant" to transform haplotype frequency
                        values into presence(1)/absence(0) calls per allele,
                        or "dosage" to indicate the allele copy number.
  -i FREQUENCY_BOUNDS [FREQUENCY_BOUNDS ...], --frequency_interval_bounds FREQUENCY_BOUNDS [FREQUENCY_BOUNDS ...]
                        Frequency interval bounds for transforming haplotype
                        frequencies into discrete calls. Custom thresholds can
                        be defined by passing one or more space-separated
                        values (relative frequencies in percentage). For
                        dominant calling, one value should be specified. For
                        dosage calling, an even total number of four or more
                        thresholds should be specified. Default values are
                        invoked by passing either "diploid" or "tetraploid".
                        The default value for dominant calling (see
                        discrete_calls argument) is 10, both for "diploid" and
                        "tetraploid". For dosage calling, the default for
                        diploids is "10, 10, 90, 90" and for tetraploids
                        "12.5, 12.5, 37.5, 37.5, 62.5, 62.5, 87.5, 87.5".

Protein effect prediction:
  --disable_protein_prediction
                        Disable the estimation of the protein from the
                        haplotypes sequences. All variations within range (-s
                        and -r) of the cut-site will be considered as relevant
                        sequence variant with an effect. This option requires
                        --gRNAs.
  -t EFFECT_THRESHOLD, --effect_threshold EFFECT_THRESHOLD
                        Threshold to determine whether a protein is affected
                        by the haplotype variant sequence or not. For each
                        haplotype, a protein identity score is calculated
                        compared to the reference. Haplotypes for which the
                        protein identity is below the effect threshold, will
                        be marked as encoding an affected protein.For
                        instance, a protein with 10% identity to the
                        reference, is below an effect threshold of 50%, and
                        will be marked as loss-of-function (LOF).
```

## ngs-smap_smap_design

### Tool Description
Returns per gene specific amplicons with or without one or more guides

### Metadata
- **Docker Image**: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/truttink/smap
- **Package**: https://anaconda.org/channels/bioconda/packages/ngs-smap/overview
- **Validation**: PASS

### Original Help Text
```text
00:19:40
2026-10-11 00:19:41,559 root - INFO: This is SMAP 5.0.1
usage: smap [-h] [-g GRNAFILE] [-gs GRNASOURCE] [-o OUTPUT]
            [-na NUMBERAMPLICONS] [-ng NUMBERGRNAS]
            [-minl MINIMUMAMPLICONLENGTH] [-maxl MAXIMUMAMPLICONLENGTH]
            [-pmlm PRIMERMAXLIBRARYMISPRIMING]
            [-ppmlm PRIMERPAIRMAXLIBRARYMISPRIMING]
            [-pmtm PRIMERMAXTEMPLATEMISPRIMING]
            [-ppmtm PRIMERPAIRMAXTEMPLATEMISPRIMING] [-hp HOMOPOLYMER] [-smy]
            [-sg SELECTGENES] [-d DISTANCE] [-go GRNAOVERLAP]
            [-ga GENERATEAMPLICONS] [-t THRESHOLD] [-b BORDERLENGTH] [-al]
            [-gl] [-sf] [-tr5 TARGETREGION5] [-tr3 TARGETREGION3] [-v] [-aa]
            [-tsr TARGETSPECIFICREGION] [-mpa] [-rpd] [-prom PROMOTER]
            [-scaf SCAFFOLD] [-db] [-psp PRESELECTEDPRIMERS] [-pT POLYT] [-rs]
            [--version]
            FastaFile GFFfile

Returns per gene specific amplicons with or without one or more guides

positional arguments:
  FastaFile             Path to the Fasta file containing all genes to screen
  GFFfile               Path to the GFF3 file containing at least the CDS
                        feature with positions relative to the fasta file

options:
  -h, --help            show this help message and exit
  -g GRNAFILE, --gRNAfile GRNAFILE
                        CRISPOR, FlashFry or other gRNA design program output
                        file.The CRISPOR and Flashfry file must contain a
                        header and 12 columns. Check the manual for specifics
  -gs GRNASOURCE, --gRNAsource GRNASOURCE
                        What is the source of the gRNA file? Enter "CRISPOR",
                        "FlashFry" or "other" (default = FlashFry)
  -o OUTPUT, --output OUTPUT
                        Name of the output files (default = SMAPdesign)
  -na NUMBERAMPLICONS, --numberAmplicons NUMBERAMPLICONS
                        The maximum number of non-overlapping amplicons per
                        gene in the output (default = 2)
  -ng NUMBERGRNAS, --numbergRNAs NUMBERGRNAS
                        Maximum number of gRNAs to retain per amplicon
                        (default = 2)
  -minl MINIMUMAMPLICONLENGTH, --minimumAmpliconLength MINIMUMAMPLICONLENGTH
                        The minimum length of the amplicons in base pairs
                        (default = 120)
  -maxl MAXIMUMAMPLICONLENGTH, --maximumAmpliconLength MAXIMUMAMPLICONLENGTH
                        The maximum length of the amplicons in base pairs
                        (default = 150)
  -pmlm PRIMERMAXLIBRARYMISPRIMING, --primerMaxLibraryMispriming PRIMERMAXLIBRARYMISPRIMING
                        The maximum allowed weighted similarity of a primer
                        with any sequence in the target gene set (Primer3
                        setting) (dault = 12)
  -ppmlm PRIMERPAIRMAXLIBRARYMISPRIMING, --primerPairMaxLibraryMispriming PRIMERPAIRMAXLIBRARYMISPRIMING
                        The maximum allowed sum of similarities of a primer
                        pair (one similarity for each primer) with any single
                        sequence in the target gene set (Primer3 setting)
                        (default = 24)
  -pmtm PRIMERMAXTEMPLATEMISPRIMING, --primerMaxTemplateMispriming PRIMERMAXTEMPLATEMISPRIMING
                        The maximum allowed similarity of a primer to ectopic
                        sites in the template (Primer3 setting) (default = 12)
  -ppmtm PRIMERPAIRMAXTEMPLATEMISPRIMING, --primerPairMaxTemplateMispriming PRIMERPAIRMAXTEMPLATEMISPRIMING
                        The maximum allowed summed similarity of both primers
                        to ectopic sites in the template (Primer3 setting)
                        (default = 24)
  -hp HOMOPOLYMER, --homopolymer HOMOPOLYMER
                        The minimum number of repeated identical nucleotides
                        in an amplicon to be discarded. E.g. if this parameter
                        is set to 8, amplicons containing a polymer of 8 As
                        (-...AAAAAAAA...-), Ts, Gs, or Cs or more will not be
                        used (default = 10)
  -smy, --summary       Write summary file and plot of the output
  -sg SELECTGENES, --selectGenes SELECTGENES
                        List of genes (one per line) to which amplicons and
                        guides must be designed. The other genes in the fasta
                        file will be used to check for specificity only
                        (default: for all genes in the fasta the design is
                        done)
  -d DISTANCE, --distance DISTANCE
                        Minimum number of bases between primer and gRNA
                        (default = 15)
  -go GRNAOVERLAP, --gRNAoverlap GRNAOVERLAP
                        The minimum number of bases between the start of two
                        gRNAs (default = 5)
  -ga GENERATEAMPLICONS, --generateAmplicons GENERATEAMPLICONS
                        Number of amplicons to generate per gene by Primer3
                        (default = 150). To generate 50 amplicons per 1000
                        bases per gene enter -1
  -t THRESHOLD, --threshold THRESHOLD
                        Minimum gRNA MIT score allowed (default = 80)
  -b BORDERLENGTH, --borderLength BORDERLENGTH
                        The length of the borders (for SMAP haplotype window)
                        (default = 10)
  -al, --ampliconLabel  Number the amplicons from left to right instead of
                        from best to worst
  -gl, --gRNAlabel      Number the gRNAs from left to right instead of from
                        best to worst
  -sf, --SMAPfiles      Write additional files for downstream analysis with
                        other SMAP packages (a gff and bed border files and
                        fasta gRNA file
  -tr5 TARGETREGION5, --targetRegion5 TARGETREGION5
                        The fraction of the coding sequence that cannot be
                        targeted at the 5' end as indicated by a float between
                        0 and 1 (default = 0.2)
  -tr3 TARGETREGION3, --targetRegion3 TARGETREGION3
                        The fraction of the coding sequence that cannot be
                        targeted at the 3' end as indicated by a float between
                        0 and 1 (default = 0.2)
  -v, --verbose         Keep track of the primer design while the program is
                        running
  -aa, --allAmplicons   Return all amplicons with their respective gRNAs per
                        gene (extra file)
  -tsr TARGETSPECIFICREGION, --targetSpecificRegion TARGETSPECIFICREGION
                        Only target a specific region in the gene indicated by
                        the feature name in the GFF file
  -mpa, --misPrimingAllowed
                        Do not check for mispriming in the gene set when
                        designing primers. By default Primer3 will not allow
                        primers that can prime at other genes in the gene set
  -rpd, --restrictPrimerDesign
                        This option will restrict primer design in large
                        introns, increasing the speed of amplicon design.
  -prom PROMOTER, --promoter PROMOTER
                        Give the last 6 bases of the promoter that will be
                        used to express the gRNA. This will be taken into
                        account when checking for BsaI or BbsI sites in the
                        gRNA (default: U6 promoter = TGATTG)
  -scaf SCAFFOLD, --scaffold SCAFFOLD
                        Give the first 6 bases of the scaffold that will be
                        used. This will be taken into account when checking
                        for BsaI or BbsI sites in the gRNA (default = GTTTTA)
  -db, --debug          Give a gff file with all amplicons designed by Primer3
                        and all gRNAs before filtering
  -psp PRESELECTEDPRIMERS, --preSelectedPrimers PRESELECTEDPRIMERS
                        Give a set of amplicons/primers for which you want to
                        find gRNAs. The primers should be given in a gff with
                        featurenames Primer_forward and Primer_reverse. The
                        forward primer should be occur before the
                        corresponding reverse primer in the gff file
  -pT POLYT, --polyT POLYT
                        Minimum number of repeated Ts (in a poly-T) in the
                        gRNA to avoid (default = 4)
  -rs, --restrictionSite
                        Do not filter out gRNAs that contain a BsaI or BbsI
                        restriction site
  --version             version of SMAP design
```

## Metadata
- **Skill**: generated
