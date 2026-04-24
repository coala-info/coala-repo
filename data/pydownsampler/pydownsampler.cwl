cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydownsampler
label: pydownsampler
doc: "Downsample BAM files to a specified coverage.\n\nTool homepage: https://github.com/LindoNkambule/pydownsampler"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility
    inputBinding:
      position: 102
      prefix: --seed
  - id: target_coverage
    type: int
    doc: Target coverage
    inputBinding:
      position: 102
      prefix: --target
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_bam
    type: File
    doc: Output BAM file
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydownsampler:1.0--py_0
