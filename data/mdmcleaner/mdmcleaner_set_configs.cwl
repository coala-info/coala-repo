cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mdmcleaner
  - set_configs
label: mdmcleaner_set_configs
doc: "Set mdmcleaner configuration options.\n\nTool homepage: https://github.com/KIT-IBG-5/mdmcleaner"
inputs:
  - id: aragorn
    type:
      - 'null'
      - File
    doc: path to aragorn binaries (if not in PATH)
    inputBinding:
      position: 101
      prefix: --aragorn
  - id: barrnap
    type:
      - 'null'
      - File
    doc: path to barrnap binaries (if not in PATH)
    inputBinding:
      position: 101
      prefix: --barrnap
  - id: blastn
    type:
      - 'null'
      - File
    doc: path to blastn binaries (if not in PATH)
    inputBinding:
      position: 101
      prefix: --blastn
  - id: blastp
    type:
      - 'null'
      - File
    doc: path to blastp binaries (if not in PATH)
    inputBinding:
      position: 101
      prefix: --blastp
  - id: db_basedir
    type:
      - 'null'
      - Directory
    doc: path to basedirectory for reference database
    inputBinding:
      position: 101
      prefix: --db_basedir
  - id: diamond
    type:
      - 'null'
      - File
    doc: path to diamond binaries (if not in PATH)
    inputBinding:
      position: 101
      prefix: --diamond
  - id: hmmsearch
    type:
      - 'null'
      - File
    doc: path to hmmsearch binaries (if not in PATH)
    inputBinding:
      position: 101
      prefix: --hmmsearch
  - id: scope
    type:
      - 'null'
      - string
    doc: change settings in local or global config file. 'global' likely require
      admin privileges. 'local' will modify or create a mdmcleaner.config file 
      in the current working directory.
    default: local
    inputBinding:
      position: 101
      prefix: --scope
  - id: threads
    type:
      - 'null'
      - int
    doc: threads to use by default
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
stdout: mdmcleaner_set_configs.out
