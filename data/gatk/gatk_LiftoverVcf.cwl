cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- LiftoverVcf
label: gatk_LiftoverVcf
doc: |-
  Lifts over a VCF file from one reference build to another. Summary Tool for "lifting over" a VCF from one genome build to another, producing a properly headered, sorted and indexed VCF in one go. Details This tool adjusts the coordinates of variants within a VCF file to match a new reference. The output file will be sorted and indexed using the target reference build.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: chain
  type: File
  doc: The liftover chain file. See https://genome.ucsc.edu/goldenPath/help/chain.html
    for a description of chain files. See http://hgdownload.soe.ucsc.edu/downloads.html#terms
    for where to download chain files.
  inputBinding:
    position: 1
    prefix: --CHAIN
- id: input
  type: File
  doc: The input VCF/BCF file to be lifted over.
  inputBinding:
    position: 1
    prefix: --INPUT
- id: output
  type: string
  doc: The output location for the lifted over VCF/BCF.
  inputBinding:
    position: 1
    prefix: --OUTPUT
- id: reference_sequence
  type: File
  doc: The reference sequence (fasta) for the TARGET genome build (i.e., the new one.
    The fasta file must have an accompanying sequence dictionary (.dict file).
  inputBinding:
    position: 1
    prefix: --REFERENCE_SEQUENCE
  secondaryFiles:
  - .fai
  - ^.dict
- id: reject
  type: string
  doc: File to which to write rejected records.
  inputBinding:
    position: 1
    prefix: --REJECT
- id: allow_missing_fields_in_header
  type:
  - 'null'
  - boolean
  doc: 'Allow INFO and FORMAT in the records that are not found in the header Possible
    values: true, false.'
  inputBinding:
    position: 1
    prefix: --ALLOW_MISSING_FIELDS_IN_HEADER
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: disable_sort
  type:
  - 'null'
  - boolean
  doc: 'Output VCF file will be written on the fly but it won''t be sorted and indexed.
    Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --DISABLE_SORT
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: liftover_min_match
  type:
  - 'null'
  - double
  doc: The minimum percent match required for a variant to be lifted.
  inputBinding:
    position: 1
    prefix: --LIFTOVER_MIN_MATCH
- id: log_failed_intervals
  type:
  - 'null'
  - boolean
  doc: 'If true, intervals failing due to match below LIFTOVER_MIN_MATCH will be logged
    as a warning to the console. Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --LOG_FAILED_INTERVALS
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: recover_swapped_ref_alt
  type:
  - 'null'
  - boolean
  doc: 'If the REF allele of the lifted site does not match the target genome, that
    variant is normally rejected. For bi-allelic SNPs, if this is set to true and
    the ALT allele equals the new REF allele, the REF and ALT alleles will be swapped.
    This can rescue some variants; however, do this carefully as some annotations
    may become invalid, such as any that are alelle-specifc. See also TAGS_TO_REVERSE
    and TAGS_TO_DROP. Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --RECOVER_SWAPPED_REF_ALT
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: tags_to_drop
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --TAGS_TO_DROP
  doc: INFO field annotations that should be deleted when swapping reference with
    variant alleles.
  inputBinding:
    position: 1
- id: tags_to_reverse
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --TAGS_TO_REVERSE
  doc: INFO field annotations that behave like an Allele Frequency and should be transformed
    with x->1-x when swapping reference with variant alleles.
  inputBinding:
    position: 1
- id: warn_on_missing_contig
  type:
  - 'null'
  - boolean
  doc: 'Warn on missing contig. Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --WARN_ON_MISSING_CONTIG
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: write_original_alleles
  type:
  - 'null'
  - boolean
  doc: 'Write the original alleles for lifted variants to the INFO field. If the alleles
    are identical, this attribute will be omitted. Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --WRITE_ORIGINAL_ALLELES
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: write_original_position
  type:
  - 'null'
  - boolean
  doc: 'Write the original contig/position for lifted variants to the INFO field.
    Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --WRITE_ORIGINAL_POSITION
    valueFrom: '$(self ? ''true'' : ''false'')'
outputs:
- id: output_file
  type: File
  doc: The output location for the lifted over VCF/BCF.
  outputBinding:
    glob: $(inputs.output)
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: reject_file
  type: File
  doc: File to which to write rejected records.
  outputBinding:
    glob: $(inputs.reject)
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
