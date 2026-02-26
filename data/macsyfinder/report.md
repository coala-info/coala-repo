# macsyfinder CWL Generation Report

## macsyfinder

### Tool Description
MacSyFinder (MSF) - Detection of macromolecular systems in protein datasets using systems modelling and similarity search.

### Metadata
- **Docker Image**: quay.io/biocontainers/macsyfinder:2.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/gem-pasteur/macsyfinder
- **Package**: https://anaconda.org/channels/bioconda/packages/macsyfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/macsyfinder/overview
- **Total Downloads**: 12.7K
- **Last updated**: 2025-12-20
- **GitHub**: https://github.com/gem-pasteur/macsyfinder
- **Stars**: N/A
### Original Help Text
```text
usage: macsyfinder [-h] [-m [MODELS ...]] [--sequence-db SEQUENCE_DB]
                   [--db-type {ordered_replicon,gembase,unordered}]
                   [--replicon-topology {linear,circular}]
                   [--topology-file TOPOLOGY_FILE] [--idx]
                   [--inter-gene-max-space INTER_GENE_MAX_SPACE INTER_GENE_MAX_SPACE]
                   [--min-mandatory-genes-required MIN_MANDATORY_GENES_REQUIRED MIN_MANDATORY_GENES_REQUIRED]
                   [--min-genes-required MIN_GENES_REQUIRED MIN_GENES_REQUIRED]
                   [--max-nb-genes MAX_NB_GENES MAX_NB_GENES]
                   [--multi-loci MULTI_LOCI] [--hmmer HMMER]
                   [--e-value-search E_VALUE_SEARCH] [--no-cut-ga | --cut-ga]
                   [--i-evalue-sel I_EVALUE_SEL]
                   [--coverage-profile COVERAGE_PROFILE]
                   [--mandatory-weight MANDATORY_WEIGHT]
                   [--accessory-weight ACCESSORY_WEIGHT]
                   [--exchangeable-weight EXCHANGEABLE_WEIGHT]
                   [--redundancy-penalty REDUNDANCY_PENALTY]
                   [--out-of-cluster OUT_OF_CLUSTER] [--models-dir MODELS_DIR]
                   [-o OUT_DIR] [--force] [--index-dir INDEX_DIR]
                   [--res-search-suffix RES_SEARCH_SUFFIX]
                   [--res-extract-suffix RES_EXTRACT_SUFFIX]
                   [--profile-suffix PROFILE_SUFFIX] [-w WORKER] [-v] [--mute]
                   [--version] [-l] [--cfg-file CFG_FILE]
                   [--previous-run PREVIOUS_RUN] [--timeout TIMEOUT]

     *            *               *                   *
*           *               *   *   *  *    **                *   *
  **     *    *   *  *     *                    *               *
    __  __  *              ____ *        *  *  *    **     *
|| |  \/  | __ _  ___  || / ___| _   _  ||   ___ _         _        *
|| | |\/| |/ _` |/ __| || \___ \| | | | ||  | __(_)_ _  __| |___ _ _
|| | |  | | (_| | (__  ||  ___) | |_| | ||  | _|| | ' \/ _` / -_) '_|
|| |_|  |_|\__,_|\___| || |____/ \__, | ||  |_| |_|_||_\__,_\___|_|
           *             *       |___/         *                   *
 *      *   * *     *   **         *   *  *           *
  *      *         *        *    *              *
             *                           *  *           *     *

MacSyFinder (MSF) - Detection of macromolecular systems in protein datasets
using systems modelling and similarity search.

options:
  -h, --help            show this help message and exit
  -m, --models [MODELS ...]
                        The models to search.
                        The first element must be the name of family models, followed by the name of the models to search.
                        If the name 'all' is in the list of models, all models from the family will be searched.
                        '--models TXSS Flagellum T2SS'
                                  means MSF will search for the models TXSS/Flagellum and TXSS/T2SS
                        '--models TXSS all'
                                  means MSF will search for all models found in the model package TXSS
                        '--models CRISPRcas/subtyping all'
                                  means MSF will search for all models described in the CRISPRCas/subtyping subfamily.
                        (required unless --previous-run is set)

Input dataset options:
  --sequence-db SEQUENCE_DB
                        Path to the sequence dataset in fasta format (gzip files are supported).
                        (required unless --previous-run is set)
  --db-type {ordered_replicon,gembase,unordered}
                        The type of dataset to deal with.
                        "unordered" corresponds to a non-assembled genome or set of unassembled genes,
                        "ordered_replicon" to an assembled genome,
                        "gembase" to a set of replicons where sequence identifiers
                        	follow this convention: ">RepliconName_SequenceID".
                        (required unless --previous-run is set)
  --replicon-topology {linear,circular}
                        The topology of the replicons
                        (this option is meaningful only if the db_type is
                        'ordered_replicon' or 'gembase'.)
                        (default: circular)
  --topology-file TOPOLOGY_FILE
                        Topology file path. The topology file allows to specify a topology
                        (linear or circular) for each replicon (this option is meaningful only if the db_type is
                        'ordered_replicon' or 'gembase'.
                        A topology file is a tabular file with two columns:
                        	the 1st is the replicon name, and the 2nd the corresponding topology:
                        	"RepliconA	linear"
  --idx                 Forces to build the indexes for the sequence dataset even
                        if they were previously computed and present at the dataset location.
                        (default: False)

Systems detection options:
  --inter-gene-max-space INTER_GENE_MAX_SPACE INTER_GENE_MAX_SPACE
                        Co-localization criterion: maximum number of components non-matched by a
                        	profile allowed between two matched components for them to be considered contiguous.
                        Option only meaningful for 'ordered' datasets.
                        The first value must name a model, the second a number of components.
                        This option can be repeated several times:
                            "--inter-gene-max-space TXSS/T2SS 12 --inter-gene-max-space TXSS/Flagellum 20
  --min-mandatory-genes-required MIN_MANDATORY_GENES_REQUIRED MIN_MANDATORY_GENES_REQUIRED
                        The minimal number of mandatory genes required for model assessment.
                        The first value must correspond to a model fully qualified name, the second value to an integer.
                        This option can be repeated several times:
                            "--min-mandatory-genes-required TXSS/T2SS 15 --min-mandatory-genes-required TXSS/Flagellum 10"
  --min-genes-required MIN_GENES_REQUIRED MIN_GENES_REQUIRED
                        The minimal number of genes required for model assessment
                        (includes both 'mandatory' and 'accessory' components).
                        The first value must correspond to a model fully qualified name, the second value to an integer.
                        This option can be repeated several times:
                            "--min-genes-required TXSS/T2SS 15 --min-genes-required TXSS/Flagellum 10
  --max-nb-genes MAX_NB_GENES MAX_NB_GENES
                        The maximal number of genes to consider a system as full.
                        The first value must correspond to a model name, the second value to an integer.
                        This option can be repeated several times:
                            "--max-nb-genes TXSS/T2SS 5 --max-nb-genes TXSS/Flagellum 10"
  --multi-loci MULTI_LOCI
                        Specifies if the system can be detected as a 'scattered' (or multiple-loci-encoded) system.
                        The models are specified as a comma separated list of fully qualified name(s)
                            "--multi-loci model_familyA/model_1,model_familyB/model_2"

Options for Hmmer execution and hits filtering:
  --hmmer HMMER         Path to the hmmsearch program.
                        If not specified, rely on the environment variable PATH
                        (default: /usr/local/bin/hmmsearch)
  --e-value-search E_VALUE_SEARCH
                        Maximal e-value for hits to be reported during hmmsearch search.
                        By default MSF set per profile threshold for hmmsearch run (hmmsearch --cut_ga option)
                        for profiles containing the GA bit score threshold.
                        If a profile does not contains the GA bit score the --e-value-search (-E in hmmsearch) is applied to this profile.
                        To applied the --e-value-search to all profiles use the --no-cut-ga option.
                        (default: 0.1)
  --no-cut-ga           By default the MSF try to applied a threshold per profile by using the
                        hmmer -cut-ga option. This is possible only if the GA bit score is present in the profile otherwise
                        MF switch to use the --e-value-search (-E in hmmsearch).
                        If this option is set the --e-value-search option is used for all profiles regardless the presence of
                        the a GA bit score in the profiles.
                        (default: False)
  --cut-ga              By default the MSF try to applied a threshold per profile by using the
                        hmmer -cut-ga option. This is possible only if the GA bit score is present in the profile otherwise
                        MSF switch to use the --e-value-search (-E in hmmsearch).
                        But the modeler can override this default behavior to do not use cut_ga but --e-value-search instead (-E in hmmsearch).
                        The user can reestablish the general MSF behavior, be sure the profiles contain the GA bit score.
                        (default: True)
  --i-evalue-sel I_EVALUE_SEL
                        Maximal independent e-value for Hmmer hits to be selected for systems detection.
                        (default:0.001)
  --coverage-profile COVERAGE_PROFILE
                        Minimal profile coverage required for the hit alignment  with the profile to allow
                        the hit selection for systems detection.
                        (default: 0.5)

Score options:
  Options for cluster and systems scoring

  --mandatory-weight MANDATORY_WEIGHT
                        the weight of a mandatory component in cluster scoring
                        (default:1.0)
  --accessory-weight ACCESSORY_WEIGHT
                        the weight of a accessory component in cluster scoring
                        (default:0.5)
  --exchangeable-weight EXCHANGEABLE_WEIGHT
                        the weight modifier for a component which code for exchangeable cluster scoring
                            (default:0.8)
  --redundancy-penalty REDUNDANCY_PENALTY
                        the weight modifier for cluster which bring a component already presents in other
                        clusters (default:1.5)
  --out-of-cluster OUT_OF_CLUSTER
                        the weight modifier for a hit which is a
                         - true loner (not in cluster)
                         - or multi-system (from an other system)
                        (default:0.7)

Path options:
  --models-dir MODELS_DIR
                        Specifies the path to the models if the models are not installed in the canonical place.
                        It gathers definitions (xml files) and HMM profiles arranged in a specific
                        file structure. A directory with the name of the model with at least two directories
                        	'profiles' - which contains HMM profiles for each gene components described in the systems' models
                        	'models' - which contains either the XML files of models' definitions or subdirectories
                        to organize the models in subsystems.
  -o, --out-dir OUT_DIR
                        Path to the directory where to store output results.
                        if out-dir is specified, res-search-dir will be ignored.
  --force               force to run even the out dir already exists and is not empty.
                        Use this option with caution, MSF will erase everything in out dir before to run.
  --index-dir INDEX_DIR
                        Specifies the path to a directory to store/read the sequence index when the sequence-db dir is not writable.
  --res-search-suffix RES_SEARCH_SUFFIX
                        The suffix to give to Hmmer raw output files. (default: .search_hmm.out)
  --res-extract-suffix RES_EXTRACT_SUFFIX
                        The suffix to give to filtered hits output files. (default: .res_hmm_extract)
  --profile-suffix PROFILE_SUFFIX
                        The suffix of profile files. For each 'Gene' element, the corresponding profile is
                        searched in the 'profile_dir', in a file which name is based on the
                        Gene name + the profile suffix.
                        For instance, if the Gene is named 'gspG' and the suffix is '.hmm3',
                        then the profile should be placed at the specified location
                        under the name 'gspG.hmm3'
                        (default: .hmm)

General options:
  -w, --worker WORKER   Number of workers to be used by MacSyFinder.
                        In the case the user wants to run MacSyFinder in a multi-thread mode.
                        0 mean that all threads available will be used.
                        (default: 1)
  -v, --verbosity       Increases the verbosity level. There are 4 levels:
                        Error messages (default), Warning (-v), Info (-vv) and Debug.(-vvv)
  --mute                Mute the log on stdout.
                        (continue to log on macsyfinder.log)
                        (default: False)
  --version             show program's version number and exit
  -l, --list-models     Displays all models installed at generic location and quit.
  --cfg-file CFG_FILE   Path to a MacSyFinder configuration file to be used. (conflict with --previous-run)
  --previous-run PREVIOUS_RUN
                        Path to a previous MacSyFinder run directory.
                        It allows to skip the Hmmer search step on a same dataset,
                        as it uses previous run results and thus parameters regarding Hmmer detection.
                        The configuration file from this previous run will be used.
                        Conflicts with options:
                            --cfg-file, --sequence-db, --profile-suffix, --res-extract-suffix, --e-value-res, --db-type, --hmmer
  --timeout TIMEOUT     In some case msf can take a long time to find the best solution (in 'gembase' and 'ordered_replicon mode').
                        The timeout is per replicon. If this step reach the timeout, the replicon is skipped (for gembase mode the analyse of other replicons continue).
                        NUMBER[SUFFIX]  NUMBER seconds. SUFFIX may be 's' for seconds (the default), 'm' for minutes, 'h' for hours or 'd' for days
                        for instance 1h2m3s means 1 hour 2 min 3 sec. NUMBER must be an integer.

For more details, visit the MacSyFinder website and see the MacSyFinder documentation.
```

