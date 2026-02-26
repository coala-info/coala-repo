cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanoraw plot_correction
label: nanoraw_plot_correction
doc: "Plotting tool for Nanopore genome correction.\n\nTool homepage: https://github.com/marcus1487/nanoraw"
inputs:
  - id: fast5_basedirs
    type:
      type: array
      items: Directory
    doc: Directories containing fast5 files.
    inputBinding:
      position: 1
  - id: basecall_subgroup
    type:
      - 'null'
      - string
    doc: FAST5 subgroup (under Analyses/[corrected-group]) where individual 
      template or complement read is stored.
    default: BaseCalled_template
    inputBinding:
      position: 102
      prefix: --basecall-subgroup
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: FAST5 group to access/plot created by genome_resquiggle script.
    default: RawGenomeCorrected_000
    inputBinding:
      position: 102
      prefix: --corrected-group
  - id: num_obs
    type:
      - 'null'
      - int
    doc: Number of observations to plot in each region.
    default: 500
    inputBinding:
      position: 102
      prefix: --num-obs
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Number of reads to plot (one region per read).
    default: 10
    inputBinding:
      position: 102
      prefix: --num-reads
  - id: pdf_filename
    type:
      - 'null'
      - File
    doc: PDF filename to store plot(s).
    default: Nanopore_genome_correction.pdf
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
  - id: region_type
    type:
      - 'null'
      - string
    doc: 'Region to plot within each read. Choices are: random (default), start, end.'
    default: random
    inputBinding:
      position: 102
      prefix: --region-type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoraw:0.5--py27r3.3.2_0
stdout: nanoraw_plot_correction.out
