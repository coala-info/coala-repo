# phylofisher CWL Generation Report

## phylofisher_sgt_constructor.py

### Tool Description
Aligns, trims, and builds single gene trees from unaligned gene files.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
- **Homepage**: https://github.com/TheBrownLab/PhyloFisher
- **Package**: https://anaconda.org/channels/bioconda/packages/phylofisher/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phylofisher/overview
- **Total Downloads**: 22.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/TheBrownLab/PhyloFisher
- **Stars**: N/A
### Original Help Text
```text
usage: sgt_constructor.py -i path/to/input/ [OPTIONS]

Aligns, trims, and builds single gene trees from unaligned gene files.

required arguments:
  -i, --input <in_dir>       Path to input directory

optional arguments:
  -t, --threads N            Desired number of threads to be utilized.
                                Default: 1
  --no_trees                 Do NOT build single gene trees.
                                Length filtration and trimmming only.
  --trees_only               Only build single gene trees.
                                No length filtration and trimming.
  -if, --in_format <format>  Format of the input files.
                                Options: fasta, phylip (names truncated at 10 characters), 
                                phylip-relaxed (names are not truncated), or nexus.
                                Default: fasta
  -o, --output <out_dir>     Path to user-defined output directory
                                Default: ./sgt_constructor_out_<M.D.Y>
  -h, --help                 Show this help message and exit.

additional information:
   Version: 1.2.13
   GitHub: https://github.com/TheBrownLab/PhyloFisher
   Cite: doi:https://10.1371/journal.pbio.3001365
```


## phylofisher_matrix_constructor.py

### Tool Description
To trim align and concatenate orthologs into a super-matrix run:

### Metadata
- **Docker Image**: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
- **Homepage**: https://github.com/TheBrownLab/PhyloFisher
- **Package**: https://anaconda.org/channels/bioconda/packages/phylofisher/overview
- **Validation**: PASS

### Original Help Text
```text
usage: matrix_constructor.py [OPTIONS] -i path/to/input/

To trim align and concatenate orthologs into a super-matrix run:

required arguments:
  -i, --input <in_dir>        Path to prep_final_dataset_<M.D.Y>

optional arguments:
  -of, --out_format <format>  Desired format of the output matrix.
                                 Options: fasta, phylip (names truncated at 10 characters), 
                                 phylip-relaxed (names are not truncated), or nexus.
                                 Default: fasta
  -if, --in_format <format>   Format of the input files.
                                 Options: fasta, phylip (names truncated at 10 characters), 
                                 phylip-relaxed (names are not truncated), or nexus.
                                 Default: fasta
  -c, --concatenation_only    Only concatenate alignments. Trimming and alignment are not performed automatically.
  -t, --threads N             Desired number of threads to be utilized.
                                 Default: 1
  --trimal_gt N               trimaAL gt parameter. Fraction of sequences with a gap allowed.
                                 Options: 0.0 - 1.0
                                 Default: 0.80
  --clean_up                  Clean up large intermediate files.
  -o, --output <out_dir>      Path to user-defined output directory
                                 Default: ./matrix_constructor_out_<M.D.Y>
  -p, --prefix <prefix>       Prefix of input files
                                 Default: NONE
                                 Example: path/to/input/prefix*
  -s, --suffix <suffix>       Suffix of input files.
                                 Default: NONE
                                 Example: path/to/input/*suffix
  -h, --help                  Show this help message and exit.

additional information:
   Version: 1.2.13
   GitHub: https://github.com/TheBrownLab/PhyloFisher
   Cite: doi:https://10.1371/journal.pbio.3001365
```


## phylofisher_nucl_matrix_constructor.py

### Tool Description
To get nucleotides trim align and concatenate orthologs into a nucleotide super-matrix:

### Metadata
- **Docker Image**: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
- **Homepage**: https://github.com/TheBrownLab/PhyloFisher
- **Package**: https://anaconda.org/channels/bioconda/packages/phylofisher/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nucl_matrix_constructor.py [OPTIONS] -i path/to/input/

To get nucleotides trim align and concatenate orthologs into a nucleotide super-matrix:

