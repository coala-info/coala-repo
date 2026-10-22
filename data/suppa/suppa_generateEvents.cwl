cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - suppa.py
  - generateEvents
label: suppa_generateEvents
doc: "Generate the alternative splicing events (or local events as ioe/ioi files) from a gene annotation file in GTF format.\n\nTool homepage: https://github.com/comprna/SUPPA"
inputs:
  - id: input_file
    type: File
    doc: specify input file
    inputBinding:
      position: 1
      prefix: --input-file
  - id: output_file
    type: string
    doc: specify output path and name without extension
    inputBinding:
      position: 1
      prefix: --output-file
  - id: format
    type: string
    doc: "Format of the annotation file: ioe (events) or ioi (isoforms)."
    inputBinding:
      position: 1
      prefix: --format
  - id: event_type
    type:
      - 'null'
      - type: array
        items: string
    doc: "list of events to analyze (space separated): SE (Skipping Exon), SS (Alternative Splice Site 5'/3'), MX (Mutually Exclusive Exon), RI (Retained Intron), FL (Alternative First/Last Exon)"
    inputBinding:
      position: 1
      prefix: --event-type
  - id: boundary
    type:
      - 'null'
      - string
    doc: "Boundary type: S (strict, default) or V (variable)."
    inputBinding:
      position: 1
      prefix: --boundary
  - id: threshold
    type:
      - 'null'
      - int
    doc: Variability threshold. In case of strict boundaries this argument is ignored (default 10nt).
    inputBinding:
      position: 1
      prefix: --threshold
  - id: pool_genes
    type:
      - 'null'
      - boolean
    doc: pool together overlapping genes.
    inputBinding:
      position: 1
      prefix: --pool-genes
  - id: exon_length
    type:
      - 'null'
      - int
    doc: length of the exons for its visualization (default 100nt)
    inputBinding:
      position: 1
      prefix: --exon-length
  - id: mode
    type:
      - 'null'
      - string
    doc: "to choose from DEBUG, INFO, WARNING, ERROR and CRITICAL"
    inputBinding:
      position: 1
      prefix: --mode
outputs:
  - id: events
    type:
      type: array
      items: File
    doc: Event files (ioe/ioi) written with the output name
    outputBinding:
      glob: $(inputs.output_file)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
