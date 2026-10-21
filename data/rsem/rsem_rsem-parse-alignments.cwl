cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-parse-alignments
label: rsem_rsem-parse-alignments
doc: "Parse a read-name sorted SAM/BAM/CRAM alignment file into RSEM's internal
  intermediate files (the first step rsem-calculate-expression runs on alignment
  input).\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: reference_name
    type: string
    doc: The name of the RSEM reference (the prefix of the files made by 
      rsem-prepare-reference).
    inputBinding:
      position: 1
  - id: imd_name
    type: string
    doc: Prefix of the intermediate files that are written (e.g. sample_imd).
    inputBinding:
      position: 2
  - id: stat_name
    type: string
    doc: Prefix of the statistics files that are written (e.g. sample_stat).
    inputBinding:
      position: 3
  - id: reference_files
    type:
      type: array
      items: File
    doc: Reference files written by rsem-prepare-reference (all files starting 
      with the reference name). They are staged in the working directory so that
      reference_name resolves.
  - id: alignment_file
    type: File
    doc: The alignment file in SAM/BAM/CRAM format (alignF).
    inputBinding:
      position: 4
  - id: read_type
    type: int
    doc: '0 single read without quality score; 1 single read with quality score;
      2 paired-end read without quality score; 3 paired-end read with quality
      score.'
    inputBinding:
      position: 5
  - id: fai_file
    type:
      - 'null'
      - File
    doc: FASTA index file, needed when the input is in CRAM format.
    inputBinding:
      position: 6
      prefix: -t
  - id: tag_name
    type:
      - 'null'
      - string
    doc: Name of an alignment tag to read (-tag).
    inputBinding:
      position: 6
      prefix: -tag
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Set it quiet.
    inputBinding:
      position: 6
      prefix: -q
outputs:
  - id: imd_files
    type:
      type: array
      items: File
    outputBinding:
      glob: $(inputs.imd_name)*
    doc: Intermediate files (prefix imd_name).
  - id: stat_files
    type:
      type: array
      items: File
    outputBinding:
      glob: $(inputs.stat_name)*
    doc: Statistics files (prefix stat_name).
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.reference_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
