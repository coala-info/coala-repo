# gubbins CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gubbins_alignment_checker | PASS | tool repo alignment; per-sequence base count CSV and reformatted alignment written |
| gubbins_extract_gubbins_clade | PASS | 3-sequence clade from the Gubbins run; alignment, gff and tree written |
| gubbins_extract_gubbins_clade_statistics | PASS | three clades from the Gubbins run; clade statistics and recombination lengths written |
| gubbins_generate_ska_alignment | PASS | 4 real SARS-CoV-2 genomes from NCBI; alignment has the 29,903 reference length and plausible SNP counts |
| gubbins_mask_gubbins_aln | PASS | gff from the Gubbins run; 169 masked bases per sequence equals blocks 22-84 plus 110-215 |
| gubbins_plot_gubbins | PASS | tree and gff from the Gubbins run; PNG shows the expected recombination blocks |
| gubbins_run_gubbins | PASS | tool repo multiple_recombinations alignment (10 sequences); predicted blocks 22-84, 28-84, 29-49 and 110-215 match the repo's expected blocks |

## gubbins_run_gubbins

### Tool Description
Gubbins: rapid phylogenetic analysis of large samples of recombinant bacterial whole genome sequences. Detects recombination in a multifasta alignment and builds a recombination-free tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
- **Homepage**: https://github.com/nickjcroucher/gubbins
- **Package**: https://anaconda.org/channels/bioconda/packages/gubbins/overview
- **Validation**: PASS

