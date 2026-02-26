cwlVersion: v1.2
class: CommandLineTool
baseCommand: kcftools_splitKCF
label: kcftools_splitKCF
doc: "Split KCF file for each chromosome\n\nTool homepage: https://github.com/sivasubramanics/kcftools"
inputs:
  - id: kcf_file
    type: File
    doc: KCF file name
    inputBinding:
      position: 101
      prefix: --kcf
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use (default: auto-detected)'
    default: auto-detected
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
