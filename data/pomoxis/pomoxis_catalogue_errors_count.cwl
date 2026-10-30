cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - catalogue_errors
  - count
label: pomoxis_catalogue_errors_count
doc: "Count query errors in a bam.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: bam
    type: File
    doc: Input alignments (bam, aligned to the reference; indexed; MD tag required).
    inputBinding:
      position: 1
    secondaryFiles:
      - pattern: .bai
        required: false
  - id: bed
    type:
      - 'null'
      - File
    doc: .bed file of reference regions to include.
    inputBinding:
      position: 102
      prefix: --bed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel execution (default 1).
    inputBinding:
      position: 102
      prefix: --threads
  - id: outdir
    type:
      - 'null'
      - string
    default: error_catalogue
    doc: Output directory.
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: counts_dir
    type: Directory
    doc: Directory with the error counts (.pkl).
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
