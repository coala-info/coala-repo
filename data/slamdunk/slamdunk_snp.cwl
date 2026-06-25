cwlVersion: v1.2
class: CommandLineTool
baseCommand: slamdunk snp
label: slamdunk_snp
doc: "Call SNPs from BAM files.\n\nTool homepage: http://t-neumann.github.io/slamdunk"
inputs:
  - id: bam
    type:
      type: array
      items: File
    doc: Bam file(s)
    inputBinding:
      position: 1
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimimum coverage to call variant
    inputBinding:
      position: 102
      prefix: --min-coverage
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: Reference fasta file
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread number
    inputBinding:
      position: 102
      prefix: --threads
  - id: var_fraction
    type:
      - 'null'
      - float
    doc: Minimimum variant fraction to call variant
    inputBinding:
      position: 102
      prefix: --var-fraction
  - id: output_dir_path
    type: Directory
    doc: Output or path parameter `output_dir_path`
    inputBinding:
      position: 103
      prefix: --output-dir
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory for mapped BAM files.
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamdunk:0.4.3--py_0
