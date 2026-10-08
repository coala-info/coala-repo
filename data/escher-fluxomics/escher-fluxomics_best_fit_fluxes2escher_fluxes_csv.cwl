cwlVersion: v1.2
class: CommandLineTool
baseCommand: best_fit_fluxes2escher_fluxes_csv
label: escher-fluxomics_best_fit_fluxes2escher_fluxes_csv
doc: "Converts an iso2flux best-fit fluxes CSV file (iso2flux 0.2, 0.6.1 or 0.7) into the ID,Avg CSV file that Escher uses for reaction data.\n\nTool homepage: https://escher.github.io"
inputs:
  - id: best_fit_fluxes
    type: File
    doc: iso2flux best-fit fluxes CSV file
    inputBinding:
      position: 1
  - id: escher_fluxes_name
    type: string
    doc: Name of the output CSV file with columns ID and Avg
    inputBinding:
      position: 2
outputs:
  - id: escher_fluxes
    type: File
    doc: CSV file with columns ID and Avg
    outputBinding:
      glob: $(inputs.escher_fluxes_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/escher-fluxomics:phenomenal-v1.6.0-beta.4_cv1.1.20
