cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igda_pipe_detect
label: igda-script_igda_pipe_detect
doc: "iGDA pipeline: detect SNVs (minor variants) in each chromosome of a sorted aligned BAM file, split into segments, and write detected_snv.vcf.\nUsage: igda_pipe_detect [options] infile(bam file) reffile contextmodel outdir\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: method
    type:
      - 'null'
      - string
    doc: "Method. \"pb\" for PacBio and \"ont\" for Oxford Nanopore. [default = \"pb\"]"
    inputBinding:
      position: 1
      prefix: -m
  - id: segment_size
    type:
      - 'null'
      - int
    doc: "Segment size(bp) to split each genome. [default = 20000]"
    inputBinding:
      position: 1
      prefix: -g
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads. [default = 1]"
    inputBinding:
      position: 1
      prefix: -n
  - id: fast_calculation
    type:
      - 'null'
      - int
    doc: "Is using the fast calculation algorithm. 1 = yes and 0 = no. [default = 1]"
    inputBinding:
      position: 1
      prefix: -f
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: "Minimal read length (shorter reads will be excluded). [default = 1000]"
    inputBinding:
      position: 1
      prefix: -l
  - id: min_depth_snv
    type:
      - 'null'
      - int
    doc: "Minimal depth for each SNV. [default = 25]"
    inputBinding:
      position: 1
      prefix: -r
  - id: min_conditional_substitution_rate
    type:
      - 'null'
      - float
    doc: "Minimal maximal conditional substitution rate. [default = 0.65]"
    inputBinding:
      position: 1
      prefix: -c
  - id: min_orphan_substitution_rate
    type:
      - 'null'
      - float
    doc: "Minimal substitution rate for orphan SNVs."
    inputBinding:
      position: 1
      prefix: -p
  - id: num_similar_reads
    type:
      - 'null'
      - int
    doc: "Number of most similar reads to construct subspaces. [default = 100]"
    inputBinding:
      position: 1
      prefix: -q
  - id: exclude_loci_file
    type:
      - 'null'
      - File
    doc: "The file that list the loci to be excluded."
    inputBinding:
      position: 1
      prefix: -x
  - id: permutation_seed
    type:
      - 'null'
      - int
    doc: "Seed for permutation test (experimental)."
    inputBinding:
      position: 1
      prefix: -s
  - id: min_depth_orphan_snv
    type:
      - 'null'
      - int
    doc: "Minimal depth for each orphan SNV. [default = 15]"
    inputBinding:
      position: 1
      prefix: -d
  - id: min_log_bf_orphan_snv
    type:
      - 'null'
      - float
    doc: "Minimal log-BF for each orphan SNV. [default = 10]"
    inputBinding:
      position: 1
      prefix: -b
  - id: auto_select_parameters
    type:
      - 'null'
      - int
    doc: "Is auto select parameters, 1=yes, 0=no. [default = 1]"
    inputBinding:
      position: 1
      prefix: -a
  - id: infile
    type: File
    doc: "sorted aligned BAM (or SAM) file"
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 2
  - id: reffile
    type: File
    doc: "reference FASTA file"
    inputBinding:
      position: 3
  - id: contextmodel
    type: Directory
    doc: "pretrained context-effect model (https://github.com/zhixingfeng/igda_contextmodel)"
    inputBinding:
      position: 4
  - id: outdir
    type: string
    doc: "output directory (must not exist)"
    inputBinding:
      position: 5
outputs:
  - id: out_dir
    type: Directory
    doc: "output directory with detected_snv.vcf and intermediate files"
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
