# consel CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| consel | PASS |  |
| consel_catass | PASS | Extracting hypotheses 1 and 5 (-X) from mam15.ass gives trees {1,5,8} and {4,5,6}, as in the CONSEL user guide. |
| consel_catci | PASS | Printed the shipped example mam15.ci; the au confidence limits match the CONSEL user guide table. |
| consel_catmt | PASS | Joined mam15.mt and KH-prescreened it at 0.01 (15 to 9 trees, KH p-values agree with catpv); joining two copies gives N 6828. |
| consel_catpv | PASS | Printed the shipped example mam15.pv; all values equal the shipped mam15-pv.txt (tiny values now print as exponents). |
| consel_catrep | PASS | Joined two makerep rep files (B 2000 per scale); consel -R on the result gives au 0.746 and 0.057 as expected; note -m (rmt) mode needs --no_sort, since the default sort breaks rmt replicates. |
| consel_makerep | PASS | Made a rep file for the 2 edge hypotheses from mam15.lnf; consel -R gives au 0.729 and 0.059, close to the user guide values (0.749, 0.076). |
| consel_makermt | PASS | Made mam15.rmt from the CONSEL example mam15.lnf with k10s.pa; consel on it gives the same tree ranking and obs values as the shipped result and close p-values (au 0.757 vs 0.789 for tree 1). |
| consel_randrep | PASS | Generated 3 rep files from the example sim1.vt and short.pa with seed 333; consel -R reads them and gives p-values for 3 items. |
| consel_seqmt | PASS | Converted the CONSEL example PAML file mam15.lnf to mam15.mt with 15 trees and 3414 sites. |
| consel_treeass | PASS | With outgroup 6, mam15.ass from the example mam15.tpl is identical to the shipped result mam15.ass. |

## consel

### Tool Description
Assess the confidence of phylogenetic tree selection by calculating p-values for various statistical tests.

### Metadata
- **Docker Image**: quay.io/biocontainers/consel:0.20--h7b50bb2_3
- **Homepage**: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/
- **Package**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-09-26
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
# $Id: consel.c,v 1.20 2011/05/12 07:23:08 shimo Exp $
# reading from stdin
#! Terminated: cant read int.
```


## consel_seqmt

### Tool Description
Convert site-wise log-likelihoods from a phylogeny package (Molphy, PAML, PAUP*, TREE-PUZZLE, PhyML) to a CONSEL mt file.

### Metadata
- **Docker Image**: quay.io/biocontainers/consel:0.20--h7b50bb2_3
- **Homepage**: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/
- **Package**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-09-26
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
# $Id: seqmt.c,v 1.6 2010/01/29 16:46:04 shimo Exp $
#! Terminated: error in command line.

# No help is printed by the program; the usage below is from the CONSEL 0.20 source (src/seqmt.c) and user's guide (program.tex):
seqmt [options] [input [output]]
Convert site-wise log-likelihoods from a phylogeny package to an mt file.
Reads input (with the extension of the chosen format) and writes output.mt
(default output = input without extension; stdin/stdout if no file names).
Options:
  --molphy   input is a Molphy lls file
  --paml     input is a PAML lnf file
  --paup     input is a PAUP* site-likelihood text file (.txt)
  --puzzle   input is a TREE-PUZZLE sitelh file
  --phyml    input is a PhyML site-likelihood file
  -d INT     debug mode
```


## consel_makermt

### Tool Description
Generate multiscale bootstrap replicates (rmt file) from an mt file or phylogeny package output, as input for consel.

### Metadata
- **Docker Image**: quay.io/biocontainers/consel:0.20--h7b50bb2_3
- **Homepage**: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/
- **Package**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-09-26
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
# $Id: makermt.c,v 1.16 2010/01/29 16:45:36 shimo Exp $
#! Terminated: error in command line.

