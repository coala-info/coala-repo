cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimi_mass_analysis
label: mimi_mimi_mass_analysis
doc: "Molecular Isotope Mass Identifier\n\nTool homepage: https://github.com/NYUAD-Core-Bioinformatics/MIMI"
inputs:
  - id: cache
    type:
      type: array
      items: File
    doc: Binary DB input file(s)
    inputBinding:
      position: 101
      prefix: --cache
  - id: iso_validation
    type:
      - 'null'
      - boolean
    doc: Include isotope validation counts in output (adds 'iso_valid' column)
    default: false
    inputBinding:
      position: 101
      prefix: --iso-validation
  - id: ppm
    type: float
    doc: Parts per million for the mono isotopic mass of chemical formula
    inputBinding:
      position: 101
      prefix: --ppm
  - id: sample
    type:
      type: array
      items: File
    doc: Input sample file
    inputBinding:
      position: 101
      prefix: --sample
  - id: vp_ppm
    type: float
    doc: Parts per million for verification of isotopes
    inputBinding:
      position: 101
      prefix: -vp
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
