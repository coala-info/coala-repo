cwlVersion: v1.2
class: CommandLineTool
baseCommand: sherpas
label: sherpas
doc: "The provided text is an error log from a container build process and does not
  contain help information or usage instructions for the 'sherpas' tool. As a result,
  no arguments could be extracted.\n\nTool homepage: https://github.com/phylo42/sherpas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sherpas:1.0.2--h2df963e_2
stdout: sherpas.out
