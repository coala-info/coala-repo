# cellsnake CWL Generation Report

## cellsnake_minimal

### Tool Description
Main cellsnake executable

### Metadata
- **Docker Image**: quay.io/biocontainers/cellsnake:0.2.0.12--pyh7cba7a3_0
- **Homepage**: https://github.com/sinanugur/cellsnake
- **Package**: https://anaconda.org/channels/bioconda/packages/cellsnake/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cellsnake/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sinanugur/cellsnake
- **Stars**: N/A
### Original Help Text
```text
Main cellsnake executable, version: 0.2.0.12

             _  _                     _           
            | || |                   | |          
  ___   ___ | || | ___  _ __    __ _ | | __  ___  
 / __| / _ \| || |/ __|| '_ \  / _` || |/ / / _ \ 
| (__ |  __/| || |\__ \| | | || (_| ||   < |  __/ 
 \___| \___||_||_||___/|_| |_| \__,_||_|\_\ \___| 
                                                  
 
Usage:
    cellsnake <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake integrated <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake --generate-template
    cellsnake --install-packages
    cellsnake (-h | --help)
    cellsnake --version

commands:
    minimal                                Run cellsnake with minimal workflow. 
    standard                               Run cellsnake with standard workflow.
    advanced                               Run cellsnake with advanced workflow.
    clustree                               Run cellsnake with clustree workflow.
    integrate                              Run cellsnake to integrate samples under analyses folder.
                                           This option expects you have already finished processing multiple samples.

main arguments:
    INPUT                                  Input directory or a file to process (if a directory given, batch mode is ON).
                                           After integration, provide the Seurat object file not a directory to work on
                                           integrated object, see tutorial if necessary (e.g. analyses_integrated/seurat/integrated.rds)
    --configfile <text>                    Config file name in YAML format, for example, "config.yaml". No default but can be created with --generate-template.
    --metadata <text>                      Metadata file name in CSV, TSV or Excel format, for example, "metadata.csv", header required, first column sample name. No default but can be created with --generate-template.
    --metadata_column <text>               Metadata column for differential expression analysis [default: condition].

other arguments:
    --gene <gene or filename>              Create publication ready plots for a gene or a list of genes from a text file.
    
main options:
    --percent_mt <double>                  Maximum mitochondrial gene percentage cutoff, 
                                           for example, 5 or 10, write "auto" for auto detection [default: 10].
    --resolution <double>                  Resolution for cluster detection, write "auto" for auto detection [default: 0.8].

other options:
    --doublet_filter <bool>                [default: True] #this may fail on some samples and on low memory. If you have a problem, try False.
    --percent_rp <double>                  [default: 0] #Ribosomal genes minimum percentage (0-100), default no filtering
    --min_cells <integer>                  [default: 3] #seurat default, recommended
    --min_features <integer>               [default: 200] #seurat default, recommended, nFeature_RNA
    --max_features <integer>               [default: Inf] #seurat default, nFeature_RNA, 5000 can be a good cutoff
    --min_molecules <integer>              [default: 0] #seurat default, nCount_RNA, min_features usually handles this so keep it 0
    --max_molecules <integer>              [default: Inf] #seurat default, nCount_RNA, to filter potential doublets, doublet filtering is already default, so keep this Inf
    --highly_variable_features <integer>   [default: 2000] #seurat defaults, recommended
    --variable_selection_method <text>     [default: vst] #seurat defaults, recommended
    
    --normalization_method <text>          [default: LogNormalize]
    --scale_factor <integer>               [default: 10000]
    --logfc_threshold <double>             [default: 0.25]
    --test_use <text>                      [default: wilcox]


    --mapping <text>                       [default: org.Hs.eg.db] #you may install others from Bioconductor, this is for human
    --organism <text>                      [default: hsa] #alternatives https://www.genome.jp/kegg/catalog/org_list.html
    --species <text>                       [default: human] for cellchat, #only human or mouse is accepted

plotting parameters:
    --min_percentage_to_plot <double>        [default: 5] #only show clusters more than % of cells on the legend
    --show_labels <bool>                     [default: True] #
    --marker_plots_per_cluster_n <integer>   [default: 20] #plot summary marker plots for top markers
    --umap_markers_plot <bool>               [default: True]
    --tsne_markers_plot <bool>               [default: False]

annotation options:
    --singler_ref <text>                    [default: BlueprintEncodeData] # https://bioconductor.org/packages/release/data/experiment/vignettes/celldex/inst/doc/userguide.html#1_Overview
    --celltypist_model <text>               [default: Immune_All_Low.pkl] #refer to Celltypist for another model 

microbiome options:
    --kraken_db_folder <text>              No default, you need to provide a folder with kraken2 database
    --taxa <text>                          [default: genus] # available options "domain", "kingdom", "phylum", "class", "order", "family", "genus", "species"
    --microbiome_min_cells <integer>       [default: 1]
    --microbiome_min_features <integer>    [default: 3]
    --confidence <double>                  [default: 0.05] #see kraken2 manual
    --min_hit_groups <integer>             [default: 4] #see kraken2 manual

integration options:
    --dims <integer>                       [default: 30] #refer to Seurat for more details
    --reduction <text>                     [default: cca] #refer to Seurat for more details

others:
    --generate-template                    Generate config file template and metadata template in the current directory.
    --install-packages                     Install, reinstall or check required R packages.
    -j <integer>, --jobs <integer>         Total CPUs. [default: 1]
    -u, --unlock                           Rescue stalled jobs (Try this if the previous job ended prematurely or currently failing).
    -r, --remove                           Delete all output files (this won't affect input files).
    -d, --dry                              Dry run, nothing will be generated.
    -h, --help                             Show this screen.
    --version                              Show version.
```


## cellsnake_standard

### Tool Description
Main cellsnake executable

### Metadata
- **Docker Image**: quay.io/biocontainers/cellsnake:0.2.0.12--pyh7cba7a3_0
- **Homepage**: https://github.com/sinanugur/cellsnake
- **Package**: https://anaconda.org/channels/bioconda/packages/cellsnake/overview
- **Validation**: PASS

### Original Help Text
```text
Main cellsnake executable, version: 0.2.0.12

             _  _                     _           
            | || |                   | |          
  ___   ___ | || | ___  _ __    __ _ | | __  ___  
 / __| / _ \| || |/ __|| '_ \  / _` || |/ / / _ \ 
| (__ |  __/| || |\__ \| | | || (_| ||   < |  __/ 
 \___| \___||_||_||___/|_| |_| \__,_||_|\_\ \___| 
                                                  
 
Usage:
    cellsnake <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake integrated <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake --generate-template
    cellsnake --install-packages
    cellsnake (-h | --help)
    cellsnake --version

commands:
    minimal                                Run cellsnake with minimal workflow. 
    standard                               Run cellsnake with standard workflow.
    advanced                               Run cellsnake with advanced workflow.
    clustree                               Run cellsnake with clustree workflow.
    integrate                              Run cellsnake to integrate samples under analyses folder.
                                           This option expects you have already finished processing multiple samples.

main arguments:
    INPUT                                  Input directory or a file to process (if a directory given, batch mode is ON).
                                           After integration, provide the Seurat object file not a directory to work on
                                           integrated object, see tutorial if necessary (e.g. analyses_integrated/seurat/integrated.rds)
    --configfile <text>                    Config file name in YAML format, for example, "config.yaml". No default but can be created with --generate-template.
    --metadata <text>                      Metadata file name in CSV, TSV or Excel format, for example, "metadata.csv", header required, first column sample name. No default but can be created with --generate-template.
    --metadata_column <text>               Metadata column for differential expression analysis [default: condition].

other arguments:
    --gene <gene or filename>              Create publication ready plots for a gene or a list of genes from a text file.
    
main options:
    --percent_mt <double>                  Maximum mitochondrial gene percentage cutoff, 
                                           for example, 5 or 10, write "auto" for auto detection [default: 10].
    --resolution <double>                  Resolution for cluster detection, write "auto" for auto detection [default: 0.8].

other options:
    --doublet_filter <bool>                [default: True] #this may fail on some samples and on low memory. If you have a problem, try False.
    --percent_rp <double>                  [default: 0] #Ribosomal genes minimum percentage (0-100), default no filtering
    --min_cells <integer>                  [default: 3] #seurat default, recommended
    --min_features <integer>               [default: 200] #seurat default, recommended, nFeature_RNA
    --max_features <integer>               [default: Inf] #seurat default, nFeature_RNA, 5000 can be a good cutoff
    --min_molecules <integer>              [default: 0] #seurat default, nCount_RNA, min_features usually handles this so keep it 0
    --max_molecules <integer>              [default: Inf] #seurat default, nCount_RNA, to filter potential doublets, doublet filtering is already default, so keep this Inf
    --highly_variable_features <integer>   [default: 2000] #seurat defaults, recommended
    --variable_selection_method <text>     [default: vst] #seurat defaults, recommended
    
    --normalization_method <text>          [default: LogNormalize]
    --scale_factor <integer>               [default: 10000]
    --logfc_threshold <double>             [default: 0.25]
    --test_use <text>                      [default: wilcox]


    --mapping <text>                       [default: org.Hs.eg.db] #you may install others from Bioconductor, this is for human
    --organism <text>                      [default: hsa] #alternatives https://www.genome.jp/kegg/catalog/org_list.html
    --species <text>                       [default: human] for cellchat, #only human or mouse is accepted

plotting parameters:
    --min_percentage_to_plot <double>        [default: 5] #only show clusters more than % of cells on the legend
    --show_labels <bool>                     [default: True] #
    --marker_plots_per_cluster_n <integer>   [default: 20] #plot summary marker plots for top markers
    --umap_markers_plot <bool>               [default: True]
    --tsne_markers_plot <bool>               [default: False]

annotation options:
    --singler_ref <text>                    [default: BlueprintEncodeData] # https://bioconductor.org/packages/release/data/experiment/vignettes/celldex/inst/doc/userguide.html#1_Overview
    --celltypist_model <text>               [default: Immune_All_Low.pkl] #refer to Celltypist for another model 

microbiome options:
    --kraken_db_folder <text>              No default, you need to provide a folder with kraken2 database
    --taxa <text>                          [default: genus] # available options "domain", "kingdom", "phylum", "class", "order", "family", "genus", "species"
    --microbiome_min_cells <integer>       [default: 1]
    --microbiome_min_features <integer>    [default: 3]
    --confidence <double>                  [default: 0.05] #see kraken2 manual
    --min_hit_groups <integer>             [default: 4] #see kraken2 manual

integration options:
    --dims <integer>                       [default: 30] #refer to Seurat for more details
    --reduction <text>                     [default: cca] #refer to Seurat for more details

others:
    --generate-template                    Generate config file template and metadata template in the current directory.
    --install-packages                     Install, reinstall or check required R packages.
    -j <integer>, --jobs <integer>         Total CPUs. [default: 1]
    -u, --unlock                           Rescue stalled jobs (Try this if the previous job ended prematurely or currently failing).
    -r, --remove                           Delete all output files (this won't affect input files).
    -d, --dry                              Dry run, nothing will be generated.
    -h, --help                             Show this screen.
    --version                              Show version.
```


## cellsnake_advanced

### Tool Description
Main cellsnake executable

### Metadata
- **Docker Image**: quay.io/biocontainers/cellsnake:0.2.0.12--pyh7cba7a3_0
- **Homepage**: https://github.com/sinanugur/cellsnake
- **Package**: https://anaconda.org/channels/bioconda/packages/cellsnake/overview
- **Validation**: PASS

### Original Help Text
```text
Main cellsnake executable, version: 0.2.0.12

             _  _                     _           
            | || |                   | |          
  ___   ___ | || | ___  _ __    __ _ | | __  ___  
 / __| / _ \| || |/ __|| '_ \  / _` || |/ / / _ \ 
| (__ |  __/| || |\__ \| | | || (_| ||   < |  __/ 
 \___| \___||_||_||___/|_| |_| \__,_||_|\_\ \___| 
                                                  
 
Usage:
    cellsnake <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake integrated <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake --generate-template
    cellsnake --install-packages
    cellsnake (-h | --help)
    cellsnake --version

commands:
    minimal                                Run cellsnake with minimal workflow. 
    standard                               Run cellsnake with standard workflow.
    advanced                               Run cellsnake with advanced workflow.
    clustree                               Run cellsnake with clustree workflow.
    integrate                              Run cellsnake to integrate samples under analyses folder.
                                           This option expects you have already finished processing multiple samples.

main arguments:
    INPUT                                  Input directory or a file to process (if a directory given, batch mode is ON).
                                           After integration, provide the Seurat object file not a directory to work on
                                           integrated object, see tutorial if necessary (e.g. analyses_integrated/seurat/integrated.rds)
    --configfile <text>                    Config file name in YAML format, for example, "config.yaml". No default but can be created with --generate-template.
    --metadata <text>                      Metadata file name in CSV, TSV or Excel format, for example, "metadata.csv", header required, first column sample name. No default but can be created with --generate-template.
    --metadata_column <text>               Metadata column for differential expression analysis [default: condition].

other arguments:
    --gene <gene or filename>              Create publication ready plots for a gene or a list of genes from a text file.
    
main options:
    --percent_mt <double>                  Maximum mitochondrial gene percentage cutoff, 
                                           for example, 5 or 10, write "auto" for auto detection [default: 10].
    --resolution <double>                  Resolution for cluster detection, write "auto" for auto detection [default: 0.8].

other options:
    --doublet_filter <bool>                [default: True] #this may fail on some samples and on low memory. If you have a problem, try False.
    --percent_rp <double>                  [default: 0] #Ribosomal genes minimum percentage (0-100), default no filtering
    --min_cells <integer>                  [default: 3] #seurat default, recommended
    --min_features <integer>               [default: 200] #seurat default, recommended, nFeature_RNA
    --max_features <integer>               [default: Inf] #seurat default, nFeature_RNA, 5000 can be a good cutoff
    --min_molecules <integer>              [default: 0] #seurat default, nCount_RNA, min_features usually handles this so keep it 0
    --max_molecules <integer>              [default: Inf] #seurat default, nCount_RNA, to filter potential doublets, doublet filtering is already default, so keep this Inf
    --highly_variable_features <integer>   [default: 2000] #seurat defaults, recommended
    --variable_selection_method <text>     [default: vst] #seurat defaults, recommended
    
    --normalization_method <text>          [default: LogNormalize]
    --scale_factor <integer>               [default: 10000]
    --logfc_threshold <double>             [default: 0.25]
    --test_use <text>                      [default: wilcox]


    --mapping <text>                       [default: org.Hs.eg.db] #you may install others from Bioconductor, this is for human
    --organism <text>                      [default: hsa] #alternatives https://www.genome.jp/kegg/catalog/org_list.html
    --species <text>                       [default: human] for cellchat, #only human or mouse is accepted

plotting parameters:
    --min_percentage_to_plot <double>        [default: 5] #only show clusters more than % of cells on the legend
    --show_labels <bool>                     [default: True] #
    --marker_plots_per_cluster_n <integer>   [default: 20] #plot summary marker plots for top markers
    --umap_markers_plot <bool>               [default: True]
    --tsne_markers_plot <bool>               [default: False]

annotation options:
    --singler_ref <text>                    [default: BlueprintEncodeData] # https://bioconductor.org/packages/release/data/experiment/vignettes/celldex/inst/doc/userguide.html#1_Overview
    --celltypist_model <text>               [default: Immune_All_Low.pkl] #refer to Celltypist for another model 

microbiome options:
    --kraken_db_folder <text>              No default, you need to provide a folder with kraken2 database
    --taxa <text>                          [default: genus] # available options "domain", "kingdom", "phylum", "class", "order", "family", "genus", "species"
    --microbiome_min_cells <integer>       [default: 1]
    --microbiome_min_features <integer>    [default: 3]
    --confidence <double>                  [default: 0.05] #see kraken2 manual
    --min_hit_groups <integer>             [default: 4] #see kraken2 manual

integration options:
    --dims <integer>                       [default: 30] #refer to Seurat for more details
    --reduction <text>                     [default: cca] #refer to Seurat for more details

others:
    --generate-template                    Generate config file template and metadata template in the current directory.
    --install-packages                     Install, reinstall or check required R packages.
    -j <integer>, --jobs <integer>         Total CPUs. [default: 1]
    -u, --unlock                           Rescue stalled jobs (Try this if the previous job ended prematurely or currently failing).
    -r, --remove                           Delete all output files (this won't affect input files).
    -d, --dry                              Dry run, nothing will be generated.
    -h, --help                             Show this screen.
    --version                              Show version.
```


## cellsnake_clustree

### Tool Description
Main cellsnake executable

### Metadata
- **Docker Image**: quay.io/biocontainers/cellsnake:0.2.0.12--pyh7cba7a3_0
- **Homepage**: https://github.com/sinanugur/cellsnake
- **Package**: https://anaconda.org/channels/bioconda/packages/cellsnake/overview
- **Validation**: PASS

### Original Help Text
```text
Main cellsnake executable, version: 0.2.0.12

             _  _                     _           
            | || |                   | |          
  ___   ___ | || | ___  _ __    __ _ | | __  ___  
 / __| / _ \| || |/ __|| '_ \  / _` || |/ / / _ \ 
| (__ |  __/| || |\__ \| | | || (_| ||   < |  __/ 
 \___| \___||_||_||___/|_| |_| \__,_||_|\_\ \___| 
                                                  
 
Usage:
    cellsnake <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake integrated <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake --generate-template
    cellsnake --install-packages
    cellsnake (-h | --help)
    cellsnake --version

commands:
    minimal                                Run cellsnake with minimal workflow. 
    standard                               Run cellsnake with standard workflow.
    advanced                               Run cellsnake with advanced workflow.
    clustree                               Run cellsnake with clustree workflow.
    integrate                              Run cellsnake to integrate samples under analyses folder.
                                           This option expects you have already finished processing multiple samples.

main arguments:
    INPUT                                  Input directory or a file to process (if a directory given, batch mode is ON).
                                           After integration, provide the Seurat object file not a directory to work on
                                           integrated object, see tutorial if necessary (e.g. analyses_integrated/seurat/integrated.rds)
    --configfile <text>                    Config file name in YAML format, for example, "config.yaml". No default but can be created with --generate-template.
    --metadata <text>                      Metadata file name in CSV, TSV or Excel format, for example, "metadata.csv", header required, first column sample name. No default but can be created with --generate-template.
    --metadata_column <text>               Metadata column for differential expression analysis [default: condition].

other arguments:
    --gene <gene or filename>              Create publication ready plots for a gene or a list of genes from a text file.
    
main options:
    --percent_mt <double>                  Maximum mitochondrial gene percentage cutoff, 
                                           for example, 5 or 10, write "auto" for auto detection [default: 10].
    --resolution <double>                  Resolution for cluster detection, write "auto" for auto detection [default: 0.8].

other options:
    --doublet_filter <bool>                [default: True] #this may fail on some samples and on low memory. If you have a problem, try False.
    --percent_rp <double>                  [default: 0] #Ribosomal genes minimum percentage (0-100), default no filtering
    --min_cells <integer>                  [default: 3] #seurat default, recommended
    --min_features <integer>               [default: 200] #seurat default, recommended, nFeature_RNA
    --max_features <integer>               [default: Inf] #seurat default, nFeature_RNA, 5000 can be a good cutoff
    --min_molecules <integer>              [default: 0] #seurat default, nCount_RNA, min_features usually handles this so keep it 0
    --max_molecules <integer>              [default: Inf] #seurat default, nCount_RNA, to filter potential doublets, doublet filtering is already default, so keep this Inf
    --highly_variable_features <integer>   [default: 2000] #seurat defaults, recommended
    --variable_selection_method <text>     [default: vst] #seurat defaults, recommended
    
    --normalization_method <text>          [default: LogNormalize]
    --scale_factor <integer>               [default: 10000]
    --logfc_threshold <double>             [default: 0.25]
    --test_use <text>                      [default: wilcox]


    --mapping <text>                       [default: org.Hs.eg.db] #you may install others from Bioconductor, this is for human
    --organism <text>                      [default: hsa] #alternatives https://www.genome.jp/kegg/catalog/org_list.html
    --species <text>                       [default: human] for cellchat, #only human or mouse is accepted

plotting parameters:
    --min_percentage_to_plot <double>        [default: 5] #only show clusters more than % of cells on the legend
    --show_labels <bool>                     [default: True] #
    --marker_plots_per_cluster_n <integer>   [default: 20] #plot summary marker plots for top markers
    --umap_markers_plot <bool>               [default: True]
    --tsne_markers_plot <bool>               [default: False]

annotation options:
    --singler_ref <text>                    [default: BlueprintEncodeData] # https://bioconductor.org/packages/release/data/experiment/vignettes/celldex/inst/doc/userguide.html#1_Overview
    --celltypist_model <text>               [default: Immune_All_Low.pkl] #refer to Celltypist for another model 

microbiome options:
    --kraken_db_folder <text>              No default, you need to provide a folder with kraken2 database
    --taxa <text>                          [default: genus] # available options "domain", "kingdom", "phylum", "class", "order", "family", "genus", "species"
    --microbiome_min_cells <integer>       [default: 1]
    --microbiome_min_features <integer>    [default: 3]
    --confidence <double>                  [default: 0.05] #see kraken2 manual
    --min_hit_groups <integer>             [default: 4] #see kraken2 manual

integration options:
    --dims <integer>                       [default: 30] #refer to Seurat for more details
    --reduction <text>                     [default: cca] #refer to Seurat for more details

others:
    --generate-template                    Generate config file template and metadata template in the current directory.
    --install-packages                     Install, reinstall or check required R packages.
    -j <integer>, --jobs <integer>         Total CPUs. [default: 1]
    -u, --unlock                           Rescue stalled jobs (Try this if the previous job ended prematurely or currently failing).
    -r, --remove                           Delete all output files (this won't affect input files).
    -d, --dry                              Dry run, nothing will be generated.
    -h, --help                             Show this screen.
    --version                              Show version.
```


## cellsnake_integrate

### Tool Description
Main cellsnake executable

### Metadata
- **Docker Image**: quay.io/biocontainers/cellsnake:0.2.0.12--pyh7cba7a3_0
- **Homepage**: https://github.com/sinanugur/cellsnake
- **Package**: https://anaconda.org/channels/bioconda/packages/cellsnake/overview
- **Validation**: PASS

### Original Help Text
```text
Main cellsnake executable, version: 0.2.0.12

             _  _                     _           
            | || |                   | |          
  ___   ___ | || | ___  _ __    __ _ | | __  ___  
 / __| / _ \| || |/ __|| '_ \  / _` || |/ / / _ \ 
| (__ |  __/| || |\__ \| | | || (_| ||   < |  __/ 
 \___| \___||_||_||___/|_| |_| \__,_||_|\_\ \___| 
                                                  
 
Usage:
    cellsnake <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake integrated <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake --generate-template
    cellsnake --install-packages
    cellsnake (-h | --help)
    cellsnake --version

commands:
    minimal                                Run cellsnake with minimal workflow. 
    standard                               Run cellsnake with standard workflow.
    advanced                               Run cellsnake with advanced workflow.
    clustree                               Run cellsnake with clustree workflow.
    integrate                              Run cellsnake to integrate samples under analyses folder.
                                           This option expects you have already finished processing multiple samples.

main arguments:
    INPUT                                  Input directory or a file to process (if a directory given, batch mode is ON).
                                           After integration, provide the Seurat object file not a directory to work on
                                           integrated object, see tutorial if necessary (e.g. analyses_integrated/seurat/integrated.rds)
    --configfile <text>                    Config file name in YAML format, for example, "config.yaml". No default but can be created with --generate-template.
    --metadata <text>                      Metadata file name in CSV, TSV or Excel format, for example, "metadata.csv", header required, first column sample name. No default but can be created with --generate-template.
    --metadata_column <text>               Metadata column for differential expression analysis [default: condition].

other arguments:
    --gene <gene or filename>              Create publication ready plots for a gene or a list of genes from a text file.
    
main options:
    --percent_mt <double>                  Maximum mitochondrial gene percentage cutoff, 
                                           for example, 5 or 10, write "auto" for auto detection [default: 10].
    --resolution <double>                  Resolution for cluster detection, write "auto" for auto detection [default: 0.8].

other options:
    --doublet_filter <bool>                [default: True] #this may fail on some samples and on low memory. If you have a problem, try False.
    --percent_rp <double>                  [default: 0] #Ribosomal genes minimum percentage (0-100), default no filtering
    --min_cells <integer>                  [default: 3] #seurat default, recommended
    --min_features <integer>               [default: 200] #seurat default, recommended, nFeature_RNA
    --max_features <integer>               [default: Inf] #seurat default, nFeature_RNA, 5000 can be a good cutoff
    --min_molecules <integer>              [default: 0] #seurat default, nCount_RNA, min_features usually handles this so keep it 0
    --max_molecules <integer>              [default: Inf] #seurat default, nCount_RNA, to filter potential doublets, doublet filtering is already default, so keep this Inf
    --highly_variable_features <integer>   [default: 2000] #seurat defaults, recommended
    --variable_selection_method <text>     [default: vst] #seurat defaults, recommended
    
    --normalization_method <text>          [default: LogNormalize]
    --scale_factor <integer>               [default: 10000]
    --logfc_threshold <double>             [default: 0.25]
    --test_use <text>                      [default: wilcox]


    --mapping <text>                       [default: org.Hs.eg.db] #you may install others from Bioconductor, this is for human
    --organism <text>                      [default: hsa] #alternatives https://www.genome.jp/kegg/catalog/org_list.html
    --species <text>                       [default: human] for cellchat, #only human or mouse is accepted

plotting parameters:
    --min_percentage_to_plot <double>        [default: 5] #only show clusters more than % of cells on the legend
    --show_labels <bool>                     [default: True] #
    --marker_plots_per_cluster_n <integer>   [default: 20] #plot summary marker plots for top markers
    --umap_markers_plot <bool>               [default: True]
    --tsne_markers_plot <bool>               [default: False]

annotation options:
    --singler_ref <text>                    [default: BlueprintEncodeData] # https://bioconductor.org/packages/release/data/experiment/vignettes/celldex/inst/doc/userguide.html#1_Overview
    --celltypist_model <text>               [default: Immune_All_Low.pkl] #refer to Celltypist for another model 

microbiome options:
    --kraken_db_folder <text>              No default, you need to provide a folder with kraken2 database
    --taxa <text>                          [default: genus] # available options "domain", "kingdom", "phylum", "class", "order", "family", "genus", "species"
    --microbiome_min_cells <integer>       [default: 1]
    --microbiome_min_features <integer>    [default: 3]
    --confidence <double>                  [default: 0.05] #see kraken2 manual
    --min_hit_groups <integer>             [default: 4] #see kraken2 manual

integration options:
    --dims <integer>                       [default: 30] #refer to Seurat for more details
    --reduction <text>                     [default: cca] #refer to Seurat for more details

others:
    --generate-template                    Generate config file template and metadata template in the current directory.
    --install-packages                     Install, reinstall or check required R packages.
    -j <integer>, --jobs <integer>         Total CPUs. [default: 1]
    -u, --unlock                           Rescue stalled jobs (Try this if the previous job ended prematurely or currently failing).
    -r, --remove                           Delete all output files (this won't affect input files).
    -d, --dry                              Dry run, nothing will be generated.
    -h, --help                             Show this screen.
    --version                              Show version.
```


## cellsnake_This

### Tool Description
Main cellsnake executable

### Metadata
- **Docker Image**: quay.io/biocontainers/cellsnake:0.2.0.12--pyh7cba7a3_0
- **Homepage**: https://github.com/sinanugur/cellsnake
- **Package**: https://anaconda.org/channels/bioconda/packages/cellsnake/overview
- **Validation**: PASS

### Original Help Text
```text
Main cellsnake executable, version: 0.2.0.12

             _  _                     _           
            | || |                   | |          
  ___   ___ | || | ___  _ __    __ _ | | __  ___  
 / __| / _ \| || |/ __|| '_ \  / _` || |/ / / _ \ 
| (__ |  __/| || |\__ \| | | || (_| ||   < |  __/ 
 \___| \___||_||_||___/|_| |_| \__,_||_|\_\ \___| 
                                                  
 
Usage:
    cellsnake <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake integrated <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake --generate-template
    cellsnake --install-packages
    cellsnake (-h | --help)
    cellsnake --version

commands:
    minimal                                Run cellsnake with minimal workflow. 
    standard                               Run cellsnake with standard workflow.
    advanced                               Run cellsnake with advanced workflow.
    clustree                               Run cellsnake with clustree workflow.
    integrate                              Run cellsnake to integrate samples under analyses folder.
                                           This option expects you have already finished processing multiple samples.

main arguments:
    INPUT                                  Input directory or a file to process (if a directory given, batch mode is ON).
                                           After integration, provide the Seurat object file not a directory to work on
                                           integrated object, see tutorial if necessary (e.g. analyses_integrated/seurat/integrated.rds)
    --configfile <text>                    Config file name in YAML format, for example, "config.yaml". No default but can be created with --generate-template.
    --metadata <text>                      Metadata file name in CSV, TSV or Excel format, for example, "metadata.csv", header required, first column sample name. No default but can be created with --generate-template.
    --metadata_column <text>               Metadata column for differential expression analysis [default: condition].

other arguments:
    --gene <gene or filename>              Create publication ready plots for a gene or a list of genes from a text file.
    
main options:
    --percent_mt <double>                  Maximum mitochondrial gene percentage cutoff, 
                                           for example, 5 or 10, write "auto" for auto detection [default: 10].
    --resolution <double>                  Resolution for cluster detection, write "auto" for auto detection [default: 0.8].

other options:
    --doublet_filter <bool>                [default: True] #this may fail on some samples and on low memory. If you have a problem, try False.
    --percent_rp <double>                  [default: 0] #Ribosomal genes minimum percentage (0-100), default no filtering
    --min_cells <integer>                  [default: 3] #seurat default, recommended
    --min_features <integer>               [default: 200] #seurat default, recommended, nFeature_RNA
    --max_features <integer>               [default: Inf] #seurat default, nFeature_RNA, 5000 can be a good cutoff
    --min_molecules <integer>              [default: 0] #seurat default, nCount_RNA, min_features usually handles this so keep it 0
    --max_molecules <integer>              [default: Inf] #seurat default, nCount_RNA, to filter potential doublets, doublet filtering is already default, so keep this Inf
    --highly_variable_features <integer>   [default: 2000] #seurat defaults, recommended
    --variable_selection_method <text>     [default: vst] #seurat defaults, recommended
    
    --normalization_method <text>          [default: LogNormalize]
    --scale_factor <integer>               [default: 10000]
    --logfc_threshold <double>             [default: 0.25]
    --test_use <text>                      [default: wilcox]


    --mapping <text>                       [default: org.Hs.eg.db] #you may install others from Bioconductor, this is for human
    --organism <text>                      [default: hsa] #alternatives https://www.genome.jp/kegg/catalog/org_list.html
    --species <text>                       [default: human] for cellchat, #only human or mouse is accepted

plotting parameters:
    --min_percentage_to_plot <double>        [default: 5] #only show clusters more than % of cells on the legend
    --show_labels <bool>                     [default: True] #
    --marker_plots_per_cluster_n <integer>   [default: 20] #plot summary marker plots for top markers
    --umap_markers_plot <bool>               [default: True]
    --tsne_markers_plot <bool>               [default: False]

annotation options:
    --singler_ref <text>                    [default: BlueprintEncodeData] # https://bioconductor.org/packages/release/data/experiment/vignettes/celldex/inst/doc/userguide.html#1_Overview
    --celltypist_model <text>               [default: Immune_All_Low.pkl] #refer to Celltypist for another model 

microbiome options:
    --kraken_db_folder <text>              No default, you need to provide a folder with kraken2 database
    --taxa <text>                          [default: genus] # available options "domain", "kingdom", "phylum", "class", "order", "family", "genus", "species"
    --microbiome_min_cells <integer>       [default: 1]
    --microbiome_min_features <integer>    [default: 3]
    --confidence <double>                  [default: 0.05] #see kraken2 manual
    --min_hit_groups <integer>             [default: 4] #see kraken2 manual

integration options:
    --dims <integer>                       [default: 30] #refer to Seurat for more details
    --reduction <text>                     [default: cca] #refer to Seurat for more details

others:
    --generate-template                    Generate config file template and metadata template in the current directory.
    --install-packages                     Install, reinstall or check required R packages.
    -j <integer>, --jobs <integer>         Total CPUs. [default: 1]
    -u, --unlock                           Rescue stalled jobs (Try this if the previous job ended prematurely or currently failing).
    -r, --remove                           Delete all output files (this won't affect input files).
    -d, --dry                              Dry run, nothing will be generated.
    -h, --help                             Show this screen.
    --version                              Show version.
```


## cellsnake_INPUT

### Tool Description
Main cellsnake executable

### Metadata
- **Docker Image**: quay.io/biocontainers/cellsnake:0.2.0.12--pyh7cba7a3_0
- **Homepage**: https://github.com/sinanugur/cellsnake
- **Package**: https://anaconda.org/channels/bioconda/packages/cellsnake/overview
- **Validation**: PASS

### Original Help Text
```text
Main cellsnake executable, version: 0.2.0.12

             _  _                     _           
            | || |                   | |          
  ___   ___ | || | ___  _ __    __ _ | | __  ___  
 / __| / _ \| || |/ __|| '_ \  / _` || |/ / / _ \ 
| (__ |  __/| || |\__ \| | | || (_| ||   < |  __/ 
 \___| \___||_||_||___/|_| |_| \__,_||_|\_\ \___| 
                                                  
 
Usage:
    cellsnake <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake integrated <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake --generate-template
    cellsnake --install-packages
    cellsnake (-h | --help)
    cellsnake --version

commands:
    minimal                                Run cellsnake with minimal workflow. 
    standard                               Run cellsnake with standard workflow.
    advanced                               Run cellsnake with advanced workflow.
    clustree                               Run cellsnake with clustree workflow.
    integrate                              Run cellsnake to integrate samples under analyses folder.
                                           This option expects you have already finished processing multiple samples.

main arguments:
    INPUT                                  Input directory or a file to process (if a directory given, batch mode is ON).
                                           After integration, provide the Seurat object file not a directory to work on
                                           integrated object, see tutorial if necessary (e.g. analyses_integrated/seurat/integrated.rds)
    --configfile <text>                    Config file name in YAML format, for example, "config.yaml". No default but can be created with --generate-template.
    --metadata <text>                      Metadata file name in CSV, TSV or Excel format, for example, "metadata.csv", header required, first column sample name. No default but can be created with --generate-template.
    --metadata_column <text>               Metadata column for differential expression analysis [default: condition].

other arguments:
    --gene <gene or filename>              Create publication ready plots for a gene or a list of genes from a text file.
    
main options:
    --percent_mt <double>                  Maximum mitochondrial gene percentage cutoff, 
                                           for example, 5 or 10, write "auto" for auto detection [default: 10].
    --resolution <double>                  Resolution for cluster detection, write "auto" for auto detection [default: 0.8].

other options:
    --doublet_filter <bool>                [default: True] #this may fail on some samples and on low memory. If you have a problem, try False.
    --percent_rp <double>                  [default: 0] #Ribosomal genes minimum percentage (0-100), default no filtering
    --min_cells <integer>                  [default: 3] #seurat default, recommended
    --min_features <integer>               [default: 200] #seurat default, recommended, nFeature_RNA
    --max_features <integer>               [default: Inf] #seurat default, nFeature_RNA, 5000 can be a good cutoff
    --min_molecules <integer>              [default: 0] #seurat default, nCount_RNA, min_features usually handles this so keep it 0
    --max_molecules <integer>              [default: Inf] #seurat default, nCount_RNA, to filter potential doublets, doublet filtering is already default, so keep this Inf
    --highly_variable_features <integer>   [default: 2000] #seurat defaults, recommended
    --variable_selection_method <text>     [default: vst] #seurat defaults, recommended
    
    --normalization_method <text>          [default: LogNormalize]
    --scale_factor <integer>               [default: 10000]
    --logfc_threshold <double>             [default: 0.25]
    --test_use <text>                      [default: wilcox]


    --mapping <text>                       [default: org.Hs.eg.db] #you may install others from Bioconductor, this is for human
    --organism <text>                      [default: hsa] #alternatives https://www.genome.jp/kegg/catalog/org_list.html
    --species <text>                       [default: human] for cellchat, #only human or mouse is accepted

plotting parameters:
    --min_percentage_to_plot <double>        [default: 5] #only show clusters more than % of cells on the legend
    --show_labels <bool>                     [default: True] #
    --marker_plots_per_cluster_n <integer>   [default: 20] #plot summary marker plots for top markers
    --umap_markers_plot <bool>               [default: True]
    --tsne_markers_plot <bool>               [default: False]

annotation options:
    --singler_ref <text>                    [default: BlueprintEncodeData] # https://bioconductor.org/packages/release/data/experiment/vignettes/celldex/inst/doc/userguide.html#1_Overview
    --celltypist_model <text>               [default: Immune_All_Low.pkl] #refer to Celltypist for another model 

microbiome options:
    --kraken_db_folder <text>              No default, you need to provide a folder with kraken2 database
    --taxa <text>                          [default: genus] # available options "domain", "kingdom", "phylum", "class", "order", "family", "genus", "species"
    --microbiome_min_cells <integer>       [default: 1]
    --microbiome_min_features <integer>    [default: 3]
    --confidence <double>                  [default: 0.05] #see kraken2 manual
    --min_hit_groups <integer>             [default: 4] #see kraken2 manual

integration options:
    --dims <integer>                       [default: 30] #refer to Seurat for more details
    --reduction <text>                     [default: cca] #refer to Seurat for more details

others:
    --generate-template                    Generate config file template and metadata template in the current directory.
    --install-packages                     Install, reinstall or check required R packages.
    -j <integer>, --jobs <integer>         Total CPUs. [default: 1]
    -u, --unlock                           Rescue stalled jobs (Try this if the previous job ended prematurely or currently failing).
    -r, --remove                           Delete all output files (this won't affect input files).
    -d, --dry                              Dry run, nothing will be generated.
    -h, --help                             Show this screen.
    --version                              Show version.
```


## cellsnake_After

### Tool Description
Main cellsnake executable

### Metadata
- **Docker Image**: quay.io/biocontainers/cellsnake:0.2.0.12--pyh7cba7a3_0
- **Homepage**: https://github.com/sinanugur/cellsnake
- **Package**: https://anaconda.org/channels/bioconda/packages/cellsnake/overview
- **Validation**: PASS

### Original Help Text
```text
Main cellsnake executable, version: 0.2.0.12

             _  _                     _           
            | || |                   | |          
  ___   ___ | || | ___  _ __    __ _ | | __  ___  
 / __| / _ \| || |/ __|| '_ \  / _` || |/ / / _ \ 
| (__ |  __/| || |\__ \| | | || (_| ||   < |  __/ 
 \___| \___||_||_||___/|_| |_| \__,_||_|\_\ \___| 
                                                  
 
Usage:
    cellsnake <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake integrated <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake --generate-template
    cellsnake --install-packages
    cellsnake (-h | --help)
    cellsnake --version

commands:
    minimal                                Run cellsnake with minimal workflow. 
    standard                               Run cellsnake with standard workflow.
    advanced                               Run cellsnake with advanced workflow.
    clustree                               Run cellsnake with clustree workflow.
    integrate                              Run cellsnake to integrate samples under analyses folder.
                                           This option expects you have already finished processing multiple samples.

main arguments:
    INPUT                                  Input directory or a file to process (if a directory given, batch mode is ON).
                                           After integration, provide the Seurat object file not a directory to work on
                                           integrated object, see tutorial if necessary (e.g. analyses_integrated/seurat/integrated.rds)
    --configfile <text>                    Config file name in YAML format, for example, "config.yaml". No default but can be created with --generate-template.
    --metadata <text>                      Metadata file name in CSV, TSV or Excel format, for example, "metadata.csv", header required, first column sample name. No default but can be created with --generate-template.
    --metadata_column <text>               Metadata column for differential expression analysis [default: condition].

other arguments:
    --gene <gene or filename>              Create publication ready plots for a gene or a list of genes from a text file.
    
main options:
    --percent_mt <double>                  Maximum mitochondrial gene percentage cutoff, 
                                           for example, 5 or 10, write "auto" for auto detection [default: 10].
    --resolution <double>                  Resolution for cluster detection, write "auto" for auto detection [default: 0.8].

other options:
    --doublet_filter <bool>                [default: True] #this may fail on some samples and on low memory. If you have a problem, try False.
    --percent_rp <double>                  [default: 0] #Ribosomal genes minimum percentage (0-100), default no filtering
    --min_cells <integer>                  [default: 3] #seurat default, recommended
    --min_features <integer>               [default: 200] #seurat default, recommended, nFeature_RNA
    --max_features <integer>               [default: Inf] #seurat default, nFeature_RNA, 5000 can be a good cutoff
    --min_molecules <integer>              [default: 0] #seurat default, nCount_RNA, min_features usually handles this so keep it 0
    --max_molecules <integer>              [default: Inf] #seurat default, nCount_RNA, to filter potential doublets, doublet filtering is already default, so keep this Inf
    --highly_variable_features <integer>   [default: 2000] #seurat defaults, recommended
    --variable_selection_method <text>     [default: vst] #seurat defaults, recommended
    
    --normalization_method <text>          [default: LogNormalize]
    --scale_factor <integer>               [default: 10000]
    --logfc_threshold <double>             [default: 0.25]
    --test_use <text>                      [default: wilcox]


    --mapping <text>                       [default: org.Hs.eg.db] #you may install others from Bioconductor, this is for human
    --organism <text>                      [default: hsa] #alternatives https://www.genome.jp/kegg/catalog/org_list.html
    --species <text>                       [default: human] for cellchat, #only human or mouse is accepted

plotting parameters:
    --min_percentage_to_plot <double>        [default: 5] #only show clusters more than % of cells on the legend
    --show_labels <bool>                     [default: True] #
    --marker_plots_per_cluster_n <integer>   [default: 20] #plot summary marker plots for top markers
    --umap_markers_plot <bool>               [default: True]
    --tsne_markers_plot <bool>               [default: False]

annotation options:
    --singler_ref <text>                    [default: BlueprintEncodeData] # https://bioconductor.org/packages/release/data/experiment/vignettes/celldex/inst/doc/userguide.html#1_Overview
    --celltypist_model <text>               [default: Immune_All_Low.pkl] #refer to Celltypist for another model 

microbiome options:
    --kraken_db_folder <text>              No default, you need to provide a folder with kraken2 database
    --taxa <text>                          [default: genus] # available options "domain", "kingdom", "phylum", "class", "order", "family", "genus", "species"
    --microbiome_min_cells <integer>       [default: 1]
    --microbiome_min_features <integer>    [default: 3]
    --confidence <double>                  [default: 0.05] #see kraken2 manual
    --min_hit_groups <integer>             [default: 4] #see kraken2 manual

integration options:
    --dims <integer>                       [default: 30] #refer to Seurat for more details
    --reduction <text>                     [default: cca] #refer to Seurat for more details

others:
    --generate-template                    Generate config file template and metadata template in the current directory.
    --install-packages                     Install, reinstall or check required R packages.
    -j <integer>, --jobs <integer>         Total CPUs. [default: 1]
    -u, --unlock                           Rescue stalled jobs (Try this if the previous job ended prematurely or currently failing).
    -r, --remove                           Delete all output files (this won't affect input files).
    -d, --dry                              Dry run, nothing will be generated.
    -h, --help                             Show this screen.
    --version                              Show version.
```


## cellsnake_integrated

### Tool Description
Main cellsnake executable

### Metadata
- **Docker Image**: quay.io/biocontainers/cellsnake:0.2.0.12--pyh7cba7a3_0
- **Homepage**: https://github.com/sinanugur/cellsnake
- **Package**: https://anaconda.org/channels/bioconda/packages/cellsnake/overview
- **Validation**: PASS

### Original Help Text
```text
Main cellsnake executable, version: 0.2.0.12

             _  _                     _           
            | || |                   | |          
  ___   ___ | || | ___  _ __    __ _ | | __  ___  
 / __| / _ \| || |/ __|| '_ \  / _` || |/ / / _ \ 
| (__ |  __/| || |\__ \| | | || (_| ||   < |  __/ 
 \___| \___||_||_||___/|_| |_| \__,_||_|\_\ \___| 
                                                  
 
Usage:
    cellsnake <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake integrated <command> <INPUT> [options] [--unlock|--remove] [--dry]
    cellsnake --generate-template
    cellsnake --install-packages
    cellsnake (-h | --help)
    cellsnake --version

commands:
    minimal                                Run cellsnake with minimal workflow. 
    standard                               Run cellsnake with standard workflow.
    advanced                               Run cellsnake with advanced workflow.
    clustree                               Run cellsnake with clustree workflow.
    integrate                              Run cellsnake to integrate samples under analyses folder.
                                           This option expects you have already finished processing multiple samples.

main arguments:
    INPUT                                  Input directory or a file to process (if a directory given, batch mode is ON).
                                           After integration, provide the Seurat object file not a directory to work on
                                           integrated object, see tutorial if necessary (e.g. analyses_integrated/seurat/integrated.rds)
    --configfile <text>                    Config file name in YAML format, for example, "config.yaml". No default but can be created with --generate-template.
    --metadata <text>                      Metadata file name in CSV, TSV or Excel format, for example, "metadata.csv", header required, first column sample name. No default but can be created with --generate-template.
    --metadata_column <text>               Metadata column for differential expression analysis [default: condition].

other arguments:
    --gene <gene or filename>              Create publication ready plots for a gene or a list of genes from a text file.
    
main options:
    --percent_mt <double>                  Maximum mitochondrial gene percentage cutoff, 
                                           for example, 5 or 10, write "auto" for auto detection [default: 10].
    --resolution <double>                  Resolution for cluster detection, write "auto" for auto detection [default: 0.8].

other options:
    --doublet_filter <bool>                [default: True] #this may fail on some samples and on low memory. If you have a problem, try False.
    --percent_rp <double>                  [default: 0] #Ribosomal genes minimum percentage (0-100), default no filtering
    --min_cells <integer>                  [default: 3] #seurat default, recommended
    --min_features <integer>               [default: 200] #seurat default, recommended, nFeature_RNA
    --max_features <integer>               [default: Inf] #seurat default, nFeature_RNA, 5000 can be a good cutoff
    --min_molecules <integer>              [default: 0] #seurat default, nCount_RNA, min_features usually handles this so keep it 0
    --max_molecules <integer>              [default: Inf] #seurat default, nCount_RNA, to filter potential doublets, doublet filtering is already default, so keep this Inf
    --highly_variable_features <integer>   [default: 2000] #seurat defaults, recommended
    --variable_selection_method <text>     [default: vst] #seurat defaults, recommended
    
    --normalization_method <text>          [default: LogNormalize]
    --scale_factor <integer>               [default: 10000]
    --logfc_threshold <double>             [default: 0.25]
    --test_use <text>                      [default: wilcox]


    --mapping <text>                       [default: org.Hs.eg.db] #you may install others from Bioconductor, this is for human
    --organism <text>                      [default: hsa] #alternatives https://www.genome.jp/kegg/catalog/org_list.html
    --species <text>                       [default: human] for cellchat, #only human or mouse is accepted

plotting parameters:
    --min_percentage_to_plot <double>        [default: 5] #only show clusters more than % of cells on the legend
    --show_labels <bool>                     [default: True] #
    --marker_plots_per_cluster_n <integer>   [default: 20] #plot summary marker plots for top markers
    --umap_markers_plot <bool>               [default: True]
    --tsne_markers_plot <bool>               [default: False]

annotation options:
    --singler_ref <text>                    [default: BlueprintEncodeData] # https://bioconductor.org/packages/release/data/experiment/vignettes/celldex/inst/doc/userguide.html#1_Overview
    --celltypist_model <text>               [default: Immune_All_Low.pkl] #refer to Celltypist for another model 

microbiome options:
    --kraken_db_folder <text>              No default, you need to provide a folder with kraken2 database
    --taxa <text>                          [default: genus] # available options "domain", "kingdom", "phylum", "class", "order", "family", "genus", "species"
    --microbiome_min_cells <integer>       [default: 1]
    --microbiome_min_features <integer>    [default: 3]
    --confidence <double>                  [default: 0.05] #see kraken2 manual
    --min_hit_groups <integer>             [default: 4] #see kraken2 manual

integration options:
    --dims <integer>                       [default: 30] #refer to Seurat for more details
    --reduction <text>                     [default: cca] #refer to Seurat for more details

others:
    --generate-template                    Generate config file template and metadata template in the current directory.
    --install-packages                     Install, reinstall or check required R packages.
    -j <integer>, --jobs <integer>         Total CPUs. [default: 1]
    -u, --unlock                           Rescue stalled jobs (Try this if the previous job ended prematurely or currently failing).
    -r, --remove                           Delete all output files (this won't affect input files).
    -d, --dry                              Dry run, nothing will be generated.
    -h, --help                             Show this screen.
    --version                              Show version.
```


## Metadata
- **Skill**: generated
