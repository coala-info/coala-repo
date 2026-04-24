cwlVersion: v1.2
class: CommandLineTool
baseCommand: medicc2
label: medicc2
doc: "medicc2 is a tool for inferring copy number alterations and phylogenetic trees
  from tumor sequencing data.\n\nTool homepage: https://bitbucket.org/schwarzlab/medicc2"
inputs:
  - id: input_file
    type: File
    doc: a path to the input file
    inputBinding:
      position: 1
  - id: output_dir
    type: Directory
    doc: a path to the output folder
    inputBinding:
      position: 2
  - id: bootstrap_method
    type:
      - 'null'
      - string
    doc: Bootstrap method. Has to be either 'chr-wise' or 'segment-wise'
    inputBinding:
      position: 103
      prefix: --bootstrap-method
  - id: bootstrap_nr
    type:
      - 'null'
      - int
    doc: Number of bootstrap runs to perform
    inputBinding:
      position: 103
      prefix: --bootstrap-nr
  - id: chromosomes_bed
    type:
      - 'null'
      - File
    doc: BED file for chromosome regions
    inputBinding:
      position: 103
      prefix: --chromosomes-bed
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Enable more verbose output (default: False).'
    inputBinding:
      position: 103
      prefix: --debug
  - id: events
    type:
      - 'null'
      - boolean
    doc: 'Whether to infer copy-number events (default: False).'
    inputBinding:
      position: 103
      prefix: --events
  - id: exclude_samples
    type:
      - 'null'
      - string
    doc: Comma separated list of sample IDs to exclude.
    inputBinding:
      position: 103
      prefix: --exclude-samples
  - id: filter_segment_length
    type:
      - 'null'
      - int
    doc: Removes segments that are smaller than specified length.
    inputBinding:
      position: 103
      prefix: --filter-segment-length
  - id: fst
    type:
      - 'null'
      - File
    doc: 'Expert option: path to an alternative FST.'
    inputBinding:
      position: 103
      prefix: --fst
  - id: fst_chr_separator
    type:
      - 'null'
      - string
    doc: 'Expert option: character used to separate chromosomes in the FST (default:
      "X").'
    inputBinding:
      position: 103
      prefix: --fst-chr-separator
  - id: input_allele_columns
    type:
      - 'null'
      - string
    doc: "Name of the CN columns (comma separated) if using TSV input format (default:
      'cn_a, cn_b'). This also adjusts the number of alleles considered (min. 1, max.
      2)."
    inputBinding:
      position: 103
      prefix: --input-allele-columns
  - id: input_chr_separator
    type:
      - 'null'
      - string
    doc: 'Character used to separate chromosomes in the input data (condensed FASTA
      only, default: "X").'
    inputBinding:
      position: 103
      prefix: --input-chr-separator
  - id: input_type
    type:
      - 'null'
      - string
    doc: 'Choose the type of input: f for FASTA, t for TSV'
    inputBinding:
      position: 103
      prefix: --input-type
  - id: maxcn
    type:
      - 'null'
      - int
    doc: 'Expert option: maximum CN at which the input is capped. Does not change
      FST. The maximum possible value is 8. Default: 8'
    inputBinding:
      position: 103
      prefix: --maxcn
  - id: n_cores
    type:
      - 'null'
      - int
    doc: Number of cores to run on
    inputBinding:
      position: 103
      prefix: --n-cores
  - id: no_plot_tree
    type:
      - 'null'
      - boolean
    doc: 'Disable plotting of tree (default: False).'
    inputBinding:
      position: 103
      prefix: --no-plot-tree
  - id: no_wgd
    type:
      - 'null'
      - boolean
    doc: 'Enable whole-genome doubling events (default: False).'
    inputBinding:
      position: 103
      prefix: --no-wgd
  - id: normal_name
    type:
      - 'null'
      - string
    doc: 'ID of the sample to be treated as the normal sample. Trees are rooted at
      this sample for ancestral reconstruction (default: "diploid"). If the sample
      ID is not found, an artificial normal sample of the same name is created with
      CN states = 1 for each allele.'
    inputBinding:
      position: 103
      prefix: --normal-name
  - id: plot
    type:
      - 'null'
      - string
    doc: "'bars' is recommended for <50 samples, heatmap for more samples, 'auto'
      will decide based on the number of samples, 'both' will plot both and 'none'
      will plot neither. (default: auto)."
    inputBinding:
      position: 103
      prefix: --plot
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Output prefix to be used (default: input filename).'
    inputBinding:
      position: 103
      prefix: --prefix
  - id: prune_weight
    type:
      - 'null'
      - float
    doc: 'Expert option: Prune weight in ancestor reconstruction. Values >0 might
      result in more accurate ancestors but will require more time and memory. Default:
      0'
    inputBinding:
      position: 103
      prefix: --prune-weight
  - id: regions_bed
    type:
      - 'null'
      - File
    doc: BED file for regions of interests
    inputBinding:
      position: 103
      prefix: --regions-bed
  - id: silent
    type:
      - 'null'
      - boolean
    doc: 'Hide all output (default: False).'
    inputBinding:
      position: 103
      prefix: --silent
  - id: topology_only
    type:
      - 'null'
      - boolean
    doc: 'Output only tree topology, without reconstructing ancestors (default: False).'
    inputBinding:
      position: 103
      prefix: --topology-only
  - id: total_copy_numbers
    type:
      - 'null'
      - boolean
    doc: 'Run for total copy number data instead of allele-specific data (default:
      False).'
    inputBinding:
      position: 103
      prefix: --total-copy-numbers
  - id: user_tree
    type:
      - 'null'
      - File
    doc: 'Do not reconstruct tree, use provided tree instead (in newick format) and
      only perform ancestral reconstruction (default: None).'
    inputBinding:
      position: 103
      prefix: --tree
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Enable verbose output (default: False).'
    inputBinding:
      position: 103
      prefix: --verbose
  - id: wgd_x2
    type:
      - 'null'
      - boolean
    doc: 'Expert option: Treat WGD as a x2 operation (default: False).'
    inputBinding:
      position: 103
      prefix: --wgd-x2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/medicc2:1.1.2--py310h8ea774a_1
stdout: medicc2.out
