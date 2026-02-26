cwlVersion: v1.2
class: CommandLineTool
baseCommand: OptiType
label: optitype_OptiTypePipeline.py
doc: "4-digit HLA typer\n\nTool homepage: https://github.com/FRED-2/OptiType"
inputs:
  - id: beta
    type:
      - 'null'
      - float
    doc: 'The beta value for for homozygosity detection (see paper). Default: 0.009.
      Handle with care.'
    default: 0.009
    inputBinding:
      position: 101
      prefix: --beta
  - id: config
    type:
      - 'null'
      - File
    doc: 'Path to config file. Default: config.ini in the same directory as this script'
    default: config.ini in the same directory as this script
    inputBinding:
      position: 101
      prefix: --config
  - id: dna
    type: boolean
    doc: Use with DNA sequencing data.
    inputBinding:
      position: 101
      prefix: --dna
  - id: enumerate
    type:
      - 'null'
      - int
    doc: 'Number of enumerations. OptiType will output the optimal solution and the
      top N-1 suboptimal solutions in the results CSV. Default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: --enumerate
  - id: input_fq
    type:
      type: array
      items: File
    doc: '.fastq file(s) (fished or raw) or .bam files stored for re-use, generated
      by an earlier OptiType run. One file: single-end mode, two files: paired-end
      mode.'
    inputBinding:
      position: 101
      prefix: --input
  - id: outdir
    type: Directory
    doc: Specifies the out directory to which all files should be written.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Specifies prefix of output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: rna
    type: boolean
    doc: Use with RNA sequencing data.
    inputBinding:
      position: 101
      prefix: --rna
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set verbose mode on.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optitype:1.3.5--hdfd78af_3
stdout: optitype_OptiTypePipeline.py.out
