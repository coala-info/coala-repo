cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seismic
  - ensembles
label: seismic-rna_seismic_ensembles
doc: 'Infer independent structure ensembles along an entire RNA.


  Tool homepage: https://github.com/rouskinlab/seismic-rna'
inputs:
  - id: input_dir
    type: Directory
    doc: Output directory of the previous step(s). It is copied into the working directory
      under the name given by the output directory option (default out, or sim for
      the sim commands).
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
  - id: mask_coords
    type:
      - 'null'
      - type: array
        items: mask_coords_rec
        inputBinding:
          position: 100
    doc: ' Select a region of a reference given its 5'' and 3'' end coordinates (give
      the option once per record)'
  - id: mask_primers
    type:
      - 'null'
      - type: array
        items: mask_primers_rec
        inputBinding:
          position: 100
    doc: ' Select a region of a reference given its forward and reverse primers (give
      the option once per record)'
  - id: primer_gap
    type:
      - 'null'
      - int
    doc: 'Leave a gap of this many bases between the primer and the region [default:
      0]'
    inputBinding:
      position: 100
      prefix: --primer-gap
  - id: mask_regions_file
    type:
      - 'null'
      - File
    doc: Select regions of references from coordinates/primers in a CSV file
    inputBinding:
      position: 100
      prefix: --mask-regions-file
  - id: mask_del
    type:
      - 'null'
      - boolean
    doc: 'Mask deletions [default: mask-del]'
    inputBinding:
      position: 100
      prefix: --mask-del
  - id: keep_del
    type:
      - 'null'
      - boolean
    doc: 'Mask deletions [default: mask-del]'
    inputBinding:
      position: 100
      prefix: --keep-del
  - id: mask_ins
    type:
      - 'null'
      - boolean
    doc: 'Mask insertions [default: mask-ins]'
    inputBinding:
      position: 100
      prefix: --mask-ins
  - id: keep_ins
    type:
      - 'null'
      - boolean
    doc: 'Mask insertions [default: mask-ins]'
    inputBinding:
      position: 100
      prefix: --keep-ins
  - id: mask_mut
    type:
      - 'null'
      - string
    doc: Mask this type of mutation
    inputBinding:
      position: 100
      prefix: --mask-mut
  - id: count_mut
    type:
      - 'null'
      - string
    doc: Count only this type of mutation
    inputBinding:
      position: 100
      prefix: --count-mut
  - id: mask_polya
    type:
      - 'null'
      - int
    doc: 'Mask stretches of at least this many consecutive A bases (0 disables) [default:
      5]'
    inputBinding:
      position: 100
      prefix: --mask-polya
  - id: mask_gu
    type:
      - 'null'
      - boolean
    doc: 'Mask G and U bases [default: mask-gu]'
    inputBinding:
      position: 100
      prefix: --mask-gu
  - id: keep_gu
    type:
      - 'null'
      - boolean
    doc: 'Mask G and U bases [default: mask-gu]'
    inputBinding:
      position: 100
      prefix: --keep-gu
  - id: mask_pos
    type:
      - 'null'
      - type: array
        items: mask_pos_rec
        inputBinding:
          position: 100
    doc: Mask this position in this reference (give the option once per record)
  - id: mask_pos_file
    type:
      - 'null'
      - File
    doc: Mask positions in references from a file
    inputBinding:
      position: 100
      prefix: --mask-pos-file
  - id: min_ninfo_pos
    type:
      - 'null'
      - int
    doc: 'Mask positions with fewer than this many informative base calls [default:
      1000]'
    inputBinding:
      position: 100
      prefix: --min-ninfo-pos
  - id: max_fmut_pos
    type:
      - 'null'
      - float
    doc: 'Mask positions with more than this fraction of mutated base calls [default:
      1.0]'
    inputBinding:
      position: 100
      prefix: --max-fmut-pos
  - id: mask_read
    type:
      - 'null'
      - string
    doc: Mask the read with this name
    inputBinding:
      position: 100
      prefix: --mask-read
  - id: mask_read_file
    type:
      - 'null'
      - File
    doc: Mask the reads with names in this file
    inputBinding:
      position: 100
      prefix: --mask-read-file
  - id: mask_discontig
    type:
      - 'null'
      - boolean
    doc: ' Mask paired-end reads with discontiguous mates [default: mask-discontig]'
    inputBinding:
      position: 100
      prefix: --mask-discontig
  - id: keep_discontig
    type:
      - 'null'
      - boolean
    doc: ' Mask paired-end reads with discontiguous mates [default: mask-discontig]'
    inputBinding:
      position: 100
      prefix: --keep-discontig
  - id: min_ncov_read
    type:
      - 'null'
      - int
    doc: 'Mask reads with fewer than this many bases covering the region [default:
      1]'
    inputBinding:
      position: 100
      prefix: --min-ncov-read
  - id: min_finfo_read
    type:
      - 'null'
      - float
    doc: 'Mask reads with less than this fraction of informative base calls [default:
      0.95]'
    inputBinding:
      position: 100
      prefix: --min-finfo-read
  - id: max_fmut_read
    type:
      - 'null'
      - float
    doc: 'Mask reads with more than this fraction of mutated base calls [default:
      1.0]'
    inputBinding:
      position: 100
      prefix: --max-fmut-read
  - id: min_mut_gap
    type:
      - 'null'
      - int
    doc: 'Mask reads with two mutations separated by fewer than this many bases [default:
      4]'
    inputBinding:
      position: 100
      prefix: --min-mut-gap
  - id: quick_unbias
    type:
      - 'null'
      - boolean
    doc: ' Correct observer bias using a quick (typically linear time) heuristic [default:
      quick-unbias]'
    inputBinding:
      position: 100
      prefix: --quick-unbias
  - id: exact_unbias
    type:
      - 'null'
      - boolean
    doc: ' Correct observer bias using a quick (typically linear time) heuristic [default:
      quick-unbias]'
    inputBinding:
      position: 100
      prefix: --exact-unbias
  - id: quick_unbias_thresh
    type:
      - 'null'
      - float
    doc: 'Treat mutated fractions under this threshold as 0 with --quick-unbias [default:
      0.001]'
    inputBinding:
      position: 100
      prefix: --quick-unbias-thresh
  - id: max_mask_iter
    type:
      - 'null'
      - int
    doc: 'Stop masking after this many iterations (0 for no limit) [default: 0]'
    inputBinding:
      position: 100
      prefix: --max-mask-iter
  - id: mask_pos_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per position for mask data [default: mask-pos-table]'
    inputBinding:
      position: 100
      prefix: --mask-pos-table
  - id: no_mask_pos_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per position for mask data [default: mask-pos-table]'
    inputBinding:
      position: 100
      prefix: --no-mask-pos-table
  - id: mask_read_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per read for mask data [default: mask-read-table]'
    inputBinding:
      position: 100
      prefix: --mask-read-table
  - id: no_mask_read_table
    type:
      - 'null'
      - boolean
    doc: ' Tabulate relationships per read for mask data [default: mask-read-table]'
    inputBinding:
      position: 100
      prefix: --no-mask-read-table
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
  - id: tile_length
    type:
      - 'null'
      - int
    doc: 'Make each tile this length (if 0, use 2x the median read length) [default:
      0]'
    inputBinding:
      position: 100
      prefix: --tile-length
  - id: tile_min_overlap
    type:
      - 'null'
      - float
    doc: 'Make adjacent tiles overlap by at least this fraction of length [default:
      0.5]'
    inputBinding:
      position: 100
      prefix: --tile-min-overlap
  - id: erase_tiles
    type:
      - 'null'
      - boolean
    doc: 'Erase the mask reports/batches from the tiling step [default: erase-tiles]'
    inputBinding:
      position: 100
      prefix: --erase-tiles
  - id: keep_tiles
    type:
      - 'null'
      - boolean
    doc: 'Erase the mask reports/batches from the tiling step [default: erase-tiles]'
    inputBinding:
      position: 100
      prefix: --keep-tiles
  - id: pair_fdr
    type:
      - 'null'
      - float
    doc: 'Find correlated pairs at this false discovery rate (FDR) [default: 0.05]'
    inputBinding:
      position: 100
      prefix: --pair-fdr
  - id: min_pairs
    type:
      - 'null'
      - int
    doc: 'Cluster only the regions with at least this many correlated pairs [default:
      2]'
    inputBinding:
      position: 100
      prefix: --min-pairs
  - id: min_cluster_length
    type:
      - 'null'
      - int
    doc: 'Cluster only the regions with at least this many positions [default: 20]'
    inputBinding:
      position: 100
      prefix: --min-cluster-length
  - id: max_cluster_length
    type:
      - 'null'
      - int
    doc: 'Cluster only the regions with no more than this many positions [default:
      1200]'
    inputBinding:
      position: 100
      prefix: --max-cluster-length
  - id: gap_mode
    type:
      - 'null'
      - string
    doc: ' If there are gaps between regions to cluster, OMIT (do not cluster) the
      gaps, INSERT a new region into each gap, or EXPAND the existing regions to fill
      the gaps [default: omit]'
    inputBinding:
      position: 100
      prefix: --gap-mode
outputs:
  - id: out_dir_result
    type: Directory
    doc: Output directory with all results
    outputBinding:
      glob: out
requirements:
  - class: SchemaDefRequirement
    types:
      - name: mask_coords_rec
        type: record
        fields:
          - name: reference
            type: string
            inputBinding:
              position: 1
              prefix: --mask-coords
          - name: end5
            type: int
            inputBinding:
              position: 2
          - name: end3
            type: int
            inputBinding:
              position: 3
      - name: mask_primers_rec
        type: record
        fields:
          - name: reference
            type: string
            inputBinding:
              position: 1
              prefix: --mask-primers
          - name: forward_primer
            type: string
            inputBinding:
              position: 2
          - name: reverse_primer
            type: string
            inputBinding:
              position: 3
      - name: mask_pos_rec
        type: record
        fields:
          - name: reference
            type: string
            inputBinding:
              position: 1
              prefix: --mask-pos
          - name: position
            type: int
            inputBinding:
              position: 2
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_dir)
        entryname: out
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
