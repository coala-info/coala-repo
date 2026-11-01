cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- CreateSequenceDictionary
label: gatk_CreateSequenceDictionary
doc: |-
  Creates a sequence dictionary for a reference sequence. This tool creates a sequence dictionary file (with ".dict" extension) from a reference sequence provided in FASTA format, which is required by many processing and analysis tools. The output file contains a header but no SAMRecords, and the header contains only sequence records. The reference sequence can be gzipped (both .fasta and .fasta.gz are supported).

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: reference
  type: File
  doc: Input reference fasta or fasta.gz
  inputBinding:
    position: 1
    prefix: --REFERENCE
- id: alt_names
  type:
  - 'null'
  - File
  doc: 'Optional file containing the alternative names for the contigs. Tools may
    use this information to consider different contig notations as identical (e.g:
    ''chr1'' and ''1''). The alternative names will be put into the appropriate @AN
    annotation for each contig. No header. First column is the original name, the
    second column is an alternative name. One contig may have more than one alternative
    name.'
  inputBinding:
    position: 1
    prefix: --ALT_NAMES
- id: genome_assembly
  type:
  - 'null'
  - string
  doc: Put into AS field of sequence dictionary entry if supplied
  inputBinding:
    position: 1
    prefix: --GENOME_ASSEMBLY
- id: num_sequences
  type:
  - 'null'
  - int
  doc: Stop after writing this many sequences. For testing.
  inputBinding:
    position: 1
    prefix: --NUM_SEQUENCES
- id: output
  type:
  - 'null'
  - string
  default: reference.dict
  doc: Output SAM file containing only the sequence dictionary. By default it will
    use the base name of the input reference with the .dict extension
  inputBinding:
    position: 1
    prefix: --OUTPUT
- id: species
  type:
  - 'null'
  - string
  doc: Put into SP field of sequence dictionary entry
  inputBinding:
    position: 1
    prefix: --SPECIES
- id: truncate_names_at_whitespace
  type:
  - 'null'
  - boolean
  doc: 'Make sequence name the first word from the > line in the fasta file. By default
    the entire contents of the > line is used, excluding leading and trailing whitespace.
    Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --TRUNCATE_NAMES_AT_WHITESPACE
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: uri
  type:
  - 'null'
  - string
  doc: Put into UR field of sequence dictionary entry. If not supplied, input reference
    file is used
  inputBinding:
    position: 1
    prefix: --URI
outputs:
- id: output_file
  type: File
  doc: Output SAM file containing only the sequence dictionary. By default it will
    use the base name of the input reference with the .dict extension
  outputBinding:
    glob: $(inputs.output)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
