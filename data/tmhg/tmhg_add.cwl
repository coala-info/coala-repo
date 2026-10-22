cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tmhgf
  - add
label: tmhg_add
doc: "Add genomes to an existing tMHG-Finder run, computing MHG sets only for the
  new internal nodes of the guide tree.\n\nTool homepage: https://github.com/yongze-yin/tMHG-Finder/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: |-
          ${ return {class: 'Directory', basename: 'new_genomes_in', listing: inputs.new_genomes}; }
        writable: false
inputs:
  - id: old_temp_genome_dir
    type: Directory
    doc: Path to the old tMHG-Finder temp genome directory (the -tg directory of the
      previous run, not the genome directory)
    inputBinding:
      position: 8
      prefix: --old_temp_genome_dir
  - id: old_mhg_output_dir
    type: Directory
    doc: Path to the old tMHG-Finder output directory which should contain an MHG
      set for each internal node
    inputBinding:
      position: 9
      prefix: --old_mhg_output_dir
  - id: new_genomes
    type: File[]
    doc: New genome FASTA files (staged together as the new genome directory, -g)
  - id: blastn_dir
    type:
      - 'null'
      - string
    doc: Directory storing blastn results (default tMHG_new_blastn/)
    inputBinding:
      position: 1
      prefix: --blastn_dir
  - id: mash_tree_path
    type:
      - 'null'
      - string
    doc: Mash-estimated guide tree path (default mash_nj_tree.newick)
    inputBinding:
      position: 2
      prefix: --mash_tree_path
  - id: customized_tree_path
    type:
      - 'null'
      - File
    doc: Path to customized tree instead of using auto-estimated tree
    inputBinding:
      position: 3
      prefix: --customized_tree_path
  - id: reroot
    type:
      - 'null'
      - string
    doc: Boolean value (True or False) determining whether to reroot the guide tree.
      Any non-empty value is read as True by the tool
    inputBinding:
      position: 4
      prefix: --reroot
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size for Mash, default 16
    inputBinding:
      position: 5
      prefix: --kmer_size
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 6
      prefix: --thread
  - id: alignment_length_threshold
    type:
      - 'null'
      - int
    doc: Alignment length threshold in base pair. tMHG-Finder does not consider MHGs
      shorter than 60 base pairs by default. If this threshold is too low, it will
      result in an excessive amount of short MHGs and a longer runtime.
    inputBinding:
      position: 7
      prefix: --alignment_length_threshold
  - id: mhg_output_dir
    type:
      - 'null'
      - string
    doc: Directory storing the new MHG output (default tMHG_new_output/)
    inputBinding:
      position: 10
      prefix: --mhg_output_dir
  - id: new_temp_genome_dir
    type:
      - 'null'
      - string
    doc: Directory storing a copy of each genome and representative genomes (default
      tMHG_new_temp_genome/)
    inputBinding:
      position: 11
      prefix: --new_temp_genome_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: mhg_output
    type: Directory
    doc: Directory with all tMHG-Finder outputs
    outputBinding:
      glob: |-
        $(inputs.mhg_output_dir ? inputs.mhg_output_dir.replace(/\/+$/, '') : 'tMHG_new_output')
  - id: temp_genomes
    type: Directory
    doc: Directory with a copy of each genome and the representative genomes
    outputBinding:
      glob: |-
        $(inputs.new_temp_genome_dir ? inputs.new_temp_genome_dir.replace(/\/+$/, '') : 'tMHG_new_temp_genome')
  - id: blastn_results
    type:
      - 'null'
      - Directory
    doc: Directory with blastn results
    outputBinding:
      glob: |-
        $(inputs.blastn_dir ? inputs.blastn_dir.replace(/\/+$/, '') : 'tMHG_new_blastn')
  - id: mash_tree
    type:
      - 'null'
      - File
    doc: Mash-estimated guide tree
    outputBinding:
      glob: |-
        $(inputs.mash_tree_path ? inputs.mash_tree_path : 'mash_nj_tree.newick')
arguments:
  - position: 12
    prefix: --new_genome_dir
    valueFrom: new_genomes_in
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tmhg:1.0.3--pyhdfd78af_0
stdout: tmhg_add.out
