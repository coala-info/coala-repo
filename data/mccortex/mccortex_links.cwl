cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mccortex31
  - links
label: mccortex_links
doc: "Clean, minimise and list cortex links. Works on a stream of input only, so memory use is very low.\n\nThis wrapper runs the k<=31 binary (mccortex31). The same command exists in mccortex63 (k<=63), mccortex95 (k<=95) and mccortex127 (k<=127) with the same options; use those binaries for larger k-mer sizes.\n\nTool homepage: https://github.com/mcveanlab/mccortex"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Silence status output normally printed to STDERR.
    inputBinding:
      position: 1
      prefix: --quiet
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output files if they already exist.
    inputBinding:
      position: 1
      prefix: --force
  - id: out
    type: string
    default: links_out.ctp.gz
    doc: Output link file (.ctp.gz).
    inputBinding:
      position: 1
      prefix: --out
  - id: limit
    type:
      - 'null'
      - int
    doc: Only use links from the first N k-mers.
    inputBinding:
      position: 1
      prefix: --limit
  - id: list
    type:
      - 'null'
      - string
    doc: List links as CSV to this file.
    inputBinding:
      position: 1
      prefix: --list
  - id: plot
    type:
      - 'null'
      - string
    doc: Plot the last k-mer from --limit to this DOT file.
    inputBinding:
      position: 1
      prefix: --plot
  - id: clean
    type:
      - 'null'
      - int
    doc: Remove junction choices with coverage below N.
    inputBinding:
      position: 1
      prefix: --clean
  - id: threshold
    type:
      - 'null'
      - string
    doc: Calculate the cleaning threshold and write it to this file.
    inputBinding:
      position: 1
      prefix: --threshold
  - id: covg_hist
    type:
      - 'null'
      - string
    doc: Write the link coverage matrix to this CSV file.
    inputBinding:
      position: 1
      prefix: --covg-hist
  - id: max_dist
    type:
      - 'null'
      - int
    doc: Maximum distance when using --covg-hist.
    inputBinding:
      position: 1
      prefix: --max-dist
  - id: max_covg
    type:
      - 'null'
      - int
    doc: Maximum coverage when using --covg-hist.
    inputBinding:
      position: 1
      prefix: --max-covg
  - id: links
    type: File
    doc: Input link file (.ctp.gz).
    inputBinding:
      position: 100
outputs:
  - id: links_out
    type: File
    doc: Output link file.
    outputBinding:
      glob: $(inputs.out)
  - id: list_file
    type:
      - 'null'
      - File
    doc: File written by --list.
    outputBinding:
      glob: $(inputs.list)
  - id: plot_file
    type:
      - 'null'
      - File
    doc: File written by --plot.
    outputBinding:
      glob: $(inputs.plot)
  - id: threshold_file
    type:
      - 'null'
      - File
    doc: File written by --threshold.
    outputBinding:
      glob: $(inputs.threshold)
  - id: covg_hist_file
    type:
      - 'null'
      - File
    doc: File written by --covg-hist.
    outputBinding:
      glob: $(inputs.covg_hist)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mccortex:1.0--h24782f9_7
