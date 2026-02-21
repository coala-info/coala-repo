cwlVersion: v1.2
class: CommandLineTool
baseCommand: gctb
label: gctb
doc: "Genome-wide Complex Trait Bayesian analysis\n\nTool homepage: https://cnsgenomics.com/software/gctb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gctb:2.0--h503566f_4
stdout: gctb.out
