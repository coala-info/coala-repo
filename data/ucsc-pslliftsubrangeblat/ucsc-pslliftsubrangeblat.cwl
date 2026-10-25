cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslLiftSubrangeBlat
label: ucsc-pslliftsubrangeblat
doc: "lift PSLs from blat subrange alignments. Lift a PSL with target coordinates from a blat subrange query (e.g. blah/hg18.2bit:chr1:1000-20000) which has subrange coordinates as the target name (e.g. chr1:1000-200000) to actual target coordinates.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: "Input PSL file (isPsl) with subrange names."
    inputBinding:
      position: 1
  - id: out_psl
    type: string
    doc: "Output PSL file name."
    inputBinding:
      position: 2
  - id: t_sizes
    type:
      - 'null'
      - File
    doc: "Lift target side based on tName, using target sizes from this tab separated file."
    inputBinding:
      position: 0
      prefix: "-tSizes="
      separate: false
  - id: q_sizes
    type:
      - 'null'
      - File
    doc: "Lift query side based on qName, using query sizes from this tab separated file."
    inputBinding:
      position: 0
      prefix: "-qSizes="
      separate: false
outputs:
  - id: out_file
    type: File
    doc: "Lifted PSL file."
    outputBinding:
      glob: $(inputs.out_psl)
  - id: stderr
    type: stderr
    doc: "Standard error"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslliftsubrangeblat:482--h0b57e2e_0
stderr: ucsc-pslliftsubrangeblat.err
