cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - compute-target-depth
label: pypgx_compute-target-depth
doc: "Compute read depth for target gene from BAM files.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: gene
    type: string
    doc: Target gene.
    inputBinding:
      position: 1
  - id: read_depth
    type: File
    doc: Output archive file with the semantic type CovFrame[ReadDepth].
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
    default: GRCh37
    inputBinding:
      position: 104
      prefix: --assembly
  - id: bed_file
    type:
      - 'null'
      - File
    doc: By default, the input data is assumed to be WGS. If it is targeted 
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
stdout: pypgx_compute-target-depth.out
