cwlVersion: v1.2
class: CommandLineTool
baseCommand: wisecondorx predict
label: wisecondorx_predict
doc: "Find copy number aberrations\n\nTool homepage: https://github.com/CenterForMedicalGeneticsGhent/wisecondorX"
inputs:
  - id: infile
    type: File
    doc: .npz input file
    inputBinding:
      position: 1
  - id: reference
    type: File
    doc: Reference .npz, as previously created with newref
    inputBinding:
      position: 2
  - id: outid
    type: string
    doc: Basename (w/o extension) of output files (paths are allowed, e.g. 
      path/to/ID_1)
    inputBinding:
      position: 3
  - id: add_plot_title
    type:
      - 'null'
      - boolean
    doc: Add the output name as plot title
    default: false
    inputBinding:
      position: 104
      prefix: --add-plot-title
  - id: alpha
    type:
      - 'null'
      - float
    doc: p-value cut-off for calling a CBS breakpoint.
    default: 0.0001
    inputBinding:
      position: 104
      prefix: --alpha
  - id: bed
    type:
      - 'null'
      - boolean
    doc: Outputs tab-delimited .bed files, containing the most important 
      information
    default: false
    inputBinding:
      position: 104
      prefix: --bed
  - id: beta
    type:
      - 'null'
      - float
    doc: When beta is given, --zscore is ignored and a ratio cut-off is used to 
      call aberrations. Beta is a number between 0 (liberal) and 1 
      (conservative) and is optimally close to the purity.
    default: None
    inputBinding:
      position: 104
      prefix: --beta
  - id: blacklist
    type:
      - 'null'
      - File
    doc: 'Blacklist that masks regions in output, structure of header-less file: chr...(/t)startpos(/t)endpos(/n)'
    default: None
    inputBinding:
      position: 104
      prefix: --blacklist
  - id: cairo
    type:
      - 'null'
      - boolean
    doc: Uses cairo bitmap type for plotting. Might be necessary for certain 
      setups.
    default: false
    inputBinding:
      position: 104
      prefix: --cairo
  - id: gender
    type:
      - 'null'
      - string
    doc: Force WisecondorX to analyze this case as a male (M) or a female (F)
    default: None
    inputBinding:
      position: 104
      prefix: --gender
  - id: maskrepeats
    type:
      - 'null'
      - int
    doc: Regions with distances > mean + sd * 3 will be masked. Number of 
      masking cycles.
    default: 5
    inputBinding:
      position: 104
      prefix: --maskrepeats
  - id: minrefbins
    type:
      - 'null'
      - int
    doc: Minimum amount of sensible reference bins per target bin.
    default: 150
    inputBinding:
      position: 104
      prefix: --minrefbins
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Outputs .png plots
    default: false
    inputBinding:
      position: 104
      prefix: --plot
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for segmentation algorithm
    default: None
    inputBinding:
      position: 104
      prefix: --seed
  - id: ylim
    type:
      - 'null'
      - string
    doc: y-axis limits for plotting. e.g. [-2,2]
    default: def
    inputBinding:
      position: 104
      prefix: --ylim
  - id: zscore
    type:
      - 'null'
      - float
    doc: z-score cut-off for aberration calling.
    default: 5
    inputBinding:
      position: 104
      prefix: --zscore
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wisecondorx:1.2.9--pyhdfd78af_0
stdout: wisecondorx_predict.out
