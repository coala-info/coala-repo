cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - prepare-depth-of-coverage
label: pypgx_prepare-depth-of-coverage
doc: "Prepare a depth of coverage file for all target genes with SV from BAM files.\n\
  \nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: depth_of_coverage
    type: File
    doc: Output archive file with the semantic type CovFrame[DepthOfCoverage].
    inputBinding:
      position: 1
  - id: bams
    type:
      type: array
      items: File
    doc: One or more input BAM files. Alternatively, you can provide a text file
      (.txt, .tsv, .csv, or .list) containing one BAM file per line.
    inputBinding:
      position: 2
  - id: assembly
    type:
      - 'null'
      - string
    doc: "Reference genome assembly (default: 'GRCh37') (choices: 'GRCh37', 'GRCh38')."
    default: GRCh37
    inputBinding:
      position: 103
      prefix: --assembly
  - id: bed
    type:
      - 'null'
      - File
    doc: By default, the input data is assumed to be WGS. If it's targeted 
      sequencing, you must provide a BED file to indicate probed regions. Note 
      that the 'chr' prefix in contig names (e.g. 'chr1' vs. '1') will be 
      automatically added or removed as necessary to match the input BAM's 
      contig names.
    inputBinding:
      position: 103
      prefix: --bed
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude specified genes. Ignored when --genes is not used.
    inputBinding:
      position: 103
      prefix: --exclude
  - id: genes
    type:
      - 'null'
      - type: array
        items: string
    doc: List of genes to include.
    inputBinding:
      position: 103
      prefix: --genes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
stdout: pypgx_prepare-depth-of-coverage.out
