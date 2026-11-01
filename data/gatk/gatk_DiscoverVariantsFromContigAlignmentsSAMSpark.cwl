cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - DiscoverVariantsFromContigAlignmentsSAMSpark
label: gatk_DiscoverVariantsFromContigAlignmentsSAMSpark
doc: |-
  This tool is used in development and should not be of interest to most researchers.  It packages structural variant calling as a separate tool, independent of the generation of local assemblies. Most researchers will run StructuralVariationDiscoveryPipelineSpark, which both generates local assemblies of interesting genomic regions, and then calls structural variants from these assemblies. This tool takes a SAM/BAM/CRAM containing the alignments of assembled contigs from local assemblies and searches it for split alignments indicating the presence of structural variations. To do so the tool parses primary and supplementary alignments; secondary alignments are ignored. To be considered valid evidence of an SV, two alignments from the same contig must have mapping quality 60, and both alignments must have length greater than or equal to min-alignment-length. Imprecise variants with approximate locations are also called. The input file is typically the output file produced by FindBreakpointEvidenceSpark.

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
  - id: output
    type: string
    inputBinding:
      position: 101
      prefix: --output
    doc: prefix for discovery (non-genotyped) VCF; sample name will be appended after
      the provided argument, followed by "_inv_del_ins.vcf"
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
  - id: output_output
    type:
      type: array
      items: File
    doc: prefix for discovery (non-genotyped) VCF; sample name will be appended after
      the provided argument, followed by "_inv_del_ins.vcf"
    outputBinding:
      glob: $(inputs.output)*
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
