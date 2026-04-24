cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmertools min
label: kmertools_min
doc: "Bin reads using minimisers\n\nTool homepage: https://github.com/anuradhawick/kmertools"
inputs:
  - id: input
    type: File
    doc: Input file path
    inputBinding:
      position: 101
      prefix: --input
  - id: m_size
    type:
      - 'null'
      - int
    doc: Minimiser size
    inputBinding:
      position: 101
      prefix: --m-size
  - id: preset
    type:
      - 'null'
      - string
    doc: "Output type to write\n\n          Possible values:\n          - s2m: Conver
      sequences into minimiser representation\n          - m2s: Group sequences by
      minimiser"
    inputBinding:
      position: 101
      prefix: --preset
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread count for computations 0=auto
    inputBinding:
      position: 101
      prefix: --threads
  - id: w_size
    type:
      - 'null'
      - int
    doc: "Window size\n          \n          0 - emits one minimiser per sequence
      (useful for sequencing reads)\n          w_size must be longer than m_size"
    inputBinding:
      position: 101
      prefix: --w-size
outputs:
  - id: output
    type: File
    doc: Output vectors path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmertools:0.2.1--h5e00ca1_0
