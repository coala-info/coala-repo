cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylpy
  - allc-to-bigwig
label: methylpy_allc-to-bigwig
doc: "Convert allc file to bigwig format\n\nTool homepage: https://github.com/yupenghe/methylpy"
inputs:
  - id: add_chr_prefix
    type:
      - 'null'
      - boolean
    doc: Boolean indicates whether to add "chr" in the input allc file to match 
      chromosome names in genome sequence file. This option overrides 
      --remove-chr-prefix.
    default: false
    inputBinding:
      position: 101
      prefix: --add-chr-prefix
  - id: allc_file
    type: File
    doc: input allc file to be converted to bigwig format
    inputBinding:
      position: 101
      prefix: --allc-file
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Genomic bin size for calculating methylation level
    default: 100
    inputBinding:
      position: 101
      prefix: --bin-size
  - id: max_site_cov
    type:
      - 'null'
      - int
    doc: Maximum total coverage of a site for it to be included.
    inputBinding:
      position: 101
      prefix: --max-site-cov
  - id: mc_type
    type:
      - 'null'
      - type: array
        items: string
    doc: List of space separated mc nucleotide contexts for which you want to 
      look for DMRs. These classifications may use the wildcards H (indicating 
      anything but a G) and N (indicating any nucleotide).
    default:
      - CGN
    inputBinding:
      position: 101
      prefix: --mc-type
  - id: min_bin_cov
    type:
      - 'null'
      - int
    doc: Minimum total coverage of all sites in a bin for methylation level to 
      be calculated.
    default: 0
    inputBinding:
      position: 101
      prefix: --min-bin-cov
  - id: min_bin_sites
    type:
      - 'null'
      - int
    doc: Minimum sites in a bin for it to be included.
    default: 0
    inputBinding:
      position: 101
      prefix: --min-bin-sites
  - id: min_site_cov
    type:
      - 'null'
      - int
    doc: Minimum total coverage of a site for it to be included.
    default: 0
    inputBinding:
      position: 101
      prefix: --min-site-cov
  - id: path_to_samtools
    type:
      - 'null'
      - File
    doc: Path to samtools installation
    inputBinding:
      position: 101
      prefix: --path-to-samtools
  - id: path_to_wigtobigwig
    type:
      - 'null'
      - File
    doc: Path to wigToBigWig executable
    inputBinding:
      position: 101
      prefix: --path-to-wigToBigWig
  - id: ref_fasta
    type: File
    doc: string indicating the path to a fasta file containing the genome 
      sequences
    inputBinding:
      position: 101
      prefix: --ref-fasta
  - id: remove_chr_prefix
    type:
      - 'null'
      - boolean
    doc: Boolean indicates whether to remove "chr" in the chromosome names in 
      genome sequence file to match chromosome names in input allc file.
    default: true
    inputBinding:
      position: 101
      prefix: --remove-chr-prefix
outputs:
  - id: output_file
    type: File
    doc: Name of output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
