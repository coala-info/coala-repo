# blockclust CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| blockclust | PASS |  |
| blockclust_blockclust.py_analysis | PASS |  |
| blockclust_blockclust.py_post | PASS |  |
| blockclust_blockclust.py_pre | PASS |  |

## blockclust

### Tool Description
Efficient clustering and classification of non-coding RNAs from short read RNA-seq profiles

### Metadata
- **Docker Image**: quay.io/biocontainers/blockclust:1.1.1--py311r43h2a4ad6c_1
- **Homepage**: https://github.com/pavanvidem/blockclust
- **Package**: https://anaconda.org/channels/bioconda/packages/blockclust/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blockclust/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pavanvidem/blockclust
- **Stars**: N/A
### Original Help Text
```text
Efficient clustering and classification of non-coding RNAs from short read RNA-seq profiles
-------------------------------------------------------------------------------------------
Usage: blockclust 
       -i, --in       [blockbuster output]
       -a, --accept   [accept annotations]
       -r, --reject   [reject annotations]
       -c, --config   [config file]
       -o, --out      [output dir]
       --help     Show help
```

## blockclust_blockclust.py_pre

### Tool Description
Efficient clustering and classification of non-coding RNAs from short read RNA-seq profiles; PRE mode converts reads BAM to tags BED

### Metadata
- **Docker Image**: quay.io/biocontainers/blockclust:1.1.1--py311r43h2a4ad6c_1
- **Homepage**: https://github.com/pavanvidem/blockclust
- **Package**: https://anaconda.org/channels/bioconda/packages/blockclust/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blockclust/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pavanvidem/blockclust
- **Stars**: N/A
### Original Help Text
```text
usage: blockclust.py [-h] [-v,--version]

Efficient clustering and classification of non-coding RNAs from short read
RNA-seq profiles

options:
  -h, --help            show this help message and exit
  -m {PRE,ANALYSIS,POST}, --mode {PRE,ANALYSIS,POST}
                        Mode of operationPRE = Preprocessing mode. convert
                        from reads BAM to tags BED.ANALYSIS = Clustering
                        and/or Classification mode.POST = Post processing such
                        as plotting and annotation with known Rfam families
                        etc. (default: ANALYSIS)
  -a ACCEPT_ANNOTATIONS, --accept ACCEPT_ANNOTATIONS
                        Annotations of known ncRNAs in BED format (default:
                        None)
  -r REJECT_ANNOTATIONS, --reject REJECT_ANNOTATIONS
                        Annotations of other known transcripts (eg. protein
                        coding) in BED format (default: None)
  -t TEST_INPUT, --test_input TEST_INPUT
                        Output of preprocessing mode as input. (default: None)
  -o OUTPUT_DIR, --out OUTPUT_DIR
                        Output directory path for the whole analysis (default:
                        None)
  -f CONFIG_FILE, --config CONFIG_FILE
                        blockClust configuration file. (default:
                        /usr/local/share/blockclust_data/blockclust.config)
  -c, --classify        Classify the input blockgroups (default: False)
  -cm {NEAREST,MODEL}, --clmode {NEAREST,MODEL}
                        Type of classificationMODEL = Model based
                        classificationNEAREST= Nearest neighbour
                        classification (default: MODEL)
  -md MODEL_DIR, --model_dir MODEL_DIR
                        Directory containing trained models for classification
                        (default: /usr/local/share/blockclust_data/models)
  -cs CMSEARCH_OUT, --cmsearch_out CMSEARCH_OUT
                        Output of cmsearch tool (default: None)
  -cbed CLUSTERS_BED, --clust_bed CLUSTERS_BED
                        BED file containing clusters from ANALYSIS mode
                        (default: None)
  -bam BAM, --bam BAM   Input bam file (default: None)
  -tbed TAGS_BED, --tags_bed TAGS_BED
                        BED file of tags (default: None)
  -tab SIM_TAB, --sim_tab SIM_TAB
                        Tabular file of pairwise blockgroup similarities
                        (default: None)
  -rfam RFAM_MAP, --rfam_map RFAM_MAP
                        Mapping of Rfam families (default:
                        /usr/local/share/blockclust_data/rfam_map.txt)
  -chr, --no_chr        Input blockgroups do not contain 'chr' in the begining
                        of chromosome ids (for eg. Ensembl database do not use
                        'chr'). (default: False)
  -v, --version         show program's version number and exit
```

## blockclust_blockclust.py_analysis

### Tool Description
Efficient clustering and classification of non-coding RNAs from short read RNA-seq profiles; ANALYSIS mode clusters and/or classifies blockgroups

