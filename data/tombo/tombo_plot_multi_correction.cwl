cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - plot_multi_correction
label: tombo_plot_multi_correction
doc: "Plot multiple corrected signal alignments from FAST5 files.\n\nTool homepage:
  https://github.com/nanoporetech/tombo"
inputs:
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: FAST5 subgroup(s) (under Analyses/[corrected-group]) containing 
      basecalls.
      - BaseCalled_template
    inputBinding:
      position: 101
      prefix: --basecall-subgroups
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
  - id: genome_locations
    type:
      - 'null'
      - type: array
        items: string
    doc: Genomic locations at which to plot signal. Format locations as 
      "chrm:position[:strand] [chrm2:position2[:strand2] ...]"
    inputBinding:
      position: 101
      prefix: --genome-locations
  - id: include_original_basecalls
    type:
      - 'null'
      - boolean
    doc: Include original basecalls in plots.
    inputBinding:
      position: 101
      prefix: --include-original-basecalls
  - id: num_obs
    type:
      - 'null'
      - int
    doc: Number of observations to plot.
    inputBinding:
      position: 101
      prefix: --num-obs
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Number of reads to plot.
    inputBinding:
      position: 101
      prefix: --num-reads
  - id: num_regions
    type:
      - 'null'
      - int
    doc: Number of regions to plot.
    inputBinding:
      position: 101
      prefix: --num-regions
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
