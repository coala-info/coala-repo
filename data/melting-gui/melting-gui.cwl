cwlVersion: v1.2
class: CommandLineTool
baseCommand: melting-gui
label: melting-gui
doc: "A graphical user interface for the MELTING software, which computes the enthalpy,
  entropy, and melting temperature of nucleic acid duplexes.\n\nTool homepage: https://github.com/GokalpKoreken/Auto-Thermodynamic-Point-of-Inflection-on-Melting-Curve-Calculator-GUI-"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/melting-gui:v4.3.1dfsg-2-deb_cv1
stdout: melting-gui.out
