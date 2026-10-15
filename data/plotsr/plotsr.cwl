cwlVersion: v1.2
class: CommandLineTool
baseCommand: plotsr
label: plotsr
doc: "plotsr is a tool to visualize structural variations and synteny between multiple
  genomes. It uses the structural rearrangements identified by SyRI and plots them
  in a publication-quality figure. The genomes file and the tracks file name other
  files: give those files in genome_files and track_files so that the names resolve.\n\nTool
  homepage: https://github.com/schneebergerlab/plotsr"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = inputs.genome_files.slice();
        if (inputs.track_files) { l = l.concat(inputs.track_files); }
        return l;
      }
inputs:
  - id: genomes
    type: File
    doc: File containing path to genomes (one line per genome, in the order of the
      comparisons)
    inputBinding:
      position: 101
      prefix: --genomes
  - id: genome_files
    type:
      type: array
      items: File
    doc: Genome files (fasta or chromosome length files) named in the genomes file;
      staged in the working directory
  - id: sr
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --sr
    doc: Structural annotation mappings (syri.out) identified by SyRI, one per
      genome comparison, in the genome order
    inputBinding:
      position: 101
  - id: bp
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --bp
    doc: Structural annotation mappings in BEDPE format
    inputBinding:
      position: 101
  - id: markers
    type:
      - 'null'
      - File
    doc: File containing path to markers (bed format)
    inputBinding:
      position: 101
      prefix: --markers
  - id: tracks
    type:
      - 'null'
      - File
    doc: File listing paths and details for all tracks to be plotted
    inputBinding:
      position: 101
      prefix: --tracks
  - id: track_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Track files (bed, bedgraph or gff) named in the tracks file; staged in the
      working directory
  - id: chrord
    type:
      - 'null'
      - File
    doc: File containing reference (first genome) chromosome IDs in the order in
      which they are to be plotted, one per line. Not compatible with --chr
    inputBinding:
      position: 101
      prefix: --chrord
  - id: chrname
    type:
      - 'null'
      - File
    doc: TSV file with reference chromosome IDs in column one and the names to
      show in the plot in column two
    inputBinding:
      position: 101
      prefix: --chrname
  - id: output
    type: string
    default: plotsr.pdf
    doc: Output file name. Acceptable format pdf, png, svg
    inputBinding:
      position: 101
      prefix: -o
  - id: itx
    type:
      - 'null'
      - boolean
    doc: Use inter-chromosomal plotting mode (experimental)
    inputBinding:
      position: 101
      prefix: --itx
  - id: chr
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --chr
    doc: Select specific chromosomes on the reference (first genome) and plot them
      in the given order. Not compatible with --chrord
    inputBinding:
      position: 101
  - id: reg
    type:
      - 'null'
      - string
    doc: 'Plot a specific region, as GenomeID:ChromosomeID:Start-End. Not compatible
      with --chr and -R'
    inputBinding:
      position: 101
      prefix: --reg
  - id: rtr
    type:
      - 'null'
      - boolean
    doc: When using --reg, plot all SRs that are within the boundaries of the homologous
      regions
    inputBinding:
      position: 101
      prefix: --rtr
  - id: nosyn
    type:
      - 'null'
      - boolean
    doc: Do not plot syntenic regions
    inputBinding:
      position: 101
      prefix: --nosyn
  - id: noinv
    type:
      - 'null'
      - boolean
    doc: Do not plot inversions
    inputBinding:
      position: 101
      prefix: --noinv
  - id: notr
    type:
      - 'null'
      - boolean
    doc: Do not plot translocations regions
    inputBinding:
      position: 101
      prefix: --notr
  - id: nodup
    type:
      - 'null'
      - boolean
    doc: Do not plot duplications regions
    inputBinding:
      position: 101
      prefix: --nodup
  - id: min_size
    type:
      - 'null'
      - int
    doc: 'Minimum size of a SR to be plotted (default: 10000)'
    inputBinding:
      position: 101
      prefix: -s
  - id: cfg
    type:
      - 'null'
      - File
    doc: Path to config file containing parameters to adjust the plot
    inputBinding:
      position: 101
      prefix: --cfg
  - id: join_syntenic
    type:
      - 'null'
      - boolean
    doc: Join adjacent syntenic blocks if they are not interrupted by SRs
    inputBinding:
      position: 101
      prefix: -R
  - id: font_size
    type:
      - 'null'
      - float
    doc: 'Font size (default: 6)'
    inputBinding:
      position: 101
      prefix: -f
  - id: height
    type:
      - 'null'
      - float
    doc: Height of the plot
    inputBinding:
      position: 101
      prefix: -H
  - id: width
    type:
      - 'null'
      - float
    doc: Width of the plot
    inputBinding:
      position: 101
      prefix: -W
  - id: homolog_space
    type:
      - 'null'
      - float
    doc: 'Space for homologous chromosome (0.1-0.75) (default: 0.7)'
    inputBinding:
      position: 101
      prefix: -S
  - id: dpi
    type:
      - 'null'
      - int
    doc: 'DPI for the final image (default: 300)'
    inputBinding:
      position: 101
      prefix: -d
  - id: backend
    type:
      - 'null'
      - type: enum
        name: plotsr_backend
        symbols: [agg, cairo, pdf, pgf, ps, svg, template]
    doc: 'Matplotlib backend to use (default: agg)'
    inputBinding:
      position: 101
      prefix: -b
  - id: vertical
    type:
      - 'null'
      - boolean
    doc: Plot vertical chromosome
    inputBinding:
      position: 101
      prefix: -v
  - id: log_file
    type: string
    default: plotsr.log
    doc: Name of log file
    inputBinding:
      position: 101
      prefix: --lf
  - id: log_level
    type:
      - 'null'
      - type: enum
        name: plotsr_log_level
        symbols: [DEBUG, INFO, WARN]
    doc: 'Log-level (default: WARN)'
    inputBinding:
      position: 101
      prefix: --log
outputs:
  - id: figure
    type: File
    doc: Output figure
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plotsr:1.1.1--pyh7cba7a3_0