required arguments:
  -it, --input_tsv <path>     Path to input tsv file which contains unique IDs and paths to nucleotide files.
  -i, --input <in_dir>        Path to prep_final_dataset_<M.D.Y>

optional arguments:
  -of, --out_format <format>  Desired format of the output matrix.
                                 Options: fasta, phylip (names truncated at 10 characters), 
                                 phylip-relaxed (names are not truncated), or nexus.
                                 Default: fasta
  -if, --in_format <format>   Format of the input files.
                                 Options: fasta, phylip (names truncated at 10 characters), 
                                 phylip-relaxed (names are not truncated), or nexus.
                                 Default: fasta
  -t, --threads N             Desired number of threads to be utilized.
                                 Default: 1
  --clean_up                  Clean up large intermediate files.
  -o, --output <out_dir>      Path to user-defined output directory
                                 Default: ./nucl_matrix_constructor_out_<M.D.Y>
  -h, --help                  Show this help message and exit.

additional information:
   Version: 1.2.13
   GitHub: https://github.com/TheBrownLab/PhyloFisher
   Cite: doi:https://10.1371/journal.pbio.3001365
```


## phylofisher_forest.py

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
- **Homepage**: https://github.com/TheBrownLab/PhyloFisher
- **Package**: https://anaconda.org/channels/bioconda/packages/phylofisher/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/forest.py", line 14, in <module>
    from ete3 import Tree, TreeStyle, NodeStyle, TextFace
ImportError: cannot import name 'TreeStyle' from 'ete3' (/usr/local/lib/python3.7/site-packages/ete3/__init__.py)
```


## phylofisher_select_taxa.py

### Tool Description
Selects taxa to be included in super matrix construction

### Metadata
- **Docker Image**: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
- **Homepage**: https://github.com/TheBrownLab/PhyloFisher
- **Package**: https://anaconda.org/channels/bioconda/packages/phylofisher/overview
- **Validation**: PASS

### Original Help Text
```text
usage: select_taxa.py [OPTIONS]

Selects taxa to be included in super matrix construction

optional arguments:
  --to_exclude exc_taxa.txt  List of taxa to exclude.
  --to_include inc_taxa.txt  List of taxa to include.
  --chimeras chimeras.tsv    A .tsv containing a Unique ID, higher and lower taxonomic designations, long name, 
                                and the Unique IDs of the taxa to collapse, for each chimera one per line
  -h, --help                 Show this help message and exit.

additional information:
   Version: 1.2.13
   GitHub: https://github.com/TheBrownLab/PhyloFisher
   Cite: doi:https://10.1371/journal.pbio.3001365
```


## phylofisher_taxon_collapser.py

### Tool Description
Collapses dataset entries into a single taxon

### Metadata
- **Docker Image**: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
- **Homepage**: https://github.com/TheBrownLab/PhyloFisher
- **Package**: https://anaconda.org/channels/bioconda/packages/phylofisher/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxon_collapser.py [OPTIONS] -i <taxa>

Collapses dataset entries into a single taxon

required arguments:
  -i, --input to_collapse.tsv  A .tsv containing a Unique ID, long name, higher taxonomy, lower taxonomy, and a list of Unique IDs to collapse
                                  for each chimera with one on each line.
                                  
                                  Example:
                                    Chimera_ID 1	Long Name	Higher_Tax	Lower_Tax	Unique_ID_1,Unique_ID_2
                                    Chimera_ID 2	Long Name	Higher_Tax	Lower_Tax	Unique_ID_3,Unique_ID_4

optional arguments:
  -h, --help                   Show this help message and exit.

additional information:
   Version: 1.2.13
   GitHub: https://github.com/TheBrownLab/PhyloFisher
   Cite: doi:https://10.1371/journal.pbio.3001365
```


## phylofisher_aa_recoder.py

### Tool Description
Recodes input matrix based on SR4 amino acid classification.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
- **Homepage**: https://github.com/TheBrownLab/PhyloFisher
- **Package**: https://anaconda.org/channels/bioconda/packages/phylofisher/overview
- **Validation**: PASS

### Original Help Text
```text
usage: aa_recoder.py [OPTIONS] -i <matrix>-re <strategy>

