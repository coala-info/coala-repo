cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_taxon_pmds
label: samsifter_filter_taxon_pmds
doc: "Filter taxa with high attribution of ancient reads in a MALT'ed and PMD'ed SAM file\n\nTool homepage: https://github.com/BioInf-Wuerzburg/SamSifter"
inputs:
  - id: input_sam
    type: File
    doc: "SAM file to be analysed; it is read from standard input, because the -i option of this tool crashes"
  - id: discard
    type:
      - 'null'
      - int
    doc: "keep or discard entries passing the filter criteria? (0 = discard, 1 = keep)"
    inputBinding:
      position: 2
      prefix: --discard
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
  - id: modify
    type:
      - 'null'
      - boolean
    doc: "modify header by adding PG record"
    inputBinding:
      position: 5
      prefix: -m
  - id: pmds
    type: float
    doc: "post-mortem degradation score (PMDS) threshold"
    inputBinding:
      position: 6
      prefix: -p
  - id: reads_perc
    type:
      - 'null'
      - float
    doc: "attributed read threshold (percent)"
    inputBinding:
      position: 7
      prefix: -rp
  - id: reads_total
    type:
      - 'null'
      - int
    doc: "attributed read threshold (total)"
    inputBinding:
      position: 8
      prefix: -rt
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the processed SAM)
  - id: stderr
    type: stderr
    doc: Standard error (log messages)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samsifter:1.0.0--py35h3978dc7_3
stdout: samsifter_filter_taxon_pmds.out
stderr: samsifter_filter_taxon_pmds.err
stdin: $(inputs.input_sam.path)
