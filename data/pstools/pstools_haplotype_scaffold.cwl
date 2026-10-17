cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pstools
  - haplotype_scaffold
label: pstools_haplotype_scaffold
doc: "Haplotype scaffolding tool using connection files and predicted haplotypes\n\
  \nTool homepage: https://github.com/shilpagarg/pstools"
inputs:
  - id: haplotype_connection_file
    type: File
    doc: haplotype connection file
    inputBinding:
      position: 1
  - id: pred_haplotypes_fa
    type: File
    doc: predicted haplotypes fasta file
    inputBinding:
      position: 2
  - id: output_dir
    type: string
    doc: output directory (created by the tool; must not exist)
    inputBinding:
      position: 3
  - id: enable_identity_check
    type:
      - 'null'
      - string
    doc: 'enable identity check on contigs, exclude identical ones while scaffolding
      (BOOL: true or false)'
    inputBinding:
      position: 103
      prefix: -i
  - id: identity_file
    type:
      - 'null'
      - File
    doc: identity file path, identity check will be ran if it is enabled and no 
      file is given
    inputBinding:
      position: 103
      prefix: -f
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: output_directory
    type: Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
