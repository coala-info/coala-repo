cwlVersion: v1.2
class: CommandLineTool
baseCommand: express
label: berkeley-express
doc: "eXpress is a streaming tool for quantifying the abundance of a set of target
  sequences from sampled subsequences (RNA-Seq reads).\n\nTool homepage: https://github.com/swati1024/torrents"
inputs:
  - id: targets_fasta
    type: File
    doc: Target sequences in FASTA format
    inputBinding:
      position: 1
  - id: sam_bam_file
    type: File
    doc: Aligned reads in SAM or BAM format
    inputBinding:
      position: 2
  - id: frag_len_mean
    type:
      - 'null'
      - float
    doc: Prior estimate on the mean fragment length
    inputBinding:
      position: 103
      prefix: --frag-len-mean
  - id: frag_len_stddev
    type:
      - 'null'
      - float
    doc: Prior estimate on the standard deviation of the fragment length
    inputBinding:
      position: 103
      prefix: --frag-len-stddev
  - id: library_type
    type:
      - 'null'
      - string
    doc: The library type (e.g., 'fr-unstranded', 'fr-firststrand', 
      'fr-secondstrand')
    inputBinding:
      position: 103
      prefix: --library-type
  - id: max_re_assign
    type:
      - 'null'
      - int
    doc: The maximum number of times a read can be re-assigned
    inputBinding:
      position: 103
      prefix: --max-re-assign
  - id: no_update_check
    type:
      - 'null'
      - boolean
    doc: Disable checking for software updates
    inputBinding:
      position: 103
      prefix: --no-update-check
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 103
      prefix: --num-threads
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The directory in which to write output files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/berkeley-express:v1.5.1-3b1-deb_cv1
