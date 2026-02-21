cwlVersion: v1.2
class: CommandLineTool
baseCommand: gprofiler-official
label: gprofiler-official
doc: "The provided text does not contain help information for the tool, but rather
  system logs indicating a failure to pull the container image due to lack of disk
  space.\n\nTool homepage: http://biit.cs.ut.ee/gprofiler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gprofiler-official:1.0.0--pyh7e72e81_1
stdout: gprofiler-official.out
