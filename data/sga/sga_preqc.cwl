cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - preqc
label: sga_preqc
doc: "Perform pre-assembly quality checks\n\nTool homepage: https://github.com/jts/sga"
inputs:
  - id: reads_file
    type: File
    doc: Input reads file
    inputBinding:
      position: 1
  - id: diploid_reference_mode
    type:
      - 'null'
      - boolean
    doc: generate metrics assuming that the input data is a reference genome, 
      not a collection of reads
    inputBinding:
      position: 102
      prefix: --diploid-reference-mode
  - id: force_em
    type:
      - 'null'
      - boolean
    doc: force preqc to proceed even if the coverage model does not converge. 
      This allows the rest of the program to continue but the branch and genome 
      size estimates may be misleading
    inputBinding:
      position: 102
      prefix: --force-EM
  - id: max_contig_length
    type:
      - 'null'
      - int
    doc: stop contig extension at N bp
    default: 50000
    inputBinding:
      position: 102
      prefix: --max-contig-length
  - id: reference
    type:
      - 'null'
      - File
    doc: use the reference FILE to calculate GC plot
    inputBinding:
      position: 102
      prefix: --reference
  - id: simple
    type:
      - 'null'
      - boolean
    doc: only compute the metrics that do not need the FM-index
    inputBinding:
      position: 102
      prefix: --simple
  - id: threads
    type:
      - 'null'
      - int
    doc: use NUM threads
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_preqc.out
