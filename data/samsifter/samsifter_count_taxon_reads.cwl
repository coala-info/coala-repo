cwlVersion: v1.2
class: CommandLineTool
baseCommand: count_taxon_reads
label: samsifter_count_taxon_reads
doc: "Counts reads per taxon ID and stores them in a separate statistics file.\n\nTool homepage: https://github.com/BioInf-Wuerzburg/SamSifter"
inputs:
  - id: input_sam
    type: File
    doc: "SAM file to be analysed (default: STDIN)"
    inputBinding:
      position: 1
      prefix: -i
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
  - id: stats_files
    type:
      type: array
      items: File
    doc: Temporary statistics file(s) with read counts per taxon
    outputBinding:
      glob: $((inputs.prefix || 'reads_per_taxon') + '.*')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
stdout: samsifter_count_taxon_reads.out
stderr: samsifter_count_taxon_reads.err
