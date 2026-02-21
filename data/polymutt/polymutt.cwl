cwlVersion: v1.2
class: CommandLineTool
baseCommand: polymutt
label: polymutt
doc: "A tool for calling genotypes and de novo mutations in families (Note: The provided
  help text contains only system error messages and no usage information).\n\nTool
  homepage: https://genome.sph.umich.edu/wiki/Polymutt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polymutt:0.18--0
stdout: polymutt.out
