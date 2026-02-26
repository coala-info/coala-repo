cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar hap-ibd.jar
label: hap-ibd
doc: "Finds segments of identity-by-descent (IBD) between individuals in a VCF file.\n\
  \nTool homepage: https://github.com/browning-lab/hap-ibd"
inputs:
  - id: excludesamples
    type:
      - 'null'
      - File
    doc: excluded samples file
    inputBinding:
      position: 101
  - id: gt
    type: File
    doc: VCF file with GT field
    inputBinding:
      position: 101
  - id: map
    type: File
    doc: PLINK map file with cM units
    inputBinding:
      position: 101
  - id: max_gap
    type:
      - 'null'
      - int
    doc: max base pairs in non-IBS gap
    default: 1000
    inputBinding:
      position: 101
  - id: min_extend
    type:
      - 'null'
      - string
    doc: min cM length of extension segment
    inputBinding:
      position: 101
  - id: min_mac
    type:
      - 'null'
      - int
    doc: minimum minor allele count filter
    default: 2
    inputBinding:
      position: 101
  - id: min_markers
    type:
      - 'null'
      - int
    doc: min markers in seed segment
    default: 100
    inputBinding:
      position: 101
  - id: min_output
    type:
      - 'null'
      - float
    doc: min cM length of output segment
    default: 2.0
    inputBinding:
      position: 101
  - id: min_seed
    type:
      - 'null'
      - float
    doc: min cM length of seed segment
    default: 2.0
    inputBinding:
      position: 101
  - id: nthreads
    type:
      - 'null'
      - int
    doc: number of computational threads
    default: all CPU cores
    inputBinding:
      position: 101
  - id: out
    type: string
    doc: output file prefix
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hap-ibd:1.0.rev20May22.818--hdfd78af_0
stdout: hap-ibd.out
