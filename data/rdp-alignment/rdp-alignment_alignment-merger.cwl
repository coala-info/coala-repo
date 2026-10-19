cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rdp-alignment
  - alignment-merger
label: rdp-alignment_alignment-merger
doc: "Read all alignment files (fasta or Stockholm, each with a #=GC_RF reference sequence) from a directory and merge them into one alignment file.

Tool homepage: https://github.com/rdpstaff/Alignment"
inputs:
  - id: alignfiledir
    type: Directory
    doc: "Directory with the aligned files to be merged"
    inputBinding:
      position: 1
  - id: outfile
    type: string
    doc: "Output fasta file with the merged alignment"
    inputBinding:
      position: 2
  - id: mask_file
    type:
      - 'null'
      - File
    doc: "File with the model positions to be ignored"
    inputBinding:
      position: 3
outputs:
  - id: merged
    type:
      - 'null'
      - File
    doc: "Merged alignment"
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
