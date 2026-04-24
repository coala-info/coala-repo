cwlVersion: v1.2
class: CommandLineTool
baseCommand: colabfold_batch
label: colabfold_colabfold_batch
doc: "ColabFold batch prediction\n\nTool homepage: https://github.com/sokrypton/ColabFold"
inputs:
  - id: input
    type: string
    doc: 'One of: 1) directory with FASTA/A3M files, 2) CSV/TSV file, 3) FASTA file
      or 4) A3M file.'
    inputBinding:
      position: 1
  - id: results
    type: Directory
    doc: Results output directory.
    inputBinding:
      position: 2
  - id: amber
    type:
      - 'null'
      - boolean
    doc: Enable OpenMM/Amber for structure relaxation. Can improve the quality 
      of side-chains at a cost of longer runtime.
    inputBinding:
      position: 103
      prefix: --amber
  - id: custom_template_path
    type:
      - 'null'
      - Directory
    doc: Directory with PDB files to provide as custom templates to the 
      predictor. No templates will be queried from the MSA server. '--templates'
      argument is also required to enable this.
    inputBinding:
      position: 103
      prefix: --custom-template-path
  - id: data
    type:
      - 'null'
      - Directory
    doc: Path to AlphaFold2 weights directory.
    inputBinding:
      position: 103
      prefix: --data
  - id: disable_cluster_profile
    type:
      - 'null'
      - boolean
    doc: 'Experimental: For multimer models, disable cluster profiles.'
    inputBinding:
      position: 103
      prefix: --disable-cluster-profile
  - id: disable_unified_memory
    type:
      - 'null'
      - boolean
    doc: If you are getting TensorFlow/Jax errors, it might help to disable 
      this.
    inputBinding:
      position: 103
      prefix: --disable-unified-memory
  - id: host_url
    type:
      - 'null'
      - string
    doc: Which MSA server should be queried. By default, the free public MSA 
      server hosted by the ColabFold team is queried.
    inputBinding:
      position: 103
      prefix: --host-url
  - id: jobname_prefix
    type:
      - 'null'
      - string
    doc: If set, the jobname will be prefixed with the given string and a 
      running number, instead of the input headers/accession.
    inputBinding:
      position: 103
      prefix: --jobname-prefix
  - id: local_pdb_path
    type:
      - 'null'
      - Directory
    doc: Directory of a local mirror of the PDB mmCIF database (e.g. 
      /path/to/pdb/divided). If provided, PDB files from the directory are used 
      for templates specified by '--pdb-hit-file'.
    inputBinding:
      position: 103
      prefix: --local-pdb-path
  - id: max_extra_seq
    type:
      - 'null'
      - int
    doc: Number of extra sequences to use. This can result in different 
      predictions and can be (carefully!) used for conformations sampling.
    inputBinding:
      position: 103
      prefix: --max-extra-seq
  - id: max_msa
    type:
      - 'null'
      - int
    doc: 'Defines: `max-seq:max-extra-seq` number of sequences to use in one go. "--max-seq"
      and "--max-extra-seq" are ignored if this parameter is set.'
    inputBinding:
      position: 103
      prefix: --max-msa
  - id: max_seq
    type:
      - 'null'
      - int
    doc: Number of sequence clusters to use. This can result in different 
      predictions and can be (carefully!) used for conformations sampling.
    inputBinding:
      position: 103
      prefix: --max-seq
  - id: model_order
    type:
      - 'null'
      - string
    inputBinding:
      position: 103
      prefix: --model-order
  - id: model_type
    type:
      - 'null'
      - string
    doc: Predict structure/complex using the given model. Auto will pick 
      "alphafold2_ptm" for structure predictions and "alphafold2_multimer_v3" 
      for complexes. Older versions of the AF2 models are generally worse, 
      however they can sometimes result in better predictions. If the model is 
      not already downloaded, it will be automatically downloaded.
    inputBinding:
      position: 103
      prefix: --model-type
  - id: msa_mode
    type:
      - 'null'
      - string
    doc: 'Databases to use to create the MSA: UniRef30+Environmental (default), UniRef30
      only or None. Using an A3M file as input overwrites this option.'
    inputBinding:
      position: 103
      prefix: --msa-mode
  - id: msa_only
    type:
      - 'null'
      - boolean
    doc: Query and store MSAs from the MSA server without structure prediction
    inputBinding:
      position: 103
      prefix: --msa-only
  - id: num_ensemble
    type:
      - 'null'
      - int
    doc: Number of ensembles. The trunk of the network is run multiple times 
      with different random choices for the MSA cluster centers. This can result
      in a better prediction at the cost of longer runtime.
    inputBinding:
      position: 103
      prefix: --num-ensemble
  - id: num_models
    type:
      - 'null'
      - int
    doc: Number of models to use for structure prediction. Reducing the number 
      of models speeds up the prediction but results in lower quality.
    inputBinding:
      position: 103
      prefix: --num-models
  - id: num_recycle
    type:
      - 'null'
      - int
    doc: Number of prediction recycles. Increasing recycles can improve the 
      prediction quality but slows down the prediction.
    inputBinding:
      position: 103
      prefix: --num-recycle
  - id: num_relax
    type:
      - 'null'
      - int
    doc: Specify how many of the top ranked structures to relax using 
      OpenMM/Amber. Typically, relaxing the top-ranked prediction is enough and 
      speeds up the runtime.
    inputBinding:
      position: 103
      prefix: --num-relax
  - id: num_seeds
    type:
      - 'null'
      - int
    doc: Number of seeds to try. Will iterate from range(random_seed, 
      random_seed+num_seeds). This can result in a better/different prediction 
      at the cost of longer runtime.
    inputBinding:
      position: 103
      prefix: --num-seeds
  - id: overwrite_existing_results
    type:
      - 'null'
      - boolean
    doc: Do not recompute results, if a query has already been predicted.
    inputBinding:
      position: 103
      prefix: --overwrite-existing-results
  - id: pair_mode
    type:
      - 'null'
      - string
    doc: 'Multimer MSA pairing mode for complex prediction: unpaired MSA only, paired
      MSA only, both (default).'
    inputBinding:
      position: 103
      prefix: --pair-mode
  - id: pair_strategy
    type:
      - 'null'
      - string
    doc: 'How sequences are paired during MSA pairing for complex prediction. complete:
      MSA sequences should only be paired if the same species exists in all MSAs.
      greedy: MSA sequences should only be paired if the same species exists in at
      least two MSAs. Typically, greedy produces better predictions as it results
      in more paired sequences. However, in some cases complete pairing might help,
      especially if MSAs are already large and can be well paired.'
    inputBinding:
      position: 103
      prefix: --pair-strategy
  - id: pdb_hit_file
    type:
      - 'null'
      - File
    doc: Path to a BLAST-m8 formatted PDB hit file corresponding to the input 
      A3M file (e.g. pdb70.m8). Typically, this parameter should be used for a 
      MSA generated by 'colabfold_search'. '--templates' argument is also 
      required to enable this.
    inputBinding:
      position: 103
      prefix: --pdb-hit-file
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Changing the seed for the random number generator can result in 
      better/different structure predictions.
    inputBinding:
      position: 103
      prefix: --random-seed
  - id: rank
    type:
      - 'null'
      - string
    doc: Choose metric to rank the "--num-models" predicted models.
    inputBinding:
      position: 103
      prefix: --rank
  - id: recompile_padding
    type:
      - 'null'
      - int
    doc: Whenever the input length changes, the model needs to be recompiled. We
      pad sequences by the specified length, so we can e.g., compute sequences 
      from length 100 to 110 without recompiling. Individual predictions will 
      become marginally slower due to longer input, but overall performance 
      increases due to not recompiling. Set to 0 to disable.
    inputBinding:
      position: 103
      prefix: --recompile-padding
  - id: recycle_early_stop_tolerance
    type:
      - 'null'
      - float
    doc: Specify convergence criteria. Run recycles until the distance between 
      recycles is within the given tolerance value.
    inputBinding:
      position: 103
      prefix: --recycle-early-stop-tolerance
  - id: relax_max_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations for the relaxation process. AlphaFold2 
      sets this to unlimited (0), however, we found that this can lead to very 
      long relaxation times for some inputs.
    inputBinding:
      position: 103
      prefix: --relax-max-iterations
  - id: relax_max_outer_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of outer iterations for the relaxation process.
    inputBinding:
      position: 103
      prefix: --relax-max-outer-iterations
  - id: relax_stiffness
    type:
      - 'null'
      - float
    doc: Stiffness parameter for relaxation.
    inputBinding:
      position: 103
      prefix: --relax-stiffness
  - id: relax_tolerance
    type:
      - 'null'
      - float
    doc: Tolerance threshold for relaxation convergence.
    inputBinding:
      position: 103
      prefix: --relax-tolerance
  - id: save_all
    type:
      - 'null'
      - boolean
    doc: Save all raw outputs from model to a pickle file. Useful for downstream
      use in other models.
    inputBinding:
      position: 103
      prefix: --save-all
  - id: save_pair_representations
    type:
      - 'null'
      - boolean
    doc: Save the pair representation embeddings of all models.
    inputBinding:
      position: 103
      prefix: --save-pair-representations
  - id: save_recycles
    type:
      - 'null'
      - boolean
    doc: Save all intermediate predictions at each recycle iteration.
    inputBinding:
      position: 103
      prefix: --save-recycles
  - id: save_single_representations
    type:
      - 'null'
      - boolean
    doc: Save the single representation embeddings of all models.
    inputBinding:
      position: 103
      prefix: --save-single-representations
  - id: sort_queries_by
    type:
      - 'null'
      - string
    doc: 'Sort input queries by: none, length, random. Sorting by length speeds up
      prediction as models are recompiled less often.'
    inputBinding:
      position: 103
      prefix: --sort-queries-by
  - id: stop_at_score
    type:
      - 'null'
      - float
    doc: Compute models until pLDDT (single chain) or pTM-score (multimer) > 
      threshold is reached. This speeds up prediction by running less models for
      easier queries.
    inputBinding:
      position: 103
      prefix: --stop-at-score
  - id: templates
    type:
      - 'null'
      - boolean
    doc: 'Query PDB templates from the MSA server. If this parameter is not set, "--custom-template-path"
      and "--pdb-hit-file" will not be used. Warning: This can result in the MSA server
      being queried with A3M input.'
    inputBinding:
      position: 103
      prefix: --templates
  - id: use_dropout
    type:
      - 'null'
      - boolean
    doc: Activate dropouts during inference to sample from uncertainty of the 
      models. This can result in different predictions and can be (carefully!) 
      used for conformations sampling.
    inputBinding:
      position: 103
      prefix: --use-dropout
  - id: use_gpu_relax
    type:
      - 'null'
      - boolean
    doc: Run OpenMM/Amber on GPU instead of CPU. This can significantly speed up
      the relaxation runtime, however, might lead to compatibility issues with 
      CUDA. Unsupported on AMD/ROCM and Apple Silicon.
    inputBinding:
      position: 103
      prefix: --use-gpu-relax
  - id: zip
    type:
      - 'null'
      - boolean
    doc: Zip all results into one <jobname>.result.zip and delete the original 
      files.
    inputBinding:
      position: 103
      prefix: --zip
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/colabfold:1.5.5--pyh7cba7a3_2
stdout: colabfold_colabfold_batch.out
