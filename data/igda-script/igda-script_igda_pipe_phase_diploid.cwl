cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda_pipe_phase
label: igda-script_igda_pipe_phase_diploid
doc: "Phases diploid genomes using PacBio or Oxford Nanopore sequencing data.\n\n\
  Tool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: indir
    type: Directory
    doc: Input directory, output of igda_pipe_detect
    inputBinding:
      position: 1
  - id: reffile
    type: File
    doc: Reference fasta file
    inputBinding:
      position: 2
  - id: outdir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 3
  - id: maximal_ann_iterations
    type:
      - 'null'
      - int
    doc: Maximal number of iteration in ANN.
    inputBinding:
      position: 104
      prefix: -b
  - id: maximal_neighbors
    type:
      - 'null'
      - int
    doc: Maximal number of nearest neighbors.
    inputBinding:
      position: 104
      prefix: -r
  - id: method
    type:
      - 'null'
      - string
    doc: Method. "pb" for PacBio and "ont" for Oxford Nanopore.
    inputBinding:
      position: 104
      prefix: -m
  - id: minimal_coverage
    type:
      - 'null'
      - int
    doc: Minimal coverage of each contig.
    inputBinding:
      position: 104
      prefix: -c
  - id: minimal_jaccard_index
    type:
      - 'null'
      - float
    doc: Minimal jaccard index for find_nccontigs and tred.
    inputBinding:
      position: 104
      prefix: -j
  - id: minimal_neighbors
    type:
      - 'null'
      - int
    doc: Minimal number of nearest neighbors.
    inputBinding:
      position: 104
      prefix: -t
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 104
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_igda_pipe_phase_diploid.out
