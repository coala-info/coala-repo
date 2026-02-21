cwlVersion: v1.2
class: CommandLineTool
baseCommand: omssa
label: omssa
doc: "Open Mass Spectrometry Search Algorithm (OMSSA) is a search engine for identifying
  MS/MS peptide spectra by matching them to libraries of known protein sequences.\n
  \nTool homepage: ftp://ftp.ncbi.nlm.nih.gov/pub/lewisg/omssa/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/omssa:2.1.9--0
stdout: omssa.out
