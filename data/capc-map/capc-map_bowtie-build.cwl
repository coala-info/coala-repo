cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capc-map
  - bowtie-build
label: capc-map_bowtie-build
doc: "Builds a Bowtie index from a set of DNA sequences.\n\nTool homepage: https://capc-map.readthedocs.io/"
inputs:
  - id: reference_in
    type:
      type: array
      items: File
    doc: Comma-separated list of files with ref sequences
    inputBinding:
      position: 1
  - id: ebwt_outfile_base
    type: string
    doc: Write Ebwt data to files with this dir/basename
    inputBinding:
      position: 2
  - id: bmax
    type:
      - 'null'
      - int
    doc: Max bucket size for blockwise suffix-array builder
    inputBinding:
      position: 103
      prefix: --bmax
  - id: colorspace
    type:
      - 'null'
      - boolean
    doc: Build a colorspace index
    inputBinding:
      position: 103
      prefix: --color
  - id: dcv
    type:
      - 'null'
      - int
    doc: Diff-cover period for blockwise suffix-array builder
    default: 1024
    inputBinding:
      position: 103
      prefix: --dcv
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Reference files are Fasta (default)
    inputBinding:
      position: 103
      prefix: -f
  - id: ftabchars
    type:
      - 'null'
      - int
    doc: Number of chars in initial lookup table
    default: 10
    inputBinding:
      position: 103
      prefix: --ftabchars
  - id: no_auto
    type:
      - 'null'
      - boolean
    doc: Disable automatic -n/--bmax/--dcv memory-fitting
    inputBinding:
      position: 103
      prefix: --noauto
  - id: nodc
    type:
      - 'null'
      - boolean
    doc: Disable diff-cover (algorithm becomes quadratic)
    inputBinding:
      position: 103
      prefix: --nodc
  - id: offrate
    type:
      - 'null'
      - int
    doc: SA is sampled every 2^offrate BWT chars
    default: 5
    inputBinding:
      position: 103
      prefix: --offrate
  - id: packed
    type:
      - 'null'
      - boolean
    doc: Use packed strings internally; slower, uses less mem
    inputBinding:
      position: 103
      prefix: --packed
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Verbose output (data build parameters) is suppressed
    inputBinding:
      position: 103
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
stdout: capc-map_bowtie-build.out
