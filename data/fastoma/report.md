# fastoma CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fastoma_batch_roothogs | PASS | new CWL, output matches FastOMA test data |
| fastoma_check_input | PASS | new CWL, output matches FastOMA test data |
| fastoma_collect_subhogs | PASS | new CWL, output matches FastOMA test data |
| fastoma_helper_pw_rel | PASS | new CWL, output matches FastOMA test data |
| fastoma_infer_roothogs | PASS | new CWL, output matches FastOMA test data |
| fastoma_infer_subhogs | PASS | new CWL, output matches FastOMA test data |

## fastoma_check_input

### Tool Description
Check the input parameters for FastOMA and write a sanitised species tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/DessimozLab/FastOMA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastoma/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastoma-check-input [-h] [--version] --proteomes PROTEOMES
                           --species-tree SPECIES_TREE --out-tree OUT_TREE
                           [--splice SPLICE] [--hogmap HOGMAP]
                           [--omamer_db OMAMER_DB] [-v]

checking parameters for FastOMA

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --proteomes PROTEOMES
                        Path to the folder containing the input proteomes
  --species-tree SPECIES_TREE
                        Path to the input species tree file in newick format
  --out-tree OUT_TREE   Path to output file for sanitised species tree.
  --splice SPLICE       Path to the folder containing the splice information
                        files
  --hogmap HOGMAP       Path to the folder containing the hogmap files
  --omamer_db OMAMER_DB
                        Path to the omamer database
  -v                    Increase verbosity to info/debug
```

## fastoma_batch_roothogs

### Tool Description
Analyse roothog families and create batches for analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/DessimozLab/FastOMA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastoma/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastoma-batch-roothogs [-h] [--version] --input-roothogs INPUT_ROOTHOGS
                              --out-big OUT_BIG --out-rest OUT_REST [-v]

Analyse roothog families and create batches for analysis

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --input-roothogs INPUT_ROOTHOGS
                        folder where input roothogs are stored
  --out-big OUT_BIG     folder where the big single family hogs should be
                        stored
  --out-rest OUT_REST   folder where the remaining families should be stored
                        inbatch subfolder structure.
  -v                    incrase verbosity
```

## fastoma_infer_roothogs

### Tool Description
Infer the root hierarchical orthologous groups from OMAmer hogmap files and the input proteomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/DessimozLab/FastOMA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastoma/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastoma-infer-roothogs [-h] [--version] --proteomes PROTEOMES
                              [--splice SPLICE] [--hogmap HOGMAP]
                              --out-rhog-folder OUT_RHOG_FOLDER [-v]
                              [--min-sequence-length MIN_SEQUENCE_LENGTH]
                              [--mergHOG-ratioMax-thresh MERGHOG_RATIOMAX_THRESH]
                              [--mergHOG-ratioMin-thresh MERGHOG_RATIOMIN_THRESH]
                              [--mergHOG-shared-thresh MERGHOG_SHARED_THRESH]
                              [--mergHOG-fscore-thresh MERGHOG_FSCORE_THRESH]
                              [--big-rhog-size BIG_RHOG_SIZE]
                              [--big-fscore-thresh BIG_FSCORE_THRESH]

checking parameters for FastOMA

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --proteomes PROTEOMES
                        Path to the folder containing the input proteomes
  --splice SPLICE       Path to the folder containing the splice information
                        files
  --hogmap HOGMAP       Path to the folder containing the hogmap files
  --out-rhog-folder OUT_RHOG_FOLDER
                        Folder where the roothog fasta files are written
  -v                    Increase verbosity to info/debug
  --min-sequence-length MIN_SEQUENCE_LENGTH
                        minimum sequence length. Shorter sequences will be
                        ignored. (Default=50)
  --mergHOG-ratioMax-thresh MERGHOG_RATIOMAX_THRESH
                        For merging rootHOGs, threshold of ratioMax
  --mergHOG-ratioMin-thresh MERGHOG_RATIOMIN_THRESH
                        For merging rootHOGs, threshold of ratioMin
  --mergHOG-shared-thresh MERGHOG_SHARED_THRESH
                        For merging rootHOGs, threshold of number shared
                        proteins
  --mergHOG-fscore-thresh MERGHOG_FSCORE_THRESH
                        For merging rootHOGs, threshold of famlut score shared
                        proteins
  --big-rhog-size BIG_RHOG_SIZE
                        For big rootHOGs, we have different heuristics
  --big-fscore-thresh BIG_FSCORE_THRESH
                        For huge rootHOGs, we have different heuristics, like
                        filtering low family score protiens
