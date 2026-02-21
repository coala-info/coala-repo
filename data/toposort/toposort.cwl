cwlVersion: v1.2
class: CommandLineTool
baseCommand: toposort
label: toposort
doc: "A tool for performing topological sorting. Note: The provided text appears to
  be a container runtime error log rather than help text, so no arguments could be
  extracted.\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/toposort:1.4--py35_0
stdout: toposort.out
