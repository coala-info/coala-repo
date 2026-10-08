cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dpcstruct
  - traceback
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
  - id: output_dir_path
    type: string
    doc: output path (optional, default is ./); the folder is created before the run
    default: traceback_output
    inputBinding:
      position: 103
      prefix: -o
outputs:
  - id: output_dir
    type: Directory
    doc: output folder with the sequence-labels_N.bin files
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '${ return {class: "Directory", basename: inputs.output_dir_path, listing: [], writable: true}; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
