cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - bdgdiff
label: macs3_bdgdiff
doc: "Differential peak detection based on paired bedGraph files\n\nTool homepage:
  https://pypi.org/project/MACS3/"
inputs:
  - id: c1
    type: File
    doc: MACS control lambda bedGraph for condition 1. Incompatible with 
      callpeak --SPMR output. REQUIRED
    inputBinding:
      position: 101
      prefix: --c1
  - id: c2
    type: File
    doc: MACS control lambda bedGraph for condition 2. Incompatible with 
      callpeak --SPMR output. REQUIRED
    inputBinding:
      position: 101
      prefix: --c2
  - id: cutoff
    type:
      - 'null'
      - float
    doc: 'log10LR cutoff. Regions with signals lower than cutoff will not be considerred
      as enriched regions. DEFAULT: 3 (likelihood ratio=1000)'
    default: 3.0
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: depth1
    type:
      - 'null'
      - float
    doc: Sequencing depth (# of non-redundant reads in million) for condition 1.
      It will be used together with --d2.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --d1
  - id: depth2
    type:
      - 'null'
      - float
    doc: Sequencing depth (# of non-redundant reads in million) for condition 2.
      It will be used together with --d1. DEPTH1 and DEPTH2 will be used to 
      calculate scaling factor for each sample, to down-scale larger sample to 
      the level of smaller one.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --d2
  - id: max_gap
    type:
      - 'null'
      - int
    doc: 'Maximum gap to merge nearby differential regions. Consider a wider gap for
      broad marks. Maximum gap should be smaller than minimum length (-g). DEFAULT:
      100'
    default: 100
    inputBinding:
      position: 101
      prefix: --max-gap
  - id: min_len
    type:
      - 'null'
      - int
    doc: 'Minimum length of differential region. Try bigger value to remove small
      regions. DEFAULT: 200'
    default: 200
    inputBinding:
      position: 101
      prefix: --min-len
  - id: t1
    type: File
    doc: MACS pileup bedGraph for condition 1. Incompatible with callpeak --SPMR
      output. REQUIRED
    inputBinding:
      position: 101
      prefix: --t1
  - id: t2
    type: File
    doc: MACS pileup bedGraph for condition 2. Incompatible with callpeak --SPMR
      output. REQUIRED
    inputBinding:
      position: 101
      prefix: --t2
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Set verbose level of runtime message. 0: only show critical message, 1:
      show additional warning message, 2: show process information, 3: show debug
      messages. DEFAULT:2'
    default: 2
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    outputBinding:
      glob: $(inputs.outdir)
  - id: o_prefix
    type:
      - 'null'
      - File
    doc: Output file prefix. Actual files will be named as PREFIX_cond1.bed, 
      PREFIX_cond2.bed and PREFIX_common.bed. Mutually exclusive with 
      -o/--ofile.
    outputBinding:
      glob: $(inputs.o_prefix)
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
    dockerPull: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
