cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - eval
label: survivor_eval
doc: "Evaluate a VCF file after SV calling over simulated data\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: vcf
    type: File
    doc: "VCF file."
    inputBinding:
      position: 1
  - id: simulated_bed
    type: File
    doc: "BED file from simulations (SURVIVOR simSV)."
    inputBinding:
      position: 2
  - id: max_distance
    type: int
    doc: "Max allowed distance to simulated."
    inputBinding:
      position: 3
  - id: output
    type: string
    doc: "Output eval file prefix."
    inputBinding:
      position: 4
outputs:
  - id: eval_files
    type:
      type: array
      items: File
    doc: "Correctly found (_right.vcf) and additional (addition.vcf) calls."
    outputBinding:
      glob: '$(inputs.output)*'
  - id: stdout
    type: stdout
    doc: "Per-type counts and the Overall line"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
stdout: survivor_eval.out
