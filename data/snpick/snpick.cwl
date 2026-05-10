cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpick
label: snpick
doc: "A fast and efficient tool for extracting variable sites and generating a VCF
  with actual bases, including ambiguous bases and codons.\n\nTool homepage: https://github.com/PathoGenOmics-Lab/snpick"
inputs:
  - id: fasta
    type: File
    doc: Input FASTA alignment file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: generate_vcf
    type:
      - 'null'
      - boolean
    doc: Generate VCF file with variable sites
    inputBinding:
      position: 101
      prefix: --vcf
  - id: include_gaps
    type:
      - 'null'
      - boolean
    doc: Consider the '-' (gap) symbol in variable site detection
    inputBinding:
      position: 101
      prefix: --include-gaps
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (optional)
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
  - id: vcf_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `vcf_output_path`
    inputBinding:
      position: 103
      prefix: --vcf-output
outputs:
  - id: output
    type: File
    doc: Output FASTA file with variable sites
    outputBinding:
      glob: $(inputs.output_path)
  - id: vcf_output
    type:
      - 'null'
      - File
    doc: Output VCF file (optional)
    outputBinding:
      glob: $(inputs.vcf_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpick:1.0.0--h3f2c17f_0
