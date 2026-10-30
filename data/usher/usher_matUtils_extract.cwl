cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- matUtils
- extract
label: usher_matUtils_extract
doc: 'matUtils extract: subsets the input mutation-annotated tree (MAT) on various
  conditions and/or converts it to other formats (Newick, VCF, JSON).


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: input_mat
  type: File
  doc: Input mutation-annotated tree file [REQUIRED]
  inputBinding:
    position: 101
    prefix: --input-mat
- id: input_gtf
  type:
  - 'null'
  - File
  doc: Input GTF annotations file (only used with --taxodium)
  inputBinding:
    position: 101
    prefix: --input-gtf
- id: input_fasta
  type:
  - 'null'
  - File
  doc: Input FASTA reference file (only used with --taxodium)
  inputBinding:
    position: 101
    prefix: --input-fasta
- id: samples
  type:
  - 'null'
  - File
  doc: Select samples by explicitly naming them. One per line
  inputBinding:
    position: 101
    prefix: --samples
- id: metadata
  type:
  - 'null'
  - File[]
  doc: Comma-delineated paths to metadata tsv/csvs containing categorical metadata
    values for a json or taxodium output. Used with -j and -l only
  inputBinding:
    position: 101
    prefix: --metadata
    itemSeparator: ','
- id: clade
  type:
  - 'null'
  - string
  doc: Select samples by membership in at least one of the indicated clade(s), comma
    delimited.
  inputBinding:
    position: 101
    prefix: --clade
- id: mutation
  type:
  - 'null'
  - string
  doc: Select samples by whether they contain any of the indicated mutation(s), comma
    delimited.
  inputBinding:
    position: 101
    prefix: --mutation
- id: match
  type:
  - 'null'
  - string
  doc: Select samples by whether their identifier matches the indicated regex pattern.
  inputBinding:
    position: 101
    prefix: --match
- id: max_epps
  type:
  - 'null'
  - int
  doc: 'Select samples by whether they have less than the maximum indicated number
    of equally parsimonious placements. Note: calculation adds significantly to runtime.
    [default: 0]'
  inputBinding:
    position: 101
    prefix: --max-epps
- id: max_parsimony
  type:
  - 'null'
  - int
  doc: 'Select samples by whether they have less than the maximum indicated parsimony
    score (terminal branch length) [default: -1]'
  inputBinding:
    position: 101
    prefix: --max-parsimony
- id: max_branch_length
  type:
  - 'null'
  - int
  doc: 'Select samples which don''t have any branches with than the indicated length
    in their ancestry. [default: -1]'
  inputBinding:
    position: 101
    prefix: --max-branch-length
- id: max_path_length
  type:
  - 'null'
  - int
  doc: 'Select samples which have a total path length (number of mutations different
    from reference) less than or equal to P. [default: -1]'
  inputBinding:
    position: 101
    prefix: --max-path-length
- id: max_mutation_density
  type:
  - 'null'
  - float
  doc: 'Select samples descended from internal nodes whose sum of descendant mutation
    counts divided by number of descendants is at most arg, i.e. filter out branches
    with a higher mutation density. [default: 0]'
  inputBinding:
    position: 101
    prefix: --max-mutation-density
- id: nearest_k
  type:
  - 'null'
  - string
  doc: Select a sample ID and the nearest k samples to it, formatted as sample:k.
    E.g. -k sample_1:50 gets sample 1 and the nearest 50 samples to it as a subtree.
  inputBinding:
    position: 101
    prefix: --nearest-k
- id: nearest_k_batch
  type:
  - 'null'
  - string
  doc: Pass a text file of sample IDs and a number of the number of context samples,
    formatted as sample_file.txt:k.
  inputBinding:
    position: 101
    prefix: --nearest-k-batch
- id: set_size
  type:
  - 'null'
  - int
  doc: 'Automatically add or remove samples at random from the selected sample set
    until it is the indicated size. [default: 0]'
  inputBinding:
    position: 101
    prefix: --set-size
- id: limit_to_lca
  type:
  - 'null'
  - boolean
  doc: Use to limit random samples chosen with -z or -w to below the most recent common
    ancestor of all other samples.
  inputBinding:
    position: 101
    prefix: --limit-to-lca
- id: get_internal_descendents
  type:
  - 'null'
  - string
  doc: Select the set of samples descended from the indicated internal node.
  inputBinding:
    position: 101
    prefix: --get-internal-descendents
