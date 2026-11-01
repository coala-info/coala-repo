cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- MergeVcfs
label: gatk_MergeVcfs
doc: |-
  Combines multiple variant files into a single variant file. Inputs One or more input file in VCF format (can be gzipped, i.e. ending in ".vcf.gz", or binary compressed, i.e. ending in ".bcf"). Optionally a sequence dictionary file (typically name ending in .dict) if the input VCF does not contain a complete contig list and if the output index is to be created (true by default).

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: input
  type:
    type: array
    items: File
    inputBinding:
      prefix: --INPUT
  doc: VCF or BCF input files (File format is determined by file extension), or a
    file having a '.list' suffix containing the path to the files, one per line.
  inputBinding:
    position: 1
  secondaryFiles:
  - pattern: .tbi
    required: false
  - pattern: .idx
    required: false
- id: output
  type: string
  doc: The merged VCF or BCF file. File format is determined by file extension.
  inputBinding:
    position: 1
    prefix: --OUTPUT
- id: comment
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --COMMENT
  doc: Comment(s) to include in the merged output file's header.
  inputBinding:
    position: 1
- id: reference_sequence
  type:
  - 'null'
  - File
  doc: Reference sequence file.
  inputBinding:
    position: 1
    prefix: --REFERENCE_SEQUENCE
  secondaryFiles:
  - .fai
  - ^.dict
- id: sequence_dictionary
  type:
  - 'null'
  - File
  doc: The index sequence dictionary to use instead of the sequence dictionary in
    the input files
  inputBinding:
    position: 1
    prefix: --SEQUENCE_DICTIONARY
outputs:
- id: output_file
  type: File
  doc: The merged VCF or BCF file. File format is determined by file extension.
  outputBinding:
    glob: $(inputs.output)
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
