cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio_HapCutToVcf
doc: "Converts the output of 'HAPCUT' ('HapCut1'/'HapCut2') to a VCF.\n\nThe output\
  \ of 'HAPCUT' does not include all input variants, but simply those variants that\
  \ are in phased blocks. This\ntool takes the original VCF and the output of 'HAPCUT',\
  \ and produces a VCF containing both the variants that were\nphased and the variants\
  \ that were not phased, such that all variants in the original file are in the output.\n\
  \nThe original VCF provided to 'HAPCUT' is assumed to contain a single sample, as\
  \ 'HAPCUT' only supports a single sample.\n\nBy default, all phased genotypes are\
  \ annotated with the 'PS' (phase set) 'FORMAT' tag, which by convention is the\n\
  position of the first variant in the phase set (see the VCF specification). Furthermore,\
  \ this tool formats the alleles\nof a phased genotype using the '|' separator instead\
  \ of the '/' separator, where the latter indicates the genotype is\nunphased. If\
  \ the option to output phased variants in GATK's 'ReadBackedPhasing' format is used,\
  \ then the first variant\nin a phase set will have '/' instead of '|' separating\
  \ its alleles. Also, all phased variants will have 'PASS' set in\nits 'FILTER' column,\
  \ while unphased variants will have 'NotPhased' set in their 'FILTER' column. Unlike\
  \ GATK's\n'ReadBackedPhasing', homozygous variants will always be unphased.\n\n\
  More information about the purpose and operation of GATK's Read-backed phasing,\
  \ including its output format, can be\nfound in the GATK Forum\n(http://gatkforums.broadinstitute.org/gatk/discussion/45/purpose-and-operation-of-read-backed-phasing)\n\
  \nAdditional 'FORMAT' fields for phased variants are provided corresponding to per-genotype\
  \ information produced by\n'HapCut1':\n\n  1. The 'RC' tag gives the counts of calls\
  \ supporting 'allele0' and 'allele1' respectively.\n  2. The 'LC' tag gives the\
  \ change in likelihood if this SNP is made homozygous or removed.\n  3. The 'MCL'\
  \ tag gives the maximum change in likelihood if this SNP is made homozygous or removed.\n\
  \  4. The 'RMEC' tag gives the reduction in 'MEC' score if we remove this variant\
  \ altogether.\n\nAdditional 'FORMAT' fields for phased variants are provided corresponding\
  \ to per-genotype information produced by\n'HapCut2':\n\n  1. The 'PR' tag is '1'\
  \ if 'HapCut2' pruned this variant, '0' otherwise.\n  2. The 'SE' tag gives the\
  \ confidence ('log10') that there is not a switch error occurring immediately before\
  \ the SNV\n     (closer to zero means that a switch error is more likely).\n  3.\
  \ The 'NE' tag gives the confidence ('log10') that the SNV is not a mismatch (single\
  \ SNV) error (closer to zero\n     means a mismatch is more likely).\n\nHapCut2\
  \ should not be run with '--call-homozygous' as the genotypes may be different than\
  \ the input and so is not\ncurrently supported.\n\nFor more information about 'HapCut1',\
  \ see the source code or paper below. source code:\nhttps://github.com/vibansal/hapcut\
  \ HapCut1 paper: An efficient and accurate algorithm for the haplotype assembly\n\
  problem Bioinformatics. 2008 Aug 15;24(16):i153-9.\n\nFor more information about\
  \ 'HapCut2', see the source code (https://github.com/vibansal/HapCUT2) below.\n\n\
  Tool homepage: https://github.com/fulcrumgenomics/fgbio"
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
  - id: fix_ambiguous_reference_alleles
    type:
      - 'null'
      - boolean
    doc: 'Fix IUPAC codes in the original VCF to be VCF 4.3 spec-compliant (ex ''R''
      -> ''A''). Does not support BCF inputs. [Default: false].'
    inputBinding:
      position: 101
      prefix: --fix-ambiguous-reference-alleles
      separate: false
      valueFrom: $("=" + self)
  - id: gatk_phasing_format
    type:
      - 'null'
      - boolean
    doc: 'Output phased variants in GATK''s ''ReadBackedPhasing'' format. [Default:
      false].'
    inputBinding:
      position: 101
      prefix: --gatk-phasing-format
      separate: false
      valueFrom: $("=" + self)
  - id: hapcut_file
    type: File
    doc: The file produced by 'HapCut1'/'HapCut2'.
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
  - id: original_vcf
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
    type: File
    doc: The original VCF provided to 'HapCut1'/'HapCut2'.
    inputBinding:
      position: 101
      prefix: --vcf
  - id: output_vcf
    type: string
    doc: The output VCF with both phased and unphased variants.
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
arguments:
  - position: 50
    valueFrom: HapCutToVcf
outputs:
  - id: output_vcf_out
    type: File
    doc: Output VCF with both phased and unphased variants.
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
