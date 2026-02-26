cwlVersion: v1.2
class: CommandLineTool
baseCommand: dpcstruct_traceback
label: dpcstruct_traceback
doc: "Assign a metacluster label to each domain inside a primary cluster.\n\nTool
  homepage: https://github.com/RitAreaSciencePark/DPCstruct"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: input files containing all primary cluster domains
    inputBinding:
      position: 1
  - id: mc_labels
    type: File
    doc: file containing a metacluster label for each primary cluster
    inputBinding:
      position: 102
      prefix: -l
  - id: num_output
    type:
      - 'null'
      - int
    doc: estimated number of output files (optional)
    inputBinding:
      position: 102
      prefix: -n
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output path (optional, default is ./)
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
