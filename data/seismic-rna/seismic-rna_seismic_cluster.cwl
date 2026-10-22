cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - cluster
label: seismic-rna_seismic_cluster
doc: 'Infer structure ensembles by clustering reads'' mutations.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: input_dir
    type: Directory
    doc: Output directory of the previous step. It is copied into the working directory
      as the output directory (named by --out-dir, default out)
  - id: input_path
    type:
      - 'null'
      - type: array
        items: string
    default:
      - out
    doc: Files or directories inside the output directory to process (paths start
      with the output directory name)
    inputBinding:
      position: 201
  - id: branch
    type:
      - 'null'
      - string
    doc: 'Create a new branch of the workflow with this name [default: ""]'
    inputBinding:
      position: 100
      prefix: --branch
  - id: min_clusters
    type:
      - 'null'
      - int
    doc: 'Start at this many clusters [default: 1]'
    inputBinding:
      position: 100
      prefix: --min-clusters
  - id: max_clusters
    type:
      - 'null'
      - int
    doc: 'Stop at this many clusters (0 for no limit) [default: 0]'
    inputBinding:
      position: 100
      prefix: --max-clusters
  - id: min_em_runs
    type:
      - 'null'
      - int
    doc: 'Run EM (successfully) at least this number of times for each K [default:
      6]'
    inputBinding:
      position: 100
      prefix: --min-em-runs
  - id: max_em_runs
    type:
      - 'null'
      - int
    doc: 'Run EM (successfully or not) at most this number of times for each K [default:
      30]'
    inputBinding:
      position: 100
      prefix: --max-em-runs
  - id: em_thresh
    type:
      - 'null'
      - float
    doc: 'Stop EM when the log likelihood increases by less than this threshold [default:
      0.37]'
    inputBinding:
      position: 100
      prefix: --em-thresh
  - id: min_em_iter
    type:
      - 'null'
      - int
    doc: 'Run EM for at least this many iterations [default: 10]'
    inputBinding:
      position: 100
      prefix: --min-em-iter
  - id: max_em_iter
    type:
      - 'null'
      - int
    doc: 'Run EM for at most this many iterations [default: 500]'
    inputBinding:
      position: 100
      prefix: --max-em-iter
  - id: max_pearson_run
    type:
      - 'null'
      - float
    doc: 'Remove runs with two clusters more similar than this correlation [default:
      0.9]'
    inputBinding:
      position: 100
      prefix: --max-pearson-run
  - id: min_marcd_run
    type:
      - 'null'
      - float
    doc: 'Remove runs with two clusters that differ by less than this MARCD [default:
      0.016]'
    inputBinding:
      position: 100
      prefix: --min-marcd-run
  - id: max_arcd_vs_ens_avg
    type:
      - 'null'
      - float
    doc: 'Remove runs where a cluster differs by more than this ARCD from the ensemble
      average at any position [default: 0.2]'
    inputBinding:
      position: 100
      prefix: --max-arcd-vs-ens-avg
  - id: max_gini_run
    type:
      - 'null'
      - float
    doc: 'Remove runs where any cluster''s Gini coefficient exceeds this limit [default:
      0.667]'
    inputBinding:
      position: 100
      prefix: --max-gini-run
  - id: jackpot
    type:
      - 'null'
      - boolean
    doc: 'Calculate the jackpotting quotient to find over-represented reads [default:
      jackpot]'
    inputBinding:
      position: 100
      prefix: --jackpot
  - id: no_jackpot
    type:
      - 'null'
      - boolean
    doc: 'Calculate the jackpotting quotient to find over-represented reads [default:
      jackpot]'
    inputBinding:
      position: 100
      prefix: --no-jackpot
  - id: jackpot_conf_level
    type:
      - 'null'
      - float
    doc: 'Confidence level for the jackpotting quotient confidence interval [default:
      0.95]'
    inputBinding:
      position: 100
      prefix: --jackpot-conf-level
  - id: max_jackpot_quotient
    type:
      - 'null'
      - float
    doc: 'Remove runs whose jackpotting quotient exceeds this limit [default: 1.1]'
    inputBinding:
      position: 100
      prefix: --max-jackpot-quotient
  - id: max_loglike_vs_best
    type:
      - 'null'
      - float
    doc: 'Remove Ks with a log likelihood gap larger than this (0 for no limit) [default:
      0.0]'
    inputBinding:
      position: 100
      prefix: --max-loglike-vs-best
  - id: min_pearson_vs_best
    type:
      - 'null'
      - float
    doc: 'Remove Ks where every run has less than this correlation vs. the best [default:
      0.97]'
    inputBinding:
      position: 100
      prefix: --min-pearson-vs-best
  - id: max_marcd_vs_best
    type:
      - 'null'
      - float
    doc: 'Remove Ks where every run has more than this MARCD vs. the best [default:
      0.008]'
    inputBinding:
      position: 100
      prefix: --max-marcd-vs-best
  - id: try_all_ks
    type:
      - 'null'
      - boolean
    doc: 'Try all numbers of clusters (Ks), even after finding the best number [default:
      stop- best-k]'
    inputBinding:
      position: 100
      prefix: --try-all-ks
  - id: stop_best_k
    type:
      - 'null'
      - boolean
    doc: 'Try all numbers of clusters (Ks), even after finding the best number [default:
      stop- best-k]'
    inputBinding:
      position: 100
      prefix: --stop-best-k
  - id: write_all_ks
    type:
      - 'null'
      - boolean
    doc: ' Write all numbers of clusters (Ks), rather than only the best number [default:
      write- best-k]'
    inputBinding:
      position: 100
      prefix: --write-all-ks
  - id: write_best_k
    type:
      - 'null'
      - boolean
    doc: ' Write all numbers of clusters (Ks), rather than only the best number [default:
      write- best-k]'
    inputBinding:
      position: 100
      prefix: --write-best-k
  - id: cluster_pos_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per position for cluster data [default: cluster-pos-table]'
    inputBinding:
      position: 100
      prefix: --cluster-pos-table
  - id: no_cluster_pos_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per position for cluster data [default: cluster-pos-table]'
    inputBinding:
      position: 100
      prefix: --no-cluster-pos-table
  - id: cluster_abundance_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate number of reads per cluster for cluster data [default: cluster-abundance-
      table]'
    inputBinding:
      position: 100
      prefix: --cluster-abundance-table
  - id: no_cluster_abundance_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate number of reads per cluster for cluster data [default: cluster-abundance-
      table]'
    inputBinding:
      position: 100
      prefix: --no-cluster-abundance-table
  - id: verify_times
    type:
      - 'null'
      - boolean
    doc: ' Verify that report files from later steps have later timestamps [default:
      verify- times]'
    inputBinding:
      position: 100
      prefix: --verify-times
  - id: no_verify_times
    type:
      - 'null'
      - boolean
    doc: ' Verify that report files from later steps have later timestamps [default:
      verify- times]'
    inputBinding:
      position: 100
      prefix: --no-verify-times
  - id: brotli_level
    type:
      - 'null'
      - int
    doc: 'Compress pickle files with this level of Brotli (0 - 11) [default: 10]'
    inputBinding:
      position: 100
      prefix: --brotli-level
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: 'Use up to this many CPUs simultaneously [default: 20]'
    inputBinding:
      position: 100
      prefix: --num-cpus
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force all tasks to run, overwriting any existing output files [default:
      no-force]'
    inputBinding:
      position: 100
      prefix: --force
  - id: no_force
    type:
      - 'null'
      - boolean
    doc: 'Force all tasks to run, overwriting any existing output files [default:
      no-force]'
    inputBinding:
      position: 100
      prefix: --no-force
  - id: tmp_pfx
    type:
      - 'null'
      - string
    doc: 'Write all temporary files to a directory with this prefix [default: ./tmp]'
    inputBinding:
      position: 100
      prefix: --tmp-pfx
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: 'Keep temporary files after finishing [default: erase-tmp]'
    inputBinding:
      position: 100
      prefix: --keep-tmp
  - id: erase_tmp
    type:
      - 'null'
      - boolean
    doc: 'Keep temporary files after finishing [default: erase-tmp]'
    inputBinding:
      position: 100
      prefix: --erase-tmp
outputs:
  - id: out_dir_result
    type: Directory
    doc: Output directory with all results
    outputBinding:
      glob: out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        entryname: out
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
