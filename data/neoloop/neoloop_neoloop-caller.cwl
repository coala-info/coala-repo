cwlVersion: v1.2
class: CommandLineTool
baseCommand: neoloop-caller
label: neoloop_neoloop-caller
doc: "Identify novel loop interactions across SV points.\n\nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs:
  - id: assembly
    type:
      - 'null'
      - File
    doc: The assembled SV list outputed by assemble-complexSVs.
    default: None
    inputBinding:
      position: 101
      prefix: --assembly
  - id: balance_type
    type:
      - 'null'
      - string
    doc: Normalization method.
    default: CNV
    inputBinding:
      position: 101
      prefix: --balance-type
  - id: cachefolder
    type:
      - 'null'
      - Directory
    doc: "Path to a folder to place the pre-trained Peakachu\nmodels. This command
      will automatically download\nappropriate models according to the sequencing
      depths\nand resolutions of your input Hi-C matrices."
    default: .cache
    inputBinding:
      position: 101
      prefix: --cachefolder
  - id: hic
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of cooler URIs. If URIs at multiple resolutions\nare provided, the
      program will first detect neo-loops\nfrom each individual resolution, and then
      combine\nresults from all resolutions in a non-redundant way.\nIf an interaction
      is detected as a loop in multiple\nresolutions, only the one with the highest
      resolution\nwill be recorded."
    default: None
    inputBinding:
      position: 101
      prefix: --hic
  - id: logfile
    type:
      - 'null'
      - File
    doc: Logging file name.
    default: neoloop.log
    inputBinding:
      position: 101
      prefix: --logFile
  - id: min_marginal_peaks
    type:
      - 'null'
      - int
    doc: "Minimum marginal number of loops when detecting loop\nanchors."
    default: 2
    inputBinding:
      position: 101
      prefix: --min-marginal-peaks
  - id: no_clustering
    type:
      - 'null'
      - boolean
    doc: No pooling will be performed if specified.
    default: false
    inputBinding:
      position: 101
      prefix: --no-clustering
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    default: 1
    inputBinding:
      position: 101
      prefix: --nproc
  - id: prob
    type:
      - 'null'
      - float
    doc: Probability threshold.
    default: 0.9
    inputBinding:
      position: 101
      prefix: --prob
  - id: protocol
    type:
      - 'null'
      - string
    doc: Experimental protocol of your Hi-C.
    default: insitu
    inputBinding:
      position: 101
      prefix: --protocol
  - id: region_size
    type:
      - 'null'
      - int
    doc: The extended genomic span of SV break points.(bp)
    default: 3000000
    inputBinding:
      position: 101
      prefix: --region-size
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to the output file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
