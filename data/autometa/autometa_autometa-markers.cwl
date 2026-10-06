cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-markers
label: autometa_autometa-markers
doc: "Annotate ORFs with kingdom-specific marker information\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: orfs
    type: File
    doc: "Path to a fasta file containing amino acid sequences of open reading frames"
    inputBinding:
      position: 1
      prefix: --orfs
  - id: kingdom
    type:
      - 'null'
      - string
    doc: "kingdom to search for markers (bacteria, archaea) (default: bacteria)"
    inputBinding:
      position: 1
      prefix: --kingdom
  - id: hmmscan
    type: string
    default: "hmmscan.tsv"
    doc: "Path to write (or reuse) the hmmscan output table"
    inputBinding:
      position: 1
      prefix: --hmmscan
  - id: out
    type: string
    default: "markers.tsv"
    doc: "Path to write filtered annotated markers corresponding to `kingdom`"
    inputBinding:
      position: 1
      prefix: --out
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: "Directory containing <kingdom>.single_copy.hmm (hmmpressed) and <kingdom>.single_copy.cutoffs"
    inputBinding:
      position: 1
      prefix: --dbdir
  - id: hmmdb
    type:
      - 'null'
      - File
    doc: "Path to single-copy marker HMM database (hmmpressed)"
    secondaryFiles:
      - pattern: .h3f
        required: false
      - pattern: .h3i
        required: false
      - pattern: .h3m
        required: false
      - pattern: .h3p
        required: false
    inputBinding:
      position: 1
      prefix: --hmmdb
  - id: cutoffs
    type:
      - 'null'
      - File
    doc: "Path to single-copy marker cutoff tsv."
    inputBinding:
      position: 1
      prefix: --cutoffs
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Whether to overwrite existing provided annotations."
    inputBinding:
      position: 1
      prefix: --force
  - id: parallel
    type:
      - 'null'
      - boolean
    doc: "Whether to use hmmscan parallel option."
    inputBinding:
      position: 1
      prefix: --parallel
  - id: gnu_parallel
    type:
      - 'null'
      - boolean
    doc: "Whether to run hmmscan using GNU parallel."
    inputBinding:
      position: 1
      prefix: --gnu-parallel
  - id: cpus
    type:
      - 'null'
      - int
    doc: "Number of cores to use for parallel execution. (default: 8)"
    inputBinding:
      position: 1
      prefix: --cpus
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed to set random state for hmmscan. (default: 42)"
    inputBinding:
      position: 1
      prefix: --seed
outputs:
  - id: hmmscan_out
    type: File
    doc: "hmmscan output table"
    outputBinding:
      glob: "$(inputs.hmmscan)"
  - id: markers_out
    type: File
    doc: "Annotated markers table"
    outputBinding:
      glob: "$(inputs.out)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
