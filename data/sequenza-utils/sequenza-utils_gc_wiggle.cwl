cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenza-utils
  - gc_wiggle
label: sequenza-utils_gc_wiggle
doc: "Generates a wiggle file with GC content information for each bin.\n\nTool homepage:
  http://sequenza-utils.readthedocs.org"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA file containing the reference genome.
    inputBinding:
      position: 1
  - id: bin_size
    type:
      - 'null'
      - int
    doc: 'Size of bins in base pairs. Default: 10000.'
    default: 10000
    inputBinding:
      position: 102
      prefix: --bin-size
  - id: gc_window
    type:
      - 'null'
      - int
    doc: 'Window size for GC content calculation. Default: 1000.'
    default: 1000
    inputBinding:
      position: 102
      prefix: --gc-window
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. Default: 1.'
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Output wiggle file name.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