### Original Help Text
```text
usage: run_gubbins.py [-h] [--prefix PREFIX] [--starting-tree STARTING_TREE]
                      [--date DATE] [--use-time-stamp] [--version]
                      [--threads THREADS] [--verbose] [--no-cleanup]
                      [--pairwise] [--filter-percentage FILTER_PERCENTAGE]
                      [--remove-identical-sequences]
                      [--tree-builder {raxml,raxmlng,iqtree,iqtree-fast,fasttree,hybrid,rapidnj,veryfasttree}]
                      [--tree-args TREE_ARGS]
                      [--first-tree-builder {raxml,raxmlng,iqtree,iqtree-fast,fasttree,rapidnj,star,veryfasttree}]
                      [--first-tree-args FIRST_TREE_ARGS]
                      [--outgroup OUTGROUP] [--bootstrap BOOTSTRAP]
                      [--transfer-bootstrap] [--sh-test] [--seed SEED]
                      [--invariant-site-correction]
                      [--model {JC,K2P,HKY,GTR,GTRGAMMA,GTRCAT}]
                      [--first-model {JC,K2P,HKY,GTR,GTRGAMMA,GTRCAT}]
                      [--best-model] [--custom-model CUSTOM_MODEL]
                      [--custom-first-model CUSTOM_FIRST_MODEL]
                      [--model-fitter {raxml,raxmlng,iqtree,fasttree,None}]
                      [--recon-model {JC,K2P,HKY,GTR,GTRGAMMA,GTRCAT}]
                      [--custom-recon-model CUSTOM_RECON_MODEL]
                      [--recon-with-dates]
                      [--model-fitter-args MODEL_FITTER_ARGS] [--mar]
                      [--seq-recon {raxml,raxmlng,iqtree,None}]
                      [--seq-recon-args SEQ_RECON_ARGS] [--min-snps MIN_SNPS]
                      [--min-window-size MIN_WINDOW_SIZE]
                      [--max-window-size MAX_WINDOW_SIZE] [--p-value P_VALUE]
                      [--trimming-ratio TRIMMING_RATIO] [--extensive-search]
                      [--iterations ITERATIONS]
                      [--converge-method {weighted_robinson_foulds,robinson_foulds,recombination}]
                      [--resume RESUME]
                      alignment_filename

Croucher N. J., Page A. J., Connor T. R., Delaney A. J., Keane J. A., Bentley
S. D., Parkhill J., Harris S.R. "Rapid phylogenetic analysis of large samples
of recombinant bacterial whole genome sequences using Gubbins". Nucleic Acids
Res. 2015 Feb 18;43(3):e15. doi: 10.1093/nar/gku1196.

optional arguments:
  -h, --help            show this help message and exit

Input and output options:
  alignment_filename    Multifasta alignment file
  --prefix PREFIX, -p PREFIX
                        Add a prefix to the final output filenames (default:
                        None)
  --starting-tree STARTING_TREE, -s STARTING_TREE
                        Starting tree (default: None)
  --date DATE, -D DATE  Two-column text file in which the second column is the
                        date of isolation in YYYY,YYYY-MM or YYYY-MM-DD format
                        (default: None)
  --use-time-stamp, -u  Use a time stamp in file names (default: False)
  --version             show program's version number and exit
  --threads THREADS, -c THREADS
                        Number of threads to use for parallelisation (default:
                        1)
  --verbose, -v         Turn on debugging (default: False)
  --no-cleanup, -n      Do not cleanup intermediate files (default: False)

Data processing options:
  --pairwise            Compare two sequences (without using a tree) (default:
                        False)
  --filter-percentage FILTER_PERCENTAGE, -f FILTER_PERCENTAGE
                        Filter out taxa with more than this percentage of gaps
                        (default: 25.0)
  --remove-identical-sequences, -d
                        Remove identical sequences (default: False)

Tree building options:
  --tree-builder {raxml,raxmlng,iqtree,iqtree-fast,fasttree,hybrid,rapidnj,veryfasttree}, -t {raxml,raxmlng,iqtree,iqtree-fast,fasttree,hybrid,rapidnj,veryfasttree}
                        Application to use for tree building (default: raxml)
  --tree-args TREE_ARGS
                        Quoted string of further arguments passed to tree
                        building algorithm (start string with a space if there
                        is a risk of being interpreted as a flag) (default:
                        None)
  --first-tree-builder {raxml,raxmlng,iqtree,iqtree-fast,fasttree,rapidnj,star,veryfasttree}
                        Application to use for building the first tree
                        (default: None)
  --first-tree-args FIRST_TREE_ARGS
                        Further arguments passed to first tree building
                        algorithm (default: None)
  --outgroup OUTGROUP, -o OUTGROUP
                        Outgroup name for rerooting. A list of comma separated
                        names can be used if they form a clade (default: None)
  --bootstrap BOOTSTRAP, -# BOOTSTRAP
                        Number of bootstrap replicates to perform with final
                        alignment (default: 0)
  --transfer-bootstrap  Calculate bootstrap supporting transfer bootstrap
                        expectation (default: False)
  --sh-test             Perform an SH test of node likelihoods (default:
                        False)
  --seed SEED           Set seed for reproducibility of analysis (default:
                        None)
  --invariant-site-correction
                        Correct for invariant sites (default: False)

Nucleotide substitution model options:
  --model {JC,K2P,HKY,GTR,GTRGAMMA,GTRCAT}, -M {JC,K2P,HKY,GTR,GTRGAMMA,GTRCAT}
                        Nucleotide substitution model (not all available for
                        all tree building algorithms) (default: None)
  --first-model {JC,K2P,HKY,GTR,GTRGAMMA,GTRCAT}
                        Nucleotide substitution model used for first tree
                        (default: None)
  --best-model          Automatically select best substitution model using
                        iqtree in later iterations (default: False)
  --custom-model CUSTOM_MODEL
                        String corresponding to a substitution model for the
                        selected tree building algorithm (default: None)
  --custom-first-model CUSTOM_FIRST_MODEL
                        String corresponding to a substitution model for the
                        selected tree building algorithm for the first
                        iteration (default: None)

Ancestral sequence reconstruction options:
  --model-fitter {raxml,raxmlng,iqtree,fasttree,None}, -F {raxml,raxmlng,iqtree,fasttree,None}
                        Application to use for model fitting for joint
                        ancestral state reconstruction [if unspecified: same
                        as tree builder if possible, else iqtree] (default:
                        None)
  --recon-model {JC,K2P,HKY,GTR,GTRGAMMA,GTRCAT}, -R {JC,K2P,HKY,GTR,GTRGAMMA,GTRCAT}
                        Nucleotide substitution model used for ancestral state
                        reconstruction (not all available for all tree
                        building algorithms) (default: GTRGAMMA)
  --custom-recon-model CUSTOM_RECON_MODEL
                        String corresponding to a substitution model for the
                        selected model fitting algorithm (default: None)
  --recon-with-dates    Use isolate date information in ancestral joint
                        sequence reconstruction (default: False)
  --model-fitter-args MODEL_FITTER_ARGS
                        Further arguments passed to model fitting algorithm
                        (default: None)
  --mar                 Use marginal, rather than joint, ancestral
                        reconstruction (default: False)
  --seq-recon {raxml,raxmlng,iqtree,None}
                        Algorithm to use for marginal reconstruction [if
                        unspecified: same as tree builder if possible, else
                        iqtree; requires --mar flag] (default: None)
  --seq-recon-args SEQ_RECON_ARGS
                        Further arguments passed to sequence reconstruction
                        algorithm (start string with a space if there is a
                        risk of being interpreted as a flag) (default: None)

Recombination detection options:
  --min-snps MIN_SNPS, -m MIN_SNPS
                        Min SNPs to identify a recombination block (default:
                        3)
  --min-window-size MIN_WINDOW_SIZE, -a MIN_WINDOW_SIZE
                        Minimum window size (default: 100)
  --max-window-size MAX_WINDOW_SIZE, -b MAX_WINDOW_SIZE
                        Maximum window size (default: 10000)
  --p-value P_VALUE     Uncorrected p value used to identify recombinations
                        (default: 0.05)
  --trimming-ratio TRIMMING_RATIO
                        Ratio of log probabilities used to trim recombinations
                        (default: 1.0)
  --extensive-search    Undertake slower, more thorough, search for
                        recombination (default: False)

Algorithm start/stop options:
  --iterations ITERATIONS, -i ITERATIONS
                        Maximum No. of iterations (default: 5)
  --converge-method {weighted_robinson_foulds,robinson_foulds,recombination}, -z {weighted_robinson_foulds,robinson_foulds,recombination}
                        Criteria to use to know when to halt iterations
                        (default: weighted_robinson_foulds)
  --resume RESUME       Intermediate tree from previous run (must include
                        "iteration_X" in file name) (default: None)
```

