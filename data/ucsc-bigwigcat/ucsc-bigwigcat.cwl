cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigCat
label: ucsc-bigwigcat
doc: "Merge non-overlapping bigWig files directly into bigWig format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: output_bw
    type: string
    doc: "Name of the output indexed bigWig file"
    inputBinding:
      position: 1
  - id: input_bws
    type:
      type: array
      items: File
    doc: "Input bigWig files (must not overlap each other)"
    inputBinding:
      position: 2
  - id: items_per_slot
    type:
      - 'null'
      - int
    doc: "Number of data points bundled at lowest level. Default 1024"
    inputBinding:
      position: 101
      prefix: -itemsPerSlot=
      separate: false
outputs:
  - id: out_output_bw
    type: File
    doc: "Output bigWig file"
    outputBinding:
      glob: $(inputs.output_bw)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigcat:482--h0b57e2e_0
