cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cvbio
arguments:
  - position: 2
    valueFrom: Disambiguate
label: cvbio_Disambiguate
doc: "Disambiguate reads that were mapped to multiple references.\n\nTool homepage:
  https://github.com/clintval/cvbio"
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
  - id: input
    type:
      type: array
      items: File
    doc: The BAMs to disambiguate.
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 1
      prefix: --log-level
  - id: prefix
    type: string
    doc: The output file prefix (e.g. dir/sample_name).
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reference_names
    type:
      - 'null'
      - type: array
        items: string
    doc: The reference names. Default to the first Assembly Name in the BAM 
      header.
    inputBinding:
      position: 101
      prefix: --reference-names
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: strategy
    type:
      - 'null'
      - string
    doc: 'The disambiguation strategy to use. Options: Classic.'
    inputBinding:
      position: 101
      prefix: --strategy
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in prefix
    outputBinding:
      glob: $(inputs.prefix)*
  - id: ambiguous_alignments
    type:
      - 'null'
      - Directory
    doc: Folder with the input-specific BAMs of ambiguously assigned templates
    outputBinding:
      glob: |-
        ${
          var p = inputs.prefix;
          var i = p.lastIndexOf('/');
          return (i < 0 ? '' : p.substring(0, i + 1)) + 'ambiguous-alignments';
        }
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cvbio:3.0.0--0
stdout: cvbio_Disambiguate.out