## gubbins_mask_gubbins_aln

### Tool Description
Mask recombinant regions detected by Gubbins from the input alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
- **Homepage**: https://github.com/nickjcroucher/gubbins
- **Package**: https://anaconda.org/channels/bioconda/packages/gubbins/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mask_gubbins_aln [-h] --aln ALN --gff GFF --out OUT [--out-fmt OUT_FMT]
                        [--missing-char MISSING_CHAR]

Mask recombinant regions detected by Gubbins from the input alignment

optional arguments:
  -h, --help            show this help message and exit
  --aln ALN             Input alignment (FASTA format)
  --gff GFF             GFF of recombinant regions detected by Gubbins
  --out OUT             Output file name
  --out-fmt OUT_FMT     Format of output alignment
  --missing-char MISSING_CHAR
                        Character used to replace recombinant sequence
```

## gubbins_alignment_checker

### Tool Description
Script to evaluate and reformat an alignment prior to Gubbins analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
- **Homepage**: https://github.com/nickjcroucher/gubbins
- **Package**: https://anaconda.org/channels/bioconda/packages/gubbins/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gubbins_alignment_checker.py [-h] --aln ALN [--out-aln OUT_ALN] --out
                                    OUT

Script to evaluate and reformat an alignment prior to Gubbins analysis

optional arguments:
  -h, --help         show this help message and exit
  --aln ALN, -a ALN  Multifasta alignment filename (default: None)
  --out-aln OUT_ALN  Reformatted alignment filename (default: None)
  --out OUT, -o OUT  Output CSV filename (default: None)
```

