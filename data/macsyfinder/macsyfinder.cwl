cwlVersion: v1.2
class: CommandLineTool
baseCommand: macsyfinder
label: macsyfinder
doc: "MacSyFinder (MSF) - Detection of macromolecular systems in protein datasets
  using systems modelling and similarity search.\n\nTool homepage: https://github.com/gem-pasteur/macsyfinder"
inputs:
  - id: accessory_weight
    type:
      - 'null'
      - float
    doc: the weight of a accessory component in cluster scoring
    default: 0.5
    inputBinding:
      position: 101
      prefix: --accessory-weight
  - id: cfg_file
    type:
      - 'null'
      - File
    doc: Path to a MacSyFinder configuration file to be used. (conflict with 
      --previous-run)
    inputBinding:
      position: 101
      prefix: --cfg-file
  - id: coverage_profile
    type:
      - 'null'
      - float
    doc: Minimal profile coverage required for the hit alignment with the 
      profile to allow the hit selection for systems detection.
    default: 0.5
    inputBinding:
      position: 101
      prefix: --coverage-profile
  - id: cut_ga
    type:
      - 'null'
      - boolean
    doc: By default the MSF try to applied a threshold per profile by using the 
      hmmer -cut-ga option. This is possible only if the GA bit score is present
      in the profile otherwise MSF switch to use the --e-value-search (-E in 
      hmmsearch). But the modeler can override this default behavior to do not 
      use cut_ga but --e-value-search instead (-E in hmmsearch). The user can 
      reestablish the general MSF behavior, be sure the profiles contain the GA 
      bit score.
    default: true
    inputBinding:
      position: 101
      prefix: --cut-ga
  - id: db_type
    type:
      - 'null'
      - string
    doc: 'The type of dataset to deal with. "unordered" corresponds to a non-assembled
      genome or set of unassembled genes, "ordered_replicon" to an assembled genome,
      "gembase" to a set of replicons where sequence identifiers follow this convention:
      ">RepliconName_SequenceID".'
    inputBinding:
      position: 101
      prefix: --db-type
  - id: e_value_search
    type:
      - 'null'
      - float
    doc: Maximal e-value for hits to be reported during hmmsearch search. By 
      default MSF set per profile threshold for hmmsearch run (hmmsearch 
      --cut_ga option) for profiles containing the GA bit score threshold. If a 
      profile does not contains the GA bit score the --e-value-search (-E in 
      hmmsearch) is applied to this profile. To applied the --e-value-search to 
      all profiles use the --no-cut-ga option.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --e-value-search
  - id: exchangeable_weight
    type:
      - 'null'
      - float
    doc: the weight modifier for a component which code for exchangeable cluster
      scoring
    default: 0.8
    inputBinding:
      position: 101
      prefix: --exchangeable-weight
  - id: force
    type:
      - 'null'
      - boolean
    doc: force to run even the out dir already exists and is not empty. Use this
      option with caution, MSF will erase everything in out dir before to run.
    inputBinding:
      position: 101
      prefix: --force
  - id: hmmer
    type:
      - 'null'
      - File
    doc: Path to the hmmsearch program. If not specified, rely on the 
      environment variable PATH
    default: /usr/local/bin/hmmsearch
    inputBinding:
      position: 101
      prefix: --hmmer
  - id: i_evalue_sel
    type:
      - 'null'
      - float
    doc: Maximal independent e-value for Hmmer hits to be selected for systems 
      detection.
    default: 0.001
    inputBinding:
      position: 101
      prefix: --i-evalue-sel
  - id: idx
    type:
      - 'null'
      - boolean
    doc: Forces to build the indexes for the sequence dataset even if they were 
      previously computed and present at the dataset location.
    default: false
    inputBinding:
      position: 101
      prefix: --idx
  - id: index_dir
    type:
      - 'null'
      - Directory
    doc: Specifies the path to a directory to store/read the sequence index when
      the sequence-db dir is not writable.
    inputBinding:
      position: 101
      prefix: --index-dir
  - id: inter_gene_max_space
    type:
      - 'null'
      - type: array
        items: int
    doc: "Co-localization criterion: maximum number of components non-matched by a
      profile allowed between two matched components for them to be considered contiguous.
      Option only meaningful for 'ordered' datasets. The first value must name a model,
      the second a number of components. This option can be repeated several times:
      \"--inter-gene-max-space TXSS/T2SS 12 --inter-gene-max-space TXSS/Flagellum
      20"
    inputBinding:
      position: 101
      prefix: --inter-gene-max-space
  - id: list_models
    type:
      - 'null'
      - boolean
    doc: Displays all models installed at generic location and quit.
    inputBinding:
      position: 101
      prefix: --list-models
  - id: mandatory_weight
    type:
      - 'null'
      - float
    doc: the weight of a mandatory component in cluster scoring
    default: 1.0
    inputBinding:
      position: 101
      prefix: --mandatory-weight
  - id: max_nb_genes
    type:
      - 'null'
      - type: array
        items: int
    doc: 'The maximal number of genes to consider a system as full. The first value
      must correspond to a model name, the second value to an integer. This option
      can be repeated several times: "--max-nb-genes TXSS/T2SS 5 --max-nb-genes TXSS/Flagellum
      10"'
    inputBinding:
      position: 101
      prefix: --max-nb-genes
  - id: min_genes_required
    type:
      - 'null'
      - type: array
        items: int
    doc: "The minimal number of genes required for model assessment (includes both
      'mandatory' and 'accessory' components). The first value must correspond to
      a model fully qualified name, the second value to an integer. This option can
      be repeated several times: \"--min-genes-required TXSS/T2SS 15 --min-genes-required
      TXSS/Flagellum 10"
    inputBinding:
      position: 101
      prefix: --min-genes-required
  - id: min_mandatory_genes_required
    type:
      - 'null'
      - type: array
        items: int
    doc: 'The minimal number of mandatory genes required for model assessment. The
      first value must correspond to a model fully qualified name, the second value
      to an integer. This option can be repeated several times: "--min-mandatory-genes-required
      TXSS/T2SS 15 --min-mandatory-genes-required TXSS/Flagellum 10"'
    inputBinding:
      position: 101
      prefix: --min-mandatory-genes-required
  - id: models
    type:
      - 'null'
      - type: array
        items: string
    doc: The models to search. The first element must be the name of family 
      models, followed by the name of the models to search. If the name 'all' is
      in the list of models, all models from the family will be searched. 
      '--models TXSS Flagellum T2SS' means MSF will search for the models 
      TXSS/Flagellum and TXSS/T2SS. '--models TXSS all' means MSF will search 
      for all models found in the model package TXSS. '--models 
      CRISPRcas/subtyping all' means MSF will search for all models described in
      the CRISPRCas/subtyping subfamily.
    inputBinding:
      position: 101
      prefix: --models
  - id: models_dir
    type:
      - 'null'
      - Directory
    doc: Specifies the path to the models if the models are not installed in the
      canonical place. It gathers definitions (xml files) and HMM profiles 
      arranged in a specific file structure. A directory with the name of the 
      model with at least two directories 'profiles' - which contains HMM 
      profiles for each gene components described in the systems' models 
      'models' - which contains either the XML files of models' definitions or 
      subdirectories to organize the models in subsystems.
    inputBinding:
      position: 101
      prefix: --models-dir
  - id: multi_loci
    type:
      - 'null'
      - string
    doc: Specifies if the system can be detected as a 'scattered' (or 
      multiple-loci-encoded) system. The models are specified as a comma 
      separated list of fully qualified name(s) "--multi-loci 
      model_familyA/model_1,model_familyB/model_2"
    inputBinding:
      position: 101
      prefix: --multi-loci
  - id: mute
    type:
      - 'null'
      - boolean
    doc: Mute the log on stdout. (continue to log on macsyfinder.log)
    default: false
    inputBinding:
      position: 101
      prefix: --mute
  - id: no_cut_ga
    type:
      - 'null'
      - boolean
    doc: By default the MSF try to applied a threshold per profile by using the 
      hmmer -cut-ga option. This is possible only if the GA bit score is present
      in the profile otherwise MF switch to use the --e-value-search (-E in 
      hmmsearch). If this option is set the --e-value-search option is used for 
      all profiles regardless the presence of the a GA bit score in the 
      profiles.
    default: false
    inputBinding:
      position: 101
      prefix: --no-cut-ga
  - id: out_of_cluster
    type:
      - 'null'
      - float
    doc: the weight modifier for a hit which is a - true loner (not in cluster) 
      - or multi-system (from an other system)
    default: 0.7
    inputBinding:
      position: 101
      prefix: --out-of-cluster
  - id: previous_run
    type:
      - 'null'
      - Directory
    doc: 'Path to a previous MacSyFinder run directory. It allows to skip the Hmmer
      search step on a same dataset, as it uses previous run results and thus parameters
      regarding Hmmer detection. The configuration file from this previous run will
      be used. Conflicts with options: --cfg-file, --sequence-db, --profile-suffix,
      --res-extract-suffix, --e-value-res, --db-type, --hmmer'
    inputBinding:
      position: 101
      prefix: --previous-run
  - id: profile_suffix
    type:
      - 'null'
      - string
    doc: The suffix of profile files. For each 'Gene' element, the corresponding
      profile is searched in the 'profile_dir', in a file which name is based on
      the Gene name + the profile suffix. For instance, if the Gene is named 
      'gspG' and the suffix is '.hmm3', then the profile should be placed at the
      specified location under the name 'gspG.hmm3'
    default: .hmm
    inputBinding:
      position: 101
      prefix: --profile-suffix
  - id: redundancy_penalty
    type:
      - 'null'
      - float
    doc: the weight modifier for cluster which bring a component already 
      presents in other clusters
    default: 1.5
    inputBinding:
      position: 101
      prefix: --redundancy-penalty
  - id: replicon_topology
    type:
      - 'null'
      - string
    doc: The topology of the replicons (this option is meaningful only if the 
      db_type is 'ordered_replicon' or 'gembase').
    default: circular
    inputBinding:
      position: 101
      prefix: --replicon-topology
  - id: res_extract_suffix
    type:
      - 'null'
      - string
    doc: The suffix to give to filtered hits output files.
    default: .res_hmm_extract
    inputBinding:
      position: 101
      prefix: --res-extract-suffix
  - id: res_search_suffix
    type:
      - 'null'
      - string
    doc: The suffix to give to Hmmer raw output files.
    default: .search_hmm.out
    inputBinding:
      position: 101
      prefix: --res-search-suffix
  - id: sequence_db
    type:
      - 'null'
      - File
    doc: Path to the sequence dataset in fasta format (gzip files are 
      supported).
    inputBinding:
      position: 101
      prefix: --sequence-db
  - id: timeout
    type:
      - 'null'
      - string
    doc: In some case msf can take a long time to find the best solution (in 
      'gembase' and 'ordered_replicon mode'). The timeout is per replicon. If 
      this step reach the timeout, the replicon is skipped (for gembase mode the
      analyse of other replicons continue). NUMBER[SUFFIX] NUMBER seconds. 
      SUFFIX may be 's' for seconds (the default), 'm' for minutes, 'h' for 
      hours or 'd' for days for instance 1h2m3s means 1 hour 2 min 3 sec. NUMBER
      must be an integer.
    inputBinding:
      position: 101
      prefix: --timeout
  - id: topology_file
    type:
      - 'null'
      - File
    doc: "Topology file path. The topology file allows to specify a topology (linear
      or circular) for each replicon (this option is meaningful only if the db_type
      is 'ordered_replicon' or 'gembase'. A topology file is a tabular file with two
      columns: the 1st is the replicon name, and the 2nd the corresponding topology:
      \"RepliconA\tlinear\""
    inputBinding:
      position: 101
      prefix: --topology-file
  - id: verbosity
    type:
      - 'null'
      - boolean
    doc: 'Increases the verbosity level. There are 4 levels: Error messages (default),
      Warning (-v), Info (-vv) and Debug.(-vvv)'
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: worker
    type:
      - 'null'
      - int
    doc: Number of workers to be used by MacSyFinder. In the case the user wants
      to run MacSyFinder in a multi-thread mode. 0 mean that all threads 
      available will be used.
    default: 1
    inputBinding:
      position: 101
      prefix: --worker
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Path to the directory where to store output results. if out-dir is 
      specified, res-search-dir will be ignored.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsyfinder:2.1.6--pyhdfd78af_0
