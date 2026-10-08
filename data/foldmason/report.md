# foldmason CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| foldmason_convertalis | PASS | converted a foldseek search result on the foldmason database to a table with amino acid and 3Di alignment columns |
| foldmason_createdb | PASS | 5 RCSB serine protease PDB files gave a 12-chain database used by all later steps |
| foldmason_easy-msa | PASS | aligned 5 RCSB serine protease structures; removed the wrong stdin input and fixed the output prefix glob |
| foldmason_msa2lddt | PASS | average MSA LDDT 0.557 over 249 columns printed for the structure alignment |
| foldmason_msa2lddtjson | PASS | wrote JSON with 12 entries, per-column scores and MSA LDDT 0.557 |
| foldmason_msa2lddtreport | PASS | wrote the HTML report (5 MB) for the structure alignment |
| foldmason_refinemsa | Failed | tool bug: refinemsa writes the refined alignment then aborts with an invalid pointer error (exit code 134); with zero refinement iterations it writes nothing |
| foldmason_structuremsa | PASS | aligned 12 chains with a sensible guide tree; run with threads 1 because more threads hang or crash this build |
| foldmason_structuremsacluster | PASS | aligned the chains of a foldseek cluster database; run with threads 1 because more threads hang or crash this build |

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

## foldmason_createdb

### Tool Description
Convert PDB or mmCIF structures into a foldmason database (amino acid, 3Di, C-alpha and header sub-databases).

### Metadata
- **Docker Image**: quay.io/biocontainers/foldmason:4.dd3c235--h5021889_0
- **Homepage**: https://github.com/steineggerlab/foldmason
- **Package**: https://anaconda.org/channels/bioconda/packages/foldmason/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldmason createdb <i:directory|.tsv>|<i:PDB|mmCIF[.gz]|tar[.gz]|DB> ... <i:PDB|mmCIF[.gz]|tar|DB> <o:sequenceDB> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:                         
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
common:                       
 --gpu INT                      Use GPU (CUDA) if possible [0]
 --prostt5-model STR            Path to ProstT5 model []
 --threads INT                  Number of CPU-cores used (all by default) [20]
 -v INT                         Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
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
 # Process multiple files
 foldseek createdb examples/1tim.pdb.gz examples/8tim.pdb.gz DB
 # Process a directory containing PDB|mmCIF[.gz]|tar[.gz]|DB recursively, only one directory can be given
 foldseek createdb examples/ DB
 # Process a TSV file with a list of PDB|mmCIF[.gz]|tar[.gz]|DB, only one TSV can be given
 foldseek createdb examples.tsv DB
 # Process a directory or tar file and filter based on file name
 # Note: --file-include and --file-exclude only apply to directory or tar input
 foldseek createdb examples/ DB --file-include "pdb.gz$"
 # Predict 3Di sequences from an amino acid FASTA file using ProstT5
 foldseek databases ProstT5 weights tmp
 foldseek createdb QUERY.fasta DB --prostt5-model weights
 
 
references:
 - van Kempen, M., Kim, S.S., Tumescheit, C., Mirdita, M., Lee, J., Gilchrist, C.L.M., Söding, J., and Steinegger, M. Fast and accurate protein structure search with Foldseek. Nature Biotechnology, doi:10.1038/s41587-023-01773-0 (2023)
 - Heinzinger, M., Weissenow, K., Gomez Sanchez, J., Henkel, A., Mirdita, M., Steinegger, M., and Burkhard, R. Bilingual Language Model for Protein Sequence and Structure. NAR Genomics and Bioinformatics, doi:10.1093/nargab/lqae150 (2024)
