cwlVersion: v1.2
class: CommandLineTool
baseCommand: samestr convert
label: samestr_convert
doc: "Convert MetaPhlAn or mOTUs marker alignments to a standardized format.\n\nTool
  homepage: https://github.com/danielpodlesny/samestr/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Path to input MetaPhlAn or mOTUs marker alignments (.sam, .sam.bz2, 
      .bam).
    inputBinding:
      position: 1
  - id: db_force
    type:
      - 'null'
      - boolean
    doc: Force execution, even when database version is not an exact match.
    inputBinding:
      position: 102
      prefix: --db-force
  - id: keep_tmp_files
    type:
      - 'null'
      - boolean
    doc: Keeps intermediate files from transformation steps on disk.
    inputBinding:
      position: 102
      prefix: --keep-tmp-files
  - id: marker_dir
    type: Directory
    doc: Path to MetaPhlAn or mOTUs clade marker database.
    inputBinding:
      position: 102
      prefix: --marker-dir
  - id: min_aln_identity
    type:
      - 'null'
      - float
    doc: Minimum percent identity in alignment.
    inputBinding:
      position: 102
      prefix: --min-aln-identity
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: Minimum alignment length.
    inputBinding:
      position: 102
      prefix: --min-aln-len
  - id: min_aln_qual
    type:
      - 'null'
      - int
    doc: Minimum alignment quality. Increasing this threshold can drastically 
      reduce the number of considered variants.
    inputBinding:
      position: 102
      prefix: --min-aln-qual
  - id: min_base_qual
    type:
      - 'null'
      - int
    doc: Minimum base call quality.
    inputBinding:
      position: 102
      prefix: --min-base-qual
  - id: min_vcov
    type:
      - 'null'
      - int
    doc: Minimum vertical coverage.
    inputBinding:
      position: 102
      prefix: --min-vcov
  - id: nprocs
    type:
      - 'null'
      - int
    doc: The number of processing units to use.
    inputBinding:
      position: 102
      prefix: --nprocs
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to output directory.
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: recursive_input
    type:
      - 'null'
      - boolean
    doc: Allow checking subdirectories of the input directory for input files.
    inputBinding:
      position: 102
      prefix: --recursive-input
  - id: tax_profiles_dir
    type:
      - 'null'
      - Directory
    doc: 'Path to directory with taxonomic profiles (MetaPhlAn or mOTUs, default extension:
      .profile.txt). When not specified, will look for profiles in `input-files` directory.'
    inputBinding:
      position: 102
      prefix: --tax-profiles-dir
  - id: tax_profiles_extension
    type:
      - 'null'
      - string
    doc: File extension of taxonomic profiles.
    inputBinding:
      position: 102
      prefix: --tax-profiles-extension
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Path to temporary directory
    inputBinding:
      position: 102
      prefix: --tmp-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samestr:1.2025.111--pyhdfd78af_0
stdout: samestr_convert.out
