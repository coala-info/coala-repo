cwlVersion: v1.2
class: CommandLineTool
baseCommand: merqury_best_k.sh
label: merqury_best_k.sh
doc: "A script to estimate the best k-mer size for Merqury analysis.\n\nTool homepage:
  https://github.com/marbl/merqury"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merqury:1.3--hdfd78af_4
stdout: merqury_best_k.sh.out
