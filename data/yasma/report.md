# yasma CWL Generation Report

## yasma_inputs

### Tool Description
Initialize a project and log inputs for later analyses

### Metadata
- **Docker Image**: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/NateyJay/YASMA
- **Package**: https://anaconda.org/channels/bioconda/packages/yasma/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/yasma/overview
- **Total Downloads**: 83
- **Last updated**: 2025-12-20
- **GitHub**: https://github.com/NateyJay/YASMA
- **Stars**: N/A
### Original Help Text
```text
Usage: yasma inputs [OPTIONS]

  Initialize a project and log inputs for later analyses

Options:
  
  Required: 
    -o, --output_directory TEXT   Directory name for annotation output.
                                  Defaults to the current directory, with this
                                  directory name as the project name.
  
  Inputs which may be logged: 
    -a, --alignment_file TEXT     Alignment file input (bam or cram).
  
  File input parameters: 
    -g, --genome_file TEXT        Genome or assembly which was used for the
                                  original alignment.
    -j, --jbrowse_directory TEXT  A path to a working directory for a jbrowse2
                                  instance.
    -ga, --gene_annotation_file TEXT
                                  Annotation file for genes (gff3) matching
                                  the included genome.
    -tl, --trimmed_libraries TEXT
                                  Path to trimmed libraries. Accepts wildcards
                                  (*).
    -ul, --untrimmed_libraries TEXT
                                  Path to untrimmed libraries. Accepts
                                  wildcards (*).
  
  Other shared parameters: 
    -s, --srrs TEXT               NCBI SRA codes for libraries. These will
                                  almost certainly start with SRR or ERR.
    -c, --conditions TEXT         Values denoting condition groups (sets of
                                  replicate libraries) for projects with
                                  multiple tissues/treatments/genotypes. Can
                                  be entered here as space sparated duplexes,
                                  with the library base_name and condition
                                  groups delimited by a colon. E.g.
                                  SRR1111111:WT SRR1111112:WT SRR1111113:mut
                                  SRR1111114:mut
    -ac, --annotation_conditions TEXT
                                  List of conditions names which will be
                                  included in the annotation. Defaults to use
                                  all libraries, though this is likely not
                                  what you want if you have multiple groups.
    --min_length INTEGER          Minimum allowed size for a trimmed read.
                                  (default 10)
    --max_length INTEGER          Maxiumum allowed size for a trimmed read.
                                  (default 50)
  -h, --help                      Show this message and exit.
```


## yasma_download

### Tool Description
Download libraries from the NCBI SRA using their SRR code

### Metadata
- **Docker Image**: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/NateyJay/YASMA
- **Package**: https://anaconda.org/channels/bioconda/packages/yasma/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yasma download [OPTIONS]

  Download libraries from the NCBI SRA using their SRR code

Options:
  
  Basic options: 
    -s, --srrs TEXT              NCBI SRA codes for libraries. These will
                                 almost certainly start with SRR or ERR.
    -o, --output_directory TEXT  Directory name for annotation output.
                                 Defaults to the current directory, with this
                                 directory name as the project name.
    --include_quals              Download libraries as .fastq format (default
                                 is only .fasta)
    --zipped / --unzipped        Whether to compress downloaded files (default
                                 is uncompressed)
  -h, --help                     Show this message and exit.
```


## yasma_adapter

### Tool Description
Tool to check untrimmed-libraries for 3' adapter content.

### Metadata
- **Docker Image**: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/NateyJay/YASMA
- **Package**: https://anaconda.org/channels/bioconda/packages/yasma/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yasma adapter [OPTIONS]

  Tool to check untrimmed-libraries for 3' adapter content.

Options:
  
  Basic options: 
    -ul, --untrimmed_libraries TEXT
                                  Path to untrimmed libraries. Accepts
                                  wildcards (*).
    -o, --output_directory TEXT   Directory name for annotation output.
                                  Defaults to the current directory, with this
                                  directory name as the project name.
  
  Optional settings: 
    --min_adapter_content FLOAT   Min proportion of reads containing the
                                  adapter, 0.0 to 1.0. Default: 0.1
    -n INTEGER                    Number of reads to check for adapter
                                  (default 10,000)
    --override_pretrim            Ignores flagging a library as pretrimmed if
                                  it has variation in read length and
                                  detectable adapter sequences.
    --override                    Overrides config file changes without
                                  prompting.
  -h, --help                      Show this message and exit.
```


