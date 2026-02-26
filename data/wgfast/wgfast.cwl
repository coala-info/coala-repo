cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgfast
label: wgfast
doc: "Must provide reference_dir.\n\nTool homepage: https://github.com/jasonsahl/wgfast"
inputs:
  - id: coverage
    type:
      - 'null'
      - int
    doc: minimum SNP coverage required to be called a SNP
    default: 3
    inputBinding:
      position: 101
      prefix: --coverage
  - id: doc
    type:
      - 'null'
      - boolean
    doc: run depth of coverage on all files?
    default: T
    inputBinding:
      position: 101
      prefix: --doc
  - id: fudge_factor
    type:
      - 'null'
      - float
    doc: How close does a subsample have to be from true placement?
    default: 0.1
    inputBinding:
      position: 101
      prefix: --fudge_factor
  - id: gatk_method
    type:
      - 'null'
      - string
    doc: How to call GATK?
    default: EMIT_ALL_CONFIDENT_SITES
    inputBinding:
      position: 101
      prefix: --gatk_method
  - id: keep
    type:
      - 'null'
      - boolean
    doc: keep temp files?
    default: F
    inputBinding:
      position: 101
      prefix: --keep
  - id: model
    type:
      - 'null'
      - string
    doc: which model to run with raxml, GTRGAMMA, ASC_GTRGAMMA, GTRCAT, 
      ASC_GTRCAT
    inputBinding:
      position: 101
      prefix: --model
  - id: only_subs
    type:
      - 'null'
      - boolean
    doc: Only run sub-sample routine and exit?
    default: F
    inputBinding:
      position: 101
      prefix: --only_subs
  - id: processors
    type:
      - 'null'
      - int
    doc: '# of processors to use'
    default: 2
    inputBinding:
      position: 101
      prefix: --processors
  - id: proportion
    type:
      - 'null'
      - float
    doc: proportion of alleles to be called a SNP
    default: 0.9
    inputBinding:
      position: 101
      prefix: --proportion
  - id: read_directory
    type: Directory
    doc: path to directory of fastq files
    inputBinding:
      position: 101
      prefix: --read_directory
  - id: reference_directory
    type: Directory
    doc: path to reference file directory
    inputBinding:
      position: 101
      prefix: --reference_directory
  - id: subnums
    type:
      - 'null'
      - int
    doc: number of subsamples to process
    default: 100
    inputBinding:
      position: 101
      prefix: --subnums
  - id: subsample
    type:
      - 'null'
      - boolean
    doc: Run subsample routine?
    default: T
    inputBinding:
      position: 101
      prefix: --subsample
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: temporary directory for GATK analysis
    default: /tmp
    inputBinding:
      position: 101
      prefix: --temp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgfast:1.0.4--py_0
stdout: wgfast.out
