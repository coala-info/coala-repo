cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tradis
  - utils
  - index
label: quatradis_tradis_utils_index
doc: "Index a reference using the specified alignment tool.\n\nTool homepage: https://github.com/quadram-institute-bioscience/QuaTradis"
inputs:
  - id: reference
    type: File
    doc: "The FASTA formatted reference for processing."
    inputBinding:
      position: 1
  - id: refname
    type: string
    doc: "The name for this reference."
    inputBinding:
      position: 2
  - id: aligner
    type:
      - 'null'
      - string
    doc: "Read aligning tool to use (bwa, smalt, minimap2) (default: bwa)."
    inputBinding:
      position: 103
      prefix: --aligner
  - id: read_len
    type:
      - 'null'
      - int
    doc: "The average read length used (required for smalt)."
    inputBinding:
      position: 104
      prefix: --read_len
  - id: smalt_k
    type:
      - 'null'
      - int
    doc: "Smalt k-mer size."
    inputBinding:
      position: 105
      prefix: --smalt_k
  - id: smalt_s
    type:
      - 'null'
      - int
    doc: "Smalt step size."
    inputBinding:
      position: 106
      prefix: --smalt_s
  - id: profile
    type:
      - 'null'
      - boolean
    doc: "Turn on profiling."
    inputBinding:
      position: 100
      prefix: --profile
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print out extra information about the process while it runs."
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index_files
    type:
      type: array
      items: File
    doc: "Index files written for the reference"
    outputBinding:
      glob: $(inputs.reference.basename).*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quatradis:1.4.0--py312h0fa9677_1
stdout: quatradis_tradis_utils_index.out