## yasma_trim

### Tool Description
Wrapper for trimming using cutadapt.

### Metadata
- **Docker Image**: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/NateyJay/YASMA
- **Package**: https://anaconda.org/channels/bioconda/packages/yasma/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yasma trim [OPTIONS]

  Wrapper for trimming using cutadapt.

Options:
  
  Basic options: 
    -ul, --untrimmed_libraries TEXT
                                  Path to untrimmed libraries. Accepts
                                  wildcards (*).
    -o, --output_directory TEXT   Directory name for annotation output.
                                  Defaults to the current directory, with this
                                  directory name as the project name.
    -a, --adapter TEXT            Adapter sequence which is meant to be
                                  trimmed.
  
  Trim options: 
    --min_length INTEGER          Minimum allowed size for a trimmed read.
                                  (default 10)
    --max_length INTEGER          Maxiumum allowed size for a trimmed read.
                                  (default 50)
    --cores INTEGER               Number of CPU cores to use. 0 has cutadapt
                                  "autodetect" the number of cores (default 1)
    --cleanup                     Removes download and untrimmed data to save
                                  space
  -h, --help                      Show this message and exit.
```


## yasma_align

### Tool Description
Aligner based on shortstack3-style weighting

### Metadata
- **Docker Image**: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/NateyJay/YASMA
- **Package**: https://anaconda.org/channels/bioconda/packages/yasma/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yasma align [OPTIONS]

  Aligner based on shortstack3-style weighting

Options:
  
  Basic options: 
    -tl, --trimmed_libraries TEXT
                                  Path to trimmed libraries. Accepts wildcards
                                  (*).
    -g, --genome_file TEXT        Genome or assembly which was used for the
                                  original alignment.
    -o, --output_directory TEXT   Directory name for annotation output.
                                  Defaults to the current directory, with this
                                  directory name as the project name.
  
  Bowtie options: 
    --cores INTEGER               Number of cores to use for alignment with
                                  bowtie.
    --max_multi INTEGER           The maximum number of possible mapping sites
                                  for a valid read.
    --max_random INTEGER          Reads with no weighting will be unmapped if
                                  they exceed this number.
    --unique_locality INTEGER     Window size in nucleotides for unique
                                  weighting.
    --offrate INTEGER             Offrate governs the tradeoff betwee disk +
                                  memory impact and speed with bowtie. Lower
                                  is faster, but with higher system
                                  requirements. Bowtie sets this to 5 by
                                  defaut, but yasma chooses 3, assuming higher
                                  memory availability.
  
  Read options: 
    --min_length INTEGER          Minimum allowed size for a trimmed read.
                                  (default 10). This should only come into
                                  effect for pre-trimmed libraries.
    --max_length INTEGER          Maxiumum allowed size for a trimmed read.
                                  (default 50). This should only come into
                                  effect for pre-trimmed libraries.
    --override                    Overrides config file changes without
                                  prompting.
  -h, --help                      Show this message and exit.
```


## yasma_tradeoff

### Tool Description
Annotator using focused capturing the most reads in the least genomic space

### Metadata
- **Docker Image**: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/NateyJay/YASMA
- **Package**: https://anaconda.org/channels/bioconda/packages/yasma/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yasma tradeoff [OPTIONS]

  Annotator using focused capturing the most reads in the least genomic space

