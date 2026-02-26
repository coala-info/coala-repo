cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - secapr
  - paralogs_to_ref
label: secapr_paralogs_to_ref
doc: "Align paralogous contigs with reference sequence\n\nTool homepage: https://github.com/AntonelliLab/seqcap_processor"
inputs:
  - id: contigs
    type: Directory
    doc: The directory containing the assembled contigs in fasta format. The 
      paralogous contigs logged in the find_target_contigs output folder will be
      extracted from this file.
    inputBinding:
      position: 101
      prefix: --contigs
  - id: extracted_target_contigs
    type: Directory
    doc: The directory containing the extraceted target contigs and with them 
      the info about paralogous loci (output dir from find_target_contigs 
      function).
    inputBinding:
      position: 101
      prefix: --extracted_target_contigs
  - id: gap_extent_penalty
    type:
      - 'null'
      - int
    doc: Set the gap extention penalty for the alignment
    default: 1
    inputBinding:
      position: 101
      prefix: --gap_extent_penalty
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: Set the gap opening penalty for the alignments
    default: 3
    inputBinding:
      position: 101
      prefix: --gap_open_penalty
  - id: reference
    type: File
    doc: The fasta-file containing the reference sequences that were used for 
      extracting target contigs.
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: output
    type: Directory
    doc: The output directory where alignments of paralogous cotnigs with 
      reference sequences will be stored.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
