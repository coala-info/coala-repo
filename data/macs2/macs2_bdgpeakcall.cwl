cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs2
  - bdgpeakcall
label: macs2_bdgpeakcall
doc: "Call peaks from bedGraph output of MACS2\n\nTool homepage: https://pypi.org/project/MACS2/"
inputs:
  - id: cutoff
    type:
      - 'null'
      - float
    doc: 'Cutoff depends on which method you used for score track. If the file contains
      pvalue scores from MACS2, score 5 means pvalue 1e-5. DEFAULT: 5'
    default: 5
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: cutoff_analysis
    type:
      - 'null'
      - boolean
    doc: 'While set, bdgpeakcall will analyze number or total length of peaks that
      can be called by different cutoff then output a summary table to help user decide
      a better cutoff. Note, minlen and maxgap may affect the results. DEFAULT: False'
    default: false
    inputBinding:
      position: 101
      prefix: --cutoff-analysis
  - id: ifile
    type: File
    doc: MACS score in bedGraph. REQUIRED
    inputBinding:
      position: 101
      prefix: --ifile
  - id: max_gap
    type:
      - 'null'
      - int
    doc: 'maximum gap between significant points in a peak, better to set it as tag
      size. DEFAULT: 30'
    default: 30
    inputBinding:
      position: 101
      prefix: --max-gap
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'minimum length of peak, better to set it as d value. DEFAULT: 200'
    default: 200
    inputBinding:
      position: 101
      prefix: --min-length
  - id: no_trackline
    type:
      - 'null'
      - boolean
    doc: Tells MACS not to include trackline with bedGraph files. The trackline 
      is required by UCSC.
    inputBinding:
      position: 101
      prefix: --no-trackline
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
    doc: Output file name. Mutually exclusive with --o-prefix.
    outputBinding:
      glob: $(inputs.ofile)
  - id: o_prefix
    type:
      - 'null'
      - File
    doc: Output file prefix. Mutually exclusive with -o/--ofile.
    outputBinding:
      glob: $(inputs.o_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
