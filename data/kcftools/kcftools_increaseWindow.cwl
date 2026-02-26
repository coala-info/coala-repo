cwlVersion: v1.2
class: CommandLineTool
baseCommand: kcftools_increaseWindow
label: kcftools_increaseWindow
doc: "Increase the window size of a KCF file by merging windows\n\nTool homepage:
  https://github.com/sivasubramanics/kcftools"
inputs:
  - id: input_file
    type: File
    doc: Input KCF file
    inputBinding:
      position: 101
      prefix: --input
  - id: window_size
    type: int
    doc: Window size
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output_file
    type: File
    doc: Output KCF file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
