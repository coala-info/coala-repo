cwlVersion: v1.2
class: CommandLineTool
baseCommand: elph
label: elph_elpher
doc: "ELPH is a general-purpose Gibbs sampler for finding motifs in a set of DNA or
  protein sequences. (Note: The provided text contains system error messages and does
  not list specific arguments or usage instructions).\n\nTool homepage: https://github.com/emacsmirror/elpher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/elph:v1.0.1-2-deb_cv1
stdout: elph_elpher.out
