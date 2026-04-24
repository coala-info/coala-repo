cwlVersion: v1.2
class: CommandLineTool
baseCommand: igv
label: igv
doc: "Space delimited list of data files to load\n\nTool homepage: http://www.broadinstitute.org/software/igv/home"
inputs:
  - id: data_files
    type:
      type: array
      items: File
    doc: Space delimited list of data files to load
    inputBinding:
      position: 1
  - id: batch_command_file
    type:
      - 'null'
      - File
    doc: Path or url to a batch command file
    inputBinding:
      position: 102
      prefix: --batch.
  - id: coverage_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Coverage file or comma delimited list of coverage files corresponding 
      to data files
    inputBinding:
      position: 102
      prefix: --coverageFile
  - id: data_server_url
    type:
      - 'null'
      - string
    doc: Path or url to a data server registry file
    inputBinding:
      position: 102
      prefix: --dataServerURL
  - id: genome
    type:
      - 'null'
      - string
    doc: Genome ID (e.g hg19) or path or url to .genome or indexed fasta file
    inputBinding:
      position: 102
      prefix: --genome
  - id: genome_server_url
    type:
      - 'null'
      - string
    doc: Path or url to a genome server registry file
    inputBinding:
      position: 102
      prefix: --genomeServerURL
  - id: http_header
    type:
      - 'null'
      - string
    doc: http header to include with all requests for list of data files
    inputBinding:
      position: 102
      prefix: --header
  - id: igv_directory
    type:
      - 'null'
      - Directory
    doc: Path to the local igv directory. Defaults to <user home>/igv
    inputBinding:
      position: 102
      prefix: --igvDirectory
  - id: index_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Index file or comma delimited list of index files corresponding to data
      files
    inputBinding:
      position: 102
      prefix: --indexFile
  - id: locus
    type:
      - 'null'
      - string
    doc: Initial locus
    inputBinding:
      position: 102
      prefix: --locus
  - id: port
    type:
      - 'null'
      - int
    doc: IGV command port number (defaults to 60151)
    inputBinding:
      position: 102
      prefix: --port
  - id: preferences
    type:
      - 'null'
      - File
    doc: Path or URL to a preference property file
    inputBinding:
      position: 102
      prefix: --preferences
  - id: track_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Name or comma-delimited list of names for tracks corresponding to data 
      files
    inputBinding:
      position: 102
      prefix: --name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igv:2.19.7--h33ea123_0
stdout: igv.out
