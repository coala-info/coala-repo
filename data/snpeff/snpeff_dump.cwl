cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snpEff
  - dump
label: snpeff_dump
doc: "Dump the genome database (genes, transcripts and exons) as a table or BED file.\n\nTool homepage: http://snpeff.sourceforge.net/"
inputs:
  - id: bed
    type:
      - 'null'
      - boolean
    doc: "Dump in BED format (implies -0)"
    inputBinding:
      position: 1
      prefix: -bed
  - id: chr_prefix
    type:
      - 'null'
      - string
    doc: "Prepend 'string' to chromosome name (e.g. 'chr1' instead of '1')"
    inputBinding:
      position: 1
      prefix: -chr
  - id: txt
    type:
      - 'null'
      - boolean
    doc: "Dump as a TXT table (implies -1)"
    inputBinding:
      position: 1
      prefix: -txt
  - id: zero_based
    type:
      - 'null'
      - boolean
    doc: "Output zero-based coordinates."
    inputBinding:
      position: 1
      prefix: '-0'
  - id: one_based
    type:
      - 'null'
      - boolean
    doc: "Output one-based coordinates"
    inputBinding:
      position: 1
      prefix: '-1'
  - id: genome_version
    type: string
    doc: "Genome version (database name)"
    inputBinding:
      position: 2
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
stdout: snpeff_dump.out
stderr: snpeff_dump.err
