# chimeraslayer CWL Generation Report

## chimeraslayer

### Tool Description
Tool for identifying chimeric sequences.

### Metadata
- **Docker Image**: biocontainers/chimeraslayer:v20101212dfsg1-2-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chimeraslayer/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
##########################################################################################
#
#  Required:
#
#    --query_NAST      multi-fasta file containing query sequences in alignment format
#
#  Common opts:
#
#    --db_NAST        db in NAST format (default: /usr/share/microbiomeutil-data/RESOURCES/rRNA16S.gold.NAST_ALIGNED.fasta)
#    --db_FASTA       db in fasta format (megablast formatted) (default: /usr/share/microbiomeutil-data/RESOURCES/rRNA16S.gold.fasta)
#
#
#    -n       number of top matching database sequences to compare to (default 15)
#    -R       min divergence ratio default: 1.007
#    -P       min percent identity among matching sequences (default: 90)
#
#  ## parameters to tune ChimeraParentSelector:
#   
#  Scoring parameters:
#   -M match score   (default: +5)
#   -N mismatch penalty  (default: -4)
#   -Q min query coverage by matching database sequence (default: 70)
#   -T maximum traverses of the multiple alignment  (default: 1)

#
#  ## parameters to tune ChimeraPhyloChecker:
#
#
#    --windowSize                default 50
#    --windowStep                default 5
#    --minBS      minimum bootstrap support for calling chimera (default: 90)
#    --num_BS_replicates         default: 100
#    --low_range_finer_BS (default: 10)    If computed BS is between minBS and (minBS - low_range_finer_BS), then num_finer_BS_replicates computed.
#    --num_finer_BS_replicates (default: 1000)
#    -S           percent of SNPs to sample on each side of breakpoint for computing bootstrap support (default: 10)
#    --num_parents_test       number of potential parents to test for chimeras (default: 3)
#    --MAX_CHIMERA_PARENT_PER_ID    Chimera/Parent alignments with perID above this are considered non-chimeras (default 100; turned off) 
#    
#
#  ## misc opts
#
#   --printFinalAlignments          shows alignment between query sequence and pair of candidate chimera parents
#   --printCSalignments             print ChimeraSlayer alignments in ChimeraSlayer output
#   --exec_dir                      chdir to here before running
#
#########################################################################################
```


## Metadata
- **Skill**: generated
