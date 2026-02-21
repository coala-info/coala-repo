cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraTestJob
label: ucsc-paratestjob
doc: "The provided text is a container engine error log and does not contain help
  information for the tool. paraTestJob is a UCSC utility typically used for testing
  the Parasol job scheduling system.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paratestjob:482--h0b57e2e_2
stdout: ucsc-paratestjob.out
