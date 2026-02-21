cwlVersion: v1.2
class: CommandLineTool
baseCommand: prequal
label: prequal
doc: "The provided text does not contain help information for the tool 'prequal'.
  It appears to be a log of a failed container build process (Singularity/Apptainer).
  As a result, no arguments or tool descriptions could be extracted from the input.\n
  \nTool homepage: https://github.com/simonwhelan/prequal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prequal:1.02--hb97b32f_2
stdout: prequal.out
