cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainPreNet
label: ucsc-chainprenet_chainPreNet
doc: "Remove chains that don't have a chance of being netted\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 1
  - id: target_sizes
    type: File
    doc: Target sizes file
    inputBinding:
      position: 2
  - id: query_sizes
    type: File
    doc: Query sizes file
    inputBinding:
      position: 3
  - id: dots
    type:
      - 'null'
      - int
    doc: output a dot every so often
    inputBinding:
      position: 104
      prefix: --dots
  - id: include_hap
    type:
      - 'null'
      - boolean
    doc: include query sequences name in the form *_hap*|*_alt*. Normally these 
      are excluded from nets as being haplotype pseudochromosomes
    inputBinding:
      position: 104
      prefix: --inclHap
  - id: pad
    type:
      - 'null'
      - int
    doc: extra to pad around blocks to decrease trash
    default: 1
    inputBinding:
      position: 104
      prefix: --pad
outputs:
  - id: output_chain
    type: File
    doc: Output chain file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainprenet:482--h0b57e2e_0
