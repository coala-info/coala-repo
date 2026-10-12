# pgap2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pgap2_add | Failed | tool bug: pgap2 add stops with AssertionError 'Leaf has no old nodes' when the new genome has any gene without a match in the previous run; only a duplicate of a known genome works |
| pgap2_main | PASS | 4 NCBI Mycoplasma pneumoniae genomes (gcode 4): 591 strict core of 792 gene clusters; indir fixed to Directory, links and fixed work dir added |
| pgap2_post_baps | PASS | new CWL; all 10 steps ran (core alignment, tree, ClonalFrameML, mask, fastbaps); all 4 strains in one cluster |
| pgap2_post_profile | PASS | new CWL; PAV matrix of the 4-genome partition: rarefaction tables, curve fit and PDF written |
| pgap2_post_singletree | PASS | new CWL; core gene tree of 4 M. pneumoniae strains built with FastTree |
| pgap2_post_stat | PASS | new CWL; on the 4-genome partition result: strict core 591 genes matches main, curve fit and PDF written |
| pgap2_post_tajimas_d | PASS | new CWL; Tajima's D table for 697 clusters; some clusters without variation or too few sequences report 0 by design |
| pgap2_prep | PASS | 3 NCBI Mycoplasma pneumoniae genomes (GenBank, gcode 4); gene counts 666-709 per strain, ANI above 99.7; fixed links to inputs left in the output |

## pgap2_prep

### Tool Description
Prepares input data for pgap2.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgap2:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bucongfan/PGAP2
- **Package**: https://anaconda.org/channels/bioconda/packages/pgap2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pgap2/overview
- **Total Downloads**: 766
- **Last updated**: 2026-02-06
- **GitHub**: https://github.com/bucongfan/PGAP2
- **Stars**: N/A
### Original Help Text
```text
usage: pgap2 prep [-h] --indir INDIR [--outdir OUTDIR] [--dup_id DUP_ID]
                  [--orth_id ORTH_ID] [--para_id PARA_ID]
                  [--type-filter TYPE_FILTER] [--id-attr-key ID_ATTR_KEY]
                  [--min_falen MIN_FALEN] [--accurate]
                  [--max_targets MAX_TARGETS] [--LD LD] [--AS AS] [--AL AL]
                  [--evalue EVALUE] [--aligner {diamond,blast}]
                  [--clust_method {cdhit,mmseqs2}] [--marker MARKER]
                  [--ani_thre ANI_THRE] [--annot] [--retrieve] [--gcode GCODE]
                  [--nodraw] [--single_file] [--verbose] [--debug] [--disable]
                  [--threads THREADS]

options:
  -h, --help            show this help message and exit
  --indir INDIR, -i INDIR
                        Input file contained, same prefix seems as the same
                        strain. (default: None)
  --outdir OUTDIR, -o OUTDIR
                        Output directory (default: .)
  --dup_id DUP_ID       The maximum identity between the most recent
                        duplication envent. (default: 0.99)
  --orth_id ORTH_ID     The maximum identity between the most similar
                        panclusters, 0 means automatic selection. (default:
                        0.98)
  --para_id PARA_ID     Use this identity as the paralogous identity, 0 means
                        automatic selection. (default: 0.7)
  --type-filter TYPE_FILTER
                        Only for gff file as input, feature type (3rd column)
                        to include, Only lines matching these types will be
                        processed. (default: CDS)
  --id-attr-key ID_ATTR_KEY
                        Only for gff file as input, Attribute key to extract
                        from the 9th column as the record ID (e.g., 'ID',
                        'gene', 'locus_tag'). (default: ID)
  --min_falen MIN_FALEN, -l MIN_FALEN
                        protein length of throw_away_sequences, at least 11
                        (default: 20)
  --accurate, -a        Apply bidirection check for paralogous gene partition.
                        (default: False)
  --max_targets MAX_TARGETS, -k MAX_TARGETS
                        The maximum targets for each query in alignment.
                        Improves accuracy for large-scale analyses, but
                        increases runtime and memory usage. (default: 2000)
  --LD LD               Minimum gene length difference proportion between two
                        genes. (default: 0.6)
  --AS AS               Coverage for the shorter sequence. (default: 0.6)
  --AL AL               Coverage for the longer sequence. (default: 0.6)
  --evalue EVALUE       The evalue of aligner. (default: 1e-05)
  --aligner {diamond,blast}
                        The aligner used to pairwise alignment. (default:
                        diamond)
  --clust_method {cdhit,mmseqs2}
                        The method used to cluster the genes. (default: cdhit)
  --marker MARKER       Assigned darb or outlier strain used to filter the
                        input. See detail in marker.cfg in the main path
                        (default: None)
  --ani_thre ANI_THRE   Expect ani threshold (default: 95)
  --annot               Discard original annotation, and re-annote the genome
                        privately using prodigal (default: False)
  --retrieve            Retrieving gene that may lost with annotations
                        (default: False)
  --gcode GCODE         The genetic code of your species. Default is [11]
                        (bacteria). (default: 11)
  --nodraw              Only output flat file, but no drawing plot (default:
                        False)
  --single_file, -s     Output each vector plot as a single file (default:
                        False)
  --verbose, -V         Verbose output (default: False)
  --debug, -D           Debug mode. Note: very verbose (default: False)
  --disable             Disable progress bar (default: False)
  --threads THREADS, -t THREADS
                        threads used in parallel (default: 1)
```


