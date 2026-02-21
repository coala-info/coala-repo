cwlVersion: v1.2
class: CommandLineTool
baseCommand: peptide-shaker
label: peptide-shaker
doc: "PeptideShaker is a search engine independent graphic user interface for interpretation
  of proteomics identification results from multiple search engines.\n\nTool homepage:
  https://compomics.github.io/projects/peptide-shaker.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peptide-shaker:3.0.11--hdfd78af_0
stdout: peptide-shaker.out
