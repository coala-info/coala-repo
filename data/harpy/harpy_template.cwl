cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - template
label: harpy_template
doc: "Create files and HPC configs for workflows. All commands write to stdout.\n\n
  Tool homepage: https://github.com/pdimens/harpy/"
inputs:
  - id: command
    type: string
    doc: The specific template command to run (groupings, impute, hpc-generic, hpc-googlebatch,
      hpc-lsf, or hpc-slurm)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for the selected command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
stdout: harpy_template.out
