cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromosome_assignment
label: vgp-processcuration_chromosome_assignment
doc: "Modify scaffold names to reflect chromosomal assignment.\n\nTool homepage: https://github.com/vgl-hub/vgl-curation"
inputs:
  - id: agp
    type: File
    doc: Path to the haplotype AGP without haplotig duplications
    inputBinding:
      position: 101
      prefix: --agp
  - id: fasta
    type: File
    doc: Path to the sorted fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: output_dir_path
    type:
      - 'null'
      - Directory
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir_path)
  - id: inter_chr_tsv
    type:
      - 'null'
      - File
    doc: Table mapping the scaffolds to their chromosomal assignment.
    outputBinding:
      glob: '*.out'
  - id: hap_chr_level_fa
    type:
      - 'null'
      - File
    doc: Fasta file with chromosomal level sequences.
    outputBinding:
      glob: '*.out'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgp-processcuration:1.1--pyhdfd78af_0
