cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutscan
label: mutscan
doc: "MutScan: detect and visualize target mutations by scanning FastQ files directly. Usage: mutscan --read1=string [options]\n\nTool homepage: https://github.com/OpenGene/MutScan"
inputs:
  - id: read1
    type: File
    doc: read1 file name
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: read2 file name
    inputBinding:
      position: 101
      prefix: --read2
  - id: mutation
    type:
      - 'null'
      - File
    doc: "mutation file name, can be a CSV format or a VCF format"
    inputBinding:
      position: 101
      prefix: --mutation
  - id: ref
    type:
      - 'null'
      - File
    doc: reference fasta file name (only needed when the mutation file is a VCF)
    inputBinding:
      position: 101
      prefix: --ref
  - id: html_path
    type:
      - 'null'
      - string
    doc: "filename of html report, default is mutscan.html in the work directory"
    inputBinding:
      position: 101
      prefix: --html
  - id: json_path
    type:
      - 'null'
      - string
    doc: "filename of JSON report, default is no JSON report"
    inputBinding:
      position: 101
      prefix: --json
  - id: thread
    type:
      - 'null'
      - int
    doc: "worker thread number, default is 4"
    inputBinding:
      position: 101
      prefix: --thread
  - id: support
    type:
      - 'null'
      - int
    doc: "min read support for reporting a mutation, default is 2"
    inputBinding:
      position: 101
      prefix: --support
  - id: mark
    type:
      - 'null'
      - boolean
    doc: "when the mutation file is a vcf file, only process the records with FILTER column M"
    inputBinding:
      position: 101
      prefix: --mark
  - id: legacy
    type:
      - 'null'
      - boolean
    doc: "use legacy mode, usually much slower but may be able to find a little more reads in certain cases"
    inputBinding:
      position: 101
      prefix: --legacy
  - id: standalone
    type:
      - 'null'
      - boolean
    doc: output standalone HTML report with a single file; do not use when scanning too many target mutations (more than 1000)
    inputBinding:
      position: 101
      prefix: --standalone
  - id: simplified
    type:
      - 'null'
      - string
    doc: "simplified mode uses less RAM but reports less information; auto, on or off (default auto)"
    inputBinding:
      position: 101
      prefix: --simplified
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "enable verbose mode, more information will be output in STDERR"
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: html
    type: File
    doc: HTML report
    outputBinding:
      glob: "$(inputs.html_path || \"mutscan.html\")"
  - id: json
    type:
      - 'null'
      - File
    doc: JSON report
    outputBinding:
      glob: "$(inputs.json_path)"
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Messages (standard error)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mutscan:1.14.1--h5ca1c30_0
stdout: mutscan.out
stderr: mutscan.err
