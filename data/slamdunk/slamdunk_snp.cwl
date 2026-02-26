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
    default: 10
    inputBinding:
      position: 102
      prefix: --min-coverage
  - id: reference
    type: File
    doc: Reference fasta file
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Thread number
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: var_fraction
    type:
      - 'null'
      - float
    doc: Minimimum variant fraction to call variant
    default: 0.8
    inputBinding:
      position: 102
      prefix: --var-fraction
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory for mapped BAM files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamdunk:0.4.3--py_0
