cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - filterdup
label: macs3_filterdup
doc: "MACS3 filterdup is used to remove duplicate reads at the same location based
  on a binomial distribution test or a fixed number.\n\nTool homepage: https://pypi.org/project/MACS3/"
inputs:
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Buffer size for incrementally increasing internal array size to store 
      reads alignment information.
    default: 100000
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: When set, filterdup will only output numbers instead of writing output 
      files.
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: format
    type:
      - 'null'
      - string
    doc: Format of tag file, "AUTO", "BED", "ELAND", "ELANDMULTI", 
      "ELANDEXPORT", "SAM", "BAM", "BOWTIE", "BAMPE", or "BEDPE".
    default: AUTO
    inputBinding:
      position: 101
      prefix: --format
  - id: gsize
    type:
      - 'null'
      - string
    doc: Effective genome size. It can be 1.0e+9 or 1000000000, or 
      shortcuts:'hs' for human, 'mm' for mouse, 'ce' for C. elegans and 'dm' for
      fruitfly.
    default: hs
    inputBinding:
      position: 101
      prefix: --gsize
  - id: ifile
    type:
      type: array
      items: File
    doc: Alignment file. If multiple files are given as '-t A B C', then they 
      will all be read and combined.
    inputBinding:
      position: 101
      prefix: --ifile
  - id: keep_duplicates
    type:
      - 'null'
      - string
    doc: "It controls the 'macs3 filterdup' behavior towards duplicate tags/pairs
      at the exact same location. Options: 'auto', 'all', or an integer."
    default: auto
    inputBinding:
      position: 101
      prefix: --keep-dup
  - id: pvalue
    type:
      - 'null'
      - float
    doc: Pvalue cutoff for binomial distribution test.
    default: 1e-05
    inputBinding:
      position: 101
      prefix: --pvalue
  - id: tsize
    type:
      - 'null'
      - int
    doc: Tag size. This will override the auto detected tag size.
    inputBinding:
      position: 101
      prefix: --tsize
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Set verbose level. 0: critical, 1: warning, 2: process info, 3: debug.'
    default: 2
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: If specified all output files will be written to that directory.
    outputBinding:
      glob: $(inputs.outdir)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BED file name. If not specified, will write to standard output.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
