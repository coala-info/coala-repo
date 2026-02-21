cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - melting-gui
  - inflectionpointcalc
label: melting-gui_inflectionpointcalc
doc: "A tool for calculating inflection points within the melting-gui suite. (Note:
  The provided help text contained only system error messages and no usage information.)\n
  \nTool homepage: https://github.com/GokalpKoreken/Auto-Thermodynamic-Point-of-Inflection-on-Melting-Curve-Calculator-GUI-"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/melting-gui:v4.3.1dfsg-2-deb_cv1
stdout: melting-gui_inflectionpointcalc.out