Options:
  
  Basic options: 
    -a, --alignment_file TEXT     Alignment file input (bam or cram).
    -o, --output_directory TEXT   Directory name for annotation output.
                                  Defaults to the current directory, with this
                                  directory name as the project name.
    -n, --name TEXT               Optional name for annotation. Useful if
                                  comparing annotations.
    -c, --conditions TEXT         Values denoting condition groups (sets of
                                  replicate libraries) for projects with
                                  multiple tissues/treatments/genotypes. Can
                                  be entered here as space sparated duplexes,
                                  with the library base_name and condition
                                  groups delimited by a colon. E.g.
                                  SRR1111111:WT SRR1111112:WT SRR1111113:mut
                                  SRR1111114:mut
    -ac, --annotation_conditions TEXT
                                  List of conditions names which will be
                                  included in the annotation. Defaults to use
                                  all libraries, though this is likely not
                                  what you want if you have multiple groups.
  
  Coverage options: 
    --coverage_window INTEGER     This is the bandwidth for accumulating read
                                  alignments into coverage, which is used
                                  instead of the normal read length. By
                                  default, this is very large (250 nt),
                                  basically meaning that depth summed across
                                  250 nt windows are used for region
                                  annotation.
    --kernel_window INTEGER       This is a max filter for the coverage, which
                                  extends coverages by a default 250 nt. This
                                  is built-in padding for regions, which will
                                  then be revised to find boundaries.
  
  Peak finding options: 
    -gsf, --genome_scaling_factor FLOAT
  
  Merging options: 
    --merge_dist INTEGER          Distance in nucleotides for which sRNA peaks
                                  should be considered for 'clumping'. Clumped
                                  regions must have sufficient similarity in
                                  sRNA-size profile and strand-preference.
                                  Default 500 nt.
    --merge_strand_similarity FLOAT
                                  Similarity threshold of strand fraction for
                                  clumping two peaks. Difference in fraction
                                  must be smaller than threshold. Default 0.5.
  
  Read options: 
    --min_length INTEGER          An override filter to ignore aligned reads
                                  which are smaller than a min length in locus
                                  calculations.
    --max_length INTEGER          The same as above, but with a max length.
  
  Locus options: 
    --filter_skew / --no_filter_skew
                                  filter highly skewed loci (default: False).
    --max_skew FLOAT              Filter value for loci which are skewed
                                  toward only one sequence in abundance. By
                                  default (0.95), if more than 1 in 20 reads
                                  for a locus are a single sequence, they are
                                  excluded from the annotation.
    --filter_complexity / --no_filter_complexity
                                  filter low complexity loci (default: True)
    --min_complexity INTEGER      Filter value for locus complexity. This is
                                  defined as the minimum number of unique-
                                  reads / 1000 nt (default: 10).
    --filter_abundance / --no_filter_abundance
                                  filter low abundance loci (default: True).
                                  This is meant to remove loci which have not
                                  reached an absolute level of abundance.
    --min_abundance INTEGER       Min reads in a locus (default 50)
    --filter_abundance_density / --no_filter_abundance_density
                                  filter low abundance loci (default: True).
                                  This is meant to remove loci which have not
                                  reached an absolute level of abundance.
    --min_abundance_density INTEGER
                                  Min of (default 100) reads per 1000
                                  nucleotides in a locus.
  
 Other options: 
    -bw, --bigwig                 Write coverage and kernel tracks to bigwig
                                  files. Increases run-time.
    --time_test                   Shows time test statistics for difference
                                  parts of the pipeline.
    --dont_revise_regions         Argument to skip revising regions step.
    --dont_trim_loci              Argument to skip final trim of annotated
                                  loci.
    --debug                       Debug flag
    --test_mode                   test_mode flag
    --override                    Overrides config file changes without
                                  prompting.
  -h, --help                      Show this message and exit.
