cwlVersion: v1.2
class: CommandLineTool
baseCommand: mkvtree
label: vmatch_mkvtree
doc: "The provided text does not contain help information for vmatch_mkvtree; it contains
  container runtime log messages indicating a failure to fetch the OCI image.\n\n
  Tool homepage: http://www.vmatch.de/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch_mkvtree.out
