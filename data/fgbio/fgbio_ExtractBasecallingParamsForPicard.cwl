cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - ExtractBasecallingParamsForPicard
label: fgbio_ExtractBasecallingParamsForPicard
doc: "Extracts sample and library information from an sample sheet for a given lane.\n\
  \nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 101
      prefix: --async-io
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 101
      prefix: --compression
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 101
      prefix: --cram-ref-fasta
  - id: input_sample_sheet
    type: File
    doc: The input sample sheet.
    inputBinding:
      position: 101
      prefix: --input
  - id: lanes
    type:
      type: array
      items: int
    doc: The lane(s) (1-based) for which to write per-lane parameter files.
    inputBinding:
      position: 101
      prefix: --lanes
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 101
      prefix: --sam-validation-stringency
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: output_directory
    type: Directory
    doc: The output folder to where per-lane parameter files should be written.
    outputBinding:
      glob: $(inputs.output_directory)
  - id: bam_output_directory
    type:
      - 'null'
      - Directory
    doc: Optional output folder to where per-lane BAM files should be written, 
      otherwise the output directory will be used.
    outputBinding:
      glob: $(inputs.bam_output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
