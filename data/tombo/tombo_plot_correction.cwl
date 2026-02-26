cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - plot_correction
label: tombo_plot_correction
doc: "Plot signal-to-sequence alignment correction (resquiggle) results from FAST5
  files.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: FAST5 subgroup(s) (under Analyses/[corrected-group]) containing 
      basecalls.
    default:
      - BaseCalled_template
    inputBinding:
      position: 101
      prefix: --basecall-subgroups
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group created by resquiggle command.
    default: RawGenomeCorrected_000
    inputBinding:
      position: 101
      prefix: --corrected-group
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: Directories containing fast5 files.
    inputBinding:
      position: 101
      prefix: --fast5-basedirs
  - id: num_obs
    type:
      - 'null'
      - int
    doc: Number of observations to plot.
    default: 500
    inputBinding:
      position: 101
      prefix: --num-obs
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Number of reads to plot.
    default: 10
    inputBinding:
      position: 101
      prefix: --num-reads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: region_type
    type:
      - 'null'
      - string
    doc: 'Region to plot within each read. Options: {random,start,end}'
    default: random
    inputBinding:
      position: 101
      prefix: --region-type
outputs:
  - id: pdf_filename
    type:
      - 'null'
      - File
    doc: PDF filename to store plot(s).
    outputBinding:
      glob: $(inputs.pdf_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
