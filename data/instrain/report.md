# instrain CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| instrain_compare | PASS |  |
| instrain_filter_reads | PASS |  |
| instrain_genome_wide | PASS |  |
| instrain_parse_annotations | PASS | synthetic data: the gene annotation table is made up (real gene IDs, invented K numbers); the profile is real |
| instrain_plot | PASS |  |
| instrain_profile | PASS |  |
| instrain_profile_genes | PASS |  |
| instrain_quick_profile | Failed | image problem: coverm is not installed in the image, so inStrain quick_profile stops with Cannot find coverm and writes nothing |

## instrain_profile

### Tool Description
Create an inStrain profile (microdiversity analysis) from a mapping file

### Metadata
- **Docker Image**: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
- **Homepage**: https://github.com/MrOlm/inStrain
- **Package**: https://anaconda.org/channels/bioconda/packages/instrain/overview
- **Validation**: PASS

### Original Help Text
```text
usage: inStrain profile [-o OUTPUT] [--use_full_fasta_header]
                        [--force_compress] [-p PROCESSES] [-d] [-h]
                        [--version] [-l MIN_READ_ANI] [--min_mapq MIN_MAPQ]
                        [--max_insert_relative MAX_INSERT_RELATIVE]
                        [--min_insert MIN_INSERT]
                        [--pairing_filter {paired_only,non_discordant,all_reads}]
                        [--priority_reads PRIORITY_READS]
                        [--maximum_reads MAXIMUM_READS]
                        [--detailed_mapping_info] [-c MIN_COV] [-f MIN_FREQ]
                        [-fdr FDR] [-g GENE_FILE] [-s [STB [STB ...]]]
                        [--mm_level] [--skip_mm_profiling] [--database_mode]
                        [--min_scaffold_reads MIN_SCAFFOLD_READS]
                        [--min_genome_coverage MIN_GENOME_COVERAGE]
                        [--min_snp MIN_SNP] [--store_everything]
                        [--scaffolds_to_profile SCAFFOLDS_TO_PROFILE]
                        [--rarefied_coverage RAREFIED_COVERAGE]
                        [--window_length WINDOW_LENGTH] [--skip_genome_wide]
                        [--skip_plot_generation]
                        bam fasta

REQUIRED:
  bam                   Sorted .bam file
  fasta                 Fasta file the bam is mapped to

I/O PARAMETERS:
  -o OUTPUT, --output OUTPUT
                        Output prefix (default: inStrain)
  --use_full_fasta_header
                        Instead of using the fasta ID (space in header before
                        space), use the full header. Needed for some mapping
                        tools (including bbMap) (default: False)
  --force_compress      Force compression of all output files (default: False)

SYSTEM PARAMETERS:
  -p PROCESSES, --processes PROCESSES
                        Number of processes to use (default: 6)
  -d, --debug           Make extra debugging output (default: False)
  -h, --help            show this help message and exit
  --version             show program's version number and exit

READ FILTERING OPTIONS:
  -l MIN_READ_ANI, --min_read_ani MIN_READ_ANI
                        Minimum percent identity of read pairs to consensus to
                        use the reads. Must be >, not >= (default: 0.95)
  --min_mapq MIN_MAPQ   Minimum mapq score of EITHER read in a pair to use
                        that pair. Must be >, not >= (default: -1)
  --max_insert_relative MAX_INSERT_RELATIVE
                        Multiplier to determine maximum insert size between
                        two reads - default is to use 3x median insert size.
                        Must be >, not >= (default: 3)
  --min_insert MIN_INSERT
                        Minimum insert size between two reads - default is 50
                        bp. If two reads are 50bp each and overlap completely,
                        their insert will be 50. Must be >, not >= (default:
                        50)
  --pairing_filter {paired_only,non_discordant,all_reads}
                        How should paired reads be handled?
                        paired_only = Only paired reads are retained
                        non_discordant = Keep all paired reads and singleton reads that map to a single scaffold
                        all_reads = Keep all reads regardless of pairing status (NOT RECOMMENDED; See documentation for deatils)
                         (default: paired_only)
  --priority_reads PRIORITY_READS
                        The location of a list of reads that should be
                        retained regardless of pairing status (for example
                        long reads or merged reads). This can be a .fastq file
                        or text file with list of read names (will assume file
                        is compressed if ends in .gz (default: None)
  --maximum_reads MAXIMUM_READS
                        Maximum number of reads. Requires sambamba to do the
                        subsetting. (default: None)

READ OUTPUT OPTIONS:
  --detailed_mapping_info
                        Make a detailed read report indicating deatils about
                        each individual mapped read (default: False)

VARIANT CALLING OPTIONS:
  -c MIN_COV, --min_cov MIN_COV
                        Minimum coverage to call an variant (default: 5)
  -f MIN_FREQ, --min_freq MIN_FREQ
                        Minimum SNP frequency to confirm a SNV (both this AND
                        the FDR snp count cutoff must be true to call a SNP).
                        (default: 0.05)
  -fdr FDR, --fdr FDR   SNP false discovery rate- based on simulation data
                        with a 0.1 percent error rate (Q30) (default: 1e-06)

GENE PROFILING OPTIONS:
  -g GENE_FILE, --gene_file GENE_FILE
                        Path to prodigal .fna genes file. If file ends in .gb
                        or .gbk, will treat as a genbank file (EXPERIMENTAL;
                        the name of the gene must be in the gene qualifier)
                        (default: None)

GENOME WIDE OPTIONS:
  -s [STB [STB ...]], --stb [STB [STB ...]]
                        Scaffold to bin. This can be a file with each line
                        listing a scaffold and a bin name, tab-seperated. This
                        can also be a space-seperated list of .fasta files,
                        with one genome per .fasta file. If nothing is
                        provided, all scaffolds will be treated as belonging
                        to the same genome (default: [])

READ ANI OPTIONS:
  --mm_level            Create output files on the mm level (see documentation
                        for info) (default: False)
  --skip_mm_profiling   Dont perform analysis on an mm level; saves RAM and
                        time; impacts plots and raw_data (default: False)

PROFILE OPTIONS:
  --database_mode       Set a number of parameters to values appropriate for
                        mapping to a large fasta file. Will set:
                        --min_read_ani 0.92 --skip_mm_profiling
                        --min_genome_coverage 1 (default: False)
  --min_scaffold_reads MIN_SCAFFOLD_READS
                        Minimum number of reads mapping to a scaffold to
                        proceed with profiling it (default: 1)
  --min_genome_coverage MIN_GENOME_COVERAGE
                        Minimum number of reads mapping to a genome to proceed
                        with profiling it. MUST profile .stb if this is set
                        (default: 0)
  --min_snp MIN_SNP     Absolute minimum number of reads connecting two SNPs
                        to calculate LD between them. (default: 20)
  --store_everything    Store intermediate dictionaries in the pickle file;
                        will result in significantly more RAM and disk usage
                        (default: False)
  --scaffolds_to_profile SCAFFOLDS_TO_PROFILE
                        Path to a file containing a list of scaffolds to
                        profile- if provided will ONLY profile those scaffolds
                        (default: None)
  --rarefied_coverage RAREFIED_COVERAGE
                        When calculating nucleotide diversity, also calculate
                        a rarefied version with this much coverage (default:
                        50)
  --window_length WINDOW_LENGTH
                        Break scaffolds into windows of this length when
                        profiling (default: 10000)

OTHER  OPTIONS:
  --skip_genome_wide    Do not generate tables that consider groups of
                        scaffolds belonging to genomes (default: False)
  --skip_plot_generation
                        Do not make plots (default: False)
```