- id: from_mrca
  type:
  - 'null'
  - boolean
  doc: Select all samples which are descended from the most recent common ancestor
    of the indicated set of samples. Applied before filling background with random
    samples.
  inputBinding:
    position: 101
    prefix: --from-mrca
- id: get_representative
  type:
  - 'null'
  - int
  doc: 'Automatically select the indicated number of representative samples per clade
    in the tree after other selection steps and prune all other samples (minimum 2).
    [default: 0]'
  inputBinding:
    position: 101
    prefix: --get-representative
- id: prune
  type:
  - 'null'
  - boolean
  doc: Remove the selected samples instead of keeping them in the output files.
  inputBinding:
    position: 101
    prefix: --prune
- id: resolve_polytomies
  type:
  - 'null'
  - boolean
  doc: Resolve all polytomies by assigning branch length 0 relationships arbitrarily.
    Applied after selection; prevents recondensing of the MAT.
  inputBinding:
    position: 101
    prefix: --resolve-polytomies
- id: output_directory
  type:
  - 'null'
  - string
  doc: 'Write output files to the target directory. Default is current directory.
    [default: ./]'
  inputBinding:
    position: 101
    prefix: --output-directory
- id: used_samples
  type:
  - 'null'
  - string
  doc: Write a simple text file of selected sample ids.
  inputBinding:
    position: 101
    prefix: --used-samples
- id: sample_paths
  type:
  - 'null'
  - string
  doc: Write the path of mutations defining each sample in the subtree.
  inputBinding:
    position: 101
    prefix: --sample-paths
- id: clade_paths
  type:
  - 'null'
  - string
  doc: Write the path of mutations defining each clade in the subtree to the target
    file.
  inputBinding:
    position: 101
    prefix: --clade-paths
- id: all_paths
  type:
  - 'null'
  - string
  doc: Write mutations assigned to each node in the subtree in depth-first traversal
    order to the target file.
  inputBinding:
    position: 101
    prefix: --all-paths
- id: write_diff
  type:
  - 'null'
  - string
  doc: Write MAPLE diff file representing selected subtree. Default is full tree
  inputBinding:
    position: 101
    prefix: --write-diff
- id: write_vcf
  type:
  - 'null'
  - string
  doc: Output VCF file representing selected subtree. Default is full tree
  inputBinding:
    position: 101
    prefix: --write-vcf
- id: no_genotypes
  type:
  - 'null'
  - boolean
  doc: Do not include sample genotype columns in VCF output. Used only with the write-vcf
    option
  inputBinding:
    position: 101
    prefix: --no-genotypes
- id: collapse_tree
  type:
  - 'null'
  - boolean
  doc: Collapse the MAT before writing it to output. Used only with the write-mat
    option
  inputBinding:
    position: 101
    prefix: --collapse-tree
- id: write_mat
  type:
  - 'null'
  - string
  doc: Write the selected tree as a new protobuf to the target file.
  inputBinding:
    position: 101
    prefix: --write-mat
- id: write_json
  type:
  - 'null'
  - string
  doc: Write the tree as a JSON to the indicated file.
  inputBinding:
    position: 101
    prefix: --write-json
- id: write_tree
  type:
  - 'null'
  - string
  doc: Use to write a newick tree to the indicated file.
  inputBinding:
    position: 101
    prefix: --write-tree
- id: write_taxodium
  type:
  - 'null'
  - string
  doc: Write protobuf in alternate format consumed by Taxodium.
  inputBinding:
    position: 101
    prefix: --write-taxodium
- id: x_scale
  type:
  - 'null'
  - float
  doc: 'Specifies custom X-axis scaling value for Taxodium output. Not necessary for
    UShER SARS-CoV-2 trees. [default: 0.200000003]'
  inputBinding:
    position: 101
    prefix: --x-scale
- id: title
  type:
  - 'null'
  - string
  doc: 'Title of MAT to display in Taxodium or Auspice (used with --write-taxodium
    or -j). [default: mutation_annotated_tree]'
  inputBinding:
    position: 101
    prefix: --title
- id: description
  type:
  - 'null'
  - string
  doc: Description of MAT to display in Taxodium (used with --write-taxodium).
  inputBinding:
    position: 101
    prefix: --description
- id: include_nt
  type:
  - 'null'
  - boolean
  doc: Include nucleotide mutations in addition to protein mutations (used with --write-taxodium)
  inputBinding:
    position: 101
    prefix: --include-nt
