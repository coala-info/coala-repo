cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snpEff
  - download
label: snpeff_download
doc: "Download a SnpEff database (or the SnpEff program itself) for a genome version.\n\nTool homepage: http://snpeff.sourceforge.net/"
inputs:
  - id: genome_version
    type: string
    doc: "Genome version (database name)"
    inputBinding:
      position: 2
  - id: data_dir_out
    type:
      - 'null'
      - string
    doc: "Directory where the database is stored (-dataDir); it is created when missing"
    inputBinding:
      position: 1
      prefix: -dataDir
      valueFrom: $(runtime.outdir + '/' + self)
  - id: config_file
    type:
      - 'null'
      - File
    doc: Specify config file
    inputBinding:
      position: 104
      prefix: -c
  - id: config_option
    type:
      - 'null'
      - string
    doc: Override a config file option
    inputBinding:
      position: 104
      prefix: -configOption
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode (very verbose).
    inputBinding:
      position: 104
      prefix: -d
  - id: no_log
    type:
      - 'null'
      - boolean
    doc: Do not report usage statistics to server
    inputBinding:
      position: 104
      prefix: -noLog
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode (do not show any messages or errors)
    inputBinding:
      position: 104
      prefix: -q
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (messages)
  - id: database_dir
    type: Directory
    doc: The data directory holding the downloaded database
    outputBinding:
      glob: $(inputs.data_dir_out)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
stdout: snpeff_download.out
stderr: snpeff_download.err
