cwlVersion: v1.2
class: CommandLineTool
baseCommand: mdmcleaner acc2taxpath
label: mdmcleaner_acc2taxpath
doc: "Convert accessions to taxonomic paths.\n\nTool homepage: https://github.com/KIT-IBG-5/mdmcleaner"
inputs:
  - id: accessions
    type:
      type: array
      items: string
    doc: (space separated list of) input accessions. Or just pass "interactive" 
      for interactive mode
    inputBinding:
      position: 1
  - id: config_file
    type:
      - 'null'
      - File
    doc: "provide a local config file with the target location to store database-files.
      default: looks for config files named 'mdmcleaner.config' in current working
      directory. settings in the local config file will override settings in the global
      config file '/usr/local/lib/python3.11/site-packages/mdmcleaner/mdmcleaner.config'"
    inputBinding:
      position: 102
      prefix: --config
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
stdout: mdmcleaner_acc2taxpath.out
