cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mdmcleaner
  - get_markers
label: mdmcleaner_get_markers
doc: "Extracts marker genes from input FASTA files.\n\nTool homepage: https://github.com/KIT-IBG-5/mdmcleaner"
inputs:
  - id: input_fastas
    type:
      type: array
      items: File
    doc: input fasta(s). May be gzip-compressed
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
  - id: markertype
    type:
      - 'null'
      - string
    doc: type of marker gene that should be extracted
    inputBinding:
      position: 102
      prefix: --markertype
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: minimum contig length (contigs shorter than this will be ignored)
    inputBinding:
      position: 102
      prefix: --mincontiglength
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory (will be created if it does not exist).
    inputBinding:
      position: 102
      prefix: --outdir
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use (default = use setting from config file)
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
stdout: mdmcleaner_get_markers.out
