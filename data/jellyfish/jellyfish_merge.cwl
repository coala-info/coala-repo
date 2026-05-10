cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jellyfish
  - merge
label: jellyfish_merge
doc: "Merge jellyfish databases\n\nTool homepage: http://www.genome.umd.edu/jellyfish.html"
inputs:
  - id: input
    type:
      type: array
      items: string
    doc: Input jellyfish databases
    inputBinding:
      position: 1
  - id: lower_count
    type:
      - 'null'
      - int
    doc: Don't output k-mer with count < lower-count
    inputBinding:
      position: 102
      prefix: --lower-count
  - id: upper_count
    type:
      - 'null'
      - int
    doc: Don't output k-mer with count > upper-count
    inputBinding:
      position: 102
      prefix: --upper-count
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jellyfish:v2.2.10-2-deb_cv1
