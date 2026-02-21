cwlVersion: v1.2
class: CommandLineTool
baseCommand: epik_ipk.py
label: epik_ipk.py
doc: "The provided text contains system error logs related to a container build failure
  (no space left on device) rather than the help documentation for the tool. As a
  result, no arguments or descriptions could be extracted.\n\nTool homepage: https://github.com/phylo42/epik"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epik:0.2.0--h077b44d_2
stdout: epik_ipk.py.out
