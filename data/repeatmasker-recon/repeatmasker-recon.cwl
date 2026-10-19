cwlVersion: v1.2
class: CommandLineTool
baseCommand: repeatmasker-recon
label: repeatmasker-recon
doc: "RECON finds repeat families from biological sequences. Runs the whole RECON
  package on a sequence name list and an MSP file (pairwise similarities).\n\nTool
  homepage: https://www.repeatmasker.org/RepeatMasker"
inputs:
  - id: seq_name_list_file
    type: File
    doc: Sequence name list file. The first line is the number of sequences, 
      then one sequence name per line, sorted in lexical order.
    inputBinding:
      position: 1
  - id: msp_file
    type: File
    doc: MSP file (score %iden start end query_name start end subject_name)
    inputBinding:
      position: 2
  - id: integer
    type:
      - 'null'
      - int
    doc: Number of sections (images spread files) to use; default 1
    inputBinding:
      position: 3
outputs:
  - id: summary
    type: Directory
    doc: Final results (eles, fams and related summary files)
    outputBinding:
      glob: summary
  - id: images
    type: Directory
    doc: Sorted MSP images (intermediate)
    outputBinding:
      glob: images
  - id: ele_def_res
    type: Directory
    doc: Initial element definitions (intermediate)
    outputBinding:
      glob: ele_def_res
  - id: ele_redef_res
    type: Directory
    doc: Re-defined elements (intermediate)
    outputBinding:
      glob: ele_redef_res
  - id: edge_redef_res
    type: Directory
    doc: Re-defined edges (intermediate)
    outputBinding:
      glob: edge_redef_res
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/repeatmasker-recon:v1.08-4-deb_cv1
