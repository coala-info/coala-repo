cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bgt
  - bcfidx
label: bgt_bcfidx
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_bcf)
        writable: true
doc: "(Re)index a BCF file with a record number index; writes <in.bcf>.csi.\n\nTool homepage: https://github.com/lh3/bgt"
inputs:
  - id: input_bcf
    type: File
    doc: Input BCF file to index
    inputBinding:
      position: 1
  - id: min_shift
    type:
      - 'null'
      - int
    doc: Minimum shift for indexing
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: bcf_index
    type: File
    doc: CSI index with record numbers (<in.bcf>.csi)
    outputBinding:
      glob: $(inputs.input_bcf.basename).csi
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgt:r283--h577a1d6_7
stdout: bgt_bcfidx.out
