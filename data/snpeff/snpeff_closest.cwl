cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snpEff
  - closest
label: snpeff_closest
doc: "Find the closest exon (or the distance to the TSS) for each variant or interval.\n\nTool homepage: http://snpeff.sourceforge.net/"
inputs:
  - id: bed
    type:
      - 'null'
      - boolean
    doc: "Input format is BED. Default: VCF"
    inputBinding:
      position: 1
      prefix: -bed
  - id: tss
    type:
      - 'null'
      - boolean
    doc: "Measure distance from TSS (transcription start site)"
    inputBinding:
      position: 1
      prefix: -tss
  - id: genome_version
    type: string
    doc: "Genome version (database name)"
    inputBinding:
      position: 2
  - id: input_file
    type: File
    doc: "Input file (VCF, or BED with -bed)"
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
stdout: snpeff_closest.out
stderr: snpeff_closest.err
