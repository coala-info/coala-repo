# sam2lca CWL Generation Report

## sam2lca_analyze

### Tool Description
Run the sam2lca analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/sam2lca:1.1.4--pyhdfd78af_0
- **Homepage**: https://github.com/maxibor/sam2lca
- **Package**: https://anaconda.org/channels/bioconda/packages/sam2lca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sam2lca/overview
- **Total Downloads**: 12.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/maxibor/sam2lca
- **Stars**: N/A
### Original Help Text
```text
Usage: sam2lca analyze [OPTIONS] SAM

  Run the sam2lca analysis

  SAM: path to SAM/BAM/CRAM alignment file

Options:
  -t, --taxonomy TEXT             Taxonomy database to use  [default: ncbi]
  -a, --acc2tax TEXT              acc2tax database to use  [default: nucl]
  -i, --identity FLOAT RANGE      Minimum identity threshold NOTE: This
                                  argument is mutually exclusive with
                                  arguments: [distance].  [default: 0.8;
                                  0<=x<=1]
  -d, --distance INTEGER          Edit distance threshold NOTE: This argument
                                  is mutually exclusive with  arguments:
                                  [identity].
  -l, --length INTEGER            Minimum alignment length  [default: 30]
  -c, --conserved                 Ignore reads mapping in ultraconserved
                                  regions
  -p, --process INTEGER           Number of process for parallelization
                                  [default: 2]
  -o, --output FILE               sam2lca output file. Default:
                                  [basename].sam2lca.*
  -b, --bam_out                   Write BAM output file with XT tag for TAXID
  -r, --bam_split_rank [strain|species|genus|family|order|class|phylum|superkingdom]
                                  Write BAM output file split by TAXID at rank
                                  -r. To use in combination with -b/--bam_out
  -n, --bam_split_read INTEGER    Minimum numbers of reads to write BAM split
                                  by TAXID. To use in combination with
                                  -b/--bam_out  [default: 50]
  --help                          Show this message and exit.
```


## sam2lca_list-db

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/sam2lca:1.1.4--pyhdfd78af_0
- **Homepage**: https://github.com/maxibor/sam2lca
- **Package**: https://anaconda.org/channels/bioconda/packages/sam2lca/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: sam2lca list-db [OPTIONS]

  List available taxonomy and acc2tax databases

Options:
  --help  Show this message and exit.
```


## sam2lca_update-db

### Tool Description
Download/prepare acc2tax and taxonomy databases

### Metadata
- **Docker Image**: quay.io/biocontainers/sam2lca:1.1.4--pyhdfd78af_0
- **Homepage**: https://github.com/maxibor/sam2lca
- **Package**: https://anaconda.org/channels/bioconda/packages/sam2lca/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sam2lca update-db [OPTIONS]

  Download/prepare acc2tax and taxonomy databases

Options:
  -t, --taxonomy TEXT  Name of taxonomy database to create (ncbi | gtdb)
                       [default: ncbi]
  --taxo_names FILE    names.dmp file for Taxonomy database (optional). Only
                       needed for custom taxonomy database (non ncbi or gtdb)
  --taxo_nodes FILE    nodes.dmp file for Taxonomy database (optional). Only
                       needed for custom taxonomy database (non ncbi or gtdb)
  --taxo_merged FILE   merged.dmp file for Taxonomy database (optional). Only
                       needed for custom taxonomy database (non ncbi or gtdb)
  -a, --acc2tax TEXT   Type of acc2tax mapping database to build.
  --acc2tax_json PATH  JSON file for specifying extra acc2tax mappings
                       [default: https://raw.githubusercontent.com/maxibor/sam
                       2lca/master/data/acc2tax.json]
  --help               Show this message and exit.
```

