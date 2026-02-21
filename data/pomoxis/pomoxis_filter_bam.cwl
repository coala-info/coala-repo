cwlVersion: v1.2
class: CommandLineTool
baseCommand: pomoxis_filter_bam
label: pomoxis_filter_bam
doc: "The provided text does not contain help information for pomoxis_filter_bam;
  it contains container runtime error logs. No arguments could be extracted.\n\nTool
  homepage: https://github.com/nanoporetech/pomoxis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
stdout: pomoxis_filter_bam.out
