cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-cross-correlation
label: connectome-workbench_wb_command_cifti-cross-correlation
doc: "Correlates every row in <cifti-a> with every row in <cifti-b>. The mapping along columns in <cifti-b> becomes the mapping along rows in the output. When using the -fisher-z option, the output is NOT a Z-score, it is artanh(r), to do further math on this output, consider using -cifti-math. Restricting the memory usage will make it calculate the output in chunks, by reading through <cifti-b> multiple times.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_a
    type: File
    doc: first input cifti file
    inputBinding:
      position: 1
  - id: cifti_b
    type: File
    doc: second input cifti file
    inputBinding:
      position: 2
  - id: cifti_out
    type: string
    doc: output cifti file
    inputBinding:
      position: 3
  - id: weights
    type:
      - 'null'
      - File
    doc: 'specify column weights: text file containing one weight per column'
    inputBinding:
      position: 4
      prefix: -weights
  - id: fisher_z
    type:
      - 'null'
      - boolean
    doc: apply fisher small z transform (ie, artanh) to correlation
    inputBinding:
      position: 5
      prefix: -fisher-z
  - id: mem_limit
    type:
      - 'null'
      - float
    doc: 'restrict memory usage: memory limit in gigabytes'
    inputBinding:
      position: 6
      prefix: -mem-limit
outputs:
  - id: cifti_out_file
    type: File
    doc: output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
