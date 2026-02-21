cwlVersion: v1.2
class: CommandLineTool
baseCommand: pileometh
label: pileometh
doc: "The provided text does not contain help information as the executable was not
  found in the environment. PileOmeMeth (now MethylDackel) is typically used for processing
  bisulfite sequencing BAM files.\n\nTool homepage: https://github.com/LeonardJ09/WGBS3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pileometh:0.1.13--0
stdout: pileometh.out
