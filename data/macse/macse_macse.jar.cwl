cwlVersion: v1.2
class: CommandLineTool
baseCommand: macse
label: macse_macse.jar
doc: "Multiple Alignment of Coding SEquences (MACSE) aligns coding nucleotide sequences
  with respect to their amino acid translation.\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
stdout: macse_macse.jar.out
