cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequenza-utils
  - seqz_binning
label: sequenza-utils_seqz_binning
doc: 'Perform the binning of the seqz file to reduce file size and memory requirement for the analysis.


  Tool homepage: http://sequenza-utils.readthedocs.org'
inputs:
  - id: seqz
    type: File
    doc: A seqz file.
    inputBinding:
      position: 1
      prefix: --seqz
  - id: output_name
    type: string
    doc: Output file name. Default STDOUT ("-"). Gzip compression when the name ends in .gz.
    inputBinding:
      position: 2
      prefix: -o
  - id: window
    type:
      - 'null'
      - int
    doc: Window size used for binning the original seqz file. Default 50.
    inputBinding:
      position: 3
      prefix: --window
  - id: tabix
    type:
      - 'null'
      - string
    doc: Path of the tabix binary. Default "tabix".
    inputBinding:
      position: 4
      prefix: --tabix
outputs:
  - id: output_seqz
    type: File
    doc: Binned seqz file.
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
