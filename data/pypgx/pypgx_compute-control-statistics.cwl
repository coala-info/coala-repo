cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - compute-control-statistics
label: pypgx_compute-control-statistics
doc: "Compute summary statistics for control gene from BAM files.\n\nTool homepage:
  https://github.com/sbslee/pypgx"
inputs:
  - id: gene
    type: string
    doc: "Control gene (recommended choices: 'EGFR', 'RYR1', 'VDR'). Alternatively,
      you can provide a custom region (format: chrom:start-end)."
    inputBinding:
      position: 1
  - id: control_statistics
    type: File
    doc: Output archive file with the semantic type SampleTable[Statistics].
    inputBinding:
      position: 2
  - id: bams
    type:
      type: array
      items: File
    doc: One or more input BAM files. Alternatively, you can provide a text file
      (.txt, .tsv, .csv, or .list) containing one BAM file per line.
    inputBinding:
      position: 3
  - id: assembly
    type:
      - 'null'
      - string
    doc: "Reference genome assembly (default: 'GRCh37') (choices: 'GRCh37', 'GRCh38')."
    inputBinding:
      position: 104
      prefix: --assembly
  - id: bed
    type:
      - 'null'
      - File
    doc: By default, the input data is assumed to be WGS. If it's targeted 
      sequencing, you must provide a BED file to indicate probed regions.
    inputBinding:
      position: 104
      prefix: --bed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
stdout: pypgx_compute-control-statistics.out
