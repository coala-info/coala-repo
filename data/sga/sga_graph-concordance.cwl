cwlVersion: v1.2
class: CommandLineTool
baseCommand: sga graph-concordance
label: sga_graph-concordance
doc: "Count read support for variants in a vcf file\n\nTool homepage: https://github.com/jts/sga"
inputs:
  - id: variant_fastq
    type: File
    doc: variant.fastq
    inputBinding:
      position: 1
  - id: base_fastq
    type: File
    doc: base.fastq
    inputBinding:
      position: 2
  - id: vcf_file
    type: File
    doc: VCF_FILE
    inputBinding:
      position: 3
  - id: germline
    type:
      - 'null'
      - File
    doc: load germline variants from FILE
    inputBinding:
      position: 104
      prefix: --germline
  - id: reference
    type:
      - 'null'
      - File
    doc: load the reference genome from FILE
    inputBinding:
      position: 104
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: use NUM threads to compute the overlaps
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_graph-concordance.out
