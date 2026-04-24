cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloacc
label: phyloacc
doc: "Bayesian rate analysis of conserved non-coding genomic elements\n\nTool homepage:
  https://github.com/phyloacc/PhyloAcc"
inputs:
  - id: aln_dir
    type:
      - 'null'
      - Directory
    doc: A directory containing individual alignment files for each locus in 
      FASTA format. One of -a/-b or -d is REQUIRED.
    inputBinding:
      position: 101
      prefix: --aln-dir
  - id: aln_file
    type:
      - 'null'
      - File
    doc: An alignment file in FASTA format with all loci concatenated. -b must 
      also be specified. Expected as FASTA format for now. One of -a/-b or -d is
      REQUIRED.
    inputBinding:
      position: 101
      prefix: --aln-file
  - id: appendlog
    type:
      - 'null'
      - boolean
    doc: Set this to keep the old log file even if --overwrite is specified. New
      log information will instead be appended to the previous log file.
    inputBinding:
      position: 101
      prefix: --appendlog
  - id: batch_size
    type:
      - 'null'
      - int
    doc: The number of loci to run per batch.
    inputBinding:
      position: 101
      prefix: --batch-size
  - id: bed_file
    type:
      - 'null'
      - File
    doc: A bed file with coordinates for the loci in the concatenated alignment 
      file. -a must also be specified. One of -a/-b or -d is REQUIRED.
    inputBinding:
      position: 101
      prefix: --bed-file
  - id: burnin
    type:
      - 'null'
      - int
    doc: The number of steps to be discarded in the Markov chain as burnin.
    inputBinding:
      position: 101
      prefix: --burnin
  - id: chain
    type:
      - 'null'
      - int
    doc: The number of chains.
    inputBinding:
      position: 101
      prefix: --chain
  - id: cluster_mem
    type:
      - 'null'
      - int
    doc: The max memory for each job in MB.
    inputBinding:
      position: 101
      prefix: --cluster-mem
  - id: cluster_nodes
    type:
      - 'null'
      - int
    doc: The number of nodes on the specified partition to submit jobs to.
    inputBinding:
      position: 101
      prefix: --cluster-nodes
  - id: cluster_part
    type:
      - 'null'
      - string
    doc: The partition or list of partitions (separated by commas) on which to 
      run PhyloAcc jobs.
    inputBinding:
      position: 101
      prefix: --cluster-part
  - id: cluster_time
    type:
      - 'null'
      - int
    doc: The time in minutes to give each job.
    inputBinding:
      position: 101
      prefix: --cluster-time
  - id: coal_cmd
    type:
      - 'null'
      - string
    doc: 'The path to the program to estimate branch lengths in coalescent units with
      --theta (Supported programs: ASTRAL).'
    inputBinding:
      position: 101
      prefix: --coal-path
  - id: coal_tree
    type:
      - 'null'
      - File
    doc: A file containing a rooted, Newick formatted tree with the same 
      topology as the species tree in the mod file (-m), but with branch lengths
      in coalescent units. When the gene tree model is used, one of -l or 
      --theta must be set.
    inputBinding:
      position: 101
      prefix: --l
  - id: config_file
    type:
      - 'null'
      - File
    doc: A YAML formatted file with the arguments for the program to be used in 
      lieu of command line arguments.
    inputBinding:
      position: 101
      prefix: --config
  - id: conserved
    type:
      - 'null'
      - string
    doc: Tip labels in the input tree to be set as non-target species. Enter 
      multiple labels separated by semi-colons (;). Any species not specified in
      -t or -g will be placed in this category.
    inputBinding:
      position: 101
      prefix: --conserved
  - id: depcheck
    type:
      - 'null'
      - boolean
    doc: Run this to check that all dependencies are installed at the provided 
      path. No other options necessary.
    inputBinding:
      position: 101
      prefix: --depcheck
  - id: dollo
    type:
      - 'null'
      - boolean
    doc: Set this to use the Dollo assumption in the original model (lineages 
      descendant from an accelerated branch cannot change state).
    inputBinding:
      position: 101
      prefix: --dollo
  - id: filter
    type:
      - 'null'
      - boolean
    doc: Set this flag to filter out loci with no informative sites before 
      running PhyloAcc.
    inputBinding:
      position: 101
      prefix: --filter
  - id: id_file
    type:
      - 'null'
      - File
    doc: A text file with locus names, one per line, corresponding to regions in
      the input bed file. -a and -b must also be specified.
    inputBinding:
      position: 101
      prefix: --id-file
  - id: info
    type:
      - 'null'
      - boolean
    doc: Print some meta information about the program and exit. No other 
      options required.
    inputBinding:
      position: 101
      prefix: --info
  - id: iqtree_path
    type:
      - 'null'
      - string
    doc: The path to the IQ-Tree executable for making gene trees with --theta.
    inputBinding:
      position: 101
      prefix: --iqtree-path
  - id: label_nodes
    type:
      - 'null'
      - boolean
    doc: Reads the tree from the input mod file (-m), labels the internal nodes,
      and exits.
    inputBinding:
      position: 101
      prefix: --labeltree
  - id: local
    type:
      - 'null'
      - boolean
    doc: Set to generate a local snakemake command to run the pipeline instead 
      of the cluster profile and command. ONLY recommended for testing purposes.
    inputBinding:
      position: 101
      prefix: --local
  - id: mcmc
    type:
      - 'null'
      - int
    doc: The total number of steps in the Markov chain.
    inputBinding:
      position: 101
      prefix: --mcmc
  - id: mod_file
    type:
      - 'null'
      - File
    doc: A file with a background transition rate matrix and phylogenetic tree 
      with branch lengths as output from phyloFit. REQUIRED.
    inputBinding:
      position: 101
      prefix: --mod-file
  - id: num_jobs
    type:
      - 'null'
      - int
    doc: The number of jobs (batches) to run in parallel. Must be less than or 
      equal to the total processes for PhyloAcc (-p).
    inputBinding:
      position: 101
      prefix: --num-jobs
  - id: num_procs
    type:
      - 'null'
      - int
    doc: The number of processes that this script should use.
    inputBinding:
      position: 101
      prefix: --num-procs
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Desired output directory. This will be created for you if it doesn't 
      exist.
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: outgroup
    type:
      - 'null'
      - string
    doc: Tip labels in the input tree to be used as outgroup species. Enter 
      multiple labels separated by semi-colons (;).
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Set this to overwrite existing files.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: phyloacc_gt_path
    type:
      - 'null'
      - string
    doc: The path to the PhyloAcc-GT binary.
    inputBinding:
      position: 101
      prefix: --gt-path
  - id: phyloacc_opts
    type:
      - 'null'
      - string
    doc: "A catch-all option for other PhyloAcc parameters. Enter as a semi-colon
      delimited list of options: 'OPT1 value;OPT2 value'"
    inputBinding:
      position: 101
      prefix: --phyloacc
  - id: phyloacc_st_path
    type:
      - 'null'
      - string
    doc: The path to the PhyloAcc-ST binary.
    inputBinding:
      position: 101
      prefix: --st-path
  - id: procs_per_batch
    type:
      - 'null'
      - int
    doc: The number of processes to use for each batch of PhyloAcc.
    inputBinding:
      position: 101
      prefix: --procs-per-batch
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Set this flag to prevent PhyloAcc from reporting detailed information 
      about each step.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: run_mode
    type:
      - 'null'
      - string
    doc: 'Determines which version of PhyloAcc will be used. gt: use the gene tree
      model for all loci, st: use the species tree model for all loci, adaptive: use
      the gene tree model on loci with many branches with low sCF and species tree
      model on all other loci.'
    inputBinding:
      position: 101
      prefix: --run-mode
  - id: scf_branch_cutoff
    type:
      - 'null'
      - float
    doc: The value of sCF to consider as 'low' for any given branch in a locus.
    inputBinding:
      position: 101
      prefix: --scf
  - id: scf_prop
    type:
      - 'null'
      - float
    doc: 'The proportion of branches to consider a locus for the gene tree model.
      Default: 0.3333, meaning if one-third of all branches for a given locus have
      low sCF, this locus will be run with the gene tree model.'
    inputBinding:
      position: 101
      prefix: --s
  - id: show_options
    type:
      - 'null'
      - boolean
    doc: Print the full list of PhyloAcc options that can be specified with 
      -phyloacc and exit.
    inputBinding:
      position: 101
      prefix: --options
  - id: softmask
    type:
      - 'null'
      - boolean
    doc: Treat lowercase bases in alignments as masked (converted to N) before 
      processing.
    inputBinding:
      position: 101
      prefix: --softmask
  - id: summarize
    type:
      - 'null'
      - boolean
    doc: Only generate the input summary plots and page. Do not write or 
      overwrite batch job files.
    inputBinding:
      position: 101
      prefix: --summarize
  - id: targets
    type:
      - 'null'
      - string
    doc: Tip labels in the input tree to be used as target species. Enter 
      multiple labels separated by semi-colons (;). REQUIRED.
    inputBinding:
      position: 101
      prefix: --targets
  - id: testcmd
    type:
      - 'null'
      - boolean
    doc: At the end of the program, print out an example command to run a 
      PhyloAcc batch directly.
    inputBinding:
      position: 101
      prefix: --testcmd
  - id: theta
    type:
      - 'null'
      - boolean
    doc: Set this to add gene tree estimation with IQ-tree and species 
      estimation with ASTRAL for estimation of the theta prior. Note that a 
      species tree with branch lengths in units of substitutions per site is 
      still required with -m. Also note that this may add substantial runtime to
      the pipeline.
    inputBinding:
      position: 101
      prefix: --theta
  - id: thin
    type:
      - 'null'
      - int
    doc: For the gene tree model, the number of MCMC steps between gene tree 
      sampling. The total number of MCMC steps specified with -mcmc will be 
      scaled by this as mcmc*thin
    inputBinding:
      position: 101
      prefix: --thin
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloacc:2.4.5--py313h4c9e609_1
stdout: phyloacc.out
