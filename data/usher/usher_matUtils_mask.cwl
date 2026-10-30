cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- matUtils
- mask
label: usher_matUtils_mask
doc: 'matUtils mask: masks the input samples of a mutation-annotated tree (MAT).


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: input_mat
  type: File
  doc: Input mutation-annotated tree file [REQUIRED]
  inputBinding:
    position: 101
    prefix: --input-mat
- id: output_mat
  type: string
  doc: Path to output masked mutation-annotated tree file [REQUIRED]
  inputBinding:
    position: 101
    prefix: --output-mat
- id: simplify
  type:
  - 'null'
  - boolean
  doc: Use to automatically remove identifying information from the tree, including
    all sample names and private mutations.
  inputBinding:
    position: 101
    prefix: --simplify
- id: restricted_samples
  type:
  - 'null'
  - File
  doc: Sample names to restrict. Use to perform masking
  inputBinding:
    position: 101
    prefix: --restricted-samples
- id: rename_samples
  type:
  - 'null'
  - File
  doc: Name of the TSV file containing names of the samples to be renamed and their
    new names
  inputBinding:
    position: 101
    prefix: --rename-samples
- id: mask_mutations
  type:
  - 'null'
  - File
  doc: Name of a TSV or CSV containing mutations to be masked in the first column
    and locations to mask downstream from in the second. If only one column is passed,
    all instances of that mutation on the tree are masked.
  inputBinding:
    position: 101
    prefix: --mask-mutations
- id: condense_tree
  type:
  - 'null'
  - boolean
  doc: Use to recondense the tree before saving.
  inputBinding:
    position: 101
    prefix: --condense-tree
- id: max_snp_distance
  type:
  - 'null'
  - int
  doc: 'Maximum distance allowed between neigboring samples that will be processed
    for post-placement sample masking. [default: 0]'
  inputBinding:
    position: 101
    prefix: --max-snp-distance
- id: maple_file
  type:
  - 'null'
  - File
  doc: Concatenated, MAPLE-formatted variant file containing phylogeny samples to
    be checked for post-placement sample masking. Samples not included in file will
    not be checked for masking. To be used with -D flag
  inputBinding:
    position: 101
    prefix: --maple-file
- id: move_nodes
  type:
  - 'null'
  - File
  doc: Name of the TSV file containing names of the nodes to be moved and their new
    parents. Use to move nodes around the tree between paths containing identical
    sets of mutations.
  inputBinding:
    position: 101
    prefix: --move-nodes
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
- id: output_mat_file
  type: File
  doc: Output file named by --output-mat. Path to output masked mutation-annotated
    tree file [REQUIRED]
  outputBinding:
    glob: $(inputs.output_mat)
- id: stdout_log
  type: stdout
  doc: Standard output (progress messages).
stdout: matUtils_mask_stdout.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
