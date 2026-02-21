cwlVersion: v1.2
class: CommandLineTool
baseCommand: qualimap
label: qualimap
doc: "Qualimap is a platform-independent application written in Java and R that provides
  both a Graphical User Interface (GUI) and a command-line interface to facilitate
  the quality control of alignment sequencing data and its derivatives like feature
  counts.\n\nTool homepage: http://qualimap.bioinfo.cipf.es/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qualimap:2.3--hdfd78af_0
stdout: qualimap.out
