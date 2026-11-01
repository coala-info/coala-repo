cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - StructuralVariantDiscoverer
label: gatk_StructuralVariantDiscoverer
doc: |-
  This tool takes a file containing the alignments of assembled contigs and searches it for contigs with split alignments or large gaps indicating the presence of structural variation breakpoints. Variations' types are determined by analyzing the signatures of the split alignments, and are written to a VCF file.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        prefix: --input
    inputBinding:
      position: 101
    doc: BAM/SAM/CRAM file containing reads This argument must be specified at least
      once.
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
  - id: output_vcf_name
    type: string
    inputBinding:
      position: 101
      prefix: --outputVCFName
    doc: Name of output VCF.
  - id: reference
    type: File
    inputBinding:
      position: 101
      prefix: --reference
    doc: Reference sequence file
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
      - pattern: .gzi
        required: false
      - pattern: ^^.dict
        required: false
  - id: assembly_imprecise_evidence_overlap_uncertainty
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --assembly-imprecise-evidence-overlap-uncertainty
    doc: 'Uncertainty in overlap of assembled breakpoints and evidence target links.
      Default value: 100.'
  - id: cnv_calls
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --cnv-calls
    doc: External CNV calls file. Should be single sample VCF, and contain only confident
      autosomal non-reference CNV calls (for now).
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
  - id: imprecise_variant_evidence_threshold
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --imprecise-variant-evidence-threshold
    doc: 'Number of pieces of imprecise evidence necessary to call a variant in the
      absence of an assembled breakpoint. Default value: 7.'
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
  - id: max_callable_imprecise_deletion_size
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max-callable-imprecise-deletion-size
    doc: 'Maximum size deletion to call based on imprecise evidence without corroborating
      read depth evidence Default value: 15000.'
  - id: min_align_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --min-align-length
    doc: 'Minimum flanking alignment length Default value: 50.'
  - id: min_mq
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --min-mq
    doc: 'Minimum mapping quality of evidence assembly contig Default value: 30.'
  - id: non_canonical_contig_names_file
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --non-canonical-contig-names-file
    doc: file containing non-canonical chromosome names (e.g chrUn_KI270588v1) in
      the reference, human reference (hg19 or hg38) assumed when omitted
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --sequence-dictionary
    doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
      Must be a .dict file.
  - id: truth_interval_padding
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --truth-interval-padding
    doc: 'Breakpoint padding for evaluation against truth data. Default value: 50.'
  - id: debug_mode
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --debug-mode
    doc: 'Run interpretation tool in debug mode (more information print to screen)
      Default value: false. Possible values: {true, false}'
outputs:
  - id: output_vcf_name_out
    type: File
    doc: Name of output VCF.
    outputBinding:
      glob: $(inputs.output_vcf_name)
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
