cwlVersion: v1.2
class: CommandLineTool
baseCommand: elph
label: elph
doc: "ELPH is a general-purpose Gibbs sampler for finding motifs in a set of DNA or
  protein sequences.\n\nTool homepage: https://github.com/emacsmirror/elpher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/elph:v1.0.1-2-deb_cv1
stdout: elph.out