## instrain_compare

### Tool Description
Compare multiple inStrain profiles (popANI, coverage_overlap, etc.)

### Metadata
- **Docker Image**: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
- **Homepage**: https://github.com/MrOlm/inStrain
- **Package**: https://anaconda.org/channels/bioconda/packages/instrain/overview
- **Validation**: PASS

### Original Help Text
```text
usage: inStrain compare -i [INPUT [INPUT ...]] [-o OUTPUT] [-p PROCESSES] [-d]
                        [-h] [--version] [-s [STB [STB ...]]] [-c MIN_COV]
                        [-f MIN_FREQ] [-fdr FDR] [--database_mode]
                        [--breadth BREADTH] [-sc SCAFFOLDS] [--genome GENOME]
                        [--store_coverage_overlap]
                        [--store_mismatch_locations]
                        [--include_self_comparisons] [--skip_plot_generation]
                        [--group_length GROUP_LENGTH] [--force_compress]
                        [-ani ANI_THRESHOLD] [-cov COVERAGE_TRESHOLD]
                        [--clusterAlg {median,ward,weighted,single,average,complete,centroid}]
                        [-bams [BAMS [BAMS ...]]] [--skip_popANI]

REQUIRED:
  -i [INPUT [INPUT ...]], --input [INPUT [INPUT ...]]
                        A list of inStrain objects, all mapped to the same
                        .fasta file (default: None)
  -o OUTPUT, --output OUTPUT
                        Output prefix (default: instrainComparer)

SYSTEM PARAMETERS:
  -p PROCESSES, --processes PROCESSES
                        Number of processes to use (default: 6)
  -d, --debug           Make extra debugging output (default: False)
  -h, --help            show this help message and exit
  --version             show program's version number and exit

GENOME WIDE OPTIONS:
  -s [STB [STB ...]], --stb [STB [STB ...]]
                        Scaffold to bin. This can be a file with each line
                        listing a scaffold and a bin name, tab-seperated. This
                        can also be a space-seperated list of .fasta files,
                        with one genome per .fasta file. If nothing is
                        provided, all scaffolds will be treated as belonging
                        to the same genome (default: [])

VARIANT CALLING OPTIONS:
  -c MIN_COV, --min_cov MIN_COV
                        Minimum coverage to call an variant (default: 5)
  -f MIN_FREQ, --min_freq MIN_FREQ
                        Minimum SNP frequency to confirm a SNV (both this AND
                        the FDR snp count cutoff must be true to call a SNP).
                        (default: 0.05)
  -fdr FDR, --fdr FDR   SNP false discovery rate- based on simulation data
                        with a 0.1 percent error rate (Q30) (default: 1e-06)

DATABASE MODE PARAMETERS:
  --database_mode       Using the parameters below, automatically determine
                        which genomes are present in each Profile and only
                        compare scaffolds from those genomes. All profiles
                        must have run Profile with the same .stb (default:
                        False)
  --breadth BREADTH     Minimum breadth_minCov required to count a genome
                        present (default: 0.5)

OTHER OPTIONS:
  -sc SCAFFOLDS, --scaffolds SCAFFOLDS
                        Location to a list of scaffolds to compare. You can
                        also make this a .fasta file and it will load the
                        scaffold names (default: None)
  --genome GENOME       Run scaffolds belonging to this single genome only.
                        Must provide an .stb file (default: None)
  --store_coverage_overlap
                        Also store coverage overlap on an mm level (default:
                        False)
  --store_mismatch_locations
                        Store the locations of SNPs (default: False)
  --include_self_comparisons
                        Also compare IS profiles against themself (default:
                        False)
  --skip_plot_generation
                        Dont create plots at the end of the run. (default:
                        False)
  --group_length GROUP_LENGTH
                        How many bp to compare simultaneously (higher will use
                        more RAM and run more quickly) (default: 10000000)
  --force_compress      Force compression of all output files (default: False)

GENOME CLUSTERING OPTIONS:
  -ani ANI_THRESHOLD, --ani_threshold ANI_THRESHOLD
                        popANI threshold to cluster genomes at. Must provide
                        .stb file to do so (default: 0.99999)
  -cov COVERAGE_TRESHOLD, --coverage_treshold COVERAGE_TRESHOLD
                        Minimum percent_genome_compared for a genome
                        comparison to count; if below the popANI will be set
                        to 0. (default: 0.1)
  --clusterAlg {median,ward,weighted,single,average,complete,centroid}
                        Algorithm used to cluster genomes (passed to
                        scipy.cluster.hierarchy.linkage) (default: average)

SNV POOLING OPTIONS:
  -bams [BAMS [BAMS ...]], --bams [BAMS [BAMS ...]]
                        Location of .bam files used during inStrain profile
                        commands; needed to pull low-frequency SNVs. MUST BE
                        IN SAME ORDER AS THE INPUT FILES (default: None)
  --skip_popANI         Only run SNV Pooling; skip other compare operations
                        (default: False)
```

