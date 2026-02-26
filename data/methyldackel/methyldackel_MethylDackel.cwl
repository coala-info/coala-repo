cwlVersion: v1.2
class: CommandLineTool
baseCommand: MethylDackel
label: methyldackel_MethylDackel
doc: "A tool for processing bisulfite sequencing alignments.\n\nTool homepage: https://github.com/dpryan79/MethylDackel"
inputs:
  - id: command
    type: string
    doc: The command to execute (mbias, extract, mergeContext, or perRead)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methyldackel:0.6.1--h577a1d6_9
stdout: methyldackel_MethylDackel.out
