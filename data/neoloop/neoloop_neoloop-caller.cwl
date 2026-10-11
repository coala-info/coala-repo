cwlVersion: v1.2
class: CommandLineTool
baseCommand: neoloop-caller
label: neoloop_neoloop-caller
doc: "Identify novel loop interactions across SV points.\n\nTool homepage: https://github.com/XiaoTaoWang/NeoLoopFinder"
inputs:
  - id: assembly
    type: File
    doc: The assembled SV list outputed by assemble-complexSVs.
    inputBinding:
      position: 101
      prefix: --assembly
  - id: balance_type
    type:
      - 'null'
      - string
    doc: Normalization method.
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
    inputBinding:
      position: 101
      prefix: --cachefolder
  - id: hic
    type:
      type: array
      items: File
    doc: "List of cool files (use hic_groups for .mcool). If URIs at multiple resolutions\nare provided, the
      program will first detect neo-loops\nfrom each individual resolution, and then
      combine\nresults from all resolutions in a non-redundant way.\nIf an interaction
      is detected as a loop in multiple\nresolutions, only the one with the highest
      resolution\nwill be recorded."
    inputBinding:
      position: 101
      prefix: --hic
      valueFrom: |-
        ${ return self.map(function(f, i) { return f.path + (inputs.hic_groups && inputs.hic_groups[i] ? inputs.hic_groups[i] : ''); }); }
  - id: hic_groups
    type:
      - 'null'
      - type: array
        items: string
    doc: Groups inside .mcool files appended, in the same order, to the cool URIs in hic (for example ::resolutions/25000).
  - id: logfile
    type:
      - 'null'
      - string
    doc: Logging file name.
    inputBinding:
      position: 101
      prefix: --logFile
  - id: min_marginal_peaks
    type:
      - 'null'
      - int
    doc: "Minimum marginal number of loops when detecting loop\nanchors."
    inputBinding:
      position: 101
      prefix: --min-marginal-peaks
  - id: no_clustering
    type:
      - 'null'
      - boolean
    doc: No pooling will be performed if specified.
    inputBinding:
      position: 101
      prefix: --no-clustering
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    inputBinding:
      position: 101
      prefix: --nproc
  - id: prob
    type:
      - 'null'
      - float
    doc: Probability threshold.
    inputBinding:
      position: 101
      prefix: --prob
  - id: protocol
    type:
      - 'null'
      - string
    doc: Experimental protocol of your Hi-C.
    inputBinding:
      position: 101
      prefix: --protocol
  - id: region_size
    type:
      - 'null'
      - int
    doc: The extended genomic span of SV break points.(bp)
    inputBinding:
      position: 101
      prefix: --region-size
  - id: output_path
    type: string
    doc: Path to the output file (BEDPE).
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Path to the output file.
    outputBinding:
      glob: $(inputs.output_path)
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file.
    outputBinding:
      glob: |-
        ${ return inputs.logfile ? inputs.logfile : 'neoloop.log'; }
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
