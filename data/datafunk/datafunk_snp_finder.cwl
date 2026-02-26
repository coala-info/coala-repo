cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - snp_finder
label: datafunk_snp_finder
doc: "Find SNPs from alignment files.\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: alignment_file
    type: File
    doc: Path to the alignment file (e.g., BAM, CRAM).
    inputBinding:
      position: 101
      prefix: -a
outputs:
  - id: snp_output_file
    type: File
    doc: Path to write the output SNP file.
    outputBinding:
      glob: $(inputs.snp_output_file)
  - id: output_directory
    type: Directory
    doc: Directory to save the output files.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
