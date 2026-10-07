cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capCmain
label: capc-map_capCmain
doc: "Main capC-MAP processing step: assign aligned digested read fragments to restriction fragments, find captured fragments and their reporters, and write valid pairs per target and a report.\n\nTool homepage: https://capc-map.readthedocs.io/"
inputs:
  - id: frag_file
    type: File
    doc: "is a bed file of restriction enzyme fragments genome wide"
    inputBinding:
      position: 1
      prefix: -r
  - id: targ_file
    type: File
    doc: "is a bed file of capture targets"
    inputBinding:
      position: 1
      prefix: -t
  - id: sam_file
    type: File
    doc: "is a SAM file containing groups of aligned digested fragments, sorted by name"
    inputBinding:
      position: 1
      prefix: -s
  - id: name
    type: string
    doc: "is the first part of the output file name"
    inputBinding:
      position: 1
      prefix: -o
  - id: exclusion_zone
    type:
      - 'null'
      - int
    doc: "exclusion zone; reporter fragments mapping within N bp of a target fragment are discarded. Default N=500."
    inputBinding:
      position: 1
      prefix: -e
  - id: save_interchromosomal
    type:
      - 'null'
      - boolean
    doc: "save interchromosomal. If present, interchromosomal interactions will be saved as well as counted."
    inputBinding:
      position: 1
      prefix: -i
outputs:
  - id: output_files
    type: File[]
    doc: "report and valid pairs files named with the given name"
    outputBinding:
      glob: $(inputs.name)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
