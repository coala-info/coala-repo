cwlVersion: v1.2
class: CommandLineTool
baseCommand: genodsp_clump
label: genodsp_clump
doc: "Clumps regions based on proximity. Requires chromosome lengths or explicit start/end
  coordinates.\n\nTool homepage: https://github.com/rsharris/genodsp"
inputs:
  - id: chromosome_lengths
    type:
      type: array
      items: string
    doc: Chromosome lengths in the format 'chromosome:length' or 
      'chromosome:start:end'. If not provided, the tool cannot determine 
      chromosome boundaries for clumping.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genodsp:0.0.10--h7b50bb2_1
stdout: genodsp_clump.out