## gubbins_extract_gubbins_clade

### Tool Description
Extract a clade from a Gubbins output

### Metadata
- **Docker Image**: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
- **Homepage**: https://github.com/nickjcroucher/gubbins
- **Package**: https://anaconda.org/channels/bioconda/packages/gubbins/overview
- **Validation**: PASS

### Original Help Text
```text
usage: extract_gubbins_clade [-h] --list LIST --aln ALN --gff GFF --tree TREE
                             --out OUT [--out-fmt OUT_FMT]
                             [--missing-char MISSING_CHAR]

Extract a clade from a Gubbins output

optional arguments:
  -h, --help            show this help message and exit
  --list LIST           List of sequences to extract
  --aln ALN             Input alignment (FASTA format)
  --gff GFF             GFF of recombinant regions detected by Gubbins
  --tree TREE           Final tree generated by Gubbins
  --out OUT             Output file prefix
  --out-fmt OUT_FMT     Format of output alignment
  --missing-char MISSING_CHAR
                        Character used to replace recombinant sequence
```

## gubbins_extract_gubbins_clade_statistics

### Tool Description
Extract a clade from a Gubbins output (per-clade recombination statistics)

### Metadata
- **Docker Image**: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
- **Homepage**: https://github.com/nickjcroucher/gubbins
- **Package**: https://anaconda.org/channels/bioconda/packages/gubbins/overview
- **Validation**: PASS

### Original Help Text
```text
usage: extract_gubbins_clade [-h] --clades CLADES --gff GFF --snps SNPS
                             [--exclude-regions EXCLUDE_REGIONS] --tree TREE
                             [--print-trees] [--print-rec-lengths] --out OUT

Extract a clade from a Gubbins output

optional arguments:
  -h, --help            show this help message and exit
  --clades CLADES       Two column file assigning isolates (first column) to
                        clades (second column)
  --gff GFF             recombination prediction GFF file output by Gubbins
  --snps SNPS           branch base reconstruction EMBL file output by Gubbins
  --exclude-regions EXCLUDE_REGIONS
                        Two column file specifying start and end of regions to
                        be excluded
  --tree TREE           Labelled tree output by Gubbins
  --print-trees         Print clade trees
  --print-rec-lengths   Print recombination lengths
  --out OUT             Output file prefix; suffix is "_clades.csv"
```

## gubbins_generate_ska_alignment

### Tool Description
Generate a ska2 alignment from a list of assemblies

### Metadata
- **Docker Image**: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
- **Homepage**: https://github.com/nickjcroucher/gubbins
- **Package**: https://anaconda.org/channels/bioconda/packages/gubbins/overview
- **Validation**: PASS

### Original Help Text
```text
usage: generate_ska_alignment [-h] --reference REFERENCE [--input INPUT] --out
                              OUT [--k K] [--threads THREADS] [--no-cleanup]

Generate a ska2 alignment from a list of assemblies

optional arguments:
  -h, --help            show this help message and exit
  --reference REFERENCE
                        Name of reference sequence to use for alignment
  --input INPUT         List of sequence data; one row per isolate, with first
                        column being the isolate name
  --out OUT             Name of output alignment
  --k K                 Split kmer size
  --threads THREADS     Number of threads to use
  --no-cleanup          Do not remove intermediate files
```

## gubbins_plot_gubbins

### Tool Description
Produce publication-ready figures of Gubbins analyses

