cwlVersion: v1.2
class: CommandLineTool
baseCommand: verkko
label: verkko
doc: "Verkko is a hybrid genome assembler designed for telomere-to-telomere assembly
  of genomes using HiFi and Oxford Nanopore reads.\n\nTool homepage: https://github.com/marbl/verkko"
inputs:
  - id: hic1_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Hi-C reads (forward/read1)
    inputBinding:
      position: 101
      prefix: --hic1
  - id: hic2_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Hi-C reads (reverse/read2)
    inputBinding:
      position: 101
      prefix: --hic2
  - id: hifi_reads
    type:
      type: array
      items: File
    doc: PacBio HiFi reads
    inputBinding:
      position: 101
      prefix: --hifi
  - id: nano_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Oxford Nanopore reads
    inputBinding:
      position: 101
      prefix: --nano
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Do not remove intermediate files
    inputBinding:
      position: 101
      prefix: --no-cleanup
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Resume a previous assembly run
    inputBinding:
      position: 101
      prefix: --resume
  - id: target
    type:
      - 'null'
      - string
    doc: Run until a specific target is reached
    inputBinding:
      position: 101
      prefix: --target
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory for the assembly
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verkko:2.3--h03b467c_1
