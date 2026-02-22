cwlVersion: v1.2
class: CommandLineTool
baseCommand: coinfinder
label: coinfinder
doc: "The provided text contains system error messages related to a container runtime
  failure (no space left on device) and does not include the help documentation for
  the tool. Coinfinder is generally used for detecting coincident genes and shared
  genomic regions in pangenomes.\n\nTool homepage: https://github.com/fwhelan/coinfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coinfinder:1.2.1--py39hb8976ed_3
stdout: coinfinder.out
