cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/share/corona_lineage_dynamics/SDPlots_lineages_local.sh
label: corona_lineage_dynamics
doc: "Generates plots for lineage dynamics based on GISAID and monthly data.\n\nTool
  homepage: https://github.com/hzi-bifo/corona_lineage_dynamics"
inputs:
  - id: gisaid_file
    type: File
    doc: GISAID data file
    inputBinding:
      position: 1
  - id: months_file
    type: File
    doc: Monthly data file
    inputBinding:
      position: 2
  - id: threshold
    type: float
    doc: Threshold value for analysis
    inputBinding:
      position: 3
outputs:
  - id: output_folder
    type: Directory
    doc: Output folder for generated plots
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/corona_lineage_dynamics:0.1.7--r44h6a1216f_0
