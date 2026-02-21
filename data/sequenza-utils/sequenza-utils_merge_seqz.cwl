cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenza-utils
  - seqz_merge
label: sequenza-utils_merge_seqz
doc: "The provided text is an error log indicating a container build failure ('no
  space left on device') and does not contain help documentation. No arguments could
  be parsed.\n\nTool homepage: http://sequenza-utils.readthedocs.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
stdout: sequenza-utils_merge_seqz.out
