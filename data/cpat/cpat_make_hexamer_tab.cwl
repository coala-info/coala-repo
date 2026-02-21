cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpat_make_hexamer_tab
label: cpat_make_hexamer_tab
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error regarding container image extraction
  (no space left on device).\n\nTool homepage: https://cpat.readthedocs.io/en/latest/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpat:3.0.5--py312hc9302aa_4
stdout: cpat_make_hexamer_tab.out
