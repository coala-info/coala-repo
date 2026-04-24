cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoraw plot_multi_correction
label: nanoraw_plot_multi_correction
doc: "Plot signal at specified genomic locations.\n\nTool homepage: https://github.com/marcus1487/nanoraw"
inputs:
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: Directories containing fast5 files.
    inputBinding:
      position: 1
  - id: basecall_subgroups
    type:
      - 'null'
      - type: array
        items: string
    doc: FAST5 subgroup (under Analyses/[corrected-group]) where individual 
      template and/or complement reads are stored.
      - BaseCalled_template
    inputBinding:
      position: 102
      prefix: --basecall-subgroups
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group to access/plot created by genome_resquiggle script.
    inputBinding:
      position: 102
      prefix: --corrected-group
  - id: genome_locations
    type:
      - 'null'
      - type: array
        items: string
    doc: Plot signal at specified genomic locations. Format locations as 
      "chrm:position[:strand] [chrm2:position2[:strand2] ...]" (strand not 
      applicable for all applications)
    inputBinding:
      position: 102
      prefix: --genome-locations
  - id: include_original_basecalls
    type:
      - 'null'
      - boolean
    doc: Iclude original basecalls in plots.
    inputBinding:
      position: 102
      prefix: --include-original-basecalls
  - id: num_obs
    type:
      - 'null'
      - int
    doc: Number of observations to plot in each region.
    inputBinding:
      position: 102
      prefix: --num-obs
  - id: num_reads_per_plot
    type:
      - 'null'
      - int
    doc: Number of reads to plot per genomic region.
    inputBinding:
      position: 102
      prefix: --num-reads-per-plot
  - id: num_regions
    type:
      - 'null'
      - int
    doc: Number of regions to plot.
    inputBinding:
      position: 102
      prefix: --num-regions
  - id: pdf_filename
    type:
      - 'null'
      - File
    doc: PDF filename to store plot(s).
    inputBinding:
      position: 102
      prefix: --pdf-filename
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print status information.
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
stdout: nanoraw_plot_multi_correction.out
