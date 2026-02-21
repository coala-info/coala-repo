cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sherpas
  - xpas-build-dna
label: sherpas_xpas-build-dna
doc: "The provided text is a system error log indicating a failure to build a container
  image due to insufficient disk space. It does not contain the help text or usage
  instructions for the tool. Consequently, no arguments could be extracted.\n\nTool
  homepage: https://github.com/phylo42/sherpas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sherpas:1.0.2--h2df963e_2
stdout: sherpas_xpas-build-dna.out
