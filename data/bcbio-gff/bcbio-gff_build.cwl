cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcbio-gff_build
label: bcbio-gff_build
doc: "The provided text is an error log from a container build process and does not
  contain help information or usage instructions for the tool.\n\nTool homepage: https://github.com/chapmanb/bcbb/tree/master/gff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcbio-gff:0.7.1--pyhdfd78af_3
stdout: bcbio-gff_build.out