```

## foldmason_structuremsa

### Tool Description
Compute a structure-based multiple sequence alignment of all structures in a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldmason:4.dd3c235--h5021889_0
- **Homepage**: https://github.com/steineggerlab/foldmason
- **Package**: https://anaconda.org/channels/bioconda/packages/foldmason/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldmason structuremsa <i:queryDB> <o:alignmentFile> [options]
 By Cameron Gilchrist <gamcil@snu.ac.kr> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:               
 --comp-bias-corr INT      Correct for locally biased amino acid composition (range 0-1) [1]
align:                   
 --gap-open TWIN           Gap open cost [aa:25,nucl:25]
 --gap-extend TWIN         Gap extension cost [aa:2,nucl:2]
profile:                 
 --wg BOOL                 Use global sequence weighting for profile calculation [1]
 --match-ratio FLOAT       Columns that have a residue in this ratio of all sequences are kept [0.900]
 --filter-msa INT          Filter msa: 0: do not filter, 1: filter [1]
 --diff INT                Filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [5]
 --qsc FLOAT               Reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
 --mask-profile INT        Mask query sequence of profile using tantan [0,1] [1]
 --pseudo-cnt-mode INT     use 0: substitution-matrix or 1: context-specific pseudocounts [0]
misc:                    
 --guide-tree STR          Guide tree in Newick format []
 --recompute-scores BOOL   Recompute all-vs-all alignment scores every iteration [0]
 --refine-iters INT        Number of alignment refinement iterations [0]
 --bitfactor-aa FLOAT      AA matrix bit factor [1.100]
 --bitfactor-3di FLOAT     3Di matrix bit factor [2.100]
 --pair-threshold FLOAT    % of pair subalignments with LDDT information [0.0,1.0] [0.000]
 --fast BOOL               Fast mode, disable residue neighbourhood similarity scoring [0]
 --refine-seed INT         Random number generator seed [-1]
 --only-scoring-cols BOOL  Normalise LDDT by no. scoring columns [0]
 --score-bias-pssm FLOAT   PSSM score bias [-0.600]
 --nb-sigma FLOAT          Neighborhood score decay constant [3.841]
 --nb-multiplier FLOAT     Neighborhood score multiplier [13.000]
 --nb-ang-cut FLOAT        Maximum distance cutoff (angstrom) for neighboring residues [45.000]
 --nb-low-cut FLOAT        Minimum neighborhood score threshold [0.020]
 --sw-gap-open INT         Gap open cost for all-vs-all Smith-Waterman alignment [9]
 --sw-gap-extend INT       Gap extension cost for all-vs-all Smith-Waterman alignment [8]
common:                  
 --sub-mat TWIN            Substitution matrix file [aa:3di.out,nucl:3di.out]
 --threads INT             Number of CPU-cores used (all by default) [20]
 --max-seq-len INT         Maximum sequence length [65535]
 -v INT                    Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Kim, W., Mirdita, M., Levy Karin, E., Gilchrist, C.L.M., Schweke, H., Söding, J., Levy, E., and Steinegger, M. Rapid and sensitive protein complex alignment with Foldseek-Multimer. Nature Methods, doi:10.1038/s41592-025-02593-7 (2025)
```

## foldmason_structuremsacluster

### Tool Description
Compute a structure-based multiple sequence alignment of the members of one cluster of a database.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldmason:4.dd3c235--h5021889_0
- **Homepage**: https://github.com/steineggerlab/foldmason
- **Package**: https://anaconda.org/channels/bioconda/packages/foldmason/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldmason structuremsacluster <i:queryDB> <i:clusterDB> <o:alignmentFile> [options]
 By Cameron Gilchrist <gamcil@snu.ac.kr> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:               
 --comp-bias-corr INT      Correct for locally biased amino acid composition (range 0-1) [1]
align:                   
 --gap-open TWIN           Gap open cost [aa:25,nucl:25]
 --gap-extend TWIN         Gap extension cost [aa:2,nucl:2]
profile:                 
 --wg BOOL                 Use global sequence weighting for profile calculation [1]
 --match-ratio FLOAT       Columns that have a residue in this ratio of all sequences are kept [0.900]
 --filter-msa INT          Filter msa: 0: do not filter, 1: filter [1]
 --diff INT                Filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [5]
 --qsc FLOAT               Reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
 --mask-profile INT        Mask query sequence of profile using tantan [0,1] [1]
 --pseudo-cnt-mode INT     use 0: substitution-matrix or 1: context-specific pseudocounts [0]
