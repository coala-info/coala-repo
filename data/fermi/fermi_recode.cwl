cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi
  - recode
label: fermi_recode
doc: "Recode an FM-index (restore the run-length encoded BWT and write it again to standard
  output).\n\nTool homepage: https://github.com/lh3/fermi"
inputs:
  - id: input_rld
    type: File
    doc: Input FM-index file (.rld or .fmd)
    inputBinding:
      position: 1
outputs:
  - id: recoded_index
    type: stdout
    doc: Recoded FM-index
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_recode.out
