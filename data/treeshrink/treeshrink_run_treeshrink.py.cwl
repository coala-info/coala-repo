cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_treeshrink.py
label: treeshrink_run_treeshrink.py
doc: "TreeShrink is a tool for inferring gene trees that are consistent with a species
  tree.\n\nTool homepage: https://github.com/uym2/TreeShrink"
inputs:
  - id: alignment
    type:
      - 'null'
      - string
    doc: The name of the input alignment; can only be used when the input 
      directory is specified (see -i option). Each subdirectory under it must 
      contain an alignment with this name.
    default: input.fasta
    inputBinding:
      position: 101
      prefix: --alignment
  - id: centroid_reroot
    type:
      - 'null'
      - boolean
    doc: Do centroid reroot in preprocessing. Highly recommended for large 
      trees.
    default: false
    inputBinding:
      position: 101
      prefix: --centroid
  - id: exceptions
    type:
      - 'null'
      - string
    doc: A list of special species that will not be removed in any of the input 
      trees.
    inputBinding:
      position: 101
      prefix: --exceptions
  - id: force_override
    type:
      - 'null'
      - boolean
    doc: Force overriding of existing output files.
    inputBinding:
      position: 101
      prefix: --force
  - id: gene_to_species_mapping
    type:
      - 'null'
      - File
    doc: The gene-name-to-species-name mapping file
    inputBinding:
      position: 101
      prefix: --g2sp
  - id: input_directory
    type:
      - 'null'
      - Directory
    doc: The parent input directory where the trees (and alignments) can be 
      found
    inputBinding:
      position: 101
      prefix: --indir
  - id: k_scaling_constants
    type:
      - 'null'
      - string
    doc: If -k not given, we use k=min(n/a,b*sqrt(n)) by default; using this 
      option, you can set the a,b constants;
    default: 5,2
    inputBinding:
      position: 101
      prefix: --kscaling
  - id: max_leaves_removed
    type:
      - 'null'
      - int
    doc: 'The maximum number of leaves that can be removed. Default: auto-select based
      on the data; see also -s'
    inputBinding:
      position: 101
      prefix: --k
  - id: min_impact_percentage
    type:
      - 'null'
      - float
    doc: Do not remove species on the per-species test if their impact on 
      diameter is less than x% where x is the given value.
    default: 5
    inputBinding:
      position: 101
      prefix: --minImpact
  - id: mode
    type:
      - 'null'
      - string
    doc: "Filtering mode: 'per-species', 'per-gene', 'all-genes','auto'."
    default: auto
    inputBinding:
      position: 101
      prefix: --mode
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: "Output directory. Default: If the input directory is specified, outputs
      will be placed in that input directory. Otherwise, a directory with the suffix
      'treeshrink' will be created in the same place as the input trees"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output name prefix. If the output directory contains some files with 
      the specified prefix, automatically adjusts the prefix (e.g. output --> 
      output1) to avoid overriding. Use --force to force overriding.
    default: output
    inputBinding:
      position: 101
      prefix: --outprefix
  - id: quantiles
    type:
      - 'null'
      - float
    doc: The quantile(s) to set threshold.
    default: 0.05
    inputBinding:
      position: 101
      prefix: --quantiles
  - id: temp_directory
    type:
      - 'null'
      - Directory
    doc: Directory to keep temporary files. If specified, the temp files will be
      kept
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: tree
    type:
      - 'null'
      - string
    doc: The name of the input tree/trees. If the input directory is specified 
      (see -i option), each subdirectory under it must contain a tree with this 
      name. Otherwise, all the trees can be included in this one file.
    default: input.tree
    inputBinding:
      position: 101
      prefix: --tree
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treeshrink:1.3.9--pyhdfd78af_1
stdout: treeshrink_run_treeshrink.py.out
