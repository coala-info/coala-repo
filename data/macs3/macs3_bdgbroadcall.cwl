cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - bdgbroadcall
label: macs3_bdgbroadcall
doc: "MACS3 tool to call broad peaks from bedGraph score tracks\n\nTool homepage:
  https://pypi.org/project/MACS3/"
inputs:
  - id: cutoff_link
    type:
      - 'null'
      - float
    doc: 'Cutoff for linking regions/low abundance regions depending on which method
      you used for score track. If the file contains qvalue scores from MACS3, score
      1 means qvalue 0.1, and score 0.3 means qvalue 0.5. DEFAULT: 1'
    default: 1.0
    inputBinding:
      position: 101
      prefix: --cutoff-link
  - id: cutoff_peak
    type:
      - 'null'
      - float
    doc: 'Cutoff for peaks depending on which method you used for score track. If
      the file contains qvalue scores from MACS3, score 2 means qvalue 0.01. Regions
      with signals lower than cutoff will not be considerred as enriched regions.
      DEFAULT: 2'
    default: 2.0
    inputBinding:
      position: 101
      prefix: --cutoff-peak
  - id: ifile
    type: File
    doc: MACS score in bedGraph. REQUIRED
    inputBinding:
      position: 101
      prefix: --ifile
  - id: lvl1_max_gap
    type:
      - 'null'
      - int
    doc: 'maximum gap between significant peaks, better to set it as tag size. DEFAULT:
      30'
    default: 30
    inputBinding:
      position: 101
      prefix: --lvl1-max-gap
  - id: lvl2_max_gap
    type:
      - 'null'
      - int
    doc: 'maximum linking between significant peaks, better to set it as 4 times of
      d value. DEFAULT: 800'
    default: 800
    inputBinding:
      position: 101
      prefix: --lvl2-max-gap
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
  - id: o_prefix
    type:
      - 'null'
      - string
    doc: Output file prefix. Mutually exclusive with -o/--ofile.
    inputBinding:
      position: 101
      prefix: --o-prefix
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    inputBinding:
      position: 101
      prefix: --outdir
outputs:
  - id: ofile
    type:
      - 'null'
      - File
    doc: Output file name. Mutually exclusive with --o-prefix.
    outputBinding:
      glob: $(inputs.ofile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.4--py310h5a5e57a_0
