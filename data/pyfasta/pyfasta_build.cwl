cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfasta_build
label: pyfasta_build
doc: "A tool for building or converting OCI images/blobs to SIF format (Note: The
  provided text appears to be an execution log rather than help documentation).\n\n
  Tool homepage: https://github.com/brentp/pyfasta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfasta:0.5.2--pyhdfd78af_2
stdout: pyfasta_build.out