misc:                    
 --guide-tree STR          Guide tree in Newick format []
 --recompute-scores BOOL   Recompute all-vs-all alignment scores every iteration [0]
 --refine-iters INT        Number of alignment refinement iterations [0]
 --bitfactor-aa FLOAT      AA matrix bit factor [1.100]
 --bitfactor-3di FLOAT     3Di matrix bit factor [2.100]
 --pair-threshold FLOAT    % of pair subalignments with LDDT information [0.0,1.0] [0.000]
 --fast BOOL               Fast mode, disable residue neighbourhood similarity scoring [0]
 --refine-seed INT         Random number generator seed [-1]
 --only-scoring-cols BOOL  Normalise LDDT by no. scoring columns [0]
 --score-bias-pssm FLOAT   PSSM score bias [-0.600]
 --nb-sigma FLOAT          Neighborhood score decay constant [3.841]
 --nb-multiplier FLOAT     Neighborhood score multiplier [13.000]
 --nb-ang-cut FLOAT        Maximum distance cutoff (angstrom) for neighboring residues [45.000]
 --nb-low-cut FLOAT        Minimum neighborhood score threshold [0.020]
 --sw-gap-open INT         Gap open cost for all-vs-all Smith-Waterman alignment [9]
 --sw-gap-extend INT       Gap extension cost for all-vs-all Smith-Waterman alignment [8]
common:                  
 --sub-mat TWIN            Substitution matrix file [aa:3di.out,nucl:3di.out]
 --threads INT             Number of CPU-cores used (all by default) [20]
 --max-seq-len INT         Maximum sequence length [65535]
 -v INT                    Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Kim, W., Mirdita, M., Levy Karin, E., Gilchrist, C.L.M., Schweke, H., Söding, J., Levy, E., and Steinegger, M. Rapid and sensitive protein complex alignment with Foldseek-Multimer. Nature Methods, doi:10.1038/s41592-025-02593-7 (2025)
```

## foldmason_msa2lddt

### Tool Description
Calculate the LDDT score of a multiple sequence alignment (printed to standard output).

### Metadata
- **Docker Image**: quay.io/biocontainers/foldmason:4.dd3c235--h5021889_0
- **Homepage**: https://github.com/steineggerlab/foldmason
- **Package**: https://anaconda.org/channels/bioconda/packages/foldmason/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldmason msa2lddt <i:queryDB> <i:msaFile> [options]
 By Cameron Gilchrist <gamcil@snu.ac.kr> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:                    
 --pair-threshold FLOAT    % of pair subalignments with LDDT information [0.0,1.0] [0.000]
 --guide-tree STR          Guide tree in Newick format []
 --report-command STR       []
 --report-paths BOOL        [1]
 --only-scoring-cols BOOL  Normalise LDDT by no. scoring columns [0]
common:                  
 --threads INT             Number of CPU-cores used (all by default) [20]
 -v INT                    Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Kim, W., Mirdita, M., Levy Karin, E., Gilchrist, C.L.M., Schweke, H., Söding, J., Levy, E., and Steinegger, M. Rapid and sensitive protein complex alignment with Foldseek-Multimer. Nature Methods, doi:10.1038/s41592-025-02593-7 (2025)
```

## foldmason_msa2lddtreport

### Tool Description
Calculate the LDDT scores of a multiple sequence alignment and write an interactive HTML report.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldmason:4.dd3c235--h5021889_0
- **Homepage**: https://github.com/steineggerlab/foldmason
- **Package**: https://anaconda.org/channels/bioconda/packages/foldmason/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldmason msa2lddtreport <i:queryDB> <i:msaFile> <o:htmlFile> [options]
 By Cameron Gilchrist <gamcil@snu.ac.kr> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:                    
 --pair-threshold FLOAT    % of pair subalignments with LDDT information [0.0,1.0] [0.000]
 --guide-tree STR          Guide tree in Newick format []
 --report-command STR       []
 --report-paths BOOL        [1]
 --only-scoring-cols BOOL  Normalise LDDT by no. scoring columns [0]
common:                  
 --threads INT             Number of CPU-cores used (all by default) [20]
 -v INT                    Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Kim, W., Mirdita, M., Levy Karin, E., Gilchrist, C.L.M., Schweke, H., Söding, J., Levy, E., and Steinegger, M. Rapid and sensitive protein complex alignment with Foldseek-Multimer. Nature Methods, doi:10.1038/s41592-025-02593-7 (2025)
