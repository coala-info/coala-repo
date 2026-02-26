cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quasitools
  - aacoverage
label: quasitools_aacoverage
doc: "This script builds an amino acid census and returns its coverage. The BAM alignment
  file corresponds to a pileup of sequences aligned to the REFERENCE. A BAM index
  file (.bai) must also be present and, except for the extension, have the same name
  as the BAM file. The REFERENCE must be in FASTA format. The BED4_FILE must be a
  BED file with at least 4 columns and specify the gene locations within the REFERENCE.\n\
  The output is in CSV format.\n\nTool homepage: https://github.com/phac-nml/quasitools/"
inputs:
  - id: bam_file
    type: File
    doc: BAM alignment file
    inputBinding:
      position: 1
  - id: reference_fasta
    type: File
    doc: REFERENCE in FASTA format
    inputBinding:
      position: 2
  - id: bed4_file
    type: File
    doc: BED4_FILE must be a BED file with at least 4 columns and specify the 
      gene locations within the REFERENCE
    inputBinding:
      position: 3
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasitools:0.7.0--py_0
