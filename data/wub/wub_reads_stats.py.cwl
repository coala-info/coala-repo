cwlVersion: v1.2
class: CommandLineTool
baseCommand: reads_stats.py
label: wub_reads_stats.py
doc: "Calculates the GC content and N50\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: fastx
    type: File
    doc: "input file fastq or fasta"
    inputBinding:
      position: 1
      prefix: --fastx
  - id: raw
    type:
      - 'null'
      - boolean
    doc: "save raw the gc content per read/contig. default[False]"
    inputBinding:
      position: 2
      prefix: --raw
  - id: savepath
    type:
      - 'null'
      - string
    doc: "output dir. default[cwd]"
    inputBinding:
      position: 3
      prefix: --savepath
  - id: report
    type:
      - 'null'
      - boolean
    doc: "Report PDF default[False]"
    inputBinding:
      position: 4
      prefix: --report
  - id: tag
    type:
      - 'null'
      - string
    doc: "output name or tag. default[input name]"
    inputBinding:
      position: 5
      prefix: --tag
outputs:
  - id: summary_stats
    type: File
    doc: "Summary statistics (GC content, N50)"
    outputBinding:
      glob: '${ var d = inputs.savepath ? inputs.savepath + "/" : ""; return d + "*_summary.stats"; }'
  - id: raw_stats
    type:
      - 'null'
      - type: array
        items: File
    doc: "Per read statistics (with --raw)"
    outputBinding:
      glob: '${ var d = inputs.savepath ? inputs.savepath + "/" : ""; return d + "*_raw.stats"; }'
  - id: report_pdf
    type:
      - 'null'
      - type: array
        items: File
    doc: "Report PDF (with --report)"
    outputBinding:
      glob: '${ var d = inputs.savepath ? inputs.savepath + "/" : ""; return d + "*.pdf"; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
