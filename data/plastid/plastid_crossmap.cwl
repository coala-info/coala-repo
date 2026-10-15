cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crossmap
label: plastid_crossmap
doc: 'Calculate a crossmap (genome-wide mappability of reads of a given length) for a genome with bowtie.


  Tool homepage: https://github.com/joshuagryphon/plastid'
inputs:
  - id: ebwt
    type: string
    doc: Bowtie index of the genome (prefix) against which crossmap will be generated
    inputBinding:
      position: 1
  - id: outbase
    type: string
    doc: Basename for output files
    inputBinding:
      position: 2
  - id: ebwt_files
    type:
      type: array
      items: File
    doc: The bowtie index files of the genome (.ebwt or .ebwtl files), staged in the working directory so that the ebwt prefix resolves
  - id: k
    type:
      - 'null'
      - int
    doc: 'K-mer length to generate from input file. (Default: 29)'
    inputBinding:
      position: 101
      prefix: -k
  - id: offset
    type:
      - 'null'
      - int
      - File
    doc: 'Offset from 5'' end of plus-strand read at which to attribute score (Default: 14)'
    inputBinding:
      position: 101
      prefix: --offset
  - id: mismatches
    type:
      - 'null'
      - int
    doc: 'Number of mismatches tolerated in alignment. (Default: 0)'
    inputBinding:
      position: 101
      prefix: --mismatches
  - id: bowtie
    type:
      - 'null'
      - string
    doc: 'Location of bowtie binary (Default: /usr/bin/bowtie)'
    inputBinding:
      position: 101
      prefix: --bowtie
  - id: have_kmers
    type:
      - 'null'
      - boolean
    doc: 'If specified, use k-mer files from previous run. In this case ''sequence_file'' should be the value ''outbase'' from the k-mer files you want to use. (Default: False)'
    inputBinding:
      position: 101
      prefix: --have_kmers
  - id: save_kmers
    type:
      - 'null'
      - boolean
    doc: Save k-mer files for reuse in a subsequent run.
    inputBinding:
      position: 101
      prefix: --save_kmers
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to use (should be <= number of chromosomes; default: 2)'
    inputBinding:
      position: 101
      prefix: --processes
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all warning messages. Cannot use with '-v'.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase verbosity. With ''-v'', show every warning. With ''-vv'', turn warnings into exceptions. Cannot use with ''-q''. (Default: show each type of warning once)'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: sequence_file
    type:
      - 'null'
      - File
    doc: A file of DNA sequence
    inputBinding:
      position: 101
      prefix: --sequence_file
  - id: sequence_format
    type:
      - 'null'
      - string
    doc: 'Format of sequence_file (Default: fasta).'
    inputBinding:
      position: 101
      prefix: --sequence_format
outputs:
  - id: outputs
    type:
      type: array
      items: File
    doc: Files written with the given output basename
    outputBinding:
      glob: $(inputs.outbase)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.ebwt_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
