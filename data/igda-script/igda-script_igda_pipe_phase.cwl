cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igda_pipe_phase
label: igda-script_igda_pipe_phase
doc: "iGDA pipeline: phase SNVs into haplotype contigs for each chromosome of an igda_pipe_detect output directory.\nUsage: igda_pipe_phase [options] indir reffile outdir\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: method
    type:
      - 'null'
      - string
    doc: "Method. \"pb\" for PacBio and \"ont\" for Oxford Nanopore. [default = pb]"
    inputBinding:
      position: 1
      prefix: -m
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: "minimal coverage of each contig. [default = 10]"
    inputBinding:
      position: 1
      prefix: -c
  - id: min_nearest_neighbors
    type:
      - 'null'
      - int
    doc: "minimal number of nearest neighbors. [default = 25]"
    inputBinding:
      position: 1
      prefix: -t
  - id: max_nearest_neighbors
    type:
      - 'null'
      - int
    doc: "maximal number of nearest neighbors. [default = 50]"
    inputBinding:
      position: 1
      prefix: -r
  - id: min_jaccard_index
    type:
      - 'null'
      - float
    doc: "minimal jaccard index for find_nccontigs and tred. [default = 2.0]"
    inputBinding:
      position: 1
      prefix: -j
  - id: max_ann_iterations
    type:
      - 'null'
      - int
    doc: "maximal number of iteration in ANN. [default = 1]"
    inputBinding:
      position: 1
      prefix: -b
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads. [default = 1]"
    inputBinding:
      position: 1
      prefix: -n
  - id: indir
    type: Directory
    doc: "output directory of igda_pipe_detect"
    inputBinding:
      position: 2
  - id: reffile
    type: File
    doc: "reference FASTA file"
    inputBinding:
      position: 3
  - id: outdir
    type: string
    doc: "output directory"
    inputBinding:
      position: 4
outputs:
  - id: out_dir
    type: Directory
    doc: "output directory with phased contigs"
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
