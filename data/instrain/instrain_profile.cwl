cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - inStrain
  - profile
label: instrain_profile
doc: "Create an inStrain profile (microdiversity analysis) from a mapping file\n\nTool homepage: https://github.com/MrOlm/inStrain"
inputs:
  - id: bam
    type: File
    doc: Sorted .bam file
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
  - id: fasta
    type: File
    doc: Fasta file the bam is mapped to
    inputBinding:
      position: 2
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output prefix (default: inStrain)'
    default: inStrain
    inputBinding:
      position: 101
      prefix: --output
  - id: use_full_fasta_header
    type:
      - 'null'
      - boolean
    doc: 'Instead of using the fasta ID (space in header before space), use the full header. Needed for some mapping tools (including bbMap) (default: False)'
    inputBinding:
      position: 101
      prefix: --use_full_fasta_header
  - id: force_compress
    type:
      - 'null'
      - boolean
    doc: 'Force compression of all output files (default: False)'
    inputBinding:
      position: 101
      prefix: --force_compress
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to use (default: 6)'
    inputBinding:
      position: 101
      prefix: --processes
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Make extra debugging output (default: False)'
    inputBinding:
      position: 101
      prefix: --debug
  - id: min_read_ani
    type:
      - 'null'
      - float
    doc: 'Minimum percent identity of read pairs to consensus to use the reads. Must be >, not >= (default: 0.95)'
    inputBinding:
      position: 101
      prefix: --min_read_ani
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: 'Minimum mapq score of EITHER read in a pair to use that pair. Must be >, not >= (default: -1)'
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: max_insert_relative
    type:
      - 'null'
      - float
    doc: 'Multiplier to determine maximum insert size between two reads - default is to use 3x median insert size. Must be >, not >= (default: 3)'
    inputBinding:
      position: 101
      prefix: --max_insert_relative
  - id: min_insert
    type:
      - 'null'
      - int
    doc: 'Minimum insert size between two reads - default is 50 bp. Must be >, not >= (default: 50)'
    inputBinding:
      position: 101
      prefix: --min_insert
  - id: pairing_filter
    type:
      - 'null'
      - type: enum
        symbols:
          - paired_only
          - non_discordant
          - all_reads
    doc: 'How should paired reads be handled? paired_only = only paired reads are retained; non_discordant = keep all paired reads and singleton reads that map to a single scaffold; all_reads = keep all reads regardless of pairing status (not recommended) (default: paired_only)'
    inputBinding:
      position: 101
      prefix: --pairing_filter
  - id: priority_reads
    type:
      - 'null'
      - File
    doc: A list of reads that should be retained regardless of pairing status (for example long reads or merged reads). A .fastq file or text file with list of read names (assumed compressed if it ends in .gz)
    inputBinding:
      position: 101
      prefix: --priority_reads
  - id: maximum_reads
    type:
      - 'null'
      - int
    doc: Maximum number of reads. Requires sambamba to do the subsetting
    inputBinding:
      position: 101
      prefix: --maximum_reads
  - id: detailed_mapping_info
    type:
      - 'null'
      - boolean
    doc: 'Make a detailed read report indicating details about each individual mapped read (default: False)'
    inputBinding:
      position: 101
      prefix: --detailed_mapping_info
  - id: min_cov
    type:
      - 'null'
      - int
    doc: 'Minimum coverage to call an variant (default: 5)'
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: min_freq
    type:
      - 'null'
      - float
    doc: 'Minimum SNP frequency to confirm a SNV (both this AND the FDR snp count cutoff must be true to call a SNP) (default: 0.05)'
    inputBinding:
      position: 101
      prefix: --min_freq
  - id: fdr
    type:
      - 'null'
      - float
    doc: 'SNP false discovery rate, based on simulation data with a 0.1 percent error rate (Q30) (default: 1e-06)'
    inputBinding:
      position: 101
      prefix: --fdr
  - id: gene_file
    type:
      - 'null'
      - File
    doc: 'Path to prodigal .fna genes file. If file ends in .gb or .gbk, will treat as a genbank file (EXPERIMENTAL; the name of the gene must be in the gene qualifier)'
    inputBinding:
      position: 101
      prefix: --gene_file
  - id: stb
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Scaffold to bin. A file with each line listing a scaffold and a bin name, tab-separated, or a list of .fasta files with one genome per .fasta file. If nothing is provided, all scaffolds are treated as belonging to the same genome'
    inputBinding:
      position: 101
      prefix: --stb
  - id: mm_level
    type:
      - 'null'
      - boolean
    doc: 'Create output files on the mm level (default: False)'
    inputBinding:
      position: 101
      prefix: --mm_level
  - id: skip_mm_profiling
    type:
      - 'null'
      - boolean
    doc: 'Dont perform analysis on an mm level; saves RAM and time; impacts plots and raw_data (default: False)'
    inputBinding:
      position: 101
      prefix: --skip_mm_profiling
  - id: database_mode
    type:
      - 'null'
      - boolean
    doc: 'Set a number of parameters to values appropriate for mapping to a large fasta file. Will set: --min_read_ani 0.92 --skip_mm_profiling --min_genome_coverage 1 (default: False)'
    inputBinding:
      position: 101
      prefix: --database_mode
  - id: min_scaffold_reads
    type:
      - 'null'
      - int
    doc: 'Minimum number of reads mapping to a scaffold to proceed with profiling it (default: 1)'
    inputBinding:
      position: 101
      prefix: --min_scaffold_reads
  - id: min_genome_coverage
    type:
      - 'null'
      - float
    doc: 'Minimum number of reads mapping to a genome to proceed with profiling it. MUST profile .stb if this is set (default: 0)'
    inputBinding:
      position: 101
      prefix: --min_genome_coverage
  - id: min_snp
    type:
      - 'null'
      - int
    doc: 'Absolute minimum number of reads connecting two SNPs to calculate LD between them (default: 20)'
    inputBinding:
      position: 101
      prefix: --min_snp
  - id: store_everything
    type:
      - 'null'
      - boolean
    doc: 'Store intermediate dictionaries in the pickle file; will result in significantly more RAM and disk usage (default: False)'
    inputBinding:
      position: 101
      prefix: --store_everything
  - id: scaffolds_to_profile
    type:
      - 'null'
      - File
    doc: Path to a file containing a list of scaffolds to profile; if provided will ONLY profile those scaffolds
    inputBinding:
      position: 101
      prefix: --scaffolds_to_profile
  - id: rarefied_coverage
    type:
      - 'null'
      - float
    doc: 'When calculating nucleotide diversity, also calculate a rarefied version with this much coverage (default: 50)'
    inputBinding:
      position: 101
      prefix: --rarefied_coverage
  - id: window_length
    type:
      - 'null'
      - int
    doc: 'Break scaffolds into windows of this length when profiling (default: 10000)'
    inputBinding:
      position: 101
      prefix: --window_length
  - id: skip_genome_wide
    type:
      - 'null'
      - boolean
    doc: 'Do not generate tables that consider groups of scaffolds belonging to genomes (default: False)'
    inputBinding:
      position: 101
      prefix: --skip_genome_wide
  - id: skip_plot_generation
    type:
      - 'null'
      - boolean
    doc: 'Do not make plots (default: False)'
    inputBinding:
      position: 101
      prefix: --skip_plot_generation
outputs:
  - id: profile_dir
    type: Directory
    doc: inStrain profile output directory (named by the output prefix)
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
