cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - AMAS.py
  - summary
label: amas_summary
doc: "Write alignment summary\n\nTool homepage: https://github.com/marekborowiec/AMAS"
inputs:
  - id: summary_out
    type: ['null', string]
    doc: "File name for the alignment summary. Default: 'summary.txt'"
    default: summary.txt
    inputBinding:
      position: 1
      prefix: --summary-out
  - id: by_taxon
    type: ['null', boolean]
    doc: "In addition to alignment summary, write by sequence/taxon summaries. Default: Don't write"
    inputBinding:
      position: 1
      prefix: --by-taxon
  - id: check_align
    type: ['null', boolean]
    doc: 'Check if input sequences are aligned. Default: no check'
    inputBinding:
      position: 1
      prefix: --check-align
  - id: cores
    type: ['null', int]
    doc: 'Number of cores used. Default: 1'
    inputBinding:
      position: 1
      prefix: --cores
  - id: in_files
    type: File[]
    doc: 'Alignment files to be taken as input'
    inputBinding:
      position: 1
      prefix: --in-files
  - id: in_format
    type: {type: enum, symbols: [fasta, phylip, nexus, phylip-int, nexus-int]}
    doc: 'The format of input alignment'
    inputBinding:
      position: 1
      prefix: --in-format
  - id: data_type
    type: {type: enum, symbols: [aa, dna]}
    doc: 'Type of data'
    inputBinding:
      position: 1
      prefix: --data-type
outputs:
  - id: summary
    type: File
    doc: Alignment summary table
    outputBinding:
      glob: $(inputs.summary_out)
  - id: taxon_summaries
    type: File[]
    doc: Per sequence/taxon summaries (<input name>-seq-summary.txt), written with --by-taxon
    outputBinding:
      glob: '*-seq-summary.txt'
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.in_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
