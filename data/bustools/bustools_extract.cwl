cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bustools
  - extract
label: bustools_extract
doc: "Extract reads from FASTQ files based on a sorted BUS file. Note: BUS file should
  be sorted by flag using bustools sort --flag.\n\nTool homepage: https://github.com/BUStools/bustools"
inputs:
  - id: sorted_bus_file
    type: File
    doc: BUS file sorted by flag
    inputBinding:
      position: 1
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude reads in the BUS file from the specified FASTQ file(s)
    inputBinding:
      position: 102
      prefix: --exclude
  - id: fastq
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ file(s) from which to extract reads (comma-separated list)
    inputBinding:
      position: 102
      prefix: --fastq
  - id: include
    type:
      - 'null'
      - boolean
    doc: Include reads in the BUS file from the specified FASTQ file(s)
    inputBinding:
      position: 102
      prefix: --include
  - id: n_fastqs
    type:
      - 'null'
      - int
    doc: Number of FASTQ file(s) per run
    inputBinding:
      position: 102
      prefix: --nFastqs
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory for FASTQ files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
