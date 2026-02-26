cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda_pipe_phase_ont
label: igda-script_igda_pipe_phase_ont
doc: "Phase ONT reads using IGDA\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: indir
    type: Directory
    doc: Input directory
    inputBinding:
      position: 1
  - id: reffile
    type: File
    doc: Reference file
    inputBinding:
      position: 2
  - id: outdir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 3
  - id: max_nn
    type:
      - 'null'
      - int
    doc: maximal number of nearest neighbors
    default: 50
    inputBinding:
      position: 104
      prefix: -m
  - id: min_cvg
    type:
      - 'null'
      - int
    doc: minimal coverage of each contig
    default: 5
    inputBinding:
      position: 104
      prefix: -c
  - id: min_nn
    type:
      - 'null'
      - int
    doc: minimal number of nearest neighbors
    default: 25
    inputBinding:
      position: 104
      prefix: -t
  - id: niter
    type:
      - 'null'
      - int
    doc: maximal number of iteration in ANN
    default: 1
    inputBinding:
      position: 104
      prefix: -b
  - id: nthread
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
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
stdout: igda-script_igda_pipe_phase_ont.out
