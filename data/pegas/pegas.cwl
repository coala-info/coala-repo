cwlVersion: v1.2
class: CommandLineTool
baseCommand: pegas
label: pegas
doc: "Run the PeGAS pipeline.\n\nTool homepage: https://github.com/liviurotiul/PeGAS"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: Total cores to use
    inputBinding:
      position: 101
      prefix: --cores
  - id: data_dir
    type: Directory
    doc: Directory with fastq.gz files
    inputBinding:
      position: 101
      prefix: --data
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: Generate the interactive HTML report (optional)
    inputBinding:
      position: 101
      prefix: --interactive
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite output dir if it exists
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: prokka_cpu_cores
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --prokka-cpu-cores
  - id: roary_cpu_cores
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --roary-cpu-cores
  - id: shovill_cpu_cores
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --shovill-cpu-cores
  - id: shovill_ram
    type:
      - 'null'
      - int
    doc: RAM (GB) to allocate to Shovill
    inputBinding:
      position: 101
      prefix: --shovill-ram
outputs:
  - id: output_dir
    type: Directory
    doc: Directory for outputs
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pegas:1.2.3--pyhdfd78af_0
