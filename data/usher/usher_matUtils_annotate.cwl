cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- matUtils
- annotate
label: usher_matUtils_annotate
doc: 'matUtils annotate: assigns clade identities to nodes of the mutation-annotated
  tree (MAT), directly or by inference.


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
  doc: Path to output processed mutation-annotated tree file [REQUIRED]
  inputBinding:
    position: 101
    prefix: --output-mat
- id: clade_names
  type:
  - 'null'
  - File
  doc: Path to a tsv file containing clade assignments of samples. An algorithm automatically
    locates and annotates clade root nodes.  If a clade has been found already using
    --clade-paths or appears in --clade-mutations then the clade's assignments in
    this file are ignored.
  inputBinding:
    position: 101
    prefix: --clade-names
- id: clade_to_nid
  type:
  - 'null'
  - File
  doc: Path to a tsv file mapping clades to their respective internal node identifiers.  Cannot
    be used in conjunction with --clade-paths, --clade-mutations or --clade-names.
  inputBinding:
    position: 101
    prefix: --clade-to-nid
- id: clade_paths
  type:
  - 'null'
  - File
  doc: Path to a tsv file mapping clades to mutation paths.  A warning is printed
    if a path is not found exactly as specified.  Format is the same as the first
    and third columns of the output of matUtils extract --clade-paths.
  inputBinding:
    position: 101
    prefix: --clade-paths
- id: clade_mutations
  type:
  - 'null'
  - File
  doc: Path to a tsv file mapping clades to sets of mutations (separated by spaces,
    commas and/or >s) which will be used instead of extracting mutations from samples
    named in the --clade-names file.  This method is more robust to small changes
    in paths, but significantly slower than --clade-paths.  If used together with
    --clade-paths, --clade-paths takes precedence.  If used together with --clade-names,
    this takes precedence.
  inputBinding:
    position: 101
    prefix: --clade-mutations
- id: allele_frequency
  type:
  - 'null'
  - float
  doc: 'Minimum allele frequency in input samples for finding the best clade root.
    Used only with -c [default: 0.800000012]'
  inputBinding:
    position: 101
    prefix: --allele-frequency
- id: mask_frequency
  type:
  - 'null'
  - float
  doc: 'Minimum allele frequency below -f in input samples that should be masked for
    finding the best clade root. Used only with -c [default: 0.200000003]'
  inputBinding:
    position: 101
    prefix: --mask-frequency
- id: set_overlap
  type:
  - 'null'
  - float
  doc: 'Minimum fraction of the clade samples that should be desecendants of the assigned
    clade root. Used only with -c [default: 0.600000024]'
  inputBinding:
    position: 101
    prefix: --set-overlap
- id: clip_sample_frequency
  type:
  - 'null'
  - float
  doc: 'Maximum proportion of samples in a branch that are exemplars from -c to consider
    when sorting candidate clade root nodes [default: 0.100000001]'
  inputBinding:
    position: 101
    prefix: --clip-sample-frequency
- id: clear_current
  type:
  - 'null'
  - boolean
  doc: Use to remove current annotations before applying new values.
  inputBinding:
    position: 101
    prefix: --clear-current
- id: output_directory
  type:
  - 'null'
  - string
  doc: 'Write output files to the target directory. Default is current directory.
    [default: ./]'
  inputBinding:
    position: 101
    prefix: --output-directory
- id: write_mutations
  type:
  - 'null'
  - string
  doc: Write a tsv listing each clade and the mutations found in at least [-f] of
    samples. Used only with -c
  inputBinding:
    position: 101
    prefix: --write-mutations
- id: write_details
  type:
  - 'null'
  - string
  doc: Write a tsv with details about the nodes considered for each clade root. Used
    only with -c
  inputBinding:
    position: 101
    prefix: --write-details
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
  doc: Output file named by --output-mat. Path to output processed mutation-annotated
    tree file [REQUIRED]
  outputBinding:
    glob: '${ return inputs.output_mat ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.output_mat : inputs.output_mat) : []; }'
- id: output_directory_dir
  type:
  - 'null'
  - Directory
  doc: Directory named by --output-directory
  outputBinding:
    glob: '${ return inputs.output_directory ? inputs.output_directory : []; }'
- id: write_mutations_file
  type:
  - 'null'
  - File
  doc: Output file named by --write-mutations. Write a tsv listing each clade and
    the mutations found in at least [-f] of samples. Used only with -c
  outputBinding:
    glob: '${ return inputs.write_mutations ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.write_mutations : inputs.write_mutations) : []; }'
- id: write_details_file
  type:
  - 'null'
  - File
  doc: Output file named by --write-details. Write a tsv with details about the nodes
    considered for each clade root. Used only with -c
  outputBinding:
    glob: '${ return inputs.write_details ? (inputs.output_directory ? inputs.output_directory
      + ''/'' + inputs.write_details : inputs.write_details) : []; }'
- id: stdout_log
  type: stdout
  doc: Standard output (progress messages).
stdout: matUtils_annotate_stdout.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
