cwlVersion: v1.2
class: CommandLineTool
baseCommand: longbow
label: longbow
doc: "longbow is a tool for processing fastq files.\n\nTool homepage: https://github.com/JMencius/longbow"
inputs:
  - id: ar
    type:
      - 'null'
      - string
    doc: 'Enable autocorrelation for basecalling mode prediction HAC/SUP(hs) or FAST/HAC/SUP
      (fhs) (Options: hs, fhs, off)'
    default: fhs
    inputBinding:
      position: 101
      prefix: --ar
  - id: buf
    type:
      - 'null'
      - boolean
    doc: Output intermediate QV, autocorrelation results, and detailed run info 
      to output json file
    inputBinding:
      position: 101
      prefix: --buf
  - id: input
    type: File
    doc: Path to the input fastq/fastq.gz file (required)
    inputBinding:
      position: 101
      prefix: --input
  - id: model
    type:
      - 'null'
      - string
    doc: Path to the trained model
    default: '{longbow_code_base}/model'
    inputBinding:
      position: 101
      prefix: --model
  - id: qscore
    type:
      - 'null'
      - int
    doc: Minimum read QV to filter reads
    default: 0
    inputBinding:
      position: 101
      prefix: --qscore
  - id: rc
    type:
      - 'null'
      - string
    doc: Enable read QV cutoff for mode correction in Guppy5/6
    default: on
    inputBinding:
      position: 101
      prefix: --rc
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Print results to standard output
    inputBinding:
      position: 101
      prefix: --stdout
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads to use
    default: 12
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to the output json file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longbow:2.3.1--py313hdfd78af_0
