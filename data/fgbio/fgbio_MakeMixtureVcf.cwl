cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_MakeMixtureVcf
doc: "Creates a VCF with one sample whose genotypes are a mixture of other samples'.\n\
  \nThe input VCF must contain all samples to be mixed, and may optionally contain\
  \ other samples. Sample mixtures can be\nspecified in one of several ways:\n\n \
  \ 1. '--samples s1 s2 s3': specifies that the samples with names 's1', 's'2 and\
  \ 's3' should be mixed equally.\n  2. ' --samples s1@0.1 s2@0.1 s3@0.8': specifies\
  \ that the three samples should be mixed at '0.1', '0.1', and '0.8'\n     respectively\n\
  \  3. '--samples s1@0.1 s2 s3': specifies that 's1' should form '0.1' of the mixture\
  \ and that the remaining ('0.9')\n     should be equally split amongst 's2' and\
  \ s'3'\n  4. If no sample names are given, all samples in the input VCF will be\
  \ used, mixing equally\n\nThe input samples are assumed to be diploid with the allele\
  \ fraction defined by the genotype ('0/0', '0/1' or '1/1').\nThe '--allele-fraction-field'\
  \ option may be specified, in which case the allele fraction of the input genotypes\
  \ will be\nretrieved from the specified 'FORMAT' field in the VCF genotypes. All\
  \ genotypes except hom-ref and no-call genotypes\nmust have this field present if\
  \ supplied.\n\nIf the --'no-call-is-hom-ref' flag is 'true' (the default) then no-call\
  \ genotypes in the input VCF are interpreted as\nhom-ref genotypes. If it is 'false',\
  \ any location with a no-call genotype will be emitted as a no-call in the mixture,\n\
  and will be filtered.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs:
  - id: allele_fraction_field
    type:
      - 'null'
      - string
    doc: Format field containing allele fraction.
    inputBinding:
      position: 101
      prefix: --allele-fraction-field
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
    doc: Input VCF containing genotypes for the samples to be mixed.
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
  - id: no_call_is_hom_ref
    type:
      - 'null'
      - boolean
    doc: 'Treat no-calls for samples as hom-ref genotypes. [Default: true].'
    inputBinding:
      position: 101
      prefix: --no-call-is-hom-ref
      separate: false
      valueFrom: $("=" + self)
  - id: output_sample_name
    type:
      - 'null'
      - string
    doc: 'Output sample name. [Default: mixture].'
    inputBinding:
      position: 101
      prefix: --output-sample-name
  - id: output_vcf
    type: string
    doc: Output VCF of mixture sample.
    inputBinding:
      position: 101
      prefix: --output
  - id: precision
    type:
      - 'null'
      - int
    doc: 'Digits of precision in generated allele fractions. [Default: 5].'
    inputBinding:
      position: 101
      prefix: --precision
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 1
      prefix: --sam-validation-stringency
  - id: samples
    type:
      - 'null'
      - string[]
    doc: Samples to mix. See general usage for format and examples.
    inputBinding:
      position: 101
      prefix: --samples
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
    valueFrom: MakeMixtureVcf
outputs:
  - id: output_vcf_out
    type: File
    doc: Output VCF of the mixture sample.
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
