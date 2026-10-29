cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_MakeTwoSampleMixtureVcf
doc: "Creates a simulated tumor or tumor/normal VCF by in-silico mixing genotypes\
  \ from two samples.\n\nThe tumor genotypes are created by mixing the incoming genotypes\
  \ for the for the 'tumor' sample and the incoming\ngenotypes for the 'normal' samples\
  \ with the 'tumor' alleles accounting for 'tumorFraction' of the resulting mixture\
  \ and\nthe 'normal' alleles accounting for '1 - tumorFraction' of the resulting\
  \ mixture (see '--tumor-fraction'). E.g. if the\n'tumor' genotype is 'A/C', the\
  \ 'normal' genotype is 'C/C', and 'tumorFraction' is set at 0.5, then the resulting\
  \ tumor\ngenotype will be 'A/C' with an allele fraction of '0.75'. The resulting\
  \ allele fraction is written to the 'AF' info\nfield in the VCF.\n\nIn tumor-only\
  \ mode ('--tumor-only') only tumor genotypes are output. In tumor/normal mode genotypes\
  \ for the 'normal'\nsamples are also emitted, and match the genotypes from the input\
  \ sample.\n\nAll loci (potentially restricted by intervals) that are variant in\
  \ one or both samples are written to the output VCF,\nthough in several cases the\
  \ variants will be filtered:\n\n  * If either of the tumor or normal sample is no-called\
  \ the resulting locus will have the 'unknown_gt' filter applied\n  * If the tumor\
  \ and the normal have more than one alternative allele between them the 'multi_allelic'\
  \ filter will be\n    applied\n  * In tumor/normal mode (as opposed to tumor-only)\
  \ loci that have an alt allele in the normal sample will have the\n    'alt_allele_in_normal'\
  \ filter applied\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
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
    doc: Input VCF file.
    inputBinding:
      position: 101
      prefix: --input
  - id: intervals
    type:
      - 'null'
      - File
    doc: Optional set of intervals to restrict to.
    inputBinding:
      position: 101
      prefix: --intervals
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
    doc: 'Treat no-calls for either sample as hom-ref genotypes. [Default: true].'
    inputBinding:
      position: 101
      prefix: --no-call-is-hom-ref
      separate: false
      valueFrom: $("=" + self)
  - id: normal
    type: string
    doc: Name of the 'normal' sample in the input VCF.
    inputBinding:
      position: 101
      prefix: --normal
  - id: output_vcf
    type: string
    doc: Output VCF file.
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
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Directory to use for temporary files.
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: tumor
    type: string
    doc: Name of the 'tumor' sample in the input VCF.
    inputBinding:
      position: 101
      prefix: --tumor
  - id: tumor_fraction
    type:
      - 'null'
      - double
    doc: 'What fraction of the mixture comes from the ''tumor'' sample. [Default:
      0.5].'
    inputBinding:
      position: 101
      prefix: --tumor-fraction
  - id: tumor_only
    type:
      - 'null'
      - boolean
    doc: 'Tumor only mode - only output tumor genotypes and don''t filter sites. [Default:
      false].'
    inputBinding:
      position: 101
      prefix: --tumor-only
      separate: false
      valueFrom: $("=" + self)
arguments:
  - position: 50
    valueFrom: MakeTwoSampleMixtureVcf
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
