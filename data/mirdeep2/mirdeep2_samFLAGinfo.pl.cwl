cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samFLAGinfo.pl
label: mirdeep2_samFLAGinfo.pl
doc: "Translate a SAM FLAG number into its meaning (bits set, hexadecimal value and description)\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: flag
    type: int
    doc: SAM FLAG number to translate
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Table of the bits set in the FLAG
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: samflaginfo.txt
