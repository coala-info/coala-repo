cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kat
  - plot
label: kat_plot
doc: "Create K-mer Plots\n\nTool homepage: https://github.com/TGAC/KAT"
inputs:
  - id: mode
    type: string
    doc: 'The plot mode to use. Options include: density, profile, spectra-cn, spectra-hist,
      spectra-mx, cold.'
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print extra information
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kat:2.4.2--py39he0b6574_5
stdout: kat_plot.out
