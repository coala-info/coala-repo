cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenza-utils
  - gc_wiggle
label: sequenza-utils_gc_wiggle
doc: 'Given a fasta file and a window size it computes the GC percentage across the sequences, and returns a file in the UCSC wiggle format.


  Tool homepage: http://sequenza-utils.readthedocs.org'
inputs:
  - id: fasta
    type: File
    doc: The fasta file.
    inputBinding:
      position: 1
      prefix: --fasta
  - id: output_name
    type: string
    doc: Output file name. Default STDOUT ("-").
    inputBinding:
      position: 2
      prefix: -o
  - id: window
    type:
      - 'null'
      - int
    doc: The window size to calculate the GC-content percentage. Default 50.
    inputBinding:
      position: 3
      prefix: -w
outputs:
  - id: output_wig
    type: File
    doc: GC-content wiggle file.
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
