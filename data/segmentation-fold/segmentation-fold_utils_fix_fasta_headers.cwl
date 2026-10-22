cwlVersion: v1.2
class: CommandLineTool
baseCommand: [segmentation-fold-utils, fix-fasta-headers]
label: segmentation-fold_utils_fix_fasta_headers
doc: "Replaces spaces in FASTA headers with underscores (for compatibility with pysam)\n\nTool homepage: https://github.com/yhoogstrate/segmentation-fold"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: LANG
        envValue: C.UTF-8
inputs:
  - id: fasta_input_file
    type: File
    doc: "FASTA input file"
    inputBinding:
      position: 1
  - id: fasta_output_file
    type: string
    doc: "FASTA output file name"
    inputBinding:
      position: 2
outputs:
  - id: fasta_output
    type: File
    doc: "FASTA with fixed headers"
    outputBinding:
      glob: $(inputs.fasta_output_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segmentation-fold:1.7.0--py27_0
stdout: segmentation-fold_utils_fix_fasta_headers.out
