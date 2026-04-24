cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccne-fast
label: ccne_ccne-fast
doc: "Carbapenemase-encoding gene copy number estimator (fast screener)\n\nTool homepage:
  https://github.com/biojiang/ccne"
inputs:
  - id: amr
    type: string
    doc: AMR gene name, such as KPC-2, NDM-1, etc or AMR ID. Please refer to 
      --listdb
    inputBinding:
      position: 101
      prefix: --amr
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use
    inputBinding:
      position: 101
      prefix: --cpus
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: CCNE database root folders
    inputBinding:
      position: 101
      prefix: --dbdir
  - id: flank
    type:
      - 'null'
      - int
    doc: The flanking length of sequence to be excluded
    inputBinding:
      position: 101
      prefix: --flank
  - id: fmtdb
    type:
      - 'null'
      - boolean
    doc: Format all the bwa index
    inputBinding:
      position: 101
      prefix: --fmtdb
  - id: in
    type: File
    doc: Input file name
    inputBinding:
      position: 101
      prefix: --in
  - id: listdb
    type:
      - 'null'
      - boolean
    doc: List all configured AMRs
    inputBinding:
      position: 101
      prefix: --listdb
  - id: listsp
    type:
      - 'null'
      - boolean
    doc: List all configured species and housekeeping genes
    inputBinding:
      position: 101
      prefix: --listsp
  - id: multiref
    type:
      - 'null'
      - boolean
    doc: Use the reads depth of all the available sequences
    inputBinding:
      position: 101
      prefix: --multiref
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No screen output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: ref
    type:
      - 'null'
      - string
    doc: 'Reference gene defalut(Kp:rpoB Ab:rpoB Ec:polB Pa:ppsA), please refer to
      --listsp.Note: When --sp is set to Pls, this parameter should be set to replicon
      type.'
    inputBinding:
      position: 101
      prefix: --ref
  - id: sp
    type: string
    doc: Species name[Kp|Ec|Ab|Pa|Pls]
    inputBinding:
      position: 101
      prefix: --sp
outputs:
  - id: out
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccne:1.1.2--hdfd78af_0
