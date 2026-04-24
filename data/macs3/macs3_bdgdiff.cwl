cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - bdgdiff
label: macs3_bdgdiff
doc: Differential peak detection based on paired bedGraph files
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
    doc: log10LR cutoff. Regions with signals lower than cutoff will not be 
      considerred as enriched regions.
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
      It will be used together with --d1. DEPTH1 and DEPTH2 will be used to 
      calculate scaling factor for each sample, to down-scale larger sample to 
      the level of smaller one.
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
  - id: ofile
    type: string
    doc: 'Output filenames. Must give three arguments in order: 1. file for unique
      regions in condition 1; 2. file for unique regions in condition 2; 3. file for
      common regions in both conditions. Note: mutually exclusive with --o-prefix.'
    inputBinding:
      position: 101
      prefix: --ofile
  - id: outdir
    type: string
    doc: If specified all output files will be written to that directory.
    inputBinding:
      position: 101
      prefix: --outdir
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
  - id: output_outdir
    type:
      - 'null'
      - Directory
    doc: If specified all output files will be written to that directory.
    outputBinding:
      glob: $(inputs.outdir)
  - id: output_ofile
    type:
      - 'null'
      - File
    doc: 'Output filenames. Must give three arguments in order: 1. file for unique
      regions in condition 1; 2. file for unique regions in condition 2; 3. file for
      common regions in both conditions. Note: mutually exclusive with --o-prefix.'
    outputBinding:
      glob: $(inputs.ofile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.4--py310h5a5e57a_0
s:url: https://pypi.org/project/MACS3/
$namespaces:
  s: https://schema.org/
