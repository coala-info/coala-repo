# phertilizer CWL Generation Report

## phertilizer

### Tool Description
Phertilizer is a tool for inferring clonal evolution and copy number alterations from single-cell sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/phertilizer:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/elkebir-group/phertilizer
- **Package**: https://anaconda.org/channels/bioconda/packages/phertilizer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phertilizer/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/elkebir-group/phertilizer
- **Stars**: N/A
### Original Help Text
```text
usage: phertilizer [-h] -f FILE --bin_count_data BIN_COUNT_DATA
                   [--bin_count_normal BIN_COUNT_NORMAL]
                   [--snv_bin_mapping SNV_BIN_MAPPING] [-a ALPHA]
                   [--min_cells MIN_CELLS] [--min_snvs MIN_SNVS]
                   [--min_frac MIN_FRAC] [-j ITERATIONS] [-s STARTS] [-d SEED]
                   [--npass NPASS] [--radius RADIUS] [-c COPIES]
                   [--neutral_mean NEUTRAL_MEAN] [--neutral_eps NEUTRAL_EPS]
                   [-m PRED_MUT] [-n PRED_CELL] [-e PRED_EVENT] [--tree TREE]
                   [--tree_pickle TREE_PICKLE] [--tree_path TREE_PATH]
                   [--tree_list TREE_LIST] [--cell_lookup CELL_LOOKUP]
                   [--mut_lookup MUT_LOOKUP]

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  input file for variant and total read counts with
                        unlabled columns: [chr snv cell base var total]
  --bin_count_data BIN_COUNT_DATA
                        input binned read counts with headers containing bin
                        ids
  --bin_count_normal BIN_COUNT_NORMAL
                        input binned read counts for normal cells with
                        identical bins as the bin count data
  --snv_bin_mapping SNV_BIN_MAPPING
                        a comma delimited file with unlabeled columns: [snv
                        chr bin]
  -a ALPHA, --alpha ALPHA
                        per base read error rate
  --min_cells MIN_CELLS
                        smallest number of cells required to form a clone
  --min_snvs MIN_SNVS   smallest number of SNVs required to form a cluster
  --min_frac MIN_FRAC   smallest proportion of total cells(snvs) needed to
                        form a cluster, if min_cells or min_snvs are given,
                        min_frac is ignored
  -j ITERATIONS, --iterations ITERATIONS
                        maximum number of iterations
  -s STARTS, --starts STARTS
                        number of restarts
  -d SEED, --seed SEED  seed
  --npass NPASS
  --radius RADIUS
  -c COPIES, --copies COPIES
                        max number of copies
  --neutral_mean NEUTRAL_MEAN
                        center of neutral RDR distribution
  --neutral_eps NEUTRAL_EPS
                        cutoff of neutral RDR distribution
  -m PRED_MUT, --pred-mut PRED_MUT
                        output file for mutation clusters
  -n PRED_CELL, --pred_cell PRED_CELL
                        output file cell clusters
  -e PRED_EVENT, --pred_event PRED_EVENT
                        output file cna genotypes
  --tree TREE           output file for png (dot) of Phertilizer tree
  --tree_pickle TREE_PICKLE
                        output pickle of Phertilizer tree
  --tree_path TREE_PATH
                        path to directory where pngs of all trees are saved
  --tree_list TREE_LIST
                        pickle file to save a ClonalTreeList of all generated
                        trees
  --cell_lookup CELL_LOOKUP
                        output file that maps internal cell index to the input
                        cell label
  --mut_lookup MUT_LOOKUP
                        output file that maps internal mutation index to the
                        input mutation label
```

