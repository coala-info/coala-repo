cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snpEff
  - seq
label: snpeff_seq
doc: "Show the sequence of genomic regions, genes or transcripts of a genome database.\n\nTool homepage: http://snpeff.sourceforge.net/"
inputs:
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: "Reverse-Watson-Cricks complement."
    inputBinding:
      position: 1
      prefix: -r
  - id: genome_version
    type: string
    doc: "Genome version (database name)"
    inputBinding:
      position: 2
  - id: seqs
    type:
      type: array
      items: string
    doc: "Sequence names or regions"
    inputBinding:
      position: 3
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
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Override data_dir parameter from config file.
    inputBinding:
      position: 104
      prefix: -dataDir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode (very verbose).
    inputBinding:
      position: 104
      prefix: -d
  - id: no_download
    type:
      - 'null'
      - boolean
    doc: Do not download a SnpEff database, if not available locally.
    inputBinding:
      position: 104
      prefix: -nodownload
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
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpeff:5.4.0a--hdfd78af_0
stdout: snpeff_seq.out
stderr: snpeff_seq.err
