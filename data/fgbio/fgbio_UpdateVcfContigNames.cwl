cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_UpdateVcfContigNames
doc: 'Updates then contig names in a VCF.


  The name of each sequence must match one of the names (including aliases) in the
  given sequence dictionary. The new name will be the primary (non-alias) name in
  the sequence dictionary.


  Use ''--skip-missing'' to ignore variants where a contig name could not be updated
  (i.e. missing from the sequence dictionary).


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
  - id: dict
    type: File
    doc: The path to the sequence dictionary with contig aliases.
    inputBinding:
      position: 101
      prefix: --dict
  - id: input_vcf
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
    type: File
    doc: Input VCF.
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
  - id: output_vcf
    type: string
    doc: Output VCF.
    inputBinding:
      position: 101
      prefix: --output
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: skip_missing
    type:
      - 'null'
      - boolean
    doc: Skip contigs in the VCF that are not found in the sequence dictionary.
    inputBinding:
      position: 101
      prefix: --skip-missing
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
    valueFrom: UpdateVcfContigNames
outputs:
  - id: output_vcf_out
    type: File
    doc: Output VCF.
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
