cwlVersion: v1.2
class: CommandLineTool
baseCommand: mzpaf
label: mzpaf
doc: "Mass Spectrometry Protein Alignment and Filtering\n\nTool homepage: https://github.com/HUPO-PSI/mzPAF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mzpaf:0.2.0a0--pyh7e72e81_0
stdout: mzpaf.out