## instrain_parse_annotations

### Tool Description
Run a number of outputs based a table of gene annotations

### Metadata
- **Docker Image**: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
- **Homepage**: https://github.com/MrOlm/inStrain
- **Package**: https://anaconda.org/channels/bioconda/packages/instrain/overview
- **Validation**: PASS

### Original Help Text
```text
usage: inStrain parse_annotations -i [INPUT [INPUT ...]] -a
                                  [ANNOTATIONS [ANNOTATIONS ...]] [-o OUTPUT]
                                  [-p PROCESSES] [-d] [-h] [--version]
                                  [-b MIN_GENOME_BREADTH]
                                  [-g MIN_GENE_BREADTH] [--store_rawdata]

REQUIRED:
  -i [INPUT [INPUT ...]], --input [INPUT [INPUT ...]]
                        A list of inStrain objects, all mapped to the same
                        .fasta file (default: None)
  -a [ANNOTATIONS [ANNOTATIONS ...]], --annotations [ANNOTATIONS [ANNOTATIONS ...]]
                        A table or set of tables with gene annotations.
                        Must be be a .csv file with two columns- `gene` and `anno`. See inStrain documentation for details
                        (https://instrain.readthedocs.io/en/latest/user_manual.html#parse-annotations) (default: None)
  -o OUTPUT, --output OUTPUT
                        Output prefix (default: annotation_output)

SYSTEM PARAMETERS:
  -p PROCESSES, --processes PROCESSES
                        Number of processes to use (default: 6)
  -d, --debug           Make extra debugging output (default: False)
  -h, --help            show this help message and exit
  --version             show program's version number and exit

OTHER OPTIONS:
  -b MIN_GENOME_BREADTH, --min_genome_breadth MIN_GENOME_BREADTH
                        Only annotate genomes on genomes with at least this
                        genome breadth. Requires having genomes called. Set to
                        0 to include all genes. (default: 0.5)
  -g MIN_GENE_BREADTH, --min_gene_breadth MIN_GENE_BREADTH
                        Only annotate genes with at least this breadth. Set to
                        0 to include all genes. (default: 0.8)
  --store_rawdata       Store the raw data dictionary (default: False)
```

