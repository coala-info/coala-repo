cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - bdgpeakcall
label: macs3_bdgpeakcall
doc: Call peaks from bedGraph output of MACS3
inputs:
  - id: cutoff
    type:
      - 'null'
      - float
    doc: 'Cutoff depends on which method you used for score track. If the file contains
      pvalue scores from MACS3, score 5 means pvalue 1e-5. Regions with signals lower
      than cutoff will not be considerred as enriched regions. DEFAULT: 5'
    default: 5.0
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: cutoff_analysis
    type:
      - 'null'
      - boolean
    doc: While set, bdgpeakcall will analyze number or total length of peaks 
      that can be called by different cutoff then output a summary table to help
      user decide a better cutoff.
    default: false
    inputBinding:
      position: 101
      prefix: --cutoff-analysis
  - id: cutoff_analysis_max
    type:
      - 'null'
      - float
    doc: 'The maximum cutoff score for performing cutoff analysis. Together with --cutoff-analysis-steps,
      the resolution in the final report can be controlled. DEFAULT: 100'
    default: 100.0
    inputBinding:
      position: 101
      prefix: --cutoff-analysis-max
  - id: cutoff_analysis_steps
    type:
      - 'null'
      - int
    doc: 'Steps for performing cutoff analysis. It will be used to decide which cutoff
      value should be included in the final report. Larger the value, higher resolution
      the cutoff analysis can be. DEFAULT: 100'
    default: 100
    inputBinding:
      position: 101
      prefix: --cutoff-analysis-steps
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
      is used by UCSC for the options for display.
    inputBinding:
      position: 101
      prefix: --no-trackline
  - id: o_prefix
    type:
      - 'null'
      - string
    doc: Output file prefix. Mutually exclusive with -o/--ofile.
    inputBinding:
      position: 101
      prefix: --o-prefix
  - id: ofile
    type: string
    doc: Output file name. Mutually exclusive with --o-prefix.
    inputBinding:
      position: 101
      prefix: --ofile
  - id: outdir
    type: string
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    inputBinding:
      position: 101
      prefix: --outdir
outputs:
  - id: output_outdir
    type:
      - 'null'
      - Directory
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    outputBinding:
      glob: $(inputs.outdir)
  - id: output_ofile
    type:
      - 'null'
      - File
    doc: Output file name. Mutually exclusive with --o-prefix.
    outputBinding:
      glob: $(inputs.ofile)
  - id: output_o_prefix
    type:
      - 'null'
      - File
    doc: Output file prefix. Mutually exclusive with -o/--ofile.
    outputBinding:
      glob: $(inputs.o_prefix)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.4--py310h5a5e57a_0
s:url: https://pypi.org/project/MACS3/
$namespaces:
  s: https://schema.org/