- id: extra_fields
  type:
  - 'null'
  - string
  doc: 'Comma-separated list of additional metadata column names beyond the defaults
    of: strain, genbank_accession, country, date, pangolin_lineage (used with --write-taxodium).'
  inputBinding:
    position: 101
    prefix: --extra-fields
- id: retain_branch_length
  type:
  - 'null'
  - boolean
  doc: Use to not recalculate branch lengths when saving newick output. Used only
    with -t
  inputBinding:
    position: 101
    prefix: --retain-branch-length
- id: minimum_subtrees_size
  type:
  - 'null'
  - int
  doc: 'Use to generate a series of JSON or Newick format files representing subtrees
    of the indicated size which cover all queried samples. Uses and overrides -j and
    -t output arguments. [default: 0]'
  inputBinding:
    position: 101
    prefix: --minimum-subtrees-size
- id: reroot
  type:
  - 'null'
  - string
  doc: Indicate an internal node ID to reroot the output tree to. Applied before all
    other manipulation steps.
  inputBinding:
    position: 101
    prefix: --reroot
- id: usher_single_subtree_size
  type:
  - 'null'
  - int
  doc: 'Use to produce an usher-style single sample subtree of the indicated size
    with all selected samples plus random samples to fill. Produces .nh and .txt files.
    [default: 0]'
  inputBinding:
    position: 101
    prefix: --usher-single-subtree-size
- id: usher_minimum_subtrees_size
  type:
  - 'null'
  - int
  doc: 'Use to produce an usher-style minimum set of subtrees of the indicated size
    which include all of the selected samples. Produces .nh and .txt files. [default:
    0]'
  inputBinding:
    position: 101
    prefix: --usher-minimum-subtrees-size
- id: usher_clades_txt
  type:
  - 'null'
  - boolean
  doc: When producing usher-style subtree(s), also write an usher-style clades.txt
    file with clade annotations for selected samples, if the tree has clade annotations.
  inputBinding:
    position: 101
    prefix: --usher-clades-txt
- id: usher_anchor_samples
  type:
  - 'null'
  - File
  doc: Add samples from file to usher-style subtree(s) (e.g. to provide larger-scale
    context by including well-known vaccine strains)
  inputBinding:
    position: 101
    prefix: --usher-anchor-samples
- id: add_random
  type:
  - 'null'
  - int
  doc: 'Add exactly W samples at random to your selection. Affected by -Z and overridden
    by -z. [default: 0]'
  inputBinding:
    position: 101
    prefix: --add-random
- id: select_nearest
  type:
  - 'null'
  - int
  doc: 'Set to add to the sample selection the y nearest samples to each of your samples,
    without duplicates. [default: 0]'
  inputBinding:
    position: 101
    prefix: --select-nearest
- id: closest_relatives
  type:
  - 'null'
  - string
  doc: Write a tsv file of the closest relative(s) (in mutations) of each selected
    sample to the indicated file. All equidistant closest samples are included unless
    --break-ties is set.
  inputBinding:
    position: 101
    prefix: --closest-relatives
- id: break_ties
  type:
  - 'null'
  - boolean
  doc: Only output one closest relative per sample (used only with --closest-relatives).
    If multiple closest relatives are equidistant, the lexicographically smallest
    sample ID is chosen.
  inputBinding:
    position: 101
    prefix: --break-ties
- id: within_distance
  type:
  - 'null'
  - string
  doc: Write a tsv file of the relatives within --distance-thresold mutations of each
    selected sample to the indicated file.
  inputBinding:
    position: 101
    prefix: --within-distance
- id: distance_threshold
  type:
  - 'null'
  - int
  doc: 'Specifies the distance threshold used in --within-distance. [default: 0]'
  inputBinding:
    position: 101
    prefix: --distance-threshold
- id: dump_metadata
  type:
  - 'null'
  - string
  doc: Set to write all final stored metadata to a tsv.
  inputBinding:
    position: 101
    prefix: --dump-metadata
- id: whitelist
  type:
  - 'null'
  - File
  doc: Pass a list of samples, one per line, to always retain regardless of any other
    parameters.
  inputBinding:
    position: 101
    prefix: --whitelist
- id: load_all_metadata
  type:
  - 'null'
  - boolean
  doc: Use to load all input metadata from -M regardless of sample selection. Significantly
    increases memory usage.
  inputBinding:
    position: 101
    prefix: --load-all-metadata
