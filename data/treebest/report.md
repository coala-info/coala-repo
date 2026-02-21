# treebest CWL Generation Report

## treebest_nj

### Tool Description
Neighbor-joining tree building using various distance metrics and models.

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/treebest/overview
- **Total Downloads**: 22.6K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/lh3/treebest
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

Usage  : treebest nj [options] <input_file>

Options: -c FILE    constrained tree(s) in NH format [null]
         -m FILE    tree to be compared [null]
         -s FILE    species tree in NH format [default taxa tree]
         -l FILE    ingroup list file [null]
         -t TYPE    codon NT: ntmm, dn, ds, dm; AA: mm, jtt, kimura [mm]
                    ntmm    p-distance (codon alignment)
                    dn      non-synonymous distance
                    ds      synonymous distance
                    dm      dn-ds merge (tree merge)
                    mm      p-distance (amino acid alignment)
                    jtt     JTT model (maximum likelihood)
                    kimura  mm + Kimura's correction
         -T NUM     time limit in seconds [no limit]
         -b NUM     bootstrapping times [100]
         -F NUM     quality cut-off [15]
         -o STR     outgroup for tree cutting [Bilateria]
         -S         treat the first constrained tree as the original tree
         -C         use the leaves of constrained trees as ingroup
         -M         do not apply alignment mask
         -N         do not mask poorly aligned segments
         -g         collapse alternative splicing
         -R         do not apply leaf-reordering
         -p         the root node is a putative node
         -a         branch mode that is used by most tree-builder
         -A         the input alignment is stored in ALN format
         -W         wipe out root (SDI information will be lost!)
         -I         copy the branch support tags from the constrained tree
         -v         verbose output
         -h         help
```


## treebest_best

### Tool Description
Estimate the best gene tree given a CDS alignment, using PHYML and species tree information.

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

Usage  : treebest best [options] <CDS_alignment>

General Options:

         -P          skip PHYML
         -S          ignore the prob. of gene evolution (NOT recommended)
         -A          apply constraint to PHYML
         -C FILE     constraining tree                               [null]
         -f FILE     species tree                                 [default]
         -r          discard species that do not appear at all

         -I          skip the mmerge step and use the constraining tree instead

Output Options:

         -D          output some debug information
         -q          suppress part of PHYML warnings
         -p STR      prefix of intermediate trees                    [null]
         -o FILE     output tree                                     [null]

Alignment Preprocessing Options:

         -s          only build tree for genes from sequenced species
         -g          collapse alternative splicing forms
         -N          do not mask low-scoring segments
         -F INT      quality cut-off                                   [11]

PHYML Related Options:

         -c INT      number of rate categories for PHYML-HKY            [2]
         -k FLOAT|e  tv/ts ratio (kappa), 'e' for estimatinig           [e]
         -a FLOAT|e  alpha parameter for Gamma distribution           [1.0]
         -d FLOAT    duplication probability                         [0.15]
         -l FLOAT    porbability of a loss following a speciation    [0.10]
         -L FLOAT    porbability of a loss following a duplication   [0.20]
         -b FLOAT    prob. of the presence of an inconsistent branch [0.01]

Note:    If you use this module in your work, please cite:

         Guindon S. and Gascuel O. (2003) A simple, fast, and accurate
           algorithm to estimate large phylogenies by maximum likelihood.
           Syst Biol, 52(5), 696-704
```


## treebest_phyml

### Tool Description
Estimate phylogenies by maximum likelihood using TreeFam extensions and the PhyML algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

Usage:   treebest phyml [options] <alignment> [<tree>]

General Options:

         -t task     build | opt | loglk | dist                          [build]
         -n          the input is a nucleotide alignment
         -s          print out some statistics
         -N          do not mask low-scoring segments
         -g          collapse alternative splicing
         -b INT      number of bootstraps (slow)                             [0]
         -o FILE     write output to file                               [stdout]
         -F INT      quality cut-off                                        [15]

Model Related Options:

         -m model    nt: JC69 | K2P | F81 | HKY | F84 | TN93 | GTR         [HKY]
                     aa: JTT | MtREV | Dayhoff | WAG                       [WAG]
         -c INT      number of relative substitution rate categories         [1]
         -k FLOAT|e  transversion/transition ratio, 'e' for estimatinig      [e]
         -a FLOAT|e  alpha parameter for Gamma distribution                [1.0]
         -i FLOAT|e  proportion of invariable sites                          [0]

Options for TreeFam Extensions:

         -S          use a species tree to guide tree building
         -f FILE     species tree                         [TreeFam species tree]
         -d FLOAT    duplication probability                              [0.15]
         -l FLOAT    porbability of a loss following a speciation         [0.10]
         -L FLOAT    probability of a loss following a duplication        [0.20]
         -C FILE     constraining tree                                    [NULL]
         -p FLOAT    prob. of the presence of an inconsistent branch      [0.01]