```

## foldmason_msa2lddtjson

### Tool Description
Calculate the LDDT scores of a multiple sequence alignment and write an JSON file.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldmason:4.dd3c235--h5021889_0
- **Homepage**: https://github.com/steineggerlab/foldmason
- **Package**: https://anaconda.org/channels/bioconda/packages/foldmason/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldmason msa2lddtjson <i:queryDB> <i:msaFile> <o:jsonFile> [options]
 By Cameron Gilchrist <gamcil@snu.ac.kr> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: misc:                    
 --pair-threshold FLOAT    % of pair subalignments with LDDT information [0.0,1.0] [0.000]
 --guide-tree STR          Guide tree in Newick format []
 --report-command STR       []
 --report-paths BOOL        [1]
 --only-scoring-cols BOOL  Normalise LDDT by no. scoring columns [0]
common:                  
 --threads INT             Number of CPU-cores used (all by default) [20]
 -v INT                    Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Kim, W., Mirdita, M., Levy Karin, E., Gilchrist, C.L.M., Schweke, H., Söding, J., Levy, E., and Steinegger, M. Rapid and sensitive protein complex alignment with Foldseek-Multimer. Nature Methods, doi:10.1038/s41592-025-02593-7 (2025)
```

## foldmason_refinemsa

### Tool Description
Refine an existing structure-based multiple sequence alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldmason:4.dd3c235--h5021889_0
- **Homepage**: https://github.com/steineggerlab/foldmason
- **Package**: https://anaconda.org/channels/bioconda/packages/foldmason/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldmason refinemsa <i:queryDB> <i:msaFile> <o:msaFile> [options]
 By Cameron Gilchrist <gamcil@snu.ac.kr> & Martin Steinegger <martin.steinegger@snu.ac.kr>
options: prefilter:               
 --comp-bias-corr INT      Correct for locally biased amino acid composition (range 0-1) [1]
align:                   
 --gap-open TWIN           Gap open cost [aa:25,nucl:25]
 --gap-extend TWIN         Gap extension cost [aa:2,nucl:2]
profile:                 
 --wg BOOL                 Use global sequence weighting for profile calculation [1]
 --match-ratio FLOAT       Columns that have a residue in this ratio of all sequences are kept [0.900]
 --filter-msa INT          Filter msa: 0: do not filter, 1: filter [1]
 --diff INT                Filter MSAs by selecting most diverse set of sequences, keeping at least this many seqs in each MSA block of length 50 [5]
 --qsc FLOAT               Reduce diversity of output MSAs using min. score per aligned residue with query sequences [-50.0,100.0] [-20.000]
 --mask-profile INT        Mask query sequence of profile using tantan [0,1] [1]
 --pseudo-cnt-mode INT     use 0: substitution-matrix or 1: context-specific pseudocounts [0]
misc:                    
 --guide-tree STR          Guide tree in Newick format []
 --recompute-scores BOOL   Recompute all-vs-all alignment scores every iteration [0]
 --refine-iters INT        Number of alignment refinement iterations [0]
 --bitfactor-aa FLOAT      AA matrix bit factor [1.100]
 --bitfactor-3di FLOAT     3Di matrix bit factor [2.100]
 --pair-threshold FLOAT    % of pair subalignments with LDDT information [0.0,1.0] [0.000]
 --fast BOOL               Fast mode, disable residue neighbourhood similarity scoring [0]
 --refine-seed INT         Random number generator seed [-1]
 --only-scoring-cols BOOL  Normalise LDDT by no. scoring columns [0]
 --score-bias-pssm FLOAT   PSSM score bias [-0.600]
 --nb-sigma FLOAT          Neighborhood score decay constant [3.841]
 --nb-multiplier FLOAT     Neighborhood score multiplier [13.000]
 --nb-ang-cut FLOAT        Maximum distance cutoff (angstrom) for neighboring residues [45.000]
 --nb-low-cut FLOAT        Minimum neighborhood score threshold [0.020]
 --sw-gap-open INT         Gap open cost for all-vs-all Smith-Waterman alignment [9]
 --sw-gap-extend INT       Gap extension cost for all-vs-all Smith-Waterman alignment [8]
