cwlVersion: v1.2
class: CommandLineTool
baseCommand: genodsp_smooth
label: genodsp_smooth
doc: "Smooths genomic data, but requires chromosome length information.\n\nTool homepage:
  https://github.com/rsharris/genodsp"
inputs:
  - id: chromosome_info
    type: string
    doc: Chromosome length information in the format 'chromosome:length' or 
      'chromosome:start:end'.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genodsp:0.0.10--h7b50bb2_1
stdout: genodsp_smooth.out
