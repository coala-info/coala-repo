cwlVersion: v1.2
class: CommandLineTool
baseCommand: [fastreeR]
label: fastreer_FASTA2DIST
doc: "Compute a distance matrix from one or more FASTA files\n\nTool homepage: https://github.com/gkanogiannis/fastreeR"
arguments:
  - position: 1
    valueFrom: FASTA2DIST
inputs:
  - id: mem
    type: ['null', int]
    doc: Max RAM for JVM in MB (default 256)
    inputBinding:
      position: 0
      prefix: --mem
  - id: lib
    type: ['null', string]
    doc: Path to JAR library folder inside the container
    inputBinding:
      position: 0
      prefix: --lib
  - id: pipe_stderr
    type: ['null', boolean]
    doc: Pipe Java stderr to CLI
    inputBinding:
      position: 0
      prefix: --pipe-stderr
  - id: extra_verbose
    type: ['null', boolean]
    doc: Print extra messages on stderr
    inputBinding:
      position: 0
      prefix: --extraVerbose
  - id: inputs
    type: ['null', 'File[]']
    doc: "Positional input FASTA files"
    inputBinding:
      position: 10
  - id: named_inputs
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -i
    doc: "Input FASTA file(s) given with -i"
    inputBinding:
      position: 9
  - id: output
    type: string
    doc: "Output file path"
    inputBinding:
      position: 11
      prefix: -o
  - id: kmer_size
    type: ['null', int]
    doc: "Kmer size for D2S calculation (default 4)"
    inputBinding:
      position: 11
      prefix: -k
  - id: threads
    type: ['null', int]
    doc: "Number of threads (default 1)"
    inputBinding:
      position: 11
      prefix: -t
  - id: normalize
    type: ['null', boolean]
    doc: "Use normalization"
    inputBinding:
      position: 11
      prefix: -n
  - id: verbose
    type: ['null', boolean]
    doc: "Print progress messages on stderr"
    inputBinding:
      position: 11
      prefix: -v
outputs:
  - id: output_file
    type: ['null', File]
    doc: Output file written with -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastreer:2.1.3--pyhdfd78af_0