## instrain_plot

### Tool Description
Make figures from the results of profile or compare

### Metadata
- **Docker Image**: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
- **Homepage**: https://github.com/MrOlm/inStrain
- **Package**: https://anaconda.org/channels/bioconda/packages/instrain/overview
- **Validation**: PASS

### Original Help Text
```text
usage: inStrain plot -i IS [-pl [PLOTS [PLOTS ...]]] [-mb MINIMUM_BREADTH]
                     [-g [GENOMES [GENOMES ...]]] [-p PROCESSES] [-d] [-h]
                     [--version]

REQUIRED:
  -i IS, --IS IS        an inStrain profile object (default: None)
  -pl [PLOTS [PLOTS ...]], --plots [PLOTS [PLOTS ...]]
                        Plots. Input 'all' or 'a' to plot all
                        1) Coverage and breadth vs. read mismatches
                        2) Genome-wide microdiversity metrics
                        3) Read-level ANI distribution
                        4) Major allele frequencies
                        5) Linkage decay
                        6) Read filtering plots
                        7) Scaffold inspection plot (large)
                        8) Linkage with SNP type (GENES REQUIRED)
                        9) Gene histograms (GENES REQUIRED)
                        10) Compare dendrograms (RUN ON COMPARE; NOT PROFILE)
                         (default: a)

OPTIONAL FIGURE ADJUSTMENTS:
  -mb MINIMUM_BREADTH, --minimum_breadth MINIMUM_BREADTH
                        Minimum breadth of coverage for genome to make it into
                        plot (from 0-1). (default: 0.5)
  -g [GENOMES [GENOMES ...]], --genomes [GENOMES [GENOMES ...]]
                        Only plot genomes with the names provided in this
                        argument (default: None)

SYSTEM PARAMETERS:
  -p PROCESSES, --processes PROCESSES
                        Number of processes to use (default: 6)
  -d, --debug           Make extra debugging output (default: False)
  -h, --help            show this help message and exit
  --version             show program's version number and exit
```

