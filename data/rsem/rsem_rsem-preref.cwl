cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-preref
label: rsem_rsem-preref
doc: "Pad a poly(A) tail onto the reference transcripts and write the RSEM
  reference sequence files (.seq, .idx.fa, .n2g.idx.fa, .ti). It is the step
  of rsem-prepare-reference that runs after the transcript FASTA file is made
  (see rsem-synthesis-reference-transcripts).\n\nTool homepage:
  https://deweylab.github.io/RSEM/"
inputs:
  - id: reference_fasta
    type: File
    doc: A FASTA format file that contains all reference transcripts 
      (refFastaF).
    inputBinding:
      position: 1
  - id: poly_a_choice
    type: int
    doc: 'Choice for polyA tail padding, a number from {0,1,2}. 0: pad polyA tail;
      1: do not pad polyA tail at all; 2: pad polyA tail for all references but
      those in the exception file.'
    inputBinding:
      position: 2
  - id: reference_name
    type: string
    doc: Name (prefix) of the reference files to write.
    inputBinding:
      position: 3
  - id: reference_files
    type:
      type: array
      items: File
    doc: Files made earlier by rsem-synthesis-reference-transcripts 
      (reference_name.ti and reference_name.grp). They are staged writable in 
      the working directory.
  - id: poly_a_length
    type:
      - 'null'
      - int
    doc: 'Length of the polyA tail you want to pad. (Default: 100)'
    inputBinding:
      position: 4
      prefix: -l
  - id: exception_file
    type:
      - 'null'
      - File
    doc: File that lists exception reference ids (IDs start from 1). Must be set 
      if poly_a_choice is 2.
    inputBinding:
      position: 4
      prefix: -f
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet.
    inputBinding:
      position: 4
      prefix: -q
outputs:
  - id: reference_output_files
    type:
      type: array
      items: File
    outputBinding:
      glob:
        - $(inputs.reference_name).seq
        - $(inputs.reference_name).idx.fa
        - $(inputs.reference_name).n2g.idx.fa
        - $(inputs.reference_name).ti
    doc: The reference files written with the reference_name prefix.
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
