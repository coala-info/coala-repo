cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedJoinTabOffset
label: ucsc-bedjointaboffset
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build the container image due to insufficient disk space
  ('no space left on device').\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedjointaboffset:377--h199ee4e_0
stdout: ucsc-bedjointaboffset.out
