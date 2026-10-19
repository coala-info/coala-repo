cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ribo
  - stack
label: riboseed_ribo_stack
doc: "Map reads to a reference and compare coverage depths in rDNA regions to the rest of the genome to assess disparity in rDNA counts between the reference and the reads.\n\nTool homepage: https://github.com/nickp60/riboSeed"
inputs:
  - id: riboscan_dir
    type: Directory
    doc: "We need the gff and fasta files from your riboScan run."
    inputBinding:
      position: 1
  - id: bam
    type:
      - 'null'
      - File
    secondaryFiles:
      - .bai
    doc: "BAM file; tested with BWA output; default: None"
    inputBinding:
      position: 101
      prefix: '--bam'
  - id: riboseed_dir
    type: Directory
    doc: "look for BAM file in this riboSeed output directory"
    inputBinding:
      position: 101
      prefix: '--riboSeed_dir'
  - id: n_samples
    type:
      - 'null'
      - int
    doc: "Number of regions to compare rDNA depth to; must be greater than 1; default: 10"
    inputBinding:
      position: 101
      prefix: '--n_samples'
  - id: experiment_name
    type:
      - 'null'
      - string
    doc: "prefix for results files; default: riboStack"
    inputBinding:
      position: 101
      prefix: '--experiment_name'
  - id: infer
    type:
      - 'null'
      - boolean
    doc: "ignore the name and length of reference sequence, using the BAM header instead"
    inputBinding:
      position: 101
      prefix: '--infer'
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Logger writes debug to file in output dir; this sets verbosity level sent to stderr. 1 = debug(), 2 = info(), 3 = warning(), 4 = error() and 5 = critical(); default: 2"
    inputBinding:
      position: 101
      prefix: '--verbosity'
  - id: output
    type: string
    doc: "output directory"
    inputBinding:
      position: 102
      prefix: '--output'
outputs:
  - id: output_dir
    type: Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseed:0.4.90--py_0
stdout: riboseed_ribo_stack.out
