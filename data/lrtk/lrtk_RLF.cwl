cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lrtk
  - RLF
label: lrtk_RLF
doc: "Reconstruct long fragments from a barcode-aware linked-read alignment file (BAM).\n\nTool homepage: https://github.com/ericcombiolab/LRTK"
inputs:
  - id: bam
    type: File
    doc: The barcode aware alignment file (.bam).
    inputBinding:
      position: 1
      prefix: -B
  - id: distance
    type: int
    doc: the expected expanding distance.
    inputBinding:
      position: 1
      prefix: -D
  - id: outfile
    type: string
    doc: output path to the long fragments.
    inputBinding:
      position: 1
      prefix: -O
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 1
      prefix: -T
outputs:
  - id: long_fragments
    type: File
    doc: Table of reconstructed long fragments.
    outputBinding:
      glob: $(inputs.outfile)
  - id: fragment_statistics
    type:
      - 'null'
      - File
    doc: Fragment statistics written to OUTFILE.stat.xls.
    outputBinding:
      glob: $(inputs.outfile).stat.xls
  - id: insert_size
    type:
      - 'null'
      - File
    doc: Insert size table written to OUTFILE.insert_size.
    outputBinding:
      glob: $(inputs.outfile).insert_size
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
