cwlVersion: v1.2
class: CommandLineTool
baseCommand: summarize_stats
label: samsifter_summarize_stats
doc: "summarize the compiled statistics files (*.sifted.csv in the working directory) of several samples\n\nTool homepage: https://github.com/BioInf-Wuerzburg/SamSifter"
inputs:
  - id: sifted_files
    type:
      type: array
      items: File
    doc: "compiled statistics files named <sample>.sifted.csv, staged in the working directory"
  - id: prefix
    type:
      - 'null'
      - string
    doc: "prefix of temporary statistics files"
    inputBinding:
      position: 2
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "print additional information to STDERR"
    inputBinding:
      position: 3
      prefix: -v
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "print debug messages to STDERR"
    inputBinding:
      position: 4
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the processed SAM)
  - id: stderr
    type: stderr
    doc: Standard error (log messages)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.sifted_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
stdout: samsifter_summarize_stats.out
stderr: samsifter_summarize_stats.err
