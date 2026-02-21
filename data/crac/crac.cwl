cwlVersion: v1.2
class: CommandLineTool
baseCommand: crac
label: crac
doc: "CRAC: a tool for analyzing RNA-seq data, detecting and classifying biological
  events (splice, snv, indel, chimera)\n\nTool homepage: https://github.com/brannondorsey/wifi-cracking"
inputs:
  - id: bam
    type:
      - 'null'
      - boolean
    doc: sam output is encode in binary format(BAM)
    inputBinding:
      position: 101
      prefix: --bam
  - id: genome_index
    type: File
    doc: set genome index file (without the extension filename)
    inputBinding:
      position: 101
      prefix: -i
  - id: kmer_length
    type: int
    doc: set k-mer length
    inputBinding:
      position: 101
      prefix: -k
  - id: max_locs
    type:
      - 'null'
      - int
    doc: set the maximum number of locations on the reference index
    default: 300
    inputBinding:
      position: 101
      prefix: --max-locs
  - id: nb_threads
    type:
      - 'null'
      - int
    doc: set the number of worker threads
    default: 1
    inputBinding:
      position: 101
      prefix: --nb-threads
  - id: no_ambiguity
    type:
      - 'null'
      - boolean
    doc: discard biological events (splice, snv, indel, chimera) which have several
      matches on the reference index
    inputBinding:
      position: 101
      prefix: --no-ambiguity
  - id: orientation
    type:
      - 'null'
      - boolean
    doc: 'set the mates alignement orientation (DEFAULT --fr). Note: also supports
      --rf or --ff'
    inputBinding:
      position: 101
      prefix: --fr
  - id: read_files
    type:
      type: array
      items: File
    doc: set read file. Specify FILE2 in case of paired-end reads
    inputBinding:
      position: 101
      prefix: -r
  - id: reads_length
    type:
      - 'null'
      - int
    doc: set read length in case of all reads have the same length to optimize CPU
      and memory times
    inputBinding:
      position: 101
      prefix: --reads-length
  - id: stranded
    type:
      - 'null'
      - boolean
    doc: set the read mapping with for a strand specific library (DEFAULT non-strand
      specific)
    inputBinding:
      position: 101
      prefix: --stranded
  - id: treat_multiple
    type:
      - 'null'
      - int
    doc: write alignments with multiple locations (with a fixed limit) in the SAM
      file rather than only one occurrence
    inputBinding:
      position: 101
      prefix: --treat-multiple
outputs:
  - id: output_sam
    type: File
    doc: set SAM output filename or print on STDOUT with "-o -" argument
    outputBinding:
      glob: $(inputs.output_sam)
  - id: summary
    type:
      - 'null'
      - File
    doc: set output summary file with some statistics about mapping and classification
    outputBinding:
      glob: $(inputs.summary)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crac:v2.5.0dfsg-3-deb_cv1
