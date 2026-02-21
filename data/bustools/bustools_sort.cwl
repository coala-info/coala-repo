cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bustools
  - sort
label: bustools_sort
doc: "Sort BUS files by barcode, UMI, ec, and flag.\n\nTool homepage: https://github.com/BUStools/bustools"
inputs:
  - id: bus_files
    type:
      type: array
      items: File
    doc: BUS files to be sorted
    inputBinding:
      position: 1
  - id: count
    type:
      - 'null'
      - boolean
    doc: Sort by multiplicity, barcode, UMI, then ec
    inputBinding:
      position: 102
      prefix: --count
  - id: flags
    type:
      - 'null'
      - boolean
    doc: Sort by flag, ec, barcode, then UMI
    inputBinding:
      position: 102
      prefix: --flags
  - id: flags_bc
    type:
      - 'null'
      - boolean
    doc: Sort by flag, barcode, UMI, then ec
    inputBinding:
      position: 102
      prefix: --flags-bc
  - id: memory
    type:
      - 'null'
      - string
    doc: Maximum memory used
    inputBinding:
      position: 102
      prefix: --memory
  - id: no_flags
    type:
      - 'null'
      - boolean
    doc: Ignore and reset the flag while sorting
    inputBinding:
      position: 102
      prefix: --no-flags
  - id: pipe
    type:
      - 'null'
      - boolean
    doc: Write to standard output
    inputBinding:
      position: 102
      prefix: --pipe
  - id: temp
    type:
      - 'null'
      - string
    doc: Location and prefix for temporary files; required if using -p, otherwise
      defaults to output
    inputBinding:
      position: 102
      prefix: --temp
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: umi
    type:
      - 'null'
      - boolean
    doc: Sort by UMI, barcode, then ec
    inputBinding:
      position: 102
      prefix: --umi
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: File for sorted output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
