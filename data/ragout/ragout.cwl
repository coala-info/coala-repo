cwlVersion: v1.2
class: CommandLineTool
baseCommand: ragout
label: ragout
doc: "Chromosome assembly with multiple references\n\nTool homepage: https://github.com/fenderglass/Ragout"
inputs:
  - id: recipe_file
    type: File
    doc: path to recipe file
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: enable debug output
    default: false
    inputBinding:
      position: 102
      prefix: --debug
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    default: ragout-out
    inputBinding:
      position: 102
      prefix: --outdir
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: overwrite results from the previous run
    default: false
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: refine
    type:
      - 'null'
      - boolean
    doc: enable refinement with assembly graph
    default: false
    inputBinding:
      position: 102
      prefix: --refine
  - id: repeats
    type:
      - 'null'
      - boolean
    doc: enable repeat resolution algorithm
    default: false
    inputBinding:
      position: 102
      prefix: --repeats
  - id: solid_scaffolds
    type:
      - 'null'
      - boolean
    doc: do not break input sequences - disables chimera detection module
    default: false
    inputBinding:
      position: 102
      prefix: --solid-scaffolds
  - id: synteny
    type:
      - 'null'
      - string
    doc: backend for synteny block decomposition
    default: sibelia
    inputBinding:
      position: 102
      prefix: --synteny
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads for synteny backend
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ragout:2.3--py36hc9558a2_0
stdout: ragout.out