# No help is printed by the program; the usage below is from the CONSEL 0.20 source (src/makermt.c) and user's guide (program.tex):
makermt [options] [input [output]]
Generate multiscale bootstrap replicates (output.rmt, plus output.vt with the
observed log-likelihoods) from an mt file or from a phylogeny package output.
Options:
  -s INT     random seed (default 0: taken from the system clock)
  -p NAME    read scales and numbers of replicates from NAME.pa
  -b VAL     multiply the numbers of replicates by VAL
  -f         one scale only (r=1, B=10000), for rescaling approximation / SH tests
  -g         multiple input mode: input and output are svt files listing file names
  --molphy | --paml | --paup | --puzzle | --phyml   input file type (as seqmt)
  -d INT     debug mode
```


## consel_catpv

### Tool Description
Print the p-values stored in pv files made by consel.

### Metadata
- **Docker Image**: quay.io/biocontainers/consel:0.20--h7b50bb2_3
- **Homepage**: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/
- **Package**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-09-26
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
#! Terminated: error in command line.

# No help is printed by the program; the usage below is from the CONSEL 0.20 source (src/catpv.c) and user's guide (program.tex):
catpv [options] pv-file ...
Print the p-values stored in pv files made by consel.
Options:
  -v         print auxiliary information (pf, rss, df, d, c, th)
  -e         print the standard errors of the p-values
  -s INT     sort the lines (1: item, 2: obs, 3..: p-value column; negative = reverse)
  -r         output the list of rank, order and item
  -h         print the abbreviations
  -l INT     number added to the item labels (default 1)
  -t INT     number of items to aggregate
  -i INT     first item to aggregate
  -o NAME    aggregate the pv files and write NAME.out
  -c NAME    congruence: write the minimum p-values over the files to NAME.pv
  --no_au    suppress printing au and np
  --no_bp    suppress printing bp
  --no_pp    suppress printing pp
  --no_sh    suppress printing kh, sh, wkh and wsh
  --no_print suppress printing
  -d INT     debug mode
```


## consel_catci

### Tool Description
Print the confidence intervals stored in ci files made by consel.

### Metadata
- **Docker Image**: quay.io/biocontainers/consel:0.20--h7b50bb2_3
- **Homepage**: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/
- **Package**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-09-26
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
#! Terminated: error in command line.

# No help is printed by the program; the usage below is from the CONSEL 0.20 source (src/catci.c) and user's guide (program.tex):
catci [options] ci-file ...
Print the confidence intervals stored in ci files made by consel.
Options:
  -v         also print the standard errors and ei values
  --no_au    suppress the intervals of the au test
  --no_np    suppress the intervals of np
  -d INT     debug mode
```


## consel_treeass

### Tool Description
Find the associations between candidate tree topologies and their edges (ass file) for edge tests with consel -a.

### Metadata
- **Docker Image**: quay.io/biocontainers/consel:0.20--h7b50bb2_3
- **Homepage**: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/
- **Package**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-09-26
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
# $Id: treeass.c,v 1.7 2002/07/26 03:20:14 shimo Exp $
#! Terminated: error in command line.

# No help is printed by the program; the usage below is from the CONSEL 0.20 source (src/treeass.c) and user's guide (program.tex):
treeass [options] [tpl-file [output]]
Find the associations between tree topologies (tpl file) and their edges;
writes output.ass (default: input name without extension) and prints the
log (trees, leaves, edges, tree->edge and edge->tree tables) to stdout.
Options:
  --outgroup INT  index of the outgroup leaf
  -v NAME    select the trees listed in NAME.vt
  -l         the tpl file starts with the number of leaves
  -p         toggle printing the leaf labels in the log
  -d INT     debug mode
```


## consel_catass

### Tool Description
Join and manipulate association (ass) files.

### Metadata
- **Docker Image**: quay.io/biocontainers/consel:0.20--h7b50bb2_3
- **Homepage**: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/
- **Package**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-09-26
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
# $Id: catass.c,v 1.1 2001/06/22 05:05:55 shimo Exp $
#! Terminated: error in command line.

# No help is printed by the program; the usage below is from the CONSEL 0.20 source (src/catass.c) and user's guide (program.tex):
catass [options] ass-file ... output
Join and manipulate association (ass) files; writes output.ass.
With only one file name, writes the identity association (see -m).
Options:
  -m INT     number of items (identity association)
  -x NAME    extract the associations listed (0-based) in NAME.vt
  -X NAME    extract the associations listed (1-based ids) in NAME.vt
  -i         intersection
  -u         union
  -n         complement (not)
