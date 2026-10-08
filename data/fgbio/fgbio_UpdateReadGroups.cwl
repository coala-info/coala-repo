cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_UpdateReadGroups
doc: 'Updates one or more read groups and their identifiers.


  This tool will replace each read group with a new read group, including a new read
  group identifier. If the read group identifier is not to be changed, it is recommended
  to use ''samtools reheader'' or Picard''s ''ReplaceSamHeader'' instead as in this
  case only the header needs modification. If all read groups are to be assigned to
  one read group, it is recommended to use Picard''s ''AddOrReplaceReadGroups''. Nonetheless,
  if the read group identifier also needs to be changed, use this tool.


  Each read group in the input file will be mapped to one and only one new read group
  identifier, unless ''--ignore-missing-read-groups'' is set. A SAM header file should
  be given with the new read groups and the ID field foreach read group containing
  the new read group identifier. An additional attribute (''FR'') should be provided
  that gives the original read group identifier (''ID'') to which this new read group
  corresponds.


  If ''--keep-read-group-attributes'' is true, then any read group attribute not replaced
  will be kept in the new read group. Otherwise, only the attributes in the provided
  SAM header file will be used.


  Tool homepage: https://github.com/fulcrumgenomics/fgbio'
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 1
      prefix: --compression
  - id: cram_ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA for CRAM encoding/decoding.
    inputBinding:
      position: 1
      prefix: --cram-ref-fasta
  - id: ignore_missing_read_groups
    type:
      - 'null'
      - boolean
    doc: Keep all read groups not found in the replacement header, otherwise throw
      an error.
    inputBinding:
      position: 101
      prefix: --ignore-missing-read-groups
  - id: input_bam
    type: File
    doc: Input BAM file.
    inputBinding:
      position: 101
      prefix: --input
  - id: keep_read_group_attributes
    type:
      - 'null'
      - boolean
    doc: Keep all read group attributes that are not replaced.
    inputBinding:
      position: 101
      prefix: --keep-read-group-attributes
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 1
      prefix: --log-level
  - id: output_bam
    type: string
    doc: Output BAM file.
    inputBinding:
      position: 101
      prefix: --output
  - id: read_groups_file
    type: File
    doc: A SAM header file with the replacement read groups (see detailed usage).
    inputBinding:
      position: 101
      prefix: --read-groups-file
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
arguments:
  - position: 50
    valueFrom: UpdateReadGroups
outputs:
  - id: output_bam_out
    type: File
    doc: Output BAM file.
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