## pgap2_main

### Tool Description
Main entry point for pgap2.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgap2:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bucongfan/PGAP2
- **Package**: https://anaconda.org/channels/bioconda/packages/pgap2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgap2 main [-h] --indir INDIR [--outdir OUTDIR] [--dup_id DUP_ID]
                  [--orth_id ORTH_ID] [--para_id PARA_ID]
                  [--type-filter TYPE_FILTER] [--id-attr-key ID_ATTR_KEY]
                  [--hconf_thre HCONF_THRE] [--exhaust_orth]
                  [--sensitivity {soft,moderate,strict}] [--ins] [--fast]
                  [--accurate] [--retrieve] [--threads THREADS]
                  [--max_targets MAX_TARGETS] [--LD LD] [--AS AS] [--AL AL]
                  [--evalue EVALUE] [--aligner {diamond,blastp}]
                  [--clust_method {cdhit,mmseqs2}] [--radius RADIUS]
                  [--min_falen MIN_FALEN] [--gcode GCODE] [--annot]
                  [--verbose] [--debug] [--disable]

options:
  -h, --help            show this help message and exit
  --indir INDIR, -i INDIR
                        Input file contained, same prefix seems as the same
                        strain. (default: None)
  --outdir OUTDIR, -o OUTDIR
                        Output directory (default: .)
  --dup_id DUP_ID       The maximum identity between the most recent
                        duplication envent. (default: 0.99)
  --orth_id ORTH_ID     The maximum identity between the most similar
                        panclusters. (default: 0.98)
  --para_id PARA_ID     Use this identity as the paralogous identity.
                        (default: 0.7)
  --type-filter TYPE_FILTER
                        Only for gff file as input, feature type (3rd column)
                        to include, Only lines matching these types will be
                        processed. (default: CDS)
  --id-attr-key ID_ATTR_KEY
                        Only for gff file as input, Attribute key to extract
                        from the 9th column as the record ID (e.g., 'ID',
                        'gene', 'locus_tag'). (default: ID)
  --hconf_thre HCONF_THRE
                        The threshold to define high confidence cluster which
                        is used to evaluate the cluster diversity. Loose this
                        value when your input is too large or too diverse,
                        such as 0.95. (default: 1)
  --exhaust_orth, -e    Try to split every paralogs gene exhausted (default:
                        False)
  --sensitivity {soft,moderate,strict}, -s {soft,moderate,strict}
                        The degree of connectedness between each node of
                        clust. (default: strict)
  --ins, -n             Ignore the influence of insertion sequence. (default:
                        False)
  --fast, -f            Do not apply fine feature analysis just partition
                        according to the gene identity and synteny. (default:
                        False)
  --accurate, -a        Apply bidirection check for paralogous gene partition
                        (useless if exhaust_orth asigned). (default: False)
  --retrieve, -r        Retrieve gene that may lost with annotations (default:
                        False)
  --threads THREADS, -t THREADS
                        threads used in parallel (default: 1)
  --max_targets MAX_TARGETS, -k MAX_TARGETS
                        The maximum targets for each query in alignment.
                        Improves accuracy for large-scale analyses, but
                        increases runtime and memory usage. (default: 2000)
  --LD LD               Minimum gene length difference proportion between two
                        genes. (default: 0.6)
  --AS AS               Coverage for the shorter sequence. (default: 0.6)
  --AL AL               Coverage for the longer sequence. (default: 0.6)
  --evalue EVALUE       The evalue of aligner. (default: 1e-05)
  --aligner {diamond,blastp}
                        The aligner used to pairwise alignment. (default:
                        diamond)
  --clust_method {cdhit,mmseqs2}
                        The method used to cluster the genes. (default:
                        mmseqs2)
  --radius RADIUS       The radius of search region. (default: 3)
  --min_falen MIN_FALEN, -m MIN_FALEN
                        protein length of throw_away_sequences, at least 11
                        (default: 20)
  --gcode GCODE         The genetic code of your species. (default: 11)
  --annot               Discard original annotation, and re-annote the genome
                        privately using prodigal (default: False)
  --verbose, -v         Verbose output (default: False)
  --debug, -D           Debug mode. Note: very verbose (default: False)
  --disable             Disable progress bar (default: False)
