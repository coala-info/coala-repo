cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs2
  - bdgdiff
label: macs2_bdgdiff
doc: "Differential peak detection based on paired bedGraph files\n\nTool homepage:
  https://pypi.org/project/MACS2/"
inputs:
  - id: c1_bdg
    type: File
    doc: MACS control lambda bedGraph for condition 1. Incompatible with 
      callpeak --SPMR output.
    inputBinding:
      position: 101
      prefix: --c1
  - id: c2_bdg
    type: File
    doc: MACS control lambda bedGraph for condition 2. Incompatible with 
      callpeak --SPMR output.
    inputBinding:
      position: 101
      prefix: --c2
  - id: cutoff
    type:
      - 'null'
      - float
    doc: 'logLR cutoff. DEFAULT: 3 (likelihood ratio=1000)'
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: depth1
    type:
      - 'null'
      - float
    doc: Sequencing depth (# of non-redundant reads in million) for condition 1.
      It will be used together with --d2.
    inputBinding:
      position: 101
      prefix: --d1
  - id: depth2
    type:
      - 'null'
      - float
    doc: Sequencing depth (# of non-redundant reads in million) for condition 2.
      It will be used together with --d1.
    inputBinding:
      position: 101
      prefix: --d2
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum gap to merge nearby differential regions. Consider a wider gap 
      for broad marks. Maximum gap should be smaller than minimum length (-g).
    inputBinding:
      position: 101
      prefix: --max-gap
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum length of differential region. Try bigger value to remove small
      regions.
    inputBinding:
      position: 101
      prefix: --min-len
  - id: o_prefix
    type:
      - 'null'
      - string
    doc: Output file prefix. Actual files will be named as PREFIX_cond1.bed, 
      PREFIX_cond2.bed and PREFIX_common.bed. Mutually exclusive with 
      -o/--ofile.
    inputBinding:
      position: 101
      prefix: --o-prefix
  - id: t1_bdg
    type: File
    doc: MACS pileup bedGraph for condition 1. Incompatible with callpeak --SPMR
      output.
    inputBinding:
      position: 101
      prefix: --t1
  - id: t2_bdg
    type: File
    doc: MACS pileup bedGraph for condition 2. Incompatible with callpeak --SPMR
      output.
    inputBinding:
      position: 101
      prefix: --t2
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    outputBinding:
      glob: $(inputs.outdir)
  - id: ofile
    type:
      - 'null'
      - File
    doc: 'Output filenames. Must give three arguments in order: 1. file for unique
      regions in condition 1; 2. file for unique regions in condition 2; 3. file for
      common regions in both conditions. Note: mutually exclusive with --o-prefix.'
    outputBinding:
      glob: $(inputs.ofile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
