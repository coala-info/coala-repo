cwlVersion: v1.2
class: CommandLineTool
baseCommand: hap-ibd
label: hap-ibd
doc: "Finds segments of identity-by-descent (IBD) between individuals in a VCF file.\n\
  \nTool homepage: https://github.com/browning-lab/hap-ibd"
inputs:
  - id: gt
    type: File
    doc: VCF file with GT field
    inputBinding:
      position: 1
      prefix: gt=
      separate: false
  - id: map
    type: File
    doc: PLINK map file with cM units
    inputBinding:
      position: 2
      prefix: map=
      separate: false
  - id: out
    type: string
    doc: output file prefix
    inputBinding:
      position: 3
      prefix: out=
      separate: false
  - id: excludesamples
    type:
      - 'null'
      - File
    doc: excluded samples file
    inputBinding:
      position: 4
      prefix: excludesamples=
      separate: false
  - id: min_seed
    type:
      - 'null'
      - float
    doc: min cM length of seed segment (default 2.0)
    inputBinding:
      position: 5
      prefix: min-seed=
      separate: false
  - id: max_gap
    type:
      - 'null'
      - int
    doc: max base pairs in non-IBS gap (default 1000)
    inputBinding:
      position: 6
      prefix: max-gap=
      separate: false
  - id: min_extend
    type:
      - 'null'
      - float
    doc: min cM length of extension segment (default min(1.0, min-seed))
    inputBinding:
      position: 7
      prefix: min-extend=
      separate: false
  - id: min_output
    type:
      - 'null'
      - float
    doc: min cM length of output segment (default 2.0)
    inputBinding:
      position: 8
      prefix: min-output=
      separate: false
  - id: min_markers
    type:
      - 'null'
      - int
    doc: min markers in seed segment (default 100)
    inputBinding:
      position: 9
      prefix: min-markers=
      separate: false
  - id: min_mac
    type:
      - 'null'
      - int
    doc: minimum minor allele count filter (default 2)
    inputBinding:
      position: 10
      prefix: min-mac=
      separate: false
  - id: nthreads
    type:
      - 'null'
      - int
    doc: number of computational threads (default all CPU cores)
    inputBinding:
      position: 11
      prefix: nthreads=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in out (.log, .ibd.gz, .hbd.gz)
    outputBinding:
      glob: $(inputs.out).*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hap-ibd:1.0.rev20May22.818--hdfd78af_0
stdout: hap-ibd.out