## instrain_quick_profile

### Tool Description
Quickly calculate coverage and breadth of a mapping using coverM

### Metadata
- **Docker Image**: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
- **Homepage**: https://github.com/MrOlm/inStrain
- **Package**: https://anaconda.org/channels/bioconda/packages/instrain/overview
- **Validation**: PASS

### Original Help Text
```text
usage: inStrain quick_profile [-p PROCESSES] [-d] [-h] [--version]
                              [-s [STB [STB ...]]] [-o OUTPUT]
                              [--breadth_cutoff BREADTH_CUTOFF]
                              [--stringent_breadth_cutoff STRINGENT_BREADTH_CUTOFF]
                              bam fasta

REQUIRED:
  bam                   Sorted .bam file
  fasta                 Fasta file the bam is mapped to

SYSTEM PARAMETERS:
  -p PROCESSES, --processes PROCESSES
                        Number of processes to use (default: 6)
  -d, --debug           Make extra debugging output (default: False)
  -h, --help            show this help message and exit
  --version             show program's version number and exit

OTHER OPTIONS:
  -s [STB [STB ...]], --stb [STB [STB ...]]
                        Scaffold to bin. This can be a file with each line
                        listing a scaffold and a bin name, tab-seperated. This
                        can also be a space-seperated list of .fasta files,
                        with one genome per .fasta file. If nothing is
                        provided, all scaffolds will be treated as belonging
                        to the same genome (default: [])
  -o OUTPUT, --output OUTPUT
                        Output prefix (default: QuickProfile)
  --breadth_cutoff BREADTH_CUTOFF
                        Minimum genome breadth to pull scaffolds (default:
                        0.5)
  --stringent_breadth_cutoff STRINGENT_BREADTH_CUTOFF
                        Minimum breadth to let scaffold into coverm raw
                        results (done with greater than; NOT greater than or
                        equal to) (default: 0.0)
```

## instrain_filter_reads

### Tool Description
Commands related to filtering reads from .bam files

### Metadata
- **Docker Image**: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
- **Homepage**: https://github.com/MrOlm/inStrain
- **Package**: https://anaconda.org/channels/bioconda/packages/instrain/overview
- **Validation**: PASS

### Original Help Text
```text
usage: inStrain filter_reads [-o OUTPUT] [-p PROCESSES] [-d] [-h] [--version]
                             [-l MIN_READ_ANI] [--min_mapq MIN_MAPQ]
                             [--max_insert_relative MAX_INSERT_RELATIVE]
                             [--min_insert MIN_INSERT]
                             [--pairing_filter {non_discordant,all_reads,paired_only}]
                             [--priority_reads PRIORITY_READS]
                             [--maximum_reads MAXIMUM_READS]
                             [--detailed_mapping_info]
                             bam fasta

REQUIRED:
  bam                   Sorted .bam file
  fasta                 Fasta file the bam is mapped to
  -o OUTPUT, --output OUTPUT
                        Location of folder to store read report(s) (default:
                        None)

SYSTEM PARAMETERS:
  -p PROCESSES, --processes PROCESSES
                        Number of processes to use (default: 6)
  -d, --debug           Make extra debugging output (default: False)
  -h, --help            show this help message and exit
  --version             show program's version number and exit

READ FILTERING OPTIONS:
  -l MIN_READ_ANI, --min_read_ani MIN_READ_ANI
                        Minimum percent identity of read pairs to consensus to
                        use the reads. Must be >, not >= (default: 0.95)
  --min_mapq MIN_MAPQ   Minimum mapq score of EITHER read in a pair to use
                        that pair. Must be >, not >= (default: -1)
  --max_insert_relative MAX_INSERT_RELATIVE
                        Multiplier to determine maximum insert size between
                        two reads - default is to use 3x median insert size.
                        Must be >, not >= (default: 3)
  --min_insert MIN_INSERT
                        Minimum insert size between two reads - default is 50
                        bp. If two reads are 50bp each and overlap completely,
                        their insert will be 50. Must be >, not >= (default:
                        50)
  --pairing_filter {non_discordant,all_reads,paired_only}
                        How should paired reads be handled?
                        paired_only = Only paired reads are retained
                        non_discordant = Keep all paired reads and singleton reads that map to a single scaffold
                        all_reads = Keep all reads regardless of pairing status (NOT RECOMMENDED; See documentation for deatils)
                         (default: paired_only)
  --priority_reads PRIORITY_READS
                        The location of a list of reads that should be
                        retained regardless of pairing status (for example
                        long reads or merged reads). This can be a .fastq file
                        or text file with list of read names (will assume file
                        is compressed if ends in .gz (default: None)
  --maximum_reads MAXIMUM_READS
                        Maximum number of reads. Requires sambamba to do the
                        subsetting. (default: None)

READ OUTPUT OPTIONS:
  --detailed_mapping_info
                        Make a detailed read report indicating deatils about
                        each individual mapped read (default: False)
```