```


## yasma_count

### Tool Description
Gets counts for all readgroups, loci, strand, and sizes.

### Metadata
- **Docker Image**: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/NateyJay/YASMA
- **Package**: https://anaconda.org/channels/bioconda/packages/yasma/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yasma count [OPTIONS]

  Gets counts for all readgroups, loci, strand, and sizes.

Options:
  
  Basic options: 
    -a, --alignment_file TEXT     Alignment file input (bam or cram).
    -o, --output_directory TEXT   Directory name for annotation output.
                                  Defaults to the current directory, with this
                                  directory name as the project name.
    -c, --conditions TEXT         Values denoting condition groups (sets of
                                  replicate libraries) for projects with
                                  multiple tissues/treatments/genotypes. Can
                                  be entered here as space sparated duplexes,
                                  with the library base_name and condition
                                  groups delimited by a colon. E.g.
                                  SRR1111111:WT SRR1111112:WT SRR1111113:mut
                                  SRR1111114:mut
    -an, --annotation_files TEXT  Locus annotations to count in gff, gff3,
                                  gtf, bed, or tabular format. Tabular
                                  requires contig:start-stop and locus_name in
                                  the first two columns (tab-delimited, "#"
                                  escape char). Defaults to find all gff files
                                  associated with annotations.
    --include_zeros TEXT          Include to save 0-depth rows in the deep
                                  counts. By default, these are excluded to
                                  save space (except for one entry to make
                                  sure downstream analyses will include un-
                                  found entries)
  -h, --help                      Show this message and exit.
```


## yasma_hairpin

### Tool Description
Evaluates annotated loci for hairpin or miRNA structures.

### Metadata
- **Docker Image**: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/NateyJay/YASMA
- **Package**: https://anaconda.org/channels/bioconda/packages/yasma/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yasma hairpin [OPTIONS]

  Evaluates annotated loci for hairpin or miRNA structures.

Options:
  
  Basic options: 
    -a, --alignment_file TEXT    Alignment file input (bam or cram).
    -o, --output_directory TEXT  Directory name for annotation output.
                                 Defaults to the current directory, with this
                                 directory name as the project name.
    -g, --genome_file TEXT       Genome or assembly which was used for the
                                 original alignment.
  
  Other options: 
    -i, --ignore_replication     Evaluate all readgroups together, ignoring if
                                 a miRNA is replicated
    -m, --max_length INTEGER     Maximum hairpin size (default 300). Longer
                                 loci will not be considered for miRNA
                                 analysis.
    --cores INTEGER              Number of cores/processes used in analyzing
                                 hairpins.
    --matures PATH               location for a fasta of mature miRNAs which
                                 will be used to spot orthologs.
    --annotation_folder PATH     location for the yasma annotation used in
                                 this analysis. Defaults to the project's
                                 tradeoff folder
    -n, --name TEXT              name for sub folder where hairpin analysis is
                                 deposited
    --silent                     Silences printing hairpin analysis to
                                 terminal. Useful when lots of loci are found.
  
  Advance options: 
    --ignore_subhairpins         This prevents folding of sub-hairpins in long
                                 stranded loci
    --trim_hairpins              With this flag, candidate hairpins are
                                 retrimmed. This is useful for loci which may
                                 be arbitrarily sized. Warning, this is very
                                 likely to produce false positives for miRNAs,
                                 as it artificially enhances precision.
  -h, --help                     Show this message and exit.