### Metadata
- **Docker Image**: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
- **Homepage**: https://github.com/nickjcroucher/gubbins
- **Package**: https://anaconda.org/channels/bioconda/packages/gubbins/overview
- **Validation**: PASS

### Original Help Text
```text
Warning: Your system is mis-configured: ‘/var/db/timezone/localtime’ is not a symlink
Warning: ‘/var/db/timezone/localtime’ is not identical to any known timezone file
Warning message:
Failed to locate timezone database 
usage: plot_gubbins.R [--] [--help] [--no-heatmap] [--show-taxa]
       [--annotation-labels] [--opts OPTS] [--tree TREE] [--rec REC]
       [--annotation ANNOTATION] [--markup MARKUP] [--meta META]
       [--clades CLADES] [--output OUTPUT] [--tree-width TREE-WIDTH]
       [--meta-width META-WIDTH] [--annotation-height
       ANNOTATION-HEIGHT] [--markup-height MARKUP-HEIGHT]
       [--heatmap-height HEATMAP-HEIGHT] [--legend-height
       LEGEND-HEIGHT] [--start-coordinate START-COORDINATE]
       [--end-coordinate END-COORDINATE] [--heatmap-y-nudge
       HEATMAP-Y-NUDGE] [--heatmap-x-nudge HEATMAP-X-NUDGE]
       [--legend-direction LEGEND-DIRECTION] [--taxon-label-size
       TAXON-LABEL-SIZE] [--meta-label-size META-LABEL-SIZE]
       [--max-branch-length MAX-BRANCH-LENGTH] [--branch-width
       BRANCH-WIDTH] [--tree-axis-expansion TREE-AXIS-EXPANSION]
       [--output-height OUTPUT-HEIGHT] [--output-width OUTPUT-WIDTH]

plot_gubbins.R: Producing publication-ready figures of Gubbins analyses

flags:
  -h, --help              show this help message and exit
  -n, --no-heatmap        Do not plot recombination heatmap
  --show-taxa             Show taxa names on tree
  --annotation-labels     Show GFF gene names on annotation

optional arguments:
  -x, --opts              RDS file containing argument values
  -t, --tree              Gubbins tree (Newick file)
  -r, --rec               Gubbins recombination inference (GFF file)
  -a, --annotation        Reference genome annotation (GFF file)
  -m, --markup            Genome loci to mark (CSV file; columns are
                          'start','end','label')
  --meta                  Metadata for each sequence (CSV file; first
                          column is 'id')
  -c, --clades            Assignment of taxa to clades (CSV file;
                          columns are 'id','clade')
  -o, --output            Output file name (PNG or PDF suffix)
  --tree-width            Width of tree relative to recombination panel
                          [default: 0.4]
  --meta-width            Width of metadata panel relative to
                          recombination panel [default: 0.25]
  --annotation-height     Height of annotation panel relative to
                          recombination panel [default: 0.05]
  --markup-height         Height of markup panel relative to
                          recombination panel [default: 0.075]
  --heatmap-height        Height of heatmap relative to recombination
                          panel [default: 0.025]
  -l, --legend-height     Height of legends relative to recombination
                          panel [default: 0.25]
  -s, --start-coordinate  Left boundary of genomic region to plot
  -e, --end-coordinate    Right boundary of genomic region to plot
  --heatmap-y-nudge       Size of metadata labels [default: 0]
  --heatmap-x-nudge       Size of metadata labels [default: 0]
  --legend-direction      Orientation of legends (horizontal or
                          vertical)
  --taxon-label-size      Size of taxon labels [default: 4]
  --meta-label-size       Size of metadata labels [default: 4]
  --max-branch-length     Maximum length at which to truncate branches
                          [default: Inf]
  -b, --branch-width      Width of branches on tree plot [default:
                          0.25]
  --tree-axis-expansion   Space between tree and right panel [default:
                          5]
  --output-height         Height of output file (inches) [default: 8]
  --output-width          Width of output file (inches) [default: 11]
```

