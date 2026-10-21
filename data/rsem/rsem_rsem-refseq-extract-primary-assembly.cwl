cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-refseq-extract-primary-assembly
label: rsem_rsem-refseq-extract-primary-assembly
doc: "Extract the primary assembly sequences from an NCBI RefSeq top-level
  assembly FASTA file (.fna). Only records whose header contains 'Primary
  Assembly' are written.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: input_top_level_assembly
    type: File
    doc: The RefSeq top-level assembly FASTA file (input_top_level_assembly.fna).
    inputBinding:
      position: 1
  - id: output_primary_assembly
    type: string
    doc: The name of the output primary assembly FASTA file 
      (output_primary_assembly.fna).
    inputBinding:
      position: 2
outputs:
  - id: primary_assembly
    type: File
    outputBinding:
      glob: $(inputs.output_primary_assembly)
    doc: The primary assembly FASTA file.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
