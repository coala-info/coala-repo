cwlVersion: v1.2
class: CommandLineTool
baseCommand: genodsp_sum
label: genodsp_sum
doc: "Summate genotype data across specified regions.\n\nTool homepage: https://github.com/rsharris/genodsp"
inputs:
  - id: chromosome_lengths
    type:
      type: array
      items: string
    doc: Chromosome lengths in the format 'chromosome:length' or 
      'chromosome:start:end'. Multiple entries can be provided.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genodsp:0.0.10--h7b50bb2_1
stdout: genodsp_sum.out