```

## fastoma_infer_subhogs

### Tool Description
Infer the sub-hierarchical orthologous groups inside each rootHOG.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/DessimozLab/FastOMA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastoma/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastoma-infer-subhogs [-h] [--version] --input-rhog-folder
                             INPUT_RHOG_FOLDER [--parallel] --species-tree
                             SPECIES_TREE [--output-pickles OUTPUT_PICKLES]
                             [--threshold-dubious-sd THRESHOLD_DUBIOUS_SD]
                             [--number-of-samples-per-hog NUMBER_OF_SAMPLES_PER_HOG]
                             [--overlap-fragments OVERLAP_FRAGMENTS]
                             [--gene-rooting-method GENE_ROOTING_METHOD]
                             [--gene-trees-write] [--msa-write]
                             [--msa-filter-method {col-row-threshold,col-elbow-row-threshold,trimal}]
                             [--gap-ratio-row GAP_RATIO_ROW]
                             [--gap-ratio-col GAP_RATIO_COL]
                             [--min-col-trim MIN_COL_TRIM] [-v]

checking parameters for FastOMA

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --input-rhog-folder INPUT_RHOG_FOLDER
                        Path to the input rootHOG folder. (default: None)
  --parallel            use concurrent parallel per rootHOG (default: False)
  --species-tree SPECIES_TREE
                        Path to the input species tree file in newick format
                        (default: None)
  --output-pickles OUTPUT_PICKLES
                        Path to the output folder (default: pickle_hogs)
  --threshold-dubious-sd THRESHOLD_DUBIOUS_SD
                        Threshold to remove proteins in a gene tree due to low
                        species overlap score, not enough evidence for
                        duplication event. (default: 0.1)
  --number-of-samples-per-hog NUMBER_OF_SAMPLES_PER_HOG
                        Number of representatives (sequences) per HOG.
                        Defaults to (default: 5)
  --overlap-fragments OVERLAP_FRAGMENTS
                        Threshold overlap between two sequences (rows) in MSA
                        to decide whether they are fragments of a gene.
                        (default: 0.15)
  --gene-rooting-method GENE_ROOTING_METHOD
                        The method used for rooting of gene tree : midpoint
                        mad Nevers_rooting . (default: midpoint)
  --gene-trees-write    writing the all gene trees . (default: False)
  --msa-write           writing the raw MSAs (might have more genes that the
                        final gene tree). (default: False)
  --msa-filter-method {col-row-threshold,col-elbow-row-threshold,trimal}
                        The method used for filtering MSAs. (default: col-row-
                        threshold)
  --gap-ratio-row GAP_RATIO_ROW
                        For trimming the MSA, the threshold of ratio of gaps
                        for each row. (default: 0.3)
  --gap-ratio-col GAP_RATIO_COL
                        For trimming the MSA, the threshold of ratio of gaps
                        for each column. (default: 0.5)
  --min-col-trim MIN_COL_TRIM
                        min no. columns in msa to consider for filtering
                        (default: 50)
  -v                    Increase verbosity to info/debug (default: 0)
```

## fastoma_collect_subhogs

### Tool Description
Collect all computed HOGs and combine them into a single OrthoXML file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/DessimozLab/FastOMA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastoma/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastoma-collect-subhogs [-h] [--version] --pickle-folder PICKLE_FOLDER
                               --roothogs-folder ROOTHOGS_FOLDER
                               --gene-id-pickle-file GENE_ID_PICKLE_FILE
                               [--out OUT] [-v] [--roothog-tsv ROOTHOG_TSV]
                               [--marker-groups-fasta MARKER_GROUPS_FASTA]
                               --species-tree SPECIES_TREE
                               [--id-transform {UniProt,noop}]

collecting all computed HOGs and combine into a single orthoxml

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --pickle-folder PICKLE_FOLDER
                        folder containing the pickle files. Will be searched
                        recursively
  --roothogs-folder ROOTHOGS_FOLDER
                        folder containing the omamer roothogs
  --gene-id-pickle-file GENE_ID_PICKLE_FILE
                        file containing the gene-id dictionary in pickle
                        format
  --out OUT             output filename in orthoxml
  -v
  --roothog-tsv ROOTHOG_TSV
                        If specified, a tsv file with the given path will be
                        produced containing the roothog assignments as TSV
                        file. In addition, a folder named RootHOGsFasta will
                        be generatedwith one fasta file per inferred RootHOG.
  --marker-groups-fasta MARKER_GROUPS_FASTA
                        If specified, a folder named OrthologousFasta and a
                        TSV file with the name provided in this argument will
                        be generated that contains single copy groups, i.e.
                        groups which have at most one gene per species. Useful
                        as phylogenetic marker genes to reconstruct species
                        trees.
  --species-tree SPECIES_TREE
                        Path to the species tree used to infer the hogs
  --id-transform {UniProt,noop}
                        ID transformer from fasta files to orthoxml /
                        OrthologGroup protein IDs. By default, no
                        transformation will be done. Existing values are:
                        noop: No transformation - entire ID of fasta header
                        UniProt: '>sp|P68250|1433B_BOVIN' --> P68250
```

## fastoma_helper_pw_rel

### Tool Description
Extract pairwise orthologous or paralogous relations from a FastOMA OrthoXML file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/DessimozLab/FastOMA
- **Package**: https://anaconda.org/channels/bioconda/packages/fastoma/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastoma-helper pw-rel [-h] [--type {ortholog,paralog}] --out OUT
                             --orthoxml ORTHOXML

options:
  -h, --help            show this help message and exit
  --type {ortholog,paralog}
                        Type of relations to extract. either 'ortholog' or
                        'paralog'
  --out OUT             Path to output file
  --orthoxml ORTHOXML   Path to input orthoxml file
```

