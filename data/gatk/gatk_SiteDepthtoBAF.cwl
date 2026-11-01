cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - SiteDepthtoBAF
label: gatk_SiteDepthtoBAF
doc: |-
  Convert SiteDepth to BafEvidence

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: baf_evidence_output
    type: string
    inputBinding:
      position: 101
      prefix: --baf-evidence-output
    doc: BAF output file
  - id: baf_sites_vcf
    type: File
    inputBinding:
      position: 101
      prefix: --baf-sites-vcf
    doc: Input VCF of SNPs marking loci for allele counts
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
  - id: site_depth
    type:
      type: array
      items: File
      inputBinding:
        prefix: --site-depth
    inputBinding:
      position: 101
    doc: SiteDepth files to process This argument must be specified at least once.
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
  - id: disable_sequence_dictionary_validation
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --disable-sequence-dictionary-validation
    doc: 'If specified, do not check the sequence dictionaries from our inputs for
      compatibility. Use at your own risk! Default value: false. Possible values:
      {true, false}'
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude-intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals to exclude from processing This argument may
      be specified 0 or more times.
  - id: input
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --input
    inputBinding:
      position: 101
    doc: BAM/SAM/CRAM file containing reads This argument may be specified 0 or more
      times.
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
      - pattern: .sbi
        required: false
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals over which to operate This argument may be
      specified 0 or more times.
  - id: max_std
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --max-std
    doc: 'Maximum standard deviation across bafs at a locus (otherwise locus will
      be ignored) Default value: 0.2.'
  - id: min_het_probability
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --min-het-probability
    doc: 'Minimum probability of site being biallelic and heterozygous Default value:
      0.5.'
  - id: min_total_depth
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --min-total-depth
    doc: 'Minimum total depth at a locus (otherwise locus will be ignored) Default
      value: 10.'
  - id: reference
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --reference
    doc: Reference sequence
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
      - pattern: .gzi
        required: false
      - pattern: ^^.dict
        required: false
  - id: sample_names
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --sample-names
    inputBinding:
      position: 101
    doc: Sample names. Necessary only when writing a *.baf.bci output file. This argument
      may be specified 0 or more times.
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --sequence-dictionary
    doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
      Must be a .dict file.
outputs:
  - id: baf_evidence_output_out
    type: File
    doc: BAF output file
    outputBinding:
      glob: $(inputs.baf_evidence_output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