- id: threads
  type:
  - 'null'
  - int
  doc: 'Number of threads to use when possible [DEFAULT uses all available cores,
    20 detected on this machine] [default: 20]'
  inputBinding:
    position: 101
    prefix: --threads
outputs:
- id: output_directory_dir
  type:
  - 'null'
  - Directory
  doc: Directory named by --output-directory
  outputBinding:
    glob: '${ return inputs.output_directory ? inputs.output_directory : []; }'
- id: used_samples_file
  type:
  - 'null'
  - File
  doc: Output file named by --used-samples. Write a simple text file of selected sample
    ids.
  outputBinding:
    glob: '${ return inputs.used_samples ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.used_samples : inputs.used_samples) : []; }'
- id: sample_paths_file
  type:
  - 'null'
  - File
  doc: Output file named by --sample-paths. Write the path of mutations defining each
    sample in the subtree.
  outputBinding:
    glob: '${ return inputs.sample_paths ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.sample_paths : inputs.sample_paths) : []; }'
- id: clade_paths_file
  type:
  - 'null'
  - File
  doc: Output file named by --clade-paths. Write the path of mutations defining each
    clade in the subtree to the target file.
  outputBinding:
    glob: '${ return inputs.clade_paths ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.clade_paths : inputs.clade_paths) : []; }'
- id: all_paths_file
  type:
  - 'null'
  - File
  doc: Output file named by --all-paths. Write mutations assigned to each node in
    the subtree in depth-first traversal order to the target file.
  outputBinding:
    glob: '${ return inputs.all_paths ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.all_paths : inputs.all_paths) : []; }'
- id: write_diff_file
  type:
  - 'null'
  - File
  doc: Output file named by --write-diff. Write MAPLE diff file representing selected
    subtree. Default is full tree
  outputBinding:
    glob: '${ return inputs.write_diff ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.write_diff : inputs.write_diff) : []; }'
- id: write_vcf_file
  type:
  - 'null'
  - File
  doc: Output file named by --write-vcf. Output VCF file representing selected subtree.
    Default is full tree
  outputBinding:
    glob: '${ return inputs.write_vcf ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.write_vcf : inputs.write_vcf) : []; }'
- id: write_mat_file
  type:
  - 'null'
  - File
  doc: Output file named by --write-mat. Write the selected tree as a new protobuf
    to the target file.
  outputBinding:
    glob: '${ return inputs.write_mat ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.write_mat : inputs.write_mat) : []; }'
- id: write_json_file
  type:
  - 'null'
  - File
  doc: Output file named by --write-json. Write the tree as a JSON to the indicated
    file.
  outputBinding:
    glob: '${ return inputs.write_json ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.write_json : inputs.write_json) : []; }'
- id: write_tree_file
  type:
  - 'null'
  - File
  doc: Output file named by --write-tree. Use to write a newick tree to the indicated
    file.
  outputBinding:
    glob: '${ return inputs.write_tree ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.write_tree : inputs.write_tree) : []; }'
- id: write_taxodium_file
  type:
  - 'null'
  - File
  doc: Output file named by --write-taxodium. Write protobuf in alternate format consumed
    by Taxodium.
  outputBinding:
    glob: '${ return inputs.write_taxodium ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.write_taxodium : inputs.write_taxodium) : []; }'
- id: closest_relatives_file
  type:
  - 'null'
  - File
  doc: Output file named by --closest-relatives. Write a tsv file of the closest relative(s)
    (in mutations) of each selected sample to the indicated file. All equidistant
    closest samples are included unless --break-ties is set.
  outputBinding:
    glob: '${ return inputs.closest_relatives ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.closest_relatives : inputs.closest_relatives) : []; }'
- id: within_distance_file
  type:
  - 'null'
  - File
  doc: Output file named by --within-distance. Write a tsv file of the relatives within
    --distance-thresold mutations of each selected sample to the indicated file.
  outputBinding:
    glob: '${ return inputs.within_distance ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.within_distance : inputs.within_distance) : []; }'
- id: dump_metadata_file
  type:
  - 'null'
  - File
  doc: Output file named by --dump-metadata. Set to write all final stored metadata
    to a tsv.
  outputBinding:
    glob: '${ return inputs.dump_metadata ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.dump_metadata : inputs.dump_metadata) : []; }'
- id: stdout_log
  type: stdout
  doc: Standard output (progress messages).
stdout: matUtils_extract_stdout.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