```


## consel_makerep

### Tool Description
Generate bootstrap replicates of the test statistics (rep file) for the hypotheses in an ass file.

### Metadata
- **Docker Image**: quay.io/biocontainers/consel:0.20--h7b50bb2_3
- **Homepage**: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/
- **Package**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-09-26
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
# $Id: makerep.c,v 1.5 2011/05/12 07:20:53 shimo Exp $
#! Terminated: error in command line.

# No help is printed by the program; the usage below is from the CONSEL 0.20 source (src/makerep.c) and user's guide (program.tex):
makerep [options] [input [output]]
Generate bootstrap replicates of the test statistics (output.rep) from an mt
file (or phylogeny package output) for the hypotheses in an ass file.
Options:
  -s INT     random seed
  -p NAME    read scales and numbers of replicates from NAME.pa
  -a NAME    read the associations (hypotheses) from NAME.ass
  --molphy | --paml | --paup | --puzzle   input file type (as seqmt)
```


## consel_catmt

### Tool Description
Join mt files along the sites, optionally prescreening the items by the KH test.

### Metadata
- **Docker Image**: quay.io/biocontainers/consel:0.20--h7b50bb2_3
- **Homepage**: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/
- **Package**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-09-26
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
# $Id: catmt.c,v 1.3 2001/08/10 06:04:55 shimo Exp $
#! Terminated: error in command line.

# No help is printed by the program; the usage below is from the CONSEL 0.20 source (src/catmt.c) and user's guide (program.tex):
catmt [options] mt-file ... output
Join mt files column-wise (sites) and write output.mt.
Options:
  --kht VAL  prescreen the items by the KH test at level VAL; the ids of the
             kept items are written to output.vt
  -d INT     debug mode
```


## consel_catrep

### Tool Description
Join and select rep (or rmt) files.

### Metadata
- **Docker Image**: quay.io/biocontainers/consel:0.20--h7b50bb2_3
- **Homepage**: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/
- **Package**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-09-26
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
# $Id: catrep.c,v 1.6 2001/08/10 06:03:10 shimo Exp $
#! Terminated: error in command line.

# No help is printed by the program; the usage below is from the CONSEL 0.20 source (src/catrep.c) and user's guide (program.tex):
catrep [options] rep-file ... output
Join and select rep (or rmt with -m) files; writes output.rep (or output.rmt).
Options:
  -m         input and output are rmt files
  -p NAME    keep only the scales listed in NAME.pa
  -e VAL     tolerance for matching scale values (default 0.005)
  -n         do not read the replicates (print the file information only)
  -a         write the output as ascii text
  -L         read the replicates in the long matrix format
  --no_sort  do not sort the scales
  -d INT     debug mode
```


## consel_randrep

### Tool Description
Random generation of rep or rmt files for simulations.

### Metadata
- **Docker Image**: quay.io/biocontainers/consel:0.20--h7b50bb2_3
- **Homepage**: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/
- **Package**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consel/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-09-26
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
# $Id: randrep.c,v 1.6 2011/05/12 07:22:30 shimo Exp $
#! Terminated: error in command line.

# No help is printed by the program; the usage below is from the CONSEL 0.20 source (src/randrep.c) and user's guide (program.tex):
randrep [options] [vt-file [output]]
Random generation of rep (or rmt with -m) files for simulations from a vt file.
Writes output.rep / output.rmt (with -r N: outputNN.rep ...).
Options:
  -s INT     random seed
  -p NAME    read scales and numbers of replicates from NAME.pa
  -r INT     number of repetitions (files)
  -f VAL     fluctuation scale (lambda)
  -m         generate rmt files instead of rep files
  --nonpara  nonparametric generation
  --model INT  model for the replicates (0: chi, 1: exponential)
  -d INT     debug mode
```


## Metadata
- **Skill**: not generated
