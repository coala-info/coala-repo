cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ncbi.py
  - tbl_transfer_prealigned
label: viral-ngs_ncbi_tbl_transfer_prealigned
doc: "This breaks out the ref and alt sequences into separate fasta files, and then creates unified files containing the reference sequence first and the alt second. Each of these unified files is then passed as a cmap to tbl_transfer_common. This function expects to receive one fasta file containing a multialignment of a single segment/chromosome along with the respective reference sequence for that segment/chromosome. It also expects a reference containing all reference segments/chromosomes, so that the reference sequence can be identified in the input file by name. It also expects a list of reference tbl files, where each file is named according to the ID present for its corresponding sequence in the refFasta. For each non-reference sequence present in the inputFasta, two files are written: a fasta containing the segment/chromosome for the same, along with its corresponding feature table as created by tbl_transfer_common.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: input_fasta
    type: File
    doc: "FASTA file containing input sequences, including pre- made alignments and reference sequence"
    inputBinding:
      position: 1
  - id: ref_fasta
    type: File
    doc: "FASTA file containing the reference genome"
    inputBinding:
      position: 2
  - id: ref_annot_tbl_files
    type:
      type: array
      items: File
    doc: "Name of the reference feature tables, each of which should have a filename comrised of [refId].tbl so they can be matched against the reference sequences"
    inputBinding:
      position: 3
  - id: output_dir
    type: string
    doc: "The output directory"
    inputBinding:
      position: 4
  - id: oob_clip
    type:
      - 'null'
      - boolean
    doc: "Out of bounds feature behavior. False: drop all features that are completely or partly out of bounds True: drop all features completely out of bounds but truncate any features that are partly out of bounds"
    inputBinding:
      position: 20
      prefix: --oob_clip
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 20
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 20
      prefix: --tmp_dirKeep
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: output_dir_dir
    type: Directory
    doc: "Output directory output_dir"
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
