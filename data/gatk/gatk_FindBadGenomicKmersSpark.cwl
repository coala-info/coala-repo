cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- FindBadGenomicKmersSpark
label: gatk_FindBadGenomicKmersSpark
doc: |-
  Search the reference for kmers (fixed-length substrings) that occur more than a specified number of times, and list them to an output file. The resulting output file is appropriate for use as the --kmers-to-ignore input file by the StructuralVariationDiscoveryPipelineSpark tool, which will ignore these kmers when trying to produce candidate reads for local assemblies.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: output
  type: string
  doc: file for ubiquitous kmer output
  inputBinding:
    position: 1
    prefix: --output
- id: reference
  type: File
  doc: Reference sequence file
  inputBinding:
    position: 1
    prefix: --reference
  secondaryFiles:
  - .fai
  - ^.dict
- id: exclude_intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --exclude-intervals
  doc: One or more genomic intervals to exclude from processing
  inputBinding:
    position: 1
- id: high_copy_fasta
  type:
  - 'null'
  - File
  doc: additional high copy kmers (mitochondrion, e.g.) fasta file name
  inputBinding:
    position: 1
    prefix: --high-copy-fasta
- id: input
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --input
  doc: BAM/SAM/CRAM file containing reads
  inputBinding:
    position: 1
- id: intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --intervals
  doc: One or more genomic intervals over which to operate
  inputBinding:
    position: 1
- id: k_size
  type:
  - 'null'
  - int
  doc: kmer size
  inputBinding:
    position: 1
    prefix: --k-size
- id: kmer_max_dust_score
  type:
  - 'null'
  - int
  doc: maximum kmer DUST score
  inputBinding:
    position: 1
    prefix: --kmer-max-dust-score
- id: splitting_index_granularity
  type:
  - 'null'
  - long
  doc: Granularity to use when writing a splitting index, one entry will be put into
    the index every n reads where n is this granularity value. Smaller granularity
    results in a larger index with more available split points.
  inputBinding:
    position: 1
    prefix: --splitting-index-granularity
outputs:
- id: output_file
  type: File
  doc: file for ubiquitous kmer output
  outputBinding:
    glob: $(inputs.output)
requirements:
- class: InlineJavascriptRequirement
- class: EnvVarRequirement
  envDef:
  - envName: SPARK_LOCAL_IP
    envValue: 127.0.0.1
  - envName: SPARK_LOCAL_HOSTNAME
    envValue: localhost
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
