cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucflag
label: nucflag
doc: "Use per-base read coverage to classify/plot misassemblies.\n\nTool homepage:
  https://github.com/logsdon-lab/NucFlag"
inputs:
  - id: chrom_sizes
    type:
      - 'null'
      - File
    doc: Chromosome sizes TSV file for bigWig files. Expects at minimum chrom 
      and its length. If not provided, wig files are produced with 
      --output_cov_dir.
    inputBinding:
      position: 101
      prefix: --chrom_sizes
  - id: config
    type:
      - 'null'
      - string
    doc: Additional threshold/params as toml file.
    inputBinding:
      position: 101
      prefix: --config
  - id: ignore_mtypes
    type:
      - 'null'
      - type: array
        items: string
    doc: Ignore misassembly types from plot and output bedfile.
    inputBinding:
      position: 101
      prefix: --ignore_mtypes
  - id: ignore_regions
    type:
      - 'null'
      - File
    doc: 'Bed file with regions to ignore. With format: contig|all,start,end,label,ignore:absolute|relative'
    inputBinding:
      position: 101
      prefix: --ignore_regions
  - id: infile
    type: File
    doc: Input bam file or per-base coverage tsv file with 3-columns (position, 
      first, second). If a bam file is provided, it must be indexed.
    inputBinding:
      position: 101
      prefix: --infile
  - id: input_regions
    type:
      - 'null'
      - File
    doc: Bed file with regions to check.
    inputBinding:
      position: 101
      prefix: --input_regions
  - id: output_cov_dir
    type:
      - 'null'
      - Directory
    doc: Output coverage dir. Generates wig or bigwig files per region.
    inputBinding:
      position: 101
      prefix: --output_cov_dir
  - id: output_plot_dir
    type:
      - 'null'
      - Directory
    doc: Output plot dir.
    inputBinding:
      position: 101
      prefix: --output_plot_dir
  - id: output_status
    type:
      - 'null'
      - File
    doc: 'Bed file with status of contigs. With format: contig,start,end,misassembled|good'
    inputBinding:
      position: 101
      prefix: --output_status
  - id: overlay_regions
    type:
      - 'null'
      - type: array
        items: File
    doc: Overlay additional regions as 4-column bedfile alongside coverage plot.
    inputBinding:
      position: 101
      prefix: --overlay_regions
  - id: processes
    type:
      - 'null'
      - int
    doc: Processes for classifying/plotting.
    default: 4
    inputBinding:
      position: 101
      prefix: --processes
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads for reading bam file.
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: ylim
    type:
      - 'null'
      - float
    doc: Plot y-axis limit. If float, used as a scaling factor from mean. (ex. 
      3.0 is mean times 3)
    default: 100
    inputBinding:
      position: 101
      prefix: --ylim
outputs:
  - id: output_misasm
    type:
      - 'null'
      - File
    doc: Output bed file with misassembled regions.
    outputBinding:
      glob: $(inputs.output_misasm)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucflag:0.3.8--pyhdfd78af_0
