cwlVersion: v1.2
class: CommandLineTool
baseCommand: metfrag.sh
label: metfrag-cli-batch_metfrag
doc: "Run MetFrag on every parameter file inside a zip archive (up to 10 jobs at a time) and collect the results in a zip archive.\n\nTool homepage: http://c-ruttkies.github.io/MetFrag/"
inputs:
  - id: zip_file
    type: File
    doc: "Zip archive of parameter files, one MetFrag parameter string per file (-z)."
    inputBinding:
      position: 1
      prefix: -z
  - id: parameters
    type:
      - 'null'
      - string
    doc: "Extra MetFrag key=value parameters added to every run (-p)."
    inputBinding:
      position: 2
      prefix: -p
  - id: database
    type:
      - 'null'
      - File
    doc: "Local candidate database used as LocalDatabasePath (-d)."
    inputBinding:
      position: 3
      prefix: -d
  - id: output
    type: string
    doc: "Name of the result zip archive (-o)."
    inputBinding:
      position: 4
      prefix: -o
outputs:
  - id: results_zip
    type: File
    doc: "Zip archive with one result CSV per parameter file."
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metfrag-cli-batch:v2.4.3_cv0.6
stdout: metfrag-cli-batch_metfrag.out
