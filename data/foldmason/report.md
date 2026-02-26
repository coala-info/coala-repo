# foldmason CWL Generation Report

## foldmason_easy-msa

### Tool Description
By Cameron Gilchrist <gamcil@snu.ac.kr> & Martin Steinegger <martin.steinegger@snu.ac.kr>

### Metadata
- **Docker Image**: quay.io/biocontainers/foldmason:4.dd3c235--h5021889_0
- **Homepage**: https://github.com/steineggerlab/foldmason
- **Package**: https://anaconda.org/channels/bioconda/packages/foldmason/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/foldmason/overview
- **Total Downloads**: 5.0K
- **Last updated**: 2025-10-11
- **GitHub**: https://github.com/steineggerlab/foldmason
- **Stars**: N/A
### Original Help Text
```text
usage: foldmason easy-msa <i:PDB|mmCIF[.gz]> ... <i:PDB|mmCIF[.gz]>|<i:stdin> <o:alignmentFile> <tmpDir> [options]
 By Cameron Gilchrist <gamcil@snu.ac.kr> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:                    
 --comp-bias-corr INT           Correct for locally biased amino acid composition (range 0-1) [1]
align:                        
 --gap-open TWIN                Gap open cost [aa:25,nucl:25]
 --gap-extend TWIN              Gap extension cost [aa:2,nucl:2]
profile:                      
 --wg BOOL                      Use global sequence weighting for profile calculation [1]
 --match-ratio FLOAT            Columns that have a residue in this ratio of all sequences are kept [0.900]
 --filter-msa INT               Filter msa: 0: do not filter, 1: filter [1]
 --diff INT                     Filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [5]
 --qsc FLOAT                    Reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
 --mask-profile INT             Mask query sequence of profile using tantan [0,1] [1]
 --pseudo-cnt-mode INT          use 0: substitution-matrix or 1: context-specific pseudocounts [0]
misc:                         
 --db-extraction-mode INT       createdb extraction mode: 0: chain 1: interface [0]
 --distance-threshold FLOAT     Residues with C-beta below this threshold will be part of interface [8.000]
 --mask-bfactor-threshold FLOAT mask residues for seeding if b-factor < thr [0,100] [0.000]
 --input-format INT             Format of input structures:
                                0: Auto-detect by extension
                                1: PDB
                                2: mmCIF
                                3: mmJSON
                                4: ChemComp
                                5: Foldcomp [0]
 --file-include STR             Include file names based on this regex [.*]
 --file-exclude STR             Exclude file names based on this regex [^$]
 --guide-tree STR               Guide tree in Newick format []
 --recompute-scores BOOL        Recompute all-vs-all alignment scores every iteration [0]
 --refine-iters INT             Number of alignment refinement iterations [0]
 --bitfactor-aa FLOAT           AA matrix bit factor [1.100]
 --bitfactor-3di FLOAT          3Di matrix bit factor [2.100]
 --pair-threshold FLOAT         % of pair subalignments with LDDT information [0.0,1.0] [0.000]
 --fast BOOL                    Fast mode, disable residue neighbourhood similarity scoring [0]
 --refine-seed INT              Random number generator seed [-1]
 --only-scoring-cols BOOL       Normalise LDDT by no. scoring columns [0]
 --score-bias-pssm FLOAT        PSSM score bias [-0.600]
 --nb-sigma FLOAT               Neighborhood score decay constant [3.841]
 --nb-multiplier FLOAT          Neighborhood score multiplier [13.000]
 --nb-ang-cut FLOAT             Maximum distance cutoff (angstrom) for neighboring residues [45.000]
 --nb-low-cut FLOAT             Minimum neighborhood score threshold [0.020]
 --sw-gap-open INT              Gap open cost for all-vs-all Smith-Waterman alignment [9]
 --sw-gap-extend INT            Gap extension cost for all-vs-all Smith-Waterman alignment [8]
 --report-command STR            []
 --report-paths BOOL             [1]
 --precluster BOOL              Pre-cluster structures before constructing MSA [0]
 --report-mode INT              MSA report mode 0: AA/3Di FASTA files only, 1: Compute LDDT and generate HTML report, 2: Compute LDDT and generate JSON [0]
common:                       
 --gpu INT                      Use GPU (CUDA) if possible [0]
 --prostt5-model STR            Path to ProstT5 model []
 --threads INT                  Number of CPU-cores used (all by default) [20]
 -v INT                         Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
 --sub-mat TWIN                 Substitution matrix file [aa:3di.out,nucl:3di.out]
 --max-seq-len INT              Maximum sequence length [65535]
expert:                       
 --chain-name-mode INT          Add chain to name:
                                0: auto
                                1: always add
                                 [0]
 --model-name-mode INT          Add model to name:
                                0: auto
                                1: always add
                                 [0]
 --write-mapping INT            write _mapping file containing mapping from internal id to taxonomic identifier [0]
 --coord-store-mode INT         Coordinate storage mode: 
                                1: C-alpha as float
                                2: C-alpha as difference (uint16_t) [2]
 --write-lookup INT             write .lookup file containing mapping from internal id, fasta id and file number [1]

examples:
 # Align a set of PDB files and create a MSA
 foldseek easy-msa example/d1asha_ result.m8 tmp
 
references:
 - Kim, W., Mirdita, M., Levy Karin, E., Gilchrist, C.L.M., Schweke, H., Söding, J., Levy, E., and Steinegger, M. Rapid and sensitive protein complex alignment with Foldseek-Multimer. Nature Methods, doi:10.1038/s41592-025-02593-7 (2025)
```

