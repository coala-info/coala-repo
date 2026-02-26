cwlVersion: v1.2
class: CommandLineTool
baseCommand: mdmcleaner_clean
label: mdmcleaner_clean
doc: "Clean input fastas of genomes and/or bins.\n\nTool homepage: https://github.com/KIT-IBG-5/mdmcleaner"
inputs:
  - id: input_fastas
    type:
      type: array
      items: File
    doc: input fastas of genomes and/or bins
    inputBinding:
      position: 1
  - id: blacklist_file
    type:
      - 'null'
      - File
    doc: File listing reference-DB sequence-names that should be ignored during 
      blast-analyses (e.g. known refDB-contaminations...
    inputBinding:
      position: 102
      prefix: --blacklistfile
  - id: config_file
    type:
      - 'null'
      - File
    doc: "provide a local config file with basic settings (such as the location of
      database-files). default: looks for config files named 'mdmcleaner.config' in
      current working directory. settings in the local config file will override settings
      in the global config file '/usr/local/lib/python3.11/site-packages/mdmcleaner/mdmcleaner.config'"
    inputBinding:
      position: 102
      prefix: --config
  - id: fast_run
    type:
      - 'null'
      - boolean
    doc: skip detailed analyses of potential reference ambiguities (runs may be 
      faster but also classification may be less exact, and potential reference 
      database contaminations will not be verified)
    inputBinding:
      position: 102
      prefix: --fast_run
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force reclassification of pre-existing blast-results
    inputBinding:
      position: 102
      prefix: --force
  - id: ignore_default_blacklist
    type:
      - 'null'
      - boolean
    doc: Ignore the default blacklist
    default: false
    inputBinding:
      position: 102
      prefix: --ignore_default_blacklist
  - id: no_filterfasta
    type:
      - 'null'
      - boolean
    doc: Do not write filtered contigs to final output fastas
    default: false
    inputBinding:
      position: 102
      prefix: --no_filterfasta
  - id: outblacklist
    type:
      - 'null'
      - File
    doc: Outputfile for new blacklist additions. If a preexisting file is 
      selected, additions will be appended to end of that file
    inputBinding:
      position: 102
      prefix: --outblacklist
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: output-folder for MDMcleaner results.
    default: mdmcleaner_output
    inputBinding:
      position: 102
      prefix: --output_folder
  - id: overview_files_basename
    type:
      - 'null'
      - string
    doc: basename for overviewfiles
    default: overview
    inputBinding:
      position: 102
      prefix: --overview_files_basename
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. (default = use setting from config file)
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mdmcleaner:0.8.7--pyh7cba7a3_0
stdout: mdmcleaner_clean.out
