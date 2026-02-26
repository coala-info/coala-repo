# rappas CWL Generation Report

## rappas

### Tool Description
Rapid Alignment-free Phylogenetic Placement via Ancestral Sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/rappas:1.22--hdfd78af_0
- **Homepage**: https://github.com/blinard-BIOINFO/RAPPAS
- **Package**: https://anaconda.org/channels/bioconda/packages/rappas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rappas/overview
- **Total Downloads**: 10.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/blinard-BIOINFO/RAPPAS
- **Stars**: N/A
### Original Help Text
```text
################################################
## RAPPAS v1.22
## ---------------------------------------------
## Rapid Alignment-free Phylogenetic Placement 
## via Ancestral Sequences
## Linard B, Swenson KM, Pardi F.
## LIRMM, Univ. of Montpellier, CNRS, France
## Citation:
## https://doi.org/10.1093/bioinformatics/btz068
## benjamin/dot/linard/at/lirmm/dot/fr
################################################

--------------------------------------------------------------------
 Minimum usage:

 1. For building the phylo-kmers database:
    java -jar RAPPAS.jar -p b -s [nucl|amino] -b ARbinary 
    -w workdir -r alignment.fasta -t tree.newick
   
 2. For placing sequences, using the database (DB) built in step 1:
    java -jar RAPPAS.jar -p p -d DB.union -q queries.fa 
    
 Note: For large references or high values of k, allocate more RAM :
       ex: java -Xms1024m -Xmx16g -jar RAPPAS.jar [options] 
       -Xms -> memory allocated at startup. (m=MegaByte, g=GigaByte)
       -Xmx -> maximum memory allocated to the process.  
---------------------------------------------------------------------

Main options:     Default values are in [].
---------------------------------------------------------------------
-b (--arbinary)   [file] Binary for marginal AR, currently 'phyml' and 
                  'baseml' (from PAML) are supported. (b phase)
-d (--database)   [file] The database of ancestral kmers. (b|p phase) 
-p (--phase)      [b|p] One of 'b' for "Build" or 'p' for "Place"
                  b: Build DB of phylo-kmers (done 1 time). 
                  p: Phylogenetic placement itself (done n times)
                     requires the DB generated during 'build' phase.
-r (--refalign)   [file] Reference alignment in fasta format.
                  It must be the multiple alignment from which was 
                  built the reference tree loaded with -t. (b phase) 
-s (--states)     ['nucl'|'amino'] States used in analysis. (b|p phase) 
-t (--reftree)    [file] Reference tree, in newick format.
-q (--queries)    [file[,file,...]] Fasta queries to place on the tree.
                  Can be a list of files separated by ','. (b|p phase)
-v (--verbosity)  [0] Verbosity level: -1=none ; 0=default ; 1=high
-w (--workdir)    [path] Working directory for temp files. (b|p phase)

Outputs options:  Jplace, log files...  
---------------------------------------------------------------------
--keep-at-most    [7] Max number of placement per query kept in 
                  the jplace output. (p phase)
--keep-factor     [0.01] Report placement with likelihood_ratio higher
                  than (factor x best_likelihood_ratio). (p phase)
--write-reduction [file] Write reduced alignment to file. (b phase)
--guppy-compat    [] Ensures output is Guppy compatible. (p phase)
--dbfilename      [string] Set DB filename. (b phase)

Algo options:     Use only if you know what you are doing...    
---------------------------------------------------------------------
-a (--alpha)      [1.0] Gammma shape parameter used in AR . (b phase)
-c (--categories) [4] # categories used in AR . (b phase)
-g (--ghosts)     [1] # ghost nodes injected per branches. (b phase)
-k (--k)          [8] k-mer length used at DB build. (b mode)
-m (--model)      [GTR|LG] Model used in AR, one of the following:
                  nucl  : JC69, HKY85, K80, F81, TN93, GTR 
                  amino : LG, WAG, JTT, Dayhoff, DCMut, CpREV,
                          mMtREV, MtMam, MtArt 
--arparameters    [string] Parameters passed to the software used for
                  anc. seq. reconstuct. Overrides -a,-c,-m options.
                  Value must be quoted by ' or ". Do not set options
                  -i,-u,--ancestral (managed by RAPPAS). (b phase)
                  PhyML example: "-m HIVw -c 10 -f m -v 0.0 --r_seed 1"
--convertUO       [] U,O amino acids are converted to C,L. (b|p phase)
--force-root      [] Root input tree (if unrooted) by adding a root
                  node on righmost branch of the trifurcation.(b phase)
--gap-jump-thresh [0.3] Gap ratio above which gap jumps are activated.
--no-reduction    [] Do not operate alignment reduction. This will 
                  keep all sites of input reference alignment and 
                  may produce erroneous ancestral k-mers. (b phase)
--ratio-reduction [0.99] Ratio for alignment reduction, e.g. sites 
                  holding >99% gaps are ignored. (b phase)
--omega           [1.0] Modifier levelling the threshold used during
                  phylo-kmer filtering, T=(omega/#states)^k .(b phase)
--use_unrooted    [] Confirms you accept to use an unrooted reference
                  tree (option -t). The trifurcation described by the
                  newick file will be considered as root. Be aware that
                  meaningless roots may impact accuracy. (b phase)

Debug options:    Use only if you know what you are doing...    
---------------------------------------------------------------------
--ambwithmax      [] Treat ambiguities with max, not mean. (p phase)
--ardir           [dir] Skip ancestral sequence reconstruction, and 
                  uses outputs from the specified directory. (b phase)
--arinputonly     [] Generate only AR inputs. (b phase)
--aronly          [] Launch AR, but not DB build. (b phase)
--dbinram         [] Build DB, do not save it to a file, but directly
                     place queries given via -q instead.
--do-n-jumps      [] Shifts from 1 to n jumps. (b phase) 
--force-gap-jump  [] Forces gap jump even if %gap<thresh. (b phase) 
--jsondb          [] DB written as json. (careful, huge file outputs!)
--noamb           [] Do not treat ambiguous states. (p phase)
--threads         [4] #threads used in AR (if raxml-ng). (b phase)

Final note:
---------------------------------------------------------------------
When you use this software, please cite RAPPAS and the binary used for 
ancestral reconstruction, e.g. one of :
 * phyml: Oliva et al, 2019. doi: 10.1093/bioinformatics/btz249
 * paml: Yang Z, 2007. doi: 10.1093/molbev/msm088
 * raxml-ng: Kzlov et al, 2019. doi: 10.1093/bioinformatics/btz305
```

