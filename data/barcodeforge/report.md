# barcodeforge CWL Generation Report

## barcodeforge_barcode

### Tool Description
Process barcode data, including VCF generation, tree formatting, USHER placement, matUtils annotation, and matUtils extraction.

### Metadata
- **Docker Image**: quay.io/biocontainers/barcodeforge:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/BarcodeForge
- **Package**: https://anaconda.org/channels/bioconda/packages/barcodeforge/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/barcodeforge/overview
- **Total Downloads**: 877
- **Last updated**: 2025-12-15
- **GitHub**: https://github.com/andersen-lab/BarcodeForge
- **Stars**: N/A
### Original Help Text
```text
Usage: barcodeforge barcode [OPTIONS] REFERENCE_GENOME ALIGNMENT TREE LINEAGES 
                                                                                
 Process barcode data, including VCF generation, tree formatting, USHER         
 placement, matUtils annotation, and matUtils extraction.                       
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --tree-format       -t  [newick|nexus]       Specify the format of the tree  │
│                                              file (newick or nexus)          │
│ --usher-args        -u  TEXT                 Additional arguments to pass to │
│                                              usher (e.g., '-U -l'). Quote    │
│                                              multiple arguments.             │
│ --threads           -T  INT [x>=1]           Number of CPUs/threads to use.  │
│                                              [default: 8]                    │
│ --matutils-overlap  -m  FLOAT [0.0<=x<=1.0]  Value for --set-overlap in      │
│                                              matUtils annotate. [default: 0] │
│ --prefix            -p  TEXT                 Prefix to add to lineage names  │
│                                              in the barcode file. [default:  │
│                                              ""]                             │
│ --plot-chunk-size   -c  INTEGER              Number of mutations to render   │
│                                              in each plot chunk. Use -1 for  │
│                                              no chunking. [default: 100]     │
│ --help                                       Show this message and exit.     │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## barcodeforge_extract-auspice-data

### Tool Description
Extract metadata and tree from an Auspice JSON file. Inspired by Dr. John Huddleston's Gist on processing Auspice JSON files. Source: https://gist.github.com/huddlej/5d7bd023d3807c698bd18c706974f2db

### Metadata
- **Docker Image**: quay.io/biocontainers/barcodeforge:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/andersen-lab/BarcodeForge
- **Package**: https://anaconda.org/channels/bioconda/packages/barcodeforge/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: barcodeforge extract-auspice-data [OPTIONS] AUSPICE_JSON_PATH           
                                                                                
 Extract metadata and tree from an Auspice JSON file. Inspired by Dr. John      
 Huddleston's Gist on processing Auspice JSON files. Source:                    
 https://gist.github.com/huddlej/5d7bd023d3807c698bd18c706974f2db               
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --output_metadata_path    PATH  Path to save the metadata table (TSV         │
│                                 format). [default: metadata.tsv]             │
│ --output_tree_path        PATH  Path to save the tree in Newick format.      │
│                                 [default: tree.nwk]                          │
│ --include_internal_nodes        Include internal nodes in the output tree.   │
│ --attributes              TEXT  Attributes to include in the metadata table  │
│                                 (e.g., 'country', 'date').                   │
│ --help                          Show this message and exit.                  │
╰──────────────────────────────────────────────────────────────────────────────╯
```

