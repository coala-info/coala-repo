cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jaeger
  - run
label: jaeger-bio_run
doc: "Run Jaeger (yet AnothEr phaGe idEntifier), a deep-learning based bacteriophage
  discovery tool, on a FASTA file of contigs.\n\nTool homepage: https://github.com/Yasas1994/Jaeger"
inputs:
  - id: input
    type: File
    doc: path to input file
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: path to output directory
    inputBinding:
      position: 101
      prefix: --output
  - id: fsize
    type: ['null', int]
    doc: length of the sliding window (value must be 2^n). default:2048
    inputBinding:
      position: 101
      prefix: --fsize
  - id: stride
    type: ['null', int]
    doc: stride of the sliding window. default:2048 (stride==fsize)
    inputBinding:
      position: 101
      prefix: --stride
  - id: model
    type:
      - 'null'
      - type: enum
        symbols:
          - default
          - experimental_1
          - experimental_2
    doc: select a deep-learning model to use. default:default
    inputBinding:
      position: 101
      prefix: --model
  - id: prophage
    type: ['null', boolean]
    doc: extract and report prophage-like regions. default:False
    inputBinding:
      position: 101
      prefix: --prophage
  - id: sensitivity
    type: ['null', float]
    doc: sensitivity of the prophage extraction algorithm (between 0 - 4). default 1.5
    inputBinding:
      position: 101
      prefix: --sensitivity
  - id: lc
    type: ['null', int]
    doc: minimum contig length to run prophage extraction algorithm. default 500000 bp
    inputBinding:
      position: 101
      prefix: --lc
  - id: rc
    type: ['null', float]
    doc: minium reliability score required to accept predictions. default 0.2
    inputBinding:
      position: 101
      prefix: --rc
  - id: pc
    type: ['null', float]
    doc: minium phage score required to accept predictions. default 3
    inputBinding:
      position: 101
      prefix: --pc
  - id: batch
    type: ['null', int]
    doc: parallel batch size, set to a lower value if your gpu runs out of memory. default:96
    inputBinding:
      position: 101
      prefix: --batch
  - id: workers
    type: ['null', int]
    doc: number of threads to use. default:4
    inputBinding:
      position: 101
      prefix: --workers
  - id: getalllogits
    type: ['null', boolean]
    doc: writes window-wise scores to a .npy file
    inputBinding:
      position: 101
      prefix: --getalllogits
  - id: getsequences
    type: ['null', boolean]
    doc: writes the putative phage sequences to a .fasta file
    inputBinding:
      position: 101
      prefix: --getsequences
  - id: cpu
    type: ['null', boolean]
    doc: ignore available gpus and explicitly run jaeger on cpu. default False
    inputBinding:
      position: 101
      prefix: --cpu
  - id: physicalid
    type: ['null', int]
    doc: sets the default gpu device id (for multi-gpu systems). default 0
    inputBinding:
      position: 101
      prefix: --physicalid
  - id: getalllabels
    type: ['null', boolean]
    doc: get predicted labels for Non-Viral contigs. default False
    inputBinding:
      position: 101
      prefix: --getalllabels
  - id: verbose
    type: ['null', boolean]
    doc: 'Verbosity level: -vvv warning, -vv info, -v debug, (default info)'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: overwrite
    type: ['null', boolean]
    doc: Overwrite existing files
    inputBinding:
      position: 101
      prefix: --overwrite
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the prediction tables
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jaeger-bio:1.1.30--pyhdfd78af_0
stdout: jaeger-bio_run.out
