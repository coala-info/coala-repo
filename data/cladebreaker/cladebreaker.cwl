cwlVersion: v1.2
class: CommandLineTool
baseCommand: cladebreaker
label: cladebreaker
doc: "No description available: The provided text is a container runtime error log,
  not help text.\n\nTool homepage: https://github.com/andriesfeder/cladebreaker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cladebreaker:0.2.3--py39hdfd78af_0
stdout: cladebreaker.out
