cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jellyfish
  - mem
label: jellyfish_mem
doc: "Give memory usage information\n\nTool homepage: http://www.genome.umd.edu/jellyfish.html"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files
    inputBinding:
      position: 1
  - id: bc
    type:
      - 'null'
      - boolean
    doc: Ignored switch
    inputBinding:
      position: 102
      prefix: --bc
  - id: counter_len
    type:
      - 'null'
      - int
    doc: Length bits of counting field
    default: 7
    inputBinding:
      position: 102
      prefix: --counter-len
  - id: full_help
    type:
      - 'null'
      - boolean
    doc: Detailed help
    inputBinding:
      position: 102
      prefix: --full-help
  - id: mem
    type:
      - 'null'
      - int
    doc: Return maximum size to fit within that memory
    inputBinding:
      position: 102
      prefix: --mem
  - id: mer_len
    type: int
    doc: Length of mer
    inputBinding:
      position: 102
      prefix: --mer-len
  - id: reprobes
    type:
      - 'null'
      - int
    doc: Maximum number of reprobes
    default: 126
    inputBinding:
      position: 102
      prefix: --reprobes
  - id: size
    type:
      - 'null'
      - int
    doc: Initial hash size
    inputBinding:
      position: 102
      prefix: --size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jellyfish:v2.2.10-2-deb_cv1
stdout: jellyfish_mem.out
