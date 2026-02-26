cwlVersion: v1.2
class: CommandLineTool
baseCommand: isocor
label: isocor
doc: "A tool for analyzing isotopic distributions of molecules.\n\nTool homepage:
  https://github.com/MetaSys-LISBP/IsoCor/"
inputs:
  - id: input_file
    type: File
    doc: Input file containing molecular formulas or names.
    inputBinding:
      position: 1
  - id: charge_state
    type:
      - 'null'
      - type: array
        items: int
    doc: Specify charge states to consider.
    inputBinding:
      position: 102
      prefix: --charge-state
  - id: element_composition
    type:
      - 'null'
      - string
    doc: Specify elemental composition for isotopic calculation (e.g., 
      'C10H20O5').
    inputBinding:
      position: 102
      prefix: --element-composition
  - id: isotopes
    type:
      - 'null'
      - string
    doc: Specify isotopes to include (e.g., '13C,2H').
    inputBinding:
      position: 102
      prefix: --isotopes
  - id: mass_range
    type:
      - 'null'
      - string
    doc: Specify the mass range for isotopic distribution calculation (e.g., 
      '100-200').
    inputBinding:
      position: 102
      prefix: --mass-range
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Generate a plot of the isotopic distribution.
    inputBinding:
      position: 102
      prefix: --plot
  - id: resolution
    type:
      - 'null'
      - float
    doc: Mass spectrometry resolution.
    default: 1000.0
    inputBinding:
      position: 102
      prefix: --resolution
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to save the results.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isocor:2.2.2--pyhdfd78af_0