```


## pgap2_add

### Tool Description
Add new sequences to an existing PGAP2 analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/pgap2:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bucongfan/PGAP2
- **Package**: https://anaconda.org/channels/bioconda/packages/pgap2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgap2 add [-h] --indir INDIR [--outdir OUTDIR] [--previous PREVIOUS]
                 [--aligner {diamond,blastp}] [--clust_method {cdhit,mmseqs2}]
                 [--type-filter TYPE_FILTER] [--id-attr-key ID_ATTR_KEY]
                 [--retrieve] [--threads THREADS] [--min_falen MIN_FALEN]
                 [--gcode GCODE] [--annot] [--verbose] [--debug] [--disable]

options:
  -h, --help            show this help message and exit
  --indir INDIR, -i INDIR
                        Input file contained, same prefix seems as the same
                        strain. (default: None)
  --outdir OUTDIR, -o OUTDIR
                        Output directory (default: .)
  --previous PREVIOUS, -p PREVIOUS
                        The previous PGAP2 result directory, used to resume
                        the partition step quickly. (default: None)
  --aligner {diamond,blastp}
                        The aligner used to pairwise alignment. (default:
                        diamond)
  --clust_method {cdhit,mmseqs2}
                        The method used to cluster the genes. (default:
                        mmseqs2)
  --type-filter TYPE_FILTER
                        Only for gff file as input, feature type (3rd column)
                        to include, Only lines matching these types will be
                        processed. (default: CDS)
  --id-attr-key ID_ATTR_KEY
                        Only for gff file as input, Attribute key to extract
                        from the 9th column as the record ID (e.g., 'ID',
                        'gene', 'locus_tag'). (default: ID)
  --retrieve, -r        Retrieve gene that may lost with annotations (default:
                        False)
  --threads THREADS, -t THREADS
                        threads used in parallel (default: 1)
  --min_falen MIN_FALEN, -m MIN_FALEN
                        protein length of throw_away_sequences, at least 11
                        (default: 20)
  --gcode GCODE         The genetic code of your species. (default: 11)
  --annot               Discard original annotation, and re-annote the genome
                        privately using prodigal (default: False)
  --verbose, -v         Verbose output (default: False)
  --debug, -D           Debug mode. Note: very verbose (default: False)
  --disable             Disable progress bar (default: False)
```


## pgap2_post_stat

### Tool Description
Statistical analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/pgap2:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bucongfan/PGAP2
- **Package**: https://anaconda.org/channels/bioconda/packages/pgap2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgap2 post stat [-h] --indir INDIR [--outdir OUTDIR] [--nodraw]
                       [--single_file] [--S S] [--N N] [--R R] [--K K]
                       [--method {TR,DG}] [--threads THREADS] [--verbose]
                       [--debug] [--disable]

options:
  -h, --help            show this help message and exit
  --indir INDIR, -i INDIR
                        Input directory generated by partition step
  --outdir OUTDIR, -o OUTDIR
                        Output directory
  --nodraw              Only output flat file, but no drawing plot
  --single_file, -s     Output each vector plot as a single file
  --S S                 Number of strains to sample in each bin
  --N N                 Number of bins to sample
  --R R                 Number of repeats for every sample
  --K K                 Inflated cof for DG method
  --method {TR,DG}      Sampling method. TR: total random; DG: diversity
                        guided
  --threads THREADS, -t THREADS
                        threads used in parallel
  --verbose, -V         Verbose output
  --debug               Debug mode. Note: very verbose
  --disable             Disable progress bar
