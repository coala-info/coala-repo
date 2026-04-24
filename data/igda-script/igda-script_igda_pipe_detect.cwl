cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda_pipe_detect
label: igda-script_igda_pipe_detect
doc: "Detects structural variants using IGDA pipeline.\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: infile
    type: File
    doc: Sorted aligned bam file. This file should be obtained by 
      igda_align_pb(igda_align_ont) and sam2bam.
    inputBinding:
      position: 1
  - id: reffile
    type: File
    doc: The reference fasta file.
    inputBinding:
      position: 2
  - id: contextmodel
    type: File
    doc: The pretrained model for context effect and can be obtained at 
      https://github.com/zhixingfeng/igda_contextmodel.
    inputBinding:
      position: 3
  - id: outdir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 4
  - id: auto_select_parameters
    type:
      - 'null'
      - boolean
    doc: Is auto select parameters, 1=yes, 0=no.
    inputBinding:
      position: 105
      prefix: -a
  - id: exclude_loci_file
    type:
      - 'null'
      - File
    doc: The file that list the loci to be excluded.
    inputBinding:
      position: 105
      prefix: -x
  - id: fast_calculation
    type:
      - 'null'
      - boolean
    doc: Is using the fast calculation algorithm. 1 = yes and 0 = no.
    inputBinding:
      position: 105
      prefix: -f
  - id: method
    type:
      - 'null'
      - string
    doc: '"pb" for PacBio and "ont" for Oxford Nanopore.'
    inputBinding:
      position: 105
      prefix: -m
  - id: min_conditional_substitution_rate
    type:
      - 'null'
      - float
    doc: Minimal maximal conditional substitution rate.
    inputBinding:
      position: 105
      prefix: -c
  - id: min_depth_orphan_snv
    type:
      - 'null'
      - int
    doc: Minimal depth for each orphan SNV.
    inputBinding:
      position: 105
      prefix: -d
  - id: min_depth_snv
    type:
      - 'null'
      - int
    doc: Minimal depth for each SNV.
    inputBinding:
      position: 105
      prefix: -r
  - id: min_log_bf_orphan_snv
    type:
      - 'null'
      - float
    doc: Minimal log-BF for each orphan SNV.
    inputBinding:
      position: 105
      prefix: -b
  - id: min_orphan_substitution_rate
    type:
      - 'null'
      - float
    doc: Minimal substitution rate for orphan SNVs.
    inputBinding:
      position: 105
      prefix: -p
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimal read length (shorter reads will be excluded).
    inputBinding:
      position: 105
      prefix: -l
  - id: num_similar_reads
    type:
      - 'null'
      - int
    doc: Number of most similar reads to construct subspaces.
    inputBinding:
      position: 105
      prefix: -q
  - id: permutation_seed
    type:
      - 'null'
      - int
    doc: Seed for permutation test (experimental). [default = 0, i.e. no 
      permutation]
    inputBinding:
      position: 105
      prefix: -s
  - id: segment_size
    type:
      - 'null'
      - int
    doc: Segment size(bp) to split each genome.
    inputBinding:
      position: 105
      prefix: -g
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 105
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_igda_pipe_detect.out