### Metadata
- **Docker Image**: quay.io/biocontainers/blockclust:1.1.1--py311r43h2a4ad6c_1
- **Homepage**: https://github.com/pavanvidem/blockclust
- **Package**: https://anaconda.org/channels/bioconda/packages/blockclust/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blockclust/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pavanvidem/blockclust
- **Stars**: N/A
### Original Help Text
```text
usage: blockclust.py [-h] [-v,--version]

Efficient clustering and classification of non-coding RNAs from short read
RNA-seq profiles

options:
  -h, --help            show this help message and exit
  -m {PRE,ANALYSIS,POST}, --mode {PRE,ANALYSIS,POST}
                        Mode of operationPRE = Preprocessing mode. convert
                        from reads BAM to tags BED.ANALYSIS = Clustering
                        and/or Classification mode.POST = Post processing such
                        as plotting and annotation with known Rfam families
                        etc. (default: ANALYSIS)
  -a ACCEPT_ANNOTATIONS, --accept ACCEPT_ANNOTATIONS
                        Annotations of known ncRNAs in BED format (default:
                        None)
  -r REJECT_ANNOTATIONS, --reject REJECT_ANNOTATIONS
                        Annotations of other known transcripts (eg. protein
                        coding) in BED format (default: None)
  -t TEST_INPUT, --test_input TEST_INPUT
                        Output of preprocessing mode as input. (default: None)
  -o OUTPUT_DIR, --out OUTPUT_DIR
                        Output directory path for the whole analysis (default:
                        None)
  -f CONFIG_FILE, --config CONFIG_FILE
                        blockClust configuration file. (default:
                        /usr/local/share/blockclust_data/blockclust.config)
  -c, --classify        Classify the input blockgroups (default: False)
  -cm {NEAREST,MODEL}, --clmode {NEAREST,MODEL}
                        Type of classificationMODEL = Model based
                        classificationNEAREST= Nearest neighbour
                        classification (default: MODEL)
  -md MODEL_DIR, --model_dir MODEL_DIR
                        Directory containing trained models for classification
                        (default: /usr/local/share/blockclust_data/models)
  -cs CMSEARCH_OUT, --cmsearch_out CMSEARCH_OUT
                        Output of cmsearch tool (default: None)
  -cbed CLUSTERS_BED, --clust_bed CLUSTERS_BED
                        BED file containing clusters from ANALYSIS mode
                        (default: None)
  -bam BAM, --bam BAM   Input bam file (default: None)
  -tbed TAGS_BED, --tags_bed TAGS_BED
                        BED file of tags (default: None)
  -tab SIM_TAB, --sim_tab SIM_TAB
                        Tabular file of pairwise blockgroup similarities
                        (default: None)
  -rfam RFAM_MAP, --rfam_map RFAM_MAP
                        Mapping of Rfam families (default:
                        /usr/local/share/blockclust_data/rfam_map.txt)
  -chr, --no_chr        Input blockgroups do not contain 'chr' in the begining
                        of chromosome ids (for eg. Ensembl database do not use
                        'chr'). (default: False)
  -v, --version         show program's version number and exit
```

## blockclust_blockclust.py_post

### Tool Description
Efficient clustering and classification of non-coding RNAs from short read RNA-seq profiles; POST mode annotates clusters with known Rfam families and plots them

### Metadata
- **Docker Image**: quay.io/biocontainers/blockclust:1.1.1--py311r43h2a4ad6c_1
- **Homepage**: https://github.com/pavanvidem/blockclust
- **Package**: https://anaconda.org/channels/bioconda/packages/blockclust/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blockclust/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pavanvidem/blockclust
- **Stars**: N/A
### Original Help Text
```text
usage: blockclust.py [-h] [-v,--version]

Efficient clustering and classification of non-coding RNAs from short read
RNA-seq profiles

options:
  -h, --help            show this help message and exit
  -m {PRE,ANALYSIS,POST}, --mode {PRE,ANALYSIS,POST}
                        Mode of operationPRE = Preprocessing mode. convert
                        from reads BAM to tags BED.ANALYSIS = Clustering
                        and/or Classification mode.POST = Post processing such
                        as plotting and annotation with known Rfam families
                        etc. (default: ANALYSIS)
  -a ACCEPT_ANNOTATIONS, --accept ACCEPT_ANNOTATIONS
                        Annotations of known ncRNAs in BED format (default:
                        None)
  -r REJECT_ANNOTATIONS, --reject REJECT_ANNOTATIONS
                        Annotations of other known transcripts (eg. protein
                        coding) in BED format (default: None)
  -t TEST_INPUT, --test_input TEST_INPUT
                        Output of preprocessing mode as input. (default: None)
  -o OUTPUT_DIR, --out OUTPUT_DIR
                        Output directory path for the whole analysis (default:
                        None)
  -f CONFIG_FILE, --config CONFIG_FILE
                        blockClust configuration file. (default:
                        /usr/local/share/blockclust_data/blockclust.config)
  -c, --classify        Classify the input blockgroups (default: False)
  -cm {NEAREST,MODEL}, --clmode {NEAREST,MODEL}
                        Type of classificationMODEL = Model based
                        classificationNEAREST= Nearest neighbour
                        classification (default: MODEL)
  -md MODEL_DIR, --model_dir MODEL_DIR
                        Directory containing trained models for classification
                        (default: /usr/local/share/blockclust_data/models)
  -cs CMSEARCH_OUT, --cmsearch_out CMSEARCH_OUT
                        Output of cmsearch tool (default: None)
  -cbed CLUSTERS_BED, --clust_bed CLUSTERS_BED
                        BED file containing clusters from ANALYSIS mode
                        (default: None)
  -bam BAM, --bam BAM   Input bam file (default: None)
  -tbed TAGS_BED, --tags_bed TAGS_BED
                        BED file of tags (default: None)
  -tab SIM_TAB, --sim_tab SIM_TAB
                        Tabular file of pairwise blockgroup similarities
                        (default: None)
  -rfam RFAM_MAP, --rfam_map RFAM_MAP
                        Mapping of Rfam families (default:
                        /usr/local/share/blockclust_data/rfam_map.txt)
  -chr, --no_chr        Input blockgroups do not contain 'chr' in the begining
                        of chromosome ids (for eg. Ensembl database do not use
                        'chr'). (default: False)
  -v, --version         show program's version number and exit
```