```

## pgap2_post_profile

### Tool Description
To generate the pangenome profile using PAV matrix, it is the subset of [stat] module

### Metadata
- **Docker Image**: quay.io/biocontainers/pgap2:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bucongfan/PGAP2
- **Package**: https://anaconda.org/channels/bioconda/packages/pgap2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgap2 post profile [-h] --pav PAV [--outdir OUTDIR] [--nodraw]
                          [--single_file] [--S S] [--N N] [--R R] [--K K]
                          [--method {TR,DG}] [--threads THREADS] [--disable]
                          [--verbose] [--debug]

options:
  -h, --help            show this help message and exit
  --pav PAV, -p PAV     The pav matrix (default: None)
  --outdir OUTDIR, -o OUTDIR
                        Output directory (default: .)
  --nodraw              Only output flat file, but no drawing plot (default:
                        False)
  --single_file, -s     Output each vector plot as a single file (default:
                        False)
  --S S                 Number of strains to sample in each bin (default: 100)
  --N N                 Number of bins to sample (default: 100)
  --R R                 Number of repeats for every sample (default: 1)
  --K K                 Inflated cof for DG method (default: 3)
  --method {TR,DG}      Sampling method. TR: total random; DG: diversity
                        guided (default: TR)
  --threads THREADS, -t THREADS
                        Number of threads (default: 1)
  --disable             Disable progress bar (default: False)
  --verbose             Verbose output (default: False)
  --debug               Debug mode. Note: very verbose (default: False)
```

## pgap2_post_singletree

### Tool Description
Workflow for core-gene alignment and phylogeny tree construction

### Metadata
- **Docker Image**: quay.io/biocontainers/pgap2:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bucongfan/PGAP2
- **Package**: https://anaconda.org/channels/bioconda/packages/pgap2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgap2 post singletree [-h] --indir INDIR [--outdir OUTDIR] [--nodraw]
                             [--verbose] [--debug] [--disable]
                             [--threads THREADS]
                             [--msa_method {mafft,muscle,tcoffee}]
                             [--tree_method {fasttree,raxml,iqtree}]
                             [--para_strategy {drop,best}] [--also_pan]
                             [--core_threshold CORE_THRESHOLD]
                             [--step {1,2,3,4,5,6}] [--add_paras ADD_PARAS]

options:
  -h, --help            show this help message and exit
  --indir INDIR, -i INDIR
                        Input directory generated by partition (default: None)
  --outdir OUTDIR, -o OUTDIR
                        Output directory (default: .)
  --nodraw              Only output flat file, but no drawing plot (default:
                        False)
  --verbose, -V         Verbose output (default: False)
  --debug               Debug mode. Note: very verbose (default: False)
  --disable             Disable progress bar (default: False)
  --threads THREADS, -t THREADS
                        threads used in parallel (default: 1)
  --msa_method {mafft,muscle,tcoffee}
                        The method of multiple sequence alignment. (default:
                        mafft)
  --tree_method {fasttree,raxml,iqtree}
                        The method of tree building. (default: fasttree)
  --para_strategy {drop,best}
                        The strategy of paralog including cluster. best: keep
                        the best one; drop: drop all paralogs contained
                        clusters. (default: best)
  --also_pan            Also output pan genome alignment (default: False)
  --core_threshold CORE_THRESHOLD
                        Core threshold to extract for tree construction
                        (default: 0.95)
  --step {1,2,3,4,5,6}  Terminate at this step. 1. Extract core cds and prot.
                        2. Multiple sequence alignment using --msa_method
                        assigned. 3. Codon alignment: Trans multiple protein
                        alignment to corresponding nucleotide alignment. 4.
                        Trim alignment using ClipKit. 5. Core alignment
                        concatenation 6. Phylogeny tree construction using
                        tree_method assigned software. (default: 6)
  --add_paras ADD_PARAS
                        Add additional parameters in the step. Format like
                        "Step number:Parameters.", such as: 6:-pseudo
                        (default: None)
