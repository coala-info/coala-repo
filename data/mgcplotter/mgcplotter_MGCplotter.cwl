cwlVersion: v1.2
class: CommandLineTool
baseCommand: MGCplotter
label: mgcplotter_MGCplotter
doc: "Microbial Genome Circular plotting tool\n\nTool homepage: https://github.com/moshi4/MGCplotter/"
inputs:
  - id: assign_cog_color
    type:
      - 'null'
      - boolean
    doc: 'Assign COG classification color to reference CDSs (Default: OFF)'
    inputBinding:
      position: 101
      prefix: --assign_cog_color
  - id: cog_color_json
    type:
      - 'null'
      - File
    doc: User-defined COG classification color json file
    inputBinding:
      position: 101
      prefix: --cog_color_json
  - id: cog_evalue
    type:
      - 'null'
      - float
    doc: 'COGclassifier e-value parameter (Default: 1e-02)'
    default: 0.01
    inputBinding:
      position: 101
      prefix: --cog_evalue
  - id: conserved_cds_color
    type:
      - 'null'
      - string
    doc: "Conserved CDS color (Default: 'chocolate')"
    default: chocolate
    inputBinding:
      position: 101
      prefix: --conserved_cds_color
  - id: conserved_cds_r
    type:
      - 'null'
      - float
    doc: 'Conserved CDS track radius size (Default: 0.04)'
    default: 0.04
    inputBinding:
      position: 101
      prefix: --conserved_cds_r
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Forcibly overwrite previous calculation result (Default: OFF)'
    inputBinding:
      position: 101
      prefix: --force
  - id: forward_cds_color
    type:
      - 'null'
      - string
    doc: "Forward CDS color (Default: 'red')"
    default: red
    inputBinding:
      position: 101
      prefix: --forward_cds_color
  - id: forward_cds_r
    type:
      - 'null'
      - float
    doc: 'Forward CDS track radius size (Default: 0.07)'
    default: 0.07
    inputBinding:
      position: 101
      prefix: --forward_cds_r
  - id: gc_content_n_color
    type:
      - 'null'
      - string
    doc: "GC content color for negative value from average (Default: 'grey')"
    default: grey
    inputBinding:
      position: 101
      prefix: --gc_content_n_color
  - id: gc_content_p_color
    type:
      - 'null'
      - string
    doc: "GC content color for positive value from average (Default: 'black')"
    default: black
    inputBinding:
      position: 101
      prefix: --gc_content_p_color
  - id: gc_content_r
    type:
      - 'null'
      - float
    doc: 'GC content track radius size (Default: 0.15)'
    default: 0.15
    inputBinding:
      position: 101
      prefix: --gc_content_r
  - id: gc_skew_n_color
    type:
      - 'null'
      - string
    doc: "GC skew color for negative value (Default: 'purple')"
    default: purple
    inputBinding:
      position: 101
      prefix: --gc_skew_n_color
  - id: gc_skew_p_color
    type:
      - 'null'
      - string
    doc: "GC skew color for positive value (Default: 'olive')"
    default: olive
    inputBinding:
      position: 101
      prefix: --gc_skew_p_color
  - id: gc_skew_r
    type:
      - 'null'
      - float
    doc: 'GC skew track radius size (Default: 0.15)'
    default: 0.15
    inputBinding:
      position: 101
      prefix: --gc_skew_r
  - id: mmseqs_evalue
    type:
      - 'null'
      - float
    doc: 'MMseqs RBH search e-value parameter (Default: 1e-03)'
    default: 0.001
    inputBinding:
      position: 101
      prefix: --mmseqs_evalue
  - id: query_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Query CDS fasta or genome genbank files 
      (*.fa|*.faa|*.fasta|*.gb|*.gbk|*.gbff)
    inputBinding:
      position: 101
      prefix: --query_files
  - id: ref_file
    type: File
    doc: Reference genome genbank file (*.gb|*.gbk|*.gbff)
    inputBinding:
      position: 101
      prefix: --ref_file
  - id: reverse_cds_color
    type:
      - 'null'
      - string
    doc: "Reverse CDS color (Default: 'blue')"
    default: blue
    inputBinding:
      position: 101
      prefix: --reverse_cds_color
  - id: reverse_cds_r
    type:
      - 'null'
      - float
    doc: 'Reverse CDS track radius size (Default: 0.07)'
    default: 0.07
    inputBinding:
      position: 101
      prefix: --reverse_cds_r
  - id: rrna_color
    type:
      - 'null'
      - string
    doc: "rRNA color (Default: 'green')"
    default: green
    inputBinding:
      position: 101
      prefix: --rrna_color
  - id: rrna_r
    type:
      - 'null'
      - float
    doc: 'rRNA track radius size (Default: 0.07)'
    default: 0.07
    inputBinding:
      position: 101
      prefix: --rrna_r
  - id: thread_num
    type:
      - 'null'
      - int
    doc: 'Threads number parameter (Default: 19)'
    default: 19
    inputBinding:
      position: 101
      prefix: --thread_num
  - id: ticks_labelsize
    type:
      - 'null'
      - int
    doc: 'Ticks label size (Default: 35)'
    default: 35
    inputBinding:
      position: 101
      prefix: --ticks_labelsize
  - id: trna_color
    type:
      - 'null'
      - string
    doc: "tRNA color (Default: 'magenta')"
    default: magenta
    inputBinding:
      position: 101
      prefix: --trna_color
  - id: trna_r
    type:
      - 'null'
      - float
    doc: 'tRNA track radius size (Default: 0.07)'
    default: 0.07
    inputBinding:
      position: 101
      prefix: --trna_r
outputs:
  - id: outdir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgcplotter:1.0.1--pyhdfd78af_0
