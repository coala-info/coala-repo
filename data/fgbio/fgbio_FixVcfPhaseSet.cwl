cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_FixVcfPhaseSet
doc: "Adds/fixes the phase set (PS) genotype field.\n\nThe VCF specification allows\
  \ phased genotypes to be annotated with the 'PS' (phase set) 'FORMAT' field. The\
  \ value\nshould be a non-negative integer, corresponding to the position of the\
  \ first variant in the phase set. Some tools will\noutput a non-integer value, as\
  \ well as describe this field as having non-Integer type in the VCF header. This\
  \ tool will\nupdate the phase set ('PS') 'FORMAT' field to be VCF spec-compliant.\n\
  \nThe handling of unphased genotypes with phase-sets is controlled by the '-x' option:\n\
  \n  * If '-x' is used the genotype will be converted to a phased genotype (e.g.\
  \ '0/1' => '0|1')\n  * Otherwise the phase-set ('PS') will be removed from the genotype\n\
  \nThe '--keep-original' option may be used to store the original 'PS' value in a\
  \ new 'OPS' field. The type described in\nthe header will match the original.\n\n\
  This tool cannot fix phased variants without a phase set, or phased variant sets\
  \ who have different phase set values.\n\nIn some cases, VCFs (e.g. from GIAB/NIST\
  \ or Platinum Genomes) have illegal header lines, for example, a 'PEDIGREE'\nheader\
  \ line without a 'ID' key-value field. The '-z' option can be used to remove those\
  \ lines. This option is included\nin this tool for convenience as those example\
  \ VCFs in some cases have these illegal header lines, and it is convenient\nto fix\
  \ the phase set in addition to removing those illegal header lines.\n\nTool homepage:\
  \ https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 1
      prefix: --async-io
      separate: false
      valueFrom: $("=" + self)
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
  - id: keep_original
    type:
      - 'null'
      - boolean
    doc: 'Store the original phase set in the ''OPS'' field. [Default: false].'
    inputBinding:
      position: 101
      prefix: --keep-original
      separate: false
      valueFrom: $("=" + self)
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
  - id: phase_genotypes_with_phase_set
    type:
      - 'null'
      - boolean
    doc: 'Set unphased genotypes with a PS FORMAT value to be phased. [Default: false].'
    inputBinding:
      position: 101
      prefix: --phase-genotypes-with-phase-set
      separate: false
      valueFrom: $("=" + self)
  - id: remove_no_id_header_lines
    type:
      - 'null'
      - boolean
    doc: 'Remove header lines that do not contain an ID key-value, which is required
      in VCF. [Default: false].'
    inputBinding:
      position: 101
      prefix: --remove-no-id-header-lines
      separate: false
      valueFrom: $("=" + self)
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
    valueFrom: FixVcfPhaseSet
outputs:
  - id: output_vcf_out
    type: File
    doc: Output VCF file.
    outputBinding:
      glob: $(inputs.output_vcf)
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
requirements:
  - class: InlineJavascriptRequirement
