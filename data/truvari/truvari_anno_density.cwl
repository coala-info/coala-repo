cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - anno
  - density
label: truvari_anno_density
doc: "Identify 'dense' and 'sparse' variant windows of the genome\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: genome
    type: File
    doc: Genome bed file
    inputBinding:
      position: 1
      prefix: "-g"
  - id: output
    type:
      - 'null'
      - string
    default: density.jl
    doc: Output joblib DataFrame
    inputBinding:
      position: 1
      prefix: "-o"
  - id: mask
    type:
      - 'null'
      - File
    doc: Mask bed file
    inputBinding:
      position: 1
      prefix: "-m"
  - id: windowsize
    type:
      - 'null'
      - int
    doc: Window size (10000)
    inputBinding:
      position: 1
      prefix: "-w"
  - id: stepsize
    type:
      - 'null'
      - int
    doc: Window step size (10000)
    inputBinding:
      position: 1
      prefix: "-s"
  - id: threshold
    type:
      - 'null'
      - float
    doc: std for identifying 'dense' regions (3)
    inputBinding:
      position: 1
      prefix: "-t"
  - id: input
    type: File
    doc: Input VCF
    inputBinding:
      position: 2
outputs:
  - id: output_joblib
    type: File
    doc: Joblib DataFrame of window densities
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
