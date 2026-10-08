cwlVersion: v1.2
class: CommandLineTool
label: escher-fluxomics_create_site_for_data
doc: "Creates an Escher web site folder (index.html with the Escher viewer) that shows a metabolic map with reaction data.\n\nTool homepage: https://escher.github.io"
inputs:
  - id: output_dir
    type: string
    doc: Name of the output site folder to create
    inputBinding:
      position: 1
  - id: map_file
    type: File
    doc: Escher metabolic map in JSON format (copied to metabolic_map.json)
    inputBinding:
      position: 2
  - id: rxn_data_csv
    type: File
    doc: Reaction data CSV file with columns ID and Avg (copied to rxn_data.csv)
    inputBinding:
      position: 3
outputs:
  - id: site
    type: Directory
    doc: Site folder with index.html, metabolic_map.json and rxn_data.csv
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/escher-fluxomics:phenomenal-v1.6.0-beta.4_cv1.1.20
