cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - leviosam
  - lift
label: leviosam_lift
doc: "Perform efficient lift-over of SAM/BAM alignments using levioSAM.\n\nTool homepage: https://github.com/alshai/levioSAM"
inputs:
  - id: alignments
    type:
      - 'null'
      - File
    doc: 'Path to the SAM/BAM file to be lifted.'
    inputBinding:
      position: 1
      prefix: -a
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads used. [1]'
    inputBinding:
      position: 2
      prefix: -t
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: 'Chunk size for each thread. [256]'
    inputBinding:
      position: 3
      prefix: -T
  - id: add_md_nm
    type:
      - 'null'
      - boolean
    doc: 'Add MD and NM to output alignment records (requires the reference option).'
    inputBinding:
      position: 4
      prefix: -m
  - id: reference
    type:
      - 'null'
      - File
    doc: 'Fasta reference that corresponds to input SAM/BAM (for use with the add_md_nm option).'
    inputBinding:
      position: 5
      prefix: -f
  - id: alignment_preset
    type:
      - 'null'
      - string
    doc: 'Alignment preset [illumina]'
    inputBinding:
      position: 6
      prefix: -x
  - id: vcf
    type:
      - 'null'
      - File
    doc: 'If vcfmap is not specified, can build indexes using a VCF file.'
    inputBinding:
      position: 7
      prefix: -v
  - id: vcfmap
    type:
      - 'null'
      - File
    doc: 'Path to an indexed VcfMap.'
    inputBinding:
      position: 8
      prefix: -l
  - id: chain
    type:
      - 'null'
      - File
    doc: 'If chainmap is not specified, build a ChainMap from a chain file.'
    inputBinding:
      position: 9
      prefix: -c
  - id: chainmap
    type:
      - 'null'
      - File
    doc: 'Path to an indexed ChainMap.'
    inputBinding:
      position: 10
      prefix: -C
  - id: allowed_cigar_changes
    type:
      - 'null'
      - int
    doc: 'Number of allowed CIGAR changes for one alignment. [0]'
    inputBinding:
      position: 11
      prefix: -G
  - id: split_rules
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -S
    doc: 'Key-value pair of a split rule, repeated for several rules (mapq:<int>, aln_score:<int>, isize:<int>, hdist:<int>, clipped_frac:<float>, lifted).'
    inputBinding:
      position: 12
  - id: bed_commit_source
    type:
      - 'null'
      - File
    doc: 'Path to a BED file (source coordinates). Reads overlapping the regions are always committed.'
    inputBinding:
      position: 13
      prefix: -r
  - id: bed_defer_dest
    type:
      - 'null'
      - File
    doc: 'Path to a BED file (dest coordinates). Reads overlapping the regions are always deferred.'
    inputBinding:
      position: 14
      prefix: -D
  - id: dest_fai
    type:
      - 'null'
      - File
    doc: 'Path to the FAI (FASTA index) file of the dest reference (used when building the map from -v/-c).'
    inputBinding:
      position: 15
      prefix: -F
  - id: sample
    type:
      - 'null'
      - string
    doc: 'The sample used to build the index (-v needs to be set).'
    inputBinding:
      position: 16
      prefix: -s
  - id: haplotype
    type:
      - 'null'
      - int
    doc: 'The haplotype used to build the index. [0]'
    inputBinding:
      position: 17
      prefix: -g
  - id: name_map
    type:
      - 'null'
      - File
    doc: 'Path to a name map file.'
    inputBinding:
      position: 18
      prefix: -n
  - id: prefix
    type: string
    doc: 'Prefix of the output files.'
    inputBinding:
      position: 19
      prefix: -p
  - id: out_format
    type:
      - 'null'
      - string
    doc: 'Output format (bam or sam).'
    inputBinding:
      position: 20
      prefix: -O
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: 'Verbose level [0]'
    inputBinding:
      position: 21
      prefix: -V
outputs:
  - id: lifted_files
    type: File[]
    doc: 'Lifted alignment files written with the prefix given in prefix'
    outputBinding:
      glob: $(inputs.prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviosam:5.2.1--h4ac6f70_2
