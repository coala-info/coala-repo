cwlVersion: v1.2
class: CommandLineTool
baseCommand: wisecondorx_convert
label: wisecondorx_convert
doc: "Convert and filter a aligned reads to .npz\n\nTool homepage: https://github.com/CenterForMedicalGeneticsGhent/wisecondorX"
inputs:
  - id: infile
    type: File
    doc: aligned reads input for conversion
    inputBinding:
      position: 1
  - id: binsize
    type:
      - 'null'
      - float
    doc: Bin size (bp)
    inputBinding:
      position: 102
      prefix: --binsize
  - id: normdup
    type:
      - 'null'
      - boolean
    doc: Do not remove duplicates
    inputBinding:
      position: 102
      prefix: --normdup
  - id: reference
    type:
      - 'null'
      - File
    doc: Fasta reference to be used during cram conversion
    inputBinding:
      position: 102
      prefix: --reference
outputs:
  - id: outfile
    type: File
    doc: Output .npz file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wisecondorx:1.2.9--pyhdfd78af_0
