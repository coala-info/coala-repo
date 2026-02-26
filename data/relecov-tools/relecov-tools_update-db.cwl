cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - relecov-tools
  - update-db
label: relecov-tools_update-db
doc: "upload the information included in json file to the database\n\nTool homepage:
  https://github.com/BU-ISCIII/relecov-tools"
inputs:
  - id: full_update
    type:
      - 'null'
      - string
    doc: 'Run the full update. Use without value to run all steps. Optionally pass
      a comma-separated list of step numbers to run only those: 1=sample->iSkyLIMS,
      2=sample->relecov, 3=bioinfodata->relecov, 4=variantdata->relecov.'
    inputBinding:
      position: 101
      prefix: --full_update
  - id: json_data
    type:
      - 'null'
      - string
    doc: data in json format
    inputBinding:
      position: 101
      prefix: --json
  - id: long_table_file
    type:
      - 'null'
      - File
    doc: Long_table.json file from read-bioinfo-metadata + viralrecon
    inputBinding:
      position: 101
      prefix: --long_table
  - id: password
    type:
      - 'null'
      - string
    doc: password for the user to login
    inputBinding:
      position: 101
      prefix: --password
  - id: platform
    type:
      - 'null'
      - string
    doc: name of the platform where data is uploaded
    inputBinding:
      position: 101
      prefix: --platform
  - id: server_url
    type:
      - 'null'
      - string
    doc: url of the platform server
    inputBinding:
      position: 101
      prefix: --server_url
  - id: upload_target_type
    type:
      - 'null'
      - string
    doc: 'Select the upload target. Without --full_update choose one of [sample|bioinfodata|variantdata].
      With --full_update provide the step numbers to run in order: 1=sample->iSkyLIMS,
      2=sample->relecov, 3=bioinfodata->relecov, 4=variantdata->relecov.'
    inputBinding:
      position: 101
      prefix: --type
  - id: user
    type:
      - 'null'
      - string
    doc: user name for login
    inputBinding:
      position: 101
      prefix: --user
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
stdout: relecov-tools_update-db.out
