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
  - id: output_folder
    type: string
    doc: Output folder for generated plots
    inputBinding:
      position: 3
  - id: threshold
    type: float
    doc: Threshold value for analysis
    inputBinding:
      position: 4
  - id: lineage_list_html
    type:
      - 'null'
      - File
    doc: Local copy of https://cov-lineages.org/lineage_list.html, used when 
      the page cannot be downloaded (staged as testdata/lineage_list.html)
outputs:
  - id: output_dir
    type: Directory
    doc: Output folder for generated plots
    outputBinding:
      glob: $(inputs.output_folder)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - |-
        ${ if (inputs.lineage_list_html) { return [{"entryname": "testdata/lineage_list.html", "entry": inputs.lineage_list_html}]; } return []; }
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/corona_lineage_dynamics:0.1.7--r44h6a1216f_0