Recodes input matrix based on SR4 amino acid classification.

required arguments:
  -i, --input matrix              Path to input matrix for recoding.
  -re, --recoding_strat strategy  Desired recoding strategy.
                                     Options: SR4, SR6, KGB6, D6, D9, D12, D15, or D18.

optional arguments:
  -if, --in_format <format>       Input file format if not FASTA.
                                     Options: fasta, phylip (names truncated at 10 characters), 
                                     phylip-relaxed (names are not truncated), or nexus.
                                     Default: fasta
  -of, --out_format <format>      Desired output format.
                                     Options: fasta, phylip (names truncated at 10 characters), 
                                     phylip-relaxed (names are not truncated), or nexus.
                                     Default: fasta
  -o, --output <out_dir>          Path to user-defined output directory
                                     Default: ./aa_recoder_out_<M.D.Y>
  -h, --help                      Show this help message and exit.

additional information:
   Version: 1.2.13
   GitHub: https://github.com/TheBrownLab/PhyloFisher
   Cite: doi:https://10.1371/journal.pbio.3001365
```


## phylofisher_heterotachy.py

### Tool Description
Removes the most heterotachous sites within a phylogenomic supermatrix in a stepwise fashion, leading to a user defined set of new matrices with these sites removed.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
- **Homepage**: https://github.com/TheBrownLab/PhyloFisher
- **Package**: https://anaconda.org/channels/bioconda/packages/phylofisher/overview
- **Validation**: PASS

### Original Help Text
```text
usage: heterotachy.py -t path/to/tree -m path/to/matrix [OPTIONS]

Removes the most heterotachous sites within a phylogenomic supermatrix in a stepwise fashion, leading to a user defined set of new matrices with these sites removed.

required arguments:
  -tr, --tree                Path to tree
  -m, --matrix               Path to supermatrix

optional arguments:
  -s, --step_size N          Size of removal step (i.e., 1000 sites removed) to exhaustion
                                Default: 3000
  -if, --in_format <format>  Input format of matrix
                                Options: fasta, nexus, phylip (names truncated at 10 characters), 
                                or phylip-relaxed (names are not truncated)
                                Default: fasta
  -f, --out_format <format>  Desired format of the output steps.
                                Options: fasta, nexus, phylip (names truncated at 10 characters), 
                                or phylip-relaxed (names are not truncated)
                                Default: fasta
  -o, --output <out_dir>     Path to user-defined output directory
                                Default: ./heterotachy_out_<M.D.Y>
  -h, --help                 Show this help message and exit.

additional information:
   Version: 1.2.13
   GitHub: https://github.com/TheBrownLab/PhyloFisher
   Cite: doi:https://10.1371/journal.pbio.3001365
```


## phylofisher_apply_to_db.py

### Tool Description
Apply parsing decisions and add new data to the database.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
- **Homepage**: https://github.com/TheBrownLab/PhyloFisher
- **Package**: https://anaconda.org/channels/bioconda/packages/phylofisher/overview
- **Validation**: PASS

### Original Help Text
```text
usage: apply_to_db.py -i <in_dir>

Apply parsing decisions and add new data to the database. 

NOTE: If apply_to_db.py fails for any reason, see backup_resoration.py 
and restore you database from the proper backup

required arguments:
  -fi, --fisher_dir <fisher_dir>  Path to fisher output directory to use for dataset addition.
  -i, --input <in_dir>            Path to forest output directory to use for database addition.

optional arguments:
  --to_exclude to_exclude.txt     Path to .txt file containing Unique IDs of taxa to exclude from dataset 
                                     addition with one taxon per line.
                                     Example:
                                       Unique ID (taxon 1)
                                       Unique ID (taxon 2)
  -t, --threads N                 Number of threads, where N is an integer.
                                     Default: 1
  -h, --help                      Show this help message and exit.

additional information:
   Version: 1.2.13
   GitHub: https://github.com/TheBrownLab/PhyloFisher
   Cite: doi:https://10.1371/journal.pbio.3001365
```

