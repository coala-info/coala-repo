cwlVersion: v1.2
class: CommandLineTool
baseCommand: lofreq
label: lofreq
doc: "LoFreq is a fast and sensitive variant caller for inferring SNVs and indels
  from next-generation sequencing data. (Note: The provided text contains system error
  messages regarding container execution and does not include the tool's help documentation.)\n
  \nTool homepage: http://csb5.github.io/lofreq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lofreq:2.1.5--py311hce89694_15
stdout: lofreq.out
