cwlVersion: v1.2
class: CommandLineTool
baseCommand: compile_stats
label: samsifter_compile_stats
doc: "compile statistics from temporary files (per-taxon read counts written by count_taxon_reads)\n\nTool homepage: https://github.com/BioInf-Wuerzburg/SamSifter"
inputs:
  - id: stats_files
    type:
      type: array
      items: File
    doc: "temporary statistics files <prefix>.NNN.csv, staged in the working directory"
  - id: prefix
    type:
      - 'null'
      - string
    doc: "prefix of temporary statistics files"
    inputBinding:
      position: 2
      prefix: -p
  - id: remove
    type:
      - 'null'
      - boolean
    doc: "remove temporary statistics files after use"
    inputBinding:
      position: 3
      prefix: -r
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "print additional information to STDERR"
    inputBinding:
      position: 4
      prefix: -v
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "print debug messages to STDERR"
    inputBinding:
      position: 5
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
      - $(inputs.stats_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
stdout: samsifter_compile_stats.out
stderr: samsifter_compile_stats.err
