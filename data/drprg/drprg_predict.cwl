cwlVersion: v1.2
class: CommandLineTool
baseCommand: drprg predict
label: drprg_predict
doc: "Predict drug resistance\n\nTool homepage: https://github.com/mbhall88/drprg"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output debugging files. Mostly for development purposes
    inputBinding:
      position: 101
      prefix: --debug
  - id: ignore_synonymous
    type:
      - 'null'
      - boolean
    doc: Ignore unknown (off-catalogue) variants that cause a synonymous 
      substitution
    inputBinding:
      position: 101
      prefix: --ignore-synonymous
  - id: illumina
    type:
      - 'null'
      - boolean
    doc: Sample reads are from Illumina sequencing
    inputBinding:
      position: 101
      prefix: --illumina
  - id: index
    type: Directory
    doc: Name of a downloaded index or path to an index
    inputBinding:
      position: 101
      prefix: --index
  - id: input
    type: File
    doc: "Reads to predict resistance from\n          \n          Both fasta and fastq
      are accepted, along with compressed or uncompressed."
    inputBinding:
      position: 101
      prefix: --input
  - id: mafft_executable
    type:
      - 'null'
      - File
    doc: Path to MAFFT executable. Will try in src/ext or $PATH if not given
    inputBinding:
      position: 101
      prefix: --mafft
  - id: makeprg_executable
    type:
      - 'null'
      - File
    doc: Path to make_prg executable. Will try in src/ext or $PATH if not given
    inputBinding:
      position: 101
      prefix: --makeprg
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: Maximum depth of coverage allowed on variants
    inputBinding:
      position: 101
      prefix: --max-covg
  - id: max_indel_length
    type:
      - 'null'
      - int
    doc: Maximum (absolute) length of insertions/deletions allowed
    inputBinding:
      position: 101
      prefix: --max-indel
  - id: min_allele_frequency
    type:
      - 'null'
      - float
    doc: "Minimum allele frequency to call variants\n          \n          If an alternate
      allele has at least this fraction of the depth, a minor resistance (\"r\") prediction
      is made. Set to 1 to disable. If --illumina is passed, the default is 0.1"
    inputBinding:
      position: 101
      prefix: --maf
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum depth of coverage allowed on variants
    inputBinding:
      position: 101
      prefix: --min-covg
  - id: min_genotype_confidence
    type:
      - 'null'
      - float
    doc: Minimum genotype confidence (GT_CONF) score allow on variants
    inputBinding:
      position: 101
      prefix: --min-gt-conf
  - id: min_read_support_fraction
    type:
      - 'null'
      - float
    doc: "Minimum fraction of read support\n          \n          For example, setting
      to 0.9 requires >=90% of coverage for the variant to be on the called allele"
    inputBinding:
      position: 101
      prefix: --min-frs
  - id: min_strand_bias
    type:
      - 'null'
      - float
    doc: "Minimum strand bias ratio allowed on variants\n          \n          For
      example, setting to 0.25 requires >=25% of total (allele) coverage on both strands
      for an allele."
    inputBinding:
      position: 101
      prefix: --min-strand-bias
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to place output
    inputBinding:
      position: 101
      prefix: --outdir
  - id: pandora_executable
    type:
      - 'null'
      - File
    doc: Path to pandora executable. Will try in src/ext or $PATH if not given
    inputBinding:
      position: 101
      prefix: --pandora
  - id: sample
    type:
      - 'null'
      - string
    doc: "Identifier to use for the sample\n          \n          If not provided,
      this will be set to the input reads file path prefix"
    inputBinding:
      position: 101
      prefix: --sample
  - id: threads
    type:
      - 'null'
      - int
    doc: "Maximum number of threads to use\n          \n          Use 0 to select
      the number automatically"
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Use verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drprg:0.1.1--h5076881_1
stdout: drprg_predict.out
