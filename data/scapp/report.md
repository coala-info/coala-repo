# scapp CWL Generation Report

## scapp

### Tool Description
SCAPP extracts likely plasmids from de novo assembly graphs

### Metadata
- **Docker Image**: quay.io/biocontainers/scapp:0.1.4--py_0
- **Homepage**: https://github.com/Shamir-Lab/SCAPP
- **Package**: https://anaconda.org/channels/bioconda/packages/scapp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scapp/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Shamir-Lab/SCAPP
- **Stars**: N/A
### Original Help Text
```text
usage: scapp [-h] -g GRAPH -o OUTPUT_DIR [-k MAX_K] [-l MIN_LENGTH]
             [-m MAX_CV] [-p NUM_PROCESSES] [-sc USE_SCORES]
             [-gh USE_GENE_HITS] [-b BAM] [-r1 READS1] [-r2 READS2]
             [-pc PLASCLASS | -pf PLASFLOW] [-clft CLASSIFICATION_THRESH]
             [-gm GENE_MATCH_THRESH] [-sls SELFLOOP_SCORE_THRESH]
             [-slm SELFLOOP_MATE_THRESH] [-cst CHROMOSOME_SCORE_THRESH]
             [-clt CHROMOSOME_LEN_THRESH] [-pst PLASMID_SCORE_THRESH]
             [-plt PLASMID_LEN_THRESH] [-cd GOOD_CYC_DOMINATED_THRESH]

SCAPP extracts likely plasmids from de novo assembly graphs

optional arguments:
  -h, --help            show this help message and exit
  -g GRAPH, --graph GRAPH
                        Assembly graph FASTG file to process
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Output directory
  -k MAX_K, --max_k MAX_K
                        Integer reflecting maximum k value used by the
                        assembler
  -l MIN_LENGTH, --min_length MIN_LENGTH
                        Minimum length required for reporting [default: 1000]
  -m MAX_CV, --max_CV MAX_CV
                        Coefficient of variation used for pre-selection
                        [default: 0.5, higher--> less restrictive]
  -p NUM_PROCESSES, --num_processes NUM_PROCESSES
                        Number of processes to use
  -sc USE_SCORES, --use_scores USE_SCORES
                        Boolean flag of whether to use sequence classification
                        scores in plasmid assembly
  -gh USE_GENE_HITS, --use_gene_hits USE_GENE_HITS
                        Boolean flag of whether to use plasmid-specific gene
                        hits in plasmid assembly
  -b BAM, --bam BAM     BAM file resulting from aligning reads to contigs
                        file, filtering for best matches
  -r1 READS1, --reads1 READS1
                        1st paired-end read file path
  -r2 READS2, --reads2 READS2
                        1st paired-end read file path
  -pc PLASCLASS, --plasclass PLASCLASS
                        PlasClass score file with scores of the assembly graph
                        nodes
  -pf PLASFLOW, --plasflow PLASFLOW
                        PlasFlow score file with scores of the assembly graph
                        nodes
  -clft CLASSIFICATION_THRESH, --classification_thresh CLASSIFICATION_THRESH
                        threshold for classifying potential plasmid [0.5]
  -gm GENE_MATCH_THRESH, --gene_match_thresh GENE_MATCH_THRESH
                        threshold for % identity and fraction of length to
                        match plasmid genes [0.75]
  -sls SELFLOOP_SCORE_THRESH, --selfloop_score_thresh SELFLOOP_SCORE_THRESH
                        threshold for self-loop plasmid score [0.9]
  -slm SELFLOOP_MATE_THRESH, --selfloop_mate_thresh SELFLOOP_MATE_THRESH
                        threshold for self-loop off loop mates [0.1]
  -cst CHROMOSOME_SCORE_THRESH, --chromosome_score_thresh CHROMOSOME_SCORE_THRESH
                        threshold for high confidence chromosome node score
                        [0.2]
  -clt CHROMOSOME_LEN_THRESH, --chromosome_len_thresh CHROMOSOME_LEN_THRESH
                        threshold for high confidence chromosome node length
                        [10000]
  -pst PLASMID_SCORE_THRESH, --plasmid_score_thresh PLASMID_SCORE_THRESH
                        threshold for high confidence plasmid node score [0.9]
  -plt PLASMID_LEN_THRESH, --plasmid_len_thresh PLASMID_LEN_THRESH
                        threshold for high confidence plasmid node length
                        [10000]
  -cd GOOD_CYC_DOMINATED_THRESH, --good_cyc_dominated_thresh GOOD_CYC_DOMINATED_THRESH
                        threshold for # of mate-pairs off the cycle in
                        dominated node [0.5]
```

