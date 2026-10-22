cwlVersion: v1.2
class: CommandLineTool
baseCommand: SmartMapRNAPrep
label: smartmap_SmartMapRNAPrep
doc: "SmartMapRNAPrep [options] -x [Bowtie2 index] -o [output prefix] -1 [R1 fastq]
  -2 [R2 fastq]\n\nTool homepage: http://shah-rohan.github.io/SmartMap"
inputs:
  - id: bowtie2_index
    type: string
    doc: Basename of the HISAT2 index for alignment (the index files must be 
      given in index_files)
    inputBinding:
      position: 101
      prefix: -x
  - id: index_files
    type:
      type: array
      items: File
    doc: HISAT2 index files (.ht2 or .ht2l) for the basename in bowtie2_index. They are staged in the working directory.
  - id: max_alignments
    type:
      - 'null'
      - int
    doc: Maximum number of alignments reported
    inputBinding:
      position: 101
      prefix: -k
  - id: output_prefix
    type: string
    doc: Output prefix prepended to the output files
    inputBinding:
      position: 101
      prefix: -o
  - id: r1_fastq
    type: File
    doc: Fastq file for read mate 1 (can be gzipped)
    inputBinding:
      position: 101
      prefix: '-1'
  - id: r2_fastq
    type: File
    doc: Fastq file for read mate 2 (can be gzipped)
    inputBinding:
      position: 101
      prefix: '-2'
  - id: remove_from_read_names
    type: string
    doc: String to be removed from read names. Required in practice, because the 
      script runs sed with this string and fails with an empty value (give a 
      string that does not occur in the read names to keep them unchanged).
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads to be used for multithreaded alignment
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: scores_bed
    type:
      type: array
      items: File
    doc: Filtered alignments with scores, gzipped BED (input for SmartMap)
    outputBinding:
      glob: $(inputs.output_prefix)*.bed.gz
  - id: splits
    type:
      - 'null'
      - Directory
    doc: One BED file per read with all its alignments
    outputBinding:
      glob: splits
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartmap:1.0.0--h077b44d_4
stdout: smartmap_SmartMapRNAPrep.out