## instrain_profile_genes

### Tool Description
Add gene-level profiling to an existing inStrain profile

### Metadata
- **Docker Image**: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
- **Homepage**: https://github.com/MrOlm/inStrain
- **Package**: https://anaconda.org/channels/bioconda/packages/instrain/overview
- **Validation**: PASS

### Original Help Text
```text
usage: inStrain profile_genes [-g GENE_FILE] -i IS [--store_everything]
                              [-p PROCESSES] [-d] [-h] [--version]

GENE PROFILING OPTIONS:
  -g GENE_FILE, --gene_file GENE_FILE
                        Path to prodigal .fna genes file. If file ends in .gb
                        or .gbk, will treat as a genbank file (EXPERIMENTAL;
                        the name of the gene must be in the gene qualifier)
                        (default: None)

INPUT / OUTPUT:
  -i IS, --IS IS        an inStrain profile object (default: None)
  --store_everything    Store gene sequences in the IS object (default: False)

SYSTEM PARAMETERS:
  -p PROCESSES, --processes PROCESSES
                        Number of processes to use (default: 6)
  -d, --debug           Make extra debugging output (default: False)
  -h, --help            show this help message and exit
  --version             show program's version number and exit
```

## instrain_genome_wide

### Tool Description
Add genome-wide tables to an existing inStrain profile

### Metadata
- **Docker Image**: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
- **Homepage**: https://github.com/MrOlm/inStrain
- **Package**: https://anaconda.org/channels/bioconda/packages/instrain/overview
- **Validation**: PASS

### Original Help Text
```text
usage: inStrain genome_wide [-s [STB [STB ...]]] -i IS [--store_everything]
                            [--mm_level] [--skip_mm_profiling] [-p PROCESSES]
                            [-d] [-h] [--version]

GENOME WIDE OPTIONS:
  -s [STB [STB ...]], --stb [STB [STB ...]]
                        Scaffold to bin. This can be a file with each line
                        listing a scaffold and a bin name, tab-seperated. This
                        can also be a space-seperated list of .fasta files,
                        with one genome per .fasta file. If nothing is
                        provided, all scaffolds will be treated as belonging
                        to the same genome (default: [])

INPUT / OUTPUT:
  -i IS, --IS IS        an inStrain profile object (default: None)
  --store_everything    Store gene sequences in the IS object (default: False)

READ ANI OPTIONS:
  --mm_level            Create output files on the mm level (see documentation
                        for info) (default: False)
  --skip_mm_profiling   Dont perform analysis on an mm level; saves RAM and
                        time; impacts plots and raw_data (default: False)

SYSTEM PARAMETERS:
  -p PROCESSES, --processes PROCESSES
                        Number of processes to use (default: 6)
  -d, --debug           Make extra debugging output (default: False)
  -h, --help            show this help message and exit
  --version             show program's version number and exit
```