```


## yasma_jbrowse

### Tool Description
Build coverage and config files for jbrowse2

### Metadata
- **Docker Image**: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/NateyJay/YASMA
- **Package**: https://anaconda.org/channels/bioconda/packages/yasma/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yasma jbrowse [OPTIONS]

  Build coverage and config files for jbrowse2

Options:
  
  Required options: 
    -a, --alignment_file TEXT     Alignment file input (bam or cram).
    -c, --conditions TEXT         Values denoting condition groups (sets of
                                  replicate libraries) for projects with
                                  multiple tissues/treatments/genotypes. Can
                                  be entered here as space sparated duplexes,
                                  with the library base_name and condition
                                  groups delimited by a colon. E.g.
                                  SRR1111111:WT SRR1111112:WT SRR1111113:mut
                                  SRR1111114:mut
    -ac, --annotation_conditions TEXT
                                  List of conditions names which will be
                                  included in the annotation. Defaults to use
                                  all libraries, though this is likely not
                                  what you want if you have multiple groups.
    -o, --output_directory TEXT   Directory name for annotation output.
                                  Defaults to the current directory, with this
                                  directory name as the project name.
    -ga, --gene_annotation_file TEXT
                                  Annotation file for genes (gff3) matching
                                  the included genome.
    -g, --genome_file TEXT        Genome or assembly which was used for the
                                  original alignment.
  
  Should include: 
    -j, --jbrowse_directory TEXT  A path to a working directory for a jbrowse2
                                  instance.
  
  Options: 
    --include_subannotations      Makes jbrowse entries for other annotations
                                  from the tradeoff module than the primary
                                  annotation 'tradeoff'.
    --min_size INTEGER            Minimum read size for specific coverage
                                  treatment Default 20 nt.
    --max_size INTEGER            Maximum read size for specific coverage
                                  treatment Default 25 nt.
    --force                       Force remake of coverage files
    --recopy                      Force recopy of all files to the jbrowse
                                  directory
    --overwrite_config            Option to overwrite and make a new jbrowse
                                  config.json de novo.
    -x, --remove_name TEXT        Names of entries which should be removed
                                  from the config. These are synonymous with
                                  the output_directories of the runs used. Use
                                  this with caution!
    --override                    Overrides config file changes without
                                  prompting.
  -h, --help                      Show this message and exit.
```


## yasma_coverage

### Tool Description
Produces bigwig coverage files

### Metadata
- **Docker Image**: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/NateyJay/YASMA
- **Package**: https://anaconda.org/channels/bioconda/packages/yasma/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yasma coverage [OPTIONS]

  Produces bigwig coverage files

Options:
  
  Basic options: 
    -o, --output_directory TEXT  Directory name for annotation output.
                                 Defaults to the current directory, with this
                                 directory name as the project name.
    -a, --alignment_file TEXT    Alignment file input (bam or cram).
  
  Run options: 
    -p, --peaks TEXT             Entry of size limits for a peak. Encoded as
                                 two integers separated by a dash (`-`), for
                                 example: 21-22 is an appropriate entry for
                                 plant miRNAS. Also accepts single-size peaks
                                 without dash. Multiple peaks may be
                                 identified, separated with spaces or by
                                 calling the option again. Default: 20-25
    --force                      Forces remaking bigwigs even if all expected
                                 are found
  -h, --help                     Show this message and exit.
```


## yasma_size-profile

### Tool Description
Convenience function for calculating aligned size profile.

### Metadata
- **Docker Image**: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
- **Homepage**: https://github.com/NateyJay/YASMA
- **Package**: https://anaconda.org/channels/bioconda/packages/yasma/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yasma size-profile [OPTIONS]

  Convenience function for calculating aligned size profile.

Options:
  
  Required: 
    -o, --output_directory TEXT   Directory name for annotation output.
                                  Defaults to the current directory, with this
                                  directory name as the project name.
    -a, --alignment_file TEXT     Alignment file input (bam or cram).
    -c, --conditions TEXT         Values denoting condition groups (sets of
                                  replicate libraries) for projects with
                                  multiple tissues/treatments/genotypes. Can
                                  be entered here as space sparated duplexes,
                                  with the library base_name and condition
                                  groups delimited by a colon. E.g.
                                  SRR1111111:WT SRR1111112:WT SRR1111113:mut
                                  SRR1111114:mut
    -ac, --annotation_conditions TEXT
                                  List of conditions names which will be
                                  included in the profile. Defaults to use all
                                  libraries, though this is likely not what
                                  you want if you have multiple groups.
    --all                         Override any annotation conditions and use
                                  all libraries for size-profiling.
  
  Optional: 
    -f, --force                   Flag to force override of output_file
                                  (default does nothing when this file is
                                  found).
  -h, --help                      Show this message and exit.
```