common:                  
 --sub-mat TWIN            Substitution matrix file [aa:3di.out,nucl:3di.out]
 --threads INT             Number of CPU-cores used (all by default) [20]
 --max-seq-len INT         Maximum sequence length [65535]
 -v INT                    Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]

references:
 - Kim, W., Mirdita, M., Levy Karin, E., Gilchrist, C.L.M., Schweke, H., Söding, J., Levy, E., and Steinegger, M. Rapid and sensitive protein complex alignment with Foldseek-Multimer. Nature Methods, doi:10.1038/s41592-025-02593-7 (2025)
```

## foldmason_convertalis

### Tool Description
Convert an alignment database into a text file (BLAST tab, SAM, HTML or superposed PDB).

### Metadata
- **Docker Image**: quay.io/biocontainers/foldmason:4.dd3c235--h5021889_0
- **Homepage**: https://github.com/steineggerlab/foldmason
- **Package**: https://anaconda.org/channels/bioconda/packages/foldmason/overview
- **Validation**: PASS

### Original Help Text
```text
usage: foldmason convertalis <i:queryDb> <i:targetDb> <i:alignmentDB> <o:alignmentFile> [options]
 By Martin Steinegger <martin.steinegger@snu.ac.kr>
options: align:               
 --gap-open TWIN       Gap open cost [aa:25,nucl:25]
 --gap-extend TWIN     Gap extension cost [aa:2,nucl:2]
misc:                
 --format-mode INT     Output format:
                       0: BLAST-TAB
                       1: SAM
                       2: BLAST-TAB + query/db length
                       3: Pretty HTML
                       4: BLAST-TAB + column headers
                       5: Calpha only PDB super-posed to query
                       BLAST-TAB (0) and BLAST-TAB + column headers (4)support custom output formats (--format-output)
                       (5) Superposed PDB files (Calpha only) [0]
 --format-output STR   Choose comma separated list of output columns from: query,target,evalue,gapopen,pident,fident,nident,qstart,qend,qlen
                       tstart,tend,tlen,alnlen,raw,bits,cigar,qseq,tseq,q3di,t3di,qheader,theader,qaln,taln,q3dialn,t3dialn,mismatch,qcov,tcov
                       qset,qsetid,tset,tsetid,taxid,taxname,taxlineage,
                       lddt,lddtfull,qca,tca,t,u,qtmscore,ttmscore,alntmscore,rmsd,prob
                       complexqtmscore,complexttmscore,complexu,complext,complexassignid
                        [query,target,fident,alnlen,mismatch,gapopen,qstart,qend,tstart,tend,evalue,bits]
 --exact-tmscore INT   turn on fast exact TMscore (slow), default is approximate [0]
common:              
 --sub-mat TWIN        Substitution matrix file [aa:3di.out,nucl:3di.out]
 --db-load-mode INT    Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch [0]
 --threads INT         Number of CPU-cores used (all by default) [20]
 --compressed INT      Write compressed output [0]
 -v INT                Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info [3]
expert:              
 --db-output BOOL      Return a result DB instead of a text file [0]

examples:
 # Create output in BLAST M8 format (12 columns):
 #  (1,2) identifiers for query and target sequences/profiles,
 #  (3) sequence identity, (4) alignment length, (5) number of mismatches,
 #  (6) number of gap openings, (7-8, 9-10) alignment start and end-position in query and in target,
 #  (11) E-value, and (12) bit score
 foldseek convertalis queryDB targetDB result.m8
 
 # Create a TSV containing pairwise alignments
 foldseek convertalis queryDB targetDB result.tsv --format-output query,target,qaln,taln
 
 # Annotate a alignment result with taxonomy information from targetDB
 foldseek convertalis queryDB targetDB result.tsv --format-output query,target,taxid,taxname,taxlineage
 
  Create SAM output
 foldseek convertalis queryDB targetDB result.sam --format-mode 1
 
 # Create a TSV containing which query file a result comes from
 foldseek createdb euk_queries.fasta bac_queries.fasta queryDB
 foldseek convertalis queryDB targetDB result.tsv --format-output qset,query,target
 
references:
 - Steinegger M, Soding J: MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, 35(11), 1026-1028 (2017)
```
