cwlVersion: v1.2
class: CommandLineTool
baseCommand: mdmcleaner completeness
label: mdmcleaner_completeness
doc: "Completeness analysis for mdmcleaner\n\nTool homepage: https://github.com/KIT-IBG-5/mdmcleaner"
inputs:
  - id: configfile
    type:
      - 'null'
      - File
    doc: "provide a local config file with the target location to store database-files.
      default: looks for config files named 'mdmcleaner.config' in current working
      directory. settings in the local config file will override settings in the global
      config file '/usr/local/lib/python3.11/site-packages/mdmcleaner/mdmcleaner.config'"
    inputBinding:
      position: 101
      prefix: --config
  - id: input_fastas
    type:
      type: array
      items: File
    doc: input fasta(s). May be gzip-compressed
    inputBinding:
      position: 101
      prefix: --input_fastas
  - id: mincontiglength
    type:
      - 'null'
      - int
    doc: minimum contig length (contigs shorter than this will be ignored)
    inputBinding:
      position: 101
      prefix: --mincontiglength
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use (default = use setting from config file)
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
stdout: mdmcleaner_completeness.out
