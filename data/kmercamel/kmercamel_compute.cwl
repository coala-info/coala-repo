cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmercamel compute
label: kmercamel_compute
doc: "Compute k-mer based superstrings.\n\nTool homepage: https://github.com/OndrejSladky/kmercamel/"
inputs:
  - id: fasta
    type: File
    doc: Path to the input FASTA file
    inputBinding:
      position: 1
  - id: algorithm
    type:
      - 'null'
      - string
    doc: the algorithm to be run [global (default), streaming, local, globalAC 
      (experimental), localAC (experimental)]
    default: global
    inputBinding:
      position: 102
      prefix: -a
  - id: d_max
    type:
      - 'null'
      - int
    doc: d_max for local algorithm
    default: 5
    inputBinding:
      position: 102
      prefix: -d
  - id: kmer_size
    type: int
    doc: k-mer size
    inputBinding:
      position: 102
      prefix: -k
  - id: mask_output_file
    type:
      - 'null'
      - File
    doc: if given, print also ms with mask maximizing ones (only with global)
    inputBinding:
      position: 102
      prefix: -M
  - id: min_frequency
    type:
      - 'null'
      - int
    doc: minimum frequency to represent a k-mer
    default: 1
    inputBinding:
      position: 102
      prefix: -z
  - id: optimize_simplitigs
    type:
      - 'null'
      - boolean
    doc: optimize for the input being correctly computed simplitigs (only with 
      global)
    inputBinding:
      position: 102
      prefix: -S
  - id: treat_reverse_complement_distinct
    type:
      - 'null'
      - boolean
    doc: treat k-mer and its reverse complement as distinct
    inputBinding:
      position: 102
      prefix: -u
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output for the (minone) masked superstring; if not specified, printed 
      to stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
