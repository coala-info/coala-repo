cwlVersion: v1.2
class: CommandLineTool
baseCommand: cufflinks
label: cufflinks
doc: "Cufflinks assembles transcripts, estimates their abundances, and tests for differential
  expression and regulation in RNA-Seq samples.\n\nTool homepage: https://github.com/santosjorge/cufflinks"
inputs:
  - id: input_bam
    type: File
    doc: File of RNA-Seq reads in SAM, BAM, or CRAM format.
    inputBinding:
      position: 1
  - id: GTF
    type:
      - 'null'
      - File
    doc: Quantitate against reference transcript annotations only.
    inputBinding:
      position: 102
      prefix: --GTF
  - id: GTF_guide
    type:
      - 'null'
      - File
    doc: Use reference transcript annotations to guide assembly.
    inputBinding:
      position: 102
      prefix: --GTF-guide
  - id: frag_bias_correct
    type:
      - 'null'
      - File
    doc: Provide a fasta file to instruct Cufflinks to run a bias correction 
      algorithm.
    inputBinding:
      position: 102
      prefix: --frag-bias-correct
  - id: frag_len_mean
    type:
      - 'null'
      - int
    doc: Average fragment length.
    inputBinding:
      position: 102
      prefix: --frag-len-mean
  - id: frag_len_std_dev
    type:
      - 'null'
      - int
    doc: Standard deviation of fragment length.
    inputBinding:
      position: 102
      prefix: --frag-len-std-dev
  - id: library_type
    type:
      - 'null'
      - string
    doc: The type of RNA-Seq library (e.g. fr-unstranded, fr-firststrand, 
      fr-secondstrand).
    inputBinding:
      position: 102
      prefix: --library-type
  - id: mask_file
    type:
      - 'null'
      - File
    doc: Ignore all alignment within regions specified by this file (e.g. rRNA).
    inputBinding:
      position: 102
      prefix: --mask-file
  - id: max_bundle_frags
    type:
      - 'null'
      - int
    doc: Maximum number of fragments allowed in a locus before skipping it.
    inputBinding:
      position: 102
      prefix: --max-bundle-frags
  - id: multi_read_correct
    type:
      - 'null'
      - boolean
    doc: Do initial estimation step to more accurately weight multi-mapped 
      reads.
    inputBinding:
      position: 102
      prefix: --multi-read-correct
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads used during analysis.
    inputBinding:
      position: 102
      prefix: --num-threads
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Write all output files to this directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cufflinks:2.2.1--py35_2
