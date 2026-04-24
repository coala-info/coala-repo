cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - plot_max_difference
label: tombo_plot_max_difference
doc: "Plot regions with the maximum difference in signal between two sets of FAST5
  files.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: FAST5 subgroup(s) (under Analyses/[corrected-group]) containing 
      basecalls.
    inputBinding:
      position: 101
      prefix: --basecall-subgroups
  - id: control_fast5_basedirs
    type:
      type: array
      items: Directory
    doc: Control set of directories containing fast5 files. These reads should 
      contain only standard nucleotides.
    inputBinding:
      position: 101
      prefix: --control-fast5-basedirs
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group created by resquiggle command.
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
  - id: num_bases
    type:
      - 'null'
      - int
    doc: Number of bases to plot/output.
    inputBinding:
      position: 101
      prefix: --num-bases
  - id: num_regions
    type:
      - 'null'
      - int
    doc: Number of regions to plot.
    inputBinding:
      position: 101
      prefix: --num-regions
  - id: overplot_threshold
    type:
      - 'null'
      - int
    doc: Coverage level to trigger alternative plot type instead of raw signal.
    inputBinding:
      position: 101
      prefix: --overplot-threshold
  - id: overplot_type
    type:
      - 'null'
      - string
    doc: 'Plot type for regions with higher coverage. Options: Downsample, Boxplot,
      Quantile, Density'
    inputBinding:
      position: 101
      prefix: --overplot-type
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: pdf_filename
    type:
      - 'null'
      - File
    doc: PDF filename to store plot(s).
    outputBinding:
      glob: $(inputs.pdf_filename)
  - id: sequences_filename
    type:
      - 'null'
      - File
    doc: File for sequences from selected regions. Sequences will be stored in 
      FASTA format.
    outputBinding:
      glob: $(inputs.sequences_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