Note:    Do not calculate distance for multiple rate categories. This is might
         be wrong due to my false implementation.

         If you use this module in your work, please cite:

         Guindon S. and Gascuel O. (2003) A simple, fast, and accurate algorithm to
           estimate large phylogenies by maximum likelihood. Syst Biol, 52(5), 696-704
```


## treebest_sdi

### Tool Description
TreeBest SDI (Speciation Duplication Inference) tool for rooting and comparing gene trees with species trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

Usage  : treebest sdi [-r|-H|-R|-m <tree0>|-l <spec_list>] <tree>

Options: -r         reroot
         -c         use core species tree instead of the default one
         -H         reroot by minimizing tree height, instead of by
                    minimizing the number of duplication events.
         -R         do not reorder the leaves.
         -s FILE    species tree [default taxa tree]
         -l FILE    cut a subtree that contains genes whose species exist in list [null]
         -m FILE    compare topology with FILE and re-order the leaves [null]
```


## treebest_spec

### Tool Description
A species tree in Newick format used by TreeBest for gene tree reconstruction and species tree reconciliation. It defines the phylogenetic relationships and taxonomy IDs for various eukaryotic species.

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
((ORYSA*-4530.rice,ARATH*-3702)Magnoliophyta-3398,(SCHPO*-4896.S_pombe,YEAST*-4932)Ascomycota-4890,
 ((((((((((((HUMAN*-9606,PANTR*-9598.chimpanzee)Homo/Pan/Gorilla-207598, 
            MACMU*-9544.monkey)Catarrhini-9526, 
            OTOGA-*30611.galago)Primates-9443, 
         ((MOUSE*-10090,RAT*-10116)Murinae-39107,RABIT-9986)Glires-314147)Euarchontoglires-314146, 
        ((BOVIN*-9913.cow,PIG-*9823)Cetartiodactyla-91561, 
         (CANFA*-9615.dog,FELCA-*9685.cat)Carnivora-33554, 
         SORAR-*42254.shrew, 
         MYOLU-*59463.bat)Laurasiatheria-314145, 
        (ECHTE-9371.tenrec,LOXAF-9785.elephant)Afrotheria-311790, 
        DASNO-9361.armadillo)Eutheria-9347,MONDO*-13616.opossum)Theria-32525,
       ORNAN-*9258.platypus)Mammalia-40674,
      CHICK*-9031)Amniota-32524,
     XENTR*-8364.frog)Tetrapoda-32523,
    (BRARE*-7955.zebrafish, 
     ((TETNG*-99883.pufferfish,FUGRU*-31033.pufferfish)Tetraodontidae-31031,
      (GASAC*-69293.stickleback,ORYLA*-8090.ricefish)Smegmamorpha-129949)Percomorpha-32485)Clupeocephala-186625)Euteleostomi-117571,
   (CIOIN*-7719,CIOSA*-51511)Ciona-7718)Chordata-7711,
  (((DROME*-7227.fly,DROPS*-7237.fly)Sophophora-32341,
    (AEDAE*-7159.mosquito,ANOGA*-7165.mosquito)Culicidae-7157)Diptera-7147, 
   APIME-*7460.honeybee)Endopterygota-33392,
  SCHMA*-6183.fluke,
  (CAEEL*-6239.worm,CAEBR*-6238.worm,CAERE*-31234.worm)Caenorhabditis-6237)Bilateria-33213)Eukaryota-2759;
```


## treebest_format

### Tool Description
Format a tree using treebest

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Usage:   treebest format [-1] <tree>
```


## treebest_filter

### Tool Description
Filter alignments using TreeBest

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

Usage:   treebest filter [options] <alignment>

Options: -n         nucleotide alignment
         -g         collapse alternative splicing
         -M         do not apply alignment mask
         -N         do not mask low-scoring segments
         -F NUM     quality cut-off [15]
```


## treebest_trans

### Tool Description
Translate a nucleotide alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Usage: treebest trans <nucl_alignment>
```


## treebest_backtrans

### Tool Description
Back-translate an amino acid alignment to a nucleotide alignment using nucleotide sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Usage: treebest backtrans [-t <thres>] <aa_aln> <nt_seq>
```


## treebest_leaf

### Tool Description
TreeBest leaf command (Note: The provided help text indicates the tool failed to recognize the --help flag and instead attempted to open it as a file).

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
[tr_get_fp] fail to open file --help
```


## treebest_mfa2aln

### Tool Description
Convert MFA (Multi-FASTA) to alignment format

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Usage: treebest mfa2aln [-n] <fasta_align>
```


## treebest_ortho

### Tool Description
TreeBest orthology analysis (Note: The tool failed to provide a standard help menu and instead attempted to open '--help' as a file, suggesting it may primarily accept file paths as positional arguments).

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
[tr_get_fp] fail to open file --help
```


## treebest_distmat

### Tool Description
Calculate a distance matrix from a sequence alignment using various evolutionary models.

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Usage: treebest distmat <dn|ds|dm|jtt|kimura|mm|dns> <alignment>
```


## treebest_treedist

### Tool Description
Calculate the distance between two trees

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Usage: treebest treedist <tree1> <tree2>
```


