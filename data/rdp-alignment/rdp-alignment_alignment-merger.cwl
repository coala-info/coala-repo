cwlVersion: v1.2
class: CommandLineTool
baseCommand: java AlignmentMerger
label: rdp-alignment_alignment-merger
doc: "This program reads in all the files from the input directory and merges the
  alignment into one single file\n\nTool homepage: https://github.com/AlbertoMartinPerez/Sequence_Analyzer_automations"
inputs:
  - id: alignfiledir
    type: Directory
    doc: stkdir contains a list of aligned stk files to be merged
    inputBinding:
      position: 1
  - id: mask_file
    type:
      - 'null'
      - File
    doc: maskfile contains the model positions to be ignored
    inputBinding:
      position: 2
outputs:
  - id: outfile_fasta
    type: File
    doc: outfile.fasta merges the alignment into one single file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-alignment:v1.2.0-5-deb_cv1
