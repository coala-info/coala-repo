cwlVersion: v1.2
class: CommandLineTool
baseCommand: irida-staramr-results
label: irida-staramr-results
doc: "Exports StarAMR results available through IRIDA into a single excel report.\n\
  \nTool homepage: https://github.com/phac-nml/irida-staramr-results"
inputs:
  - id: config
    type: File
    doc: Required. Path to a configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: from_date
    type:
      - 'null'
      - string
    doc: Download only results of the analysis that were created FROM this date 
      (YYYY-MM-DD).
    inputBinding:
      position: 101
      prefix: --from_date
  - id: password
    type:
      - 'null'
      - string
    doc: This is your IRIDA account password.
    inputBinding:
      position: 101
      prefix: --password
  - id: project
    type: string
    doc: Required. Project(s) to scan for StarAMR results.
    inputBinding:
      position: 101
      prefix: --project
  - id: split_results
    type:
      - 'null'
      - boolean
    doc: Export each analysis results into separate output files resulting to 
      one excel file per analysis.
    inputBinding:
      position: 101
      prefix: --split_results
  - id: to_date
    type:
      - 'null'
      - string
    doc: Download only results of the analysis that were created UP UNTIL this 
      date (YYYY-MM-DD).
    inputBinding:
      position: 101
      prefix: --to_date
  - id: username
    type:
      - 'null'
      - string
    doc: This is your IRIDA account username.
    inputBinding:
      position: 101
      prefix: --username
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The name of the output excel file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irida-staramr-results:0.3.1--pyh5e36f6f_0