## treebest_pwalign

### Tool Description
PairWise ALIGNment tool for nt2nt, aa2aa, nt2aa, or splice alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

Program : pwalign (PairWise ALIGNment tool)
Version : 0.1.5, on May 3, 2006
Contact : liheng@genomics.org.cn

Usage   : pwalign [options] <nt2nt|aa2aa|nt2aa|splice> <seq1> <seq2>

Options : -f       generate full alignment
          -a       do not apply matrix mean in local alignment
          -d       just calculate alignment boundaries
          -o NUM   gap open penalty
          -e NUM   gap extension penalty
          -n NUM   gap end penalty for nt2nt or aa2aa
          -s NUM   frame-shift penalty for aa2nt
          -g NUM   good splicing penalty
          -w NUM   band-width
          -b NUM   bad splicing penalty
          -m       output miscellaneous information
          -h       help
```


## treebest_mmerge

### Tool Description
Merge multiple trees into a forest or reroot trees

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

Usage  : treebest mmerge [-r] <forest>

Options: -r         reroot
         -s FILE    species tree [default taxa tree]
```


## treebest_export

### Tool Description
Export a tree to a graphical format

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

Usage:   treebest export [options] <tree>

Options: -x NUM      width [640]
         -y NUM      height [480]
         -m NUM      margin [20]
         -f NUM      font size [11]
         -b FNUM     box size [4.0]
         -w FNUM     font width [font_size/2]
         -s FILE     species tree
         -B          suppress bootstrap value
         -M          black/white mode
         -S          show species name
         -d          speciation/duplication inference
         -p          pseudo-length
```


## treebest_subtree

### Tool Description
Extract a subtree from a tree based on a list of nodes

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Usage: treebest subtree <tree> <list>
```


## treebest_simulate

### Tool Description
Simulate gene trees given a species tree using a duplication-loss model.

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
(((0000_CAERE:0.1875,
0001_CAEBR:0.1875,
0002_CAEEL:0.1875
)Caenorhabditis:0.0208333,
0003_SCHMA:0.208333,
((0004_ANOGA:0.166667,
0005_AEDAE:0.166667
)Culicidae:0.0208333,
(0006_DROPS:0.166667,
0007_DROME:0.166667
)Sophophora:0.0208333
)Diptera:0.0208333,
((0008_CIOSA:0.166667,
0009_CIOIN:0.166667
)Ciona:0.0208333,
((((0010_ORYLA:0.104167,
0011_GASAC:0.104167
)Smegmamorpha:0.0208333,
((0012_FUGRU:0.104167,
0013_TETNG:0.104167
)Tetraodontidae:0.0104167,
(0014_FUGRU:0.104167,
0015_TETNG:0.104167
)Tetraodontidae:0.0104167
)Tetraodontidae:0.0104167
)Percomorpha:0.0208333,
0016_BRARE:0.145833
)Clupeocephala:0.0208333,
(0017_XENTR:0.145833,
(0018_CHICK:0.125,
(0019_MONDO:0.114583,
(0020_MONDO:0.104167,
((0021_CANFA:0.0625,
0022_BOVIN:0.0625
)Laurasiatheria:0.0208333,
((0023_RAT:0.0416667,
0024_MOUSE:0.0416667
)Murinae:0.0208333,
(0025_MACMU:0.0416667,
(0026_PANTR:0.0208333,
0027_HUMAN:0.0208333
)Homo/Pan/Gorilla:0.0208333
)Catarrhini:0.0208333
)Euarchontoglires:0.0208333
)Eutheria:0.0208333
)Theria:0.0104167
)Theria:0.0104167
)Amniota:0.0208333
)Tetrapoda:0.0208333
)Euteleostomi:0.0208333
)Chordata:0.0208333
)Bilateria:0.0208333,
((0028_YEAST:0.104167,
0029_YEAST:0.104167
)YEAST:0.104167,
0030_SCHPO:0.208333
)Ascomycota:0.0208333,
(0031_ARATH:0.208333,
0032_ORYSA:0.208333
)Magnoliophyta:0.0208333
)Eukaryota:0.0208333;
```


## treebest_sortleaf

### Tool Description
Sort leaves in a tree file

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Usage: treebest sortleaf <tree1> [<tree2>]
```


## treebest_estlen

### Tool Description
Estimate branch lengths for a tree given a distance matrix and a tag.

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Usage: treebest estlen <tree> <matrix> <tag>
```


## treebest_trimpoor

### Tool Description
Trim poor branches from a tree based on a threshold.

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
treebest trimpoor <tree> [<threshold>=0]
```


## treebest_root

### Tool Description
Root a phylogenetic tree. (Note: The provided help text was an error message indicating the tool does not support --help and instead expected a file path.)

### Metadata
- **Docker Image**: quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2
- **Homepage**: https://github.com/lh3/treebest
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
[tr_get_fp] fail to open file --help
```


## Metadata
- **Skill**: not generated
