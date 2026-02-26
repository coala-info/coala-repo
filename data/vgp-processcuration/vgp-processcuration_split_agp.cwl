cwlVersion: v1.2
class: CommandLineTool
baseCommand: split_agp
label: vgp-processcuration_split_agp
doc: "Correct AGP for sequence lengths, split the agp per haplotype, assign unlocs
  and remove duplicated haplotigs\n\nTool homepage: https://github.com/vgl-hub/vgl-curation"
inputs:
  - id: agp_file
    type: File
    doc: Path to the curated AGP file
    inputBinding:
      position: 101
      prefix: --agp
  - id: fasta_file
    type: File
    doc: Path to the assembly fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory
    default: current directory
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgp-processcuration:1.1--pyhdfd78af_0
stdout: vgp-processcuration_split_agp.out
