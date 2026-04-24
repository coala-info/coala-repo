cwlVersion: v1.2
class: CommandLineTool
baseCommand: haystack_hotspots
label: haystack_bio_haystack_hotspots
doc: "HAYSTACK Parameters\n\nTool homepage: https://github.com/rfarouni/haystack_bio"
inputs:
  - id: samples_filename_or_bam_folder
    type: string
    doc: "A tab delimited file with in each row (1) a sample\n                   \
      \     name, (2) the path to the corresponding bam or bigwig\n              \
      \          filename. Alternatively it is possible to specify a\n           \
      \             folder containing some .bam files to analyze."
    inputBinding:
      position: 1
  - id: genome_name
    type: string
    doc: "Genome assembly to use from UCSC (for example hg19,\n                  \
      \      mm9, etc.)"
    inputBinding:
      position: 2
  - id: bin_size
    type:
      - 'null'
      - int
    doc: bin size to use
    inputBinding:
      position: 103
      prefix: --bin_size
  - id: blacklist
    type:
      - 'null'
      - File
    doc: "Exclude blacklisted regions. Blacklisted regions are\n                 \
      \       not excluded by default. Use hg19 to blacklist regions\n           \
      \             for the human genome build 19, otherwise provide the\n       \
      \                 filepath for a bed file with blacklisted regions."
    inputBinding:
      position: 103
      prefix: --blacklist
  - id: chrom_exclude
    type:
      - 'null'
      - string
    doc: "Exclude chromosomes that contain given (regex) string.\n               \
      \         For example _random|chrX|chrY excludes random, X, and\n          \
      \              Y chromosome regions"
    inputBinding:
      position: 103
      prefix: --chrom_exclude
  - id: depleted
    type:
      - 'null'
      - boolean
    doc: "Look for cell type specific regions with depletion of\n                \
      \        signal instead of enrichment"
    inputBinding:
      position: 103
      prefix: --depleted
  - id: disable_quantile_normalization
    type:
      - 'null'
      - boolean
    doc: Disable quantile normalization
    inputBinding:
      position: 103
      prefix: --disable_quantile_normalization
  - id: do_not_filter_bams
    type:
      - 'null'
      - boolean
    doc: "Use BAM files as provided. Do not remove reads that\n                  \
      \      are unmapped, mate unmapped, not primary aligned or\n               \
      \         low MAPQ reads, reads failing qc and optical\n                   \
      \     duplicates"
    inputBinding:
      position: 103
      prefix: --do_not_filter_bams
  - id: do_not_recompute
    type:
      - 'null'
      - boolean
    doc: Keep any file previously precalculated
    inputBinding:
      position: 103
      prefix: --do_not_recompute
  - id: input_is_bigwig
    type:
      - 'null'
      - boolean
    doc: "Use the bigwig format instead of the bam format for\n                  \
      \      the input. Note: The files must have extension .bw"
    inputBinding:
      position: 103
      prefix: --input_is_bigwig
  - id: keep_intermediate_files
    type:
      - 'null'
      - boolean
    doc: keep intermediate bedgraph files
    inputBinding:
      position: 103
      prefix: --keep_intermediate_files
  - id: max_regions_percentage
    type:
      - 'null'
      - float
    doc: Upper bound on the % of the regions selected
    inputBinding:
      position: 103
      prefix: --max_regions_percentage
  - id: n_processes
    type:
      - 'null'
      - int
    doc: "Specify the number of processes to use. The default is\n               \
      \         #cores available."
    inputBinding:
      position: 103
      prefix: --n_processes
  - id: name
    type:
      - 'null'
      - string
    doc: Define a custom output filename for the report
    inputBinding:
      position: 103
      prefix: --name
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 103
      prefix: --output_directory
  - id: read_ext
    type:
      - 'null'
      - int
    doc: Read extension in bps
    inputBinding:
      position: 103
      prefix: --read_ext
  - id: th_rpm
    type:
      - 'null'
      - int
    doc: "Percentile on the signal intensity to consider for the\n               \
      \         hotspots"
    inputBinding:
      position: 103
      prefix: --th_rpm
  - id: transformation
    type:
      - 'null'
      - string
    doc: "Variance stabilizing transformation among: none, log2,\n               \
      \         angle"
    inputBinding:
      position: 103
      prefix: --transformation
  - id: z_score_high
    type:
      - 'null'
      - float
    doc: z-score value to select the specific regions
    inputBinding:
      position: 103
      prefix: --z_score_high
  - id: z_score_low
    type:
      - 'null'
      - float
    doc: z-score value to select the not specific regions
    inputBinding:
      position: 103
      prefix: --z_score_low
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystack_bio:0.5.5--0
stdout: haystack_bio_haystack_hotspots.out
