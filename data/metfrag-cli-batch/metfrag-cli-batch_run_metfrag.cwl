cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_metfrag.sh
label: metfrag-cli-batch_run_metfrag
doc: "Run MetFrag in parallel over the lines of one or more parameter files (GNU parallel), writing results to a results file or folder.\n\nTool homepage: http://c-ruttkies.github.io/MetFrag/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.support_files || [])
inputs:
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: "Parameter file (-p): each line holds the key=value settings of one MetFrag run. Comma-separated names are allowed."
    inputBinding:
      position: 1
      prefix: -p
  - id: parameter_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Several parameter files (-pp), joined with commas. Use either parameter_file or parameter_files."
    inputBinding:
      position: 1
      prefix: -pp
      itemSeparator: ','
  - id: additional_parameters
    type:
      - 'null'
      - string
    doc: "Extra MetFrag key=value parameters appended to every run (-a)."
    inputBinding:
      position: 2
      prefix: -a
  - id: local_database_path
    type:
      - 'null'
      - File
    doc: "Local candidate database appended as LocalDatabasePath (-l)."
    inputBinding:
      position: 2
      prefix: -l
  - id: results_path
    type:
      - 'null'
      - string
    doc: "Folder for the result files, one per run (-r). Created before the run."
    inputBinding:
      position: 2
      prefix: -r
  - id: results_file
    type:
      - 'null'
      - string
    doc: "Single results file (-f). Use either results_file or results_path."
    inputBinding:
      position: 2
      prefix: -f
  - id: zip_file
    type:
      - 'null'
      - string
    doc: "Name of a zip archive that collects the files in results_path (-z)."
    inputBinding:
      position: 2
      prefix: -z
  - id: output_file
    type:
      - 'null'
      - string
    doc: "Merged results table written when rename_results is true (-o)."
    inputBinding:
      position: 2
      prefix: -o
  - id: rename_results
    type:
      - 'null'
      - string
    doc: "Set to true to add file name, parent m/z and retention time columns and merge results into output_file (-rn)."
    inputBinding:
      position: 2
      prefix: -rn
  - id: additional_scores
    type:
      - 'null'
      - string
    doc: "Comma-separated extra score types added to MetFragScoreTypes (-s)."
    inputBinding:
      position: 2
      prefix: -s
  - id: support_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named inside the parameter files, staged in the working directory."
outputs:
  - id: results_file_out
    type:
      - 'null'
      - File
    doc: "Results file written with -f."
    outputBinding:
      glob: $(inputs.results_file)
  - id: results_path_out
    type:
      - 'null'
      - Directory
    doc: "Result folder written with -r."
    outputBinding:
      glob: $(inputs.results_path)
  - id: merged_output
    type:
      - 'null'
      - File
    doc: "Merged results table written with -o."
    outputBinding:
      glob: $(inputs.output_file)
  - id: zip_out
    type:
      - 'null'
      - File
    doc: "Zip archive written with -z."
    outputBinding:
      glob: $(inputs.zip_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metfrag-cli-batch:v2.4.3_cv0.6
stdout: metfrag-cli-batch_run_metfrag.out
