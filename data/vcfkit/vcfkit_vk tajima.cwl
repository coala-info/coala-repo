cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vk
  - tajima
label: vcfkit_vk tajima
doc: "Calculate Tajima's D\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs:
  - id: window_size
    type: int
    doc: Size of window
    inputBinding:
      position: 1
  - id: step_size
    type: int
    doc: Distance to move window.
    inputBinding:
      position: 2
  - id: vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 3
  - id: extra
    type:
      - 'null'
      - boolean
    doc: display extra
    inputBinding:
      position: 104
      prefix: --extra
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Suppress header output
    inputBinding:
      position: 104
      prefix: --no-header
  - id: sliding
    type:
      - 'null'
      - boolean
    doc: Use sliding window
    inputBinding:
      position: 104
      prefix: --sliding
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk tajima.out
