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
  - id: output_directory_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `output_directory_path`
    inputBinding:
      position: 102
      prefix: --output-directory
  - id: snp_output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `snp_output_file_path`
    inputBinding:
      position: 103
      prefix: --snp-output-file
outputs:
  - id: snp_output_file
    type: File
    doc: Path to write the output SNP file.
    outputBinding:
      glob: $(inputs.snp_output_file_path)
  - id: output_directory
    type: Directory
    doc: Directory to save the output files.
    outputBinding:
      glob: $(inputs.output_directory_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
