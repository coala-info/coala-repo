cwlVersion: v1.2
class: CommandLineTool
baseCommand: pomoxis_subsample_bam
label: pomoxis_subsample_bam
doc: "Subsample BAM files. (Note: The provided text appears to be a container runtime
  error log rather than help text, so no arguments could be extracted.)\n\nTool homepage:
  https://github.com/nanoporetech/pomoxis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
stdout: pomoxis_subsample_bam.out
