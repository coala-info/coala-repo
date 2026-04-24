cwlVersion: v1.2
class: CommandLineTool
baseCommand: mdmcleaner refdb_contams
label: mdmcleaner_refdb_contams
doc: "Analyze the ambiguity report file to identify and manage contaminants in a reference
  database.\n\nTool homepage: https://github.com/KIT-IBG-5/mdmcleaner"
inputs:
  - id: ambiguity_report
    type: File
    doc: The ambiguity report file to analyse (Usually 
      './overview_refdb_ambiguities.tsv')
    inputBinding:
      position: 1
  - id: config_file
    type:
      - 'null'
      - File
    doc: "provide a local config file with the target location to store database-files.
      directory. settings in the local config file will override settings in the global
      config file '/usr/local/lib/python3.11/site-packages/mdmcleaner/mdmcleaner.config'"
    inputBinding:
      position: 102
      prefix: --config
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use (default = use setting from config file)
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: out_blacklist
    type:
      - 'null'
      - File
    doc: Outputfile for new blacklist additions. If a preexisting file is 
      selected, additions will be appended to end of that file
    outputBinding:
      glob: $(inputs.out_blacklist)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
