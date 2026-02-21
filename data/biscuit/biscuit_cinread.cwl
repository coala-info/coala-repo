cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biscuit
  - cinread
label: biscuit_cinread
doc: "Extract cytosine information from a BAM file based on a reference genome.\n\n
  Tool homepage: https://github.com/huishenlab/biscuit"
inputs:
  - id: reference_fasta
    type: File
    doc: Reference genome in FASTA format
    inputBinding:
      position: 1
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 2
  - id: print_content
    type:
      - 'null'
      - string
    doc: 'Content to print, ","-delimited. Options: QNAME, QPAIR, STRAND, BSSTRAND,
      MAPQ, QBEG, QEND, CHRM, CRPOS, CGRPOS, CQPOS, CRBASE, CCTXT, CQBASE, CRETENTION'
    default: QNAME,QPAIR,BSSTRAND,CRBASE,CQBASE
    inputBinding:
      position: 103
      prefix: -p
  - id: region
    type:
      - 'null'
      - string
    doc: Region (optional, will process the whole bam if not specified)
    inputBinding:
      position: 103
      prefix: -g
  - id: secondary_mapping
    type:
      - 'null'
      - boolean
    doc: Consider secondary mapping
    default: false
    inputBinding:
      position: 103
      prefix: -s
  - id: target
    type:
      - 'null'
      - string
    doc: Target (c, cg, ch, hcg, gch, hch)
    default: cg
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file [stdout]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
