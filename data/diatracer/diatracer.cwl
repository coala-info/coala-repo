cwlVersion: v1.2
class: CommandLineTool
baseCommand: diatracer
label: diatracer
doc: "diaTracer: spectrum-centric analysis of diaPASEF (Bruker timsTOF) data; reads
  a .d folder and writes pseudo-MS/MS spectra (mzML) to a work directory. Needs a
  license key (checked online) from msfragger-upgrader.nesvilab.org/diatracer/.\n\n\
  Tool homepage: https://diatracer.nesvilab.org/"
inputs:
  - id: key
    type: string
    doc: license key
    inputBinding:
      position: 101
      prefix: --key
  - id: d_file
    type: Directory
    doc: .d file path
    inputBinding:
      position: 102
      prefix: --dFilePath
  - id: work_dir
    type: string
    doc: work directory
    inputBinding:
      position: 102
      prefix: --workDir
  - id: delta_apex_im
    type:
      - 'null'
      - float
    doc: Ion mobility delta range for ms1 and ms2 match. default 0.01
    inputBinding:
      position: 102
      prefix: --deltaApexIM
  - id: delta_apex_rt
    type:
      - 'null'
      - int
    doc: Apex scan delta range for ms1 and ms2 match. default 3
    inputBinding:
      position: 102
      prefix: --deltaApexRT
  - id: ms1_ms2_corr
    type:
      - 'null'
      - float
    doc: 'MS1 and MS2 correlation threshold. default: 0.3'
    inputBinding:
      position: 102
      prefix: --ms1MS2Corr
  - id: mass_defect_filter
    type:
      - 'null'
      - int
    doc: 'Apply mass defect filter. 1: apply; 0: not apply. default: 1'
    inputBinding:
      position: 102
      prefix: --massDefectFilter
  - id: mass_defect_offset
    type:
      - 'null'
      - float
    doc: 'Mass defect offset. default: 0.1'
    inputBinding:
      position: 102
      prefix: --massDefectOffset
  - id: write_inter
    type:
      - 'null'
      - int
    doc: 'write inter files . 1: write; 0: not write. default: 0'
    inputBinding:
      position: 102
      prefix: --writeInter
  - id: rf_max
    type:
      - 'null'
      - int
    doc: 'Top N peaks in the spectrum. default: 500'
    inputBinding:
      position: 102
      prefix: --RFMax
  - id: thread_num
    type:
      - 'null'
      - int
    doc: thread number
    inputBinding:
      position: 102
      prefix: --threadNum
outputs:
  - id: out_dir
    type: Directory
    doc: Work directory with the diaTracer output (pseudo-MS/MS mzML).
    outputBinding:
      glob: $(inputs.work_dir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diatracer:1.2.5--h9ee0642_0
stdout: diatracer.out
