cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ncbi.py
  - prep_genbank_files
label: viral-ngs_ncbi_prep_genbank_files
doc: "Prepare genbank submission files. Requires .fasta and .tbl files as input, as well as numerous other metadata files for the submission. Creates a directory full of files (.sqn in particular) that can be sent to GenBank.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: template_file
    type: File
    doc: "Submission template file (.sbt) including author and contact info"
    inputBinding:
      position: 1
  - id: fasta_files
    type:
      type: array
      items: File
    doc: "Input fasta files"
    inputBinding:
      position: 2
      valueFrom: $(self.map(function(f) { return f.basename; }))
  - id: annot_dir
    type: Directory
    doc: "Output directory with genbank submission files (.tbl files must already be there)"
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
  - id: comment
    type:
      - 'null'
      - string
    doc: "comment field"
    inputBinding:
      position: 20
      prefix: --comment
  - id: sequencing_tech
    type:
      - 'null'
      - string
    doc: "sequencing technology (e.g. Illumina HiSeq 2500)"
    inputBinding:
      position: 20
      prefix: --sequencing_tech
  - id: master_source_table
    type:
      - 'null'
      - File
    doc: "source modifier table"
    inputBinding:
      position: 20
      prefix: --master_source_table
  - id: biosample_map
    type:
      - 'null'
      - File
    doc: "A file with two columns and a header: sample and BioSample. This file may refer to samples that are not included in this submission."
    inputBinding:
      position: 20
      prefix: --biosample_map
  - id: coverage_table
    type:
      - 'null'
      - File
    doc: "A genome coverage report file with a header row. The table must have at least two columns named sample and aln2self_cov_median. All other columns are ignored. Rows referring to samples not in this submission are ignored."
    inputBinding:
      position: 20
      prefix: --coverage_table
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
  - id: annot_dir_out
    type: Directory
    doc: "Output directory with the Genbank submission files"
    outputBinding:
      glob: $(inputs.annot_dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta_files)
        writable: true
      - entry: $(inputs.annot_dir)
        writable: true

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