```

## pgap2_post_baps

### Tool Description
Workflow for bayesian analysis of population structure

### Metadata
- **Docker Image**: quay.io/biocontainers/pgap2:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bucongfan/PGAP2
- **Package**: https://anaconda.org/channels/bioconda/packages/pgap2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgap2 post baps [-h] --indir INDIR [--outdir OUTDIR] [--nodraw]
                       [--verbose] [--debug] [--disable] [--threads THREADS]
                       [--msa_method {mafft,muscle,tcoffee}]
                       [--tree_method {fasttree,raxml,iqtree}]
                       [--para_strategy {drop,best}] [--also_pan]
                       [--fastbaps_levels FASTBAPS_LEVELS]
                       [--fastbaps_prior {symmetric,baps,optimise.symmetric,optimise.baps}]
                       [--core_threshold CORE_THRESHOLD]
                       [--step {1,2,3,4,5,6,7,8,9,10}] [--add_paras ADD_PARAS]

options:
  -h, --help            show this help message and exit
  --indir INDIR, -i INDIR
                        Input directory generated by partition (default: None)
  --outdir OUTDIR, -o OUTDIR
                        Output directory (default: .)
  --nodraw              Only output flat file, but no drawing plot (default:
                        False)
  --verbose, -V         Verbose output (default: False)
  --debug               Debug mode. Note: very verbose (default: False)
  --disable             Disable progress bar (default: False)
  --threads THREADS, -t THREADS
                        threads used in parallel (default: 1)
  --msa_method {mafft,muscle,tcoffee}
                        The method of multiple sequence alignment. (default:
                        mafft)
  --tree_method {fasttree,raxml,iqtree}
                        The method of tree building. (default: fasttree)
  --para_strategy {drop,best}
                        The strategy of paralog including cluster. best: keep
                        the best one; drop: drop all paralogs contained
                        clusters. (default: best)
  --also_pan            Also output pan genome alignment. (default: False)
  --fastbaps_levels FASTBAPS_LEVELS
                        Parameter of fastbaps (default: 2)
  --fastbaps_prior {symmetric,baps,optimise.symmetric,optimise.baps}
                        Parameter of fastbaps (default: symmetric)
  --core_threshold CORE_THRESHOLD
                        Core threshold to extract for tree construction
                        (default: 0.95)
  --step {1,2,3,4,5,6,7,8,9,10}
                        Terminate at this step. 1. Extract core cds and prot.
                        2. Multiple sequence alignment using --msa_method
                        assigned. 3. Codon alignment: Trans multiple protein
                        alignment to corresponding nucleotide alignment. 4.
                        Trim alignment using ClipKit. 5. Core alignment
                        concatenation 6. Phylogeny tree construction using
                        FastTree. 7. Recombination inference using
                        ClonalFrameML. 8. Musk the recombination region using
                        maskrc-svg. 9. Reconstruct the phylogeny tree. 10.
                        Population structure analysis using fastbaps.
                        (default: 10)
  --add_paras ADD_PARAS
                        Add additional parameters in the step. Format like
                        "Step number:Parameters.", such as: 7:--kappa 4.232
                        (default: None)
```

## pgap2_post_tajimas_d

### Tool Description
Workflow for Tajima's D test

### Metadata
- **Docker Image**: quay.io/biocontainers/pgap2:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/bucongfan/PGAP2
- **Package**: https://anaconda.org/channels/bioconda/packages/pgap2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pgap2 post tajimas_d [-h] --indir INDIR [--outdir OUTDIR] [--nodraw]
                            [--verbose] [--debug] [--disable]
                            [--threads THREADS]
                            [--msa_method {mafft,muscle,tcoffee}]
                            [--para_strategy {drop,best}] [--clusts CLUSTS]
                            [--step {1,2,3,4,5}] [--add_paras ADD_PARAS]

options:
  -h, --help            show this help message and exit
  --indir INDIR, -i INDIR
                        Input directory generated by partition (default: None)
  --outdir OUTDIR, -o OUTDIR
                        Output directory (default: .)
  --nodraw              Only output flat file, but no drawing plot (default:
                        False)
  --verbose, -V         Verbose output (default: False)
  --debug               Debug mode. Note: very verbose (default: False)
  --disable             Disable progress bar (default: False)
  --threads THREADS, -t THREADS
                        threads used in parallel (default: 1)
  --msa_method {mafft,muscle,tcoffee}
                        The method of multiple sequence alignment. (default:
                        mafft)
  --para_strategy {drop,best}
                        The strategy of paralog including cluster. best: keep
                        the best one; drop: drop all paralogs contained
                        clusters. (default: best)
  --clusts CLUSTS       A file containing one line per cluster for which
                        Tajima's D test needs to be performed. By default, all
                        clusters will be used. (default: None)
  --step {1,2,3,4,5}    Terminate at this step. 1. Extract core cds and prot.
                        2. Multiple sequence alignment using --msa_method
                        assigned. 3. Codon alignment: Trans multiple protein
                        alignment to corresponding nucleotide alignment. 4.
                        Trim alignment using ClipKit. 5. Tajima's D Test.
                        (default: 5)
  --add_paras ADD_PARAS
                        Add additional parameters in the step. Format like
                        "Step number:Parameters.", such as: 4:-g 0.8 (default:
                        None)
```

## Metadata
- **Skill**: generated
