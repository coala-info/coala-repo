# scenicplus CWL Generation Report

## scenicplus_init_snakemake

### Tool Description
Initialize ScenicPlus project for Snakemake

### Metadata
- **Docker Image**: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/scenicplus
- **Package**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Total Downloads**: 94
- **Last updated**: 2025-12-17
- **GitHub**: https://github.com/aertslab/scenicplus
- **Stars**: N/A
### Original Help Text
```text
/usr/local/lib/python3.11/site-packages/scenicplus/__init__.py:1: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  from pkg_resources import get_distribution, DistributionNotFound
usage: scenicplus init_snakemake [-h] --out_dir OUT_DIR
scenicplus init_snakemake: error: argument -h/--help: ignored explicit argument 'elp'
```


## scenicplus_prepare_data

### Tool Description
Prepare gene expression, chromatin accessibility and motif enrichment data.

### Metadata
- **Docker Image**: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/scenicplus
- **Package**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Validation**: PASS

### Original Help Text
```text
____   ____ _____ _   _ ___ ____      
  / ___| / ___| ____| \ | |_ _/ ___|[31;1m _ [0m
  \___ \| |   |  _| |  \| || | |  [31;1m _|.|_[0m
   ___) | |___| |___| |\  || | |__[31;1m|_..._|[0m
  |____/ \____|_____|_| \_|___\____|[31;1m|_|[0m 


scenicplus verions: 1.0a2
usage: scenicplus prepare_data [-h]
                               {prepare_GEX_ACC,prepare_menr,download_genome_annotations,search_spance}
                               ...

Prepare gene expression, chromatin accessibility and motif enrichment data.

positional arguments:
  {prepare_GEX_ACC,prepare_menr,download_genome_annotations,search_spance}

options:
  -h, --help            show this help message and exit
```


## scenicplus_grn_inference

### Tool Description
Infer Enhancer driven Gene Regulatory Networks.

### Metadata
- **Docker Image**: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
- **Homepage**: https://github.com/aertslab/scenicplus
- **Package**: https://anaconda.org/channels/bioconda/packages/scenicplus/overview
- **Validation**: PASS

### Original Help Text
```text
____   ____ _____ _   _ ___ ____      
  / ___| / ___| ____| \ | |_ _/ ___|[31;1m _ [0m
  \___ \| |   |  _| |  \| || | |  [31;1m _|.|_[0m
   ___) | |___| |___| |\  || | |__[31;1m|_..._|[0m
  |____/ \____|_____|_| \_|___\____|[31;1m|_|[0m 


scenicplus verions: 1.0a2
usage: scenicplus grn_inference [-h]
                                {TF_to_gene,region_to_gene,motif_enrichment_cistarget,motif_enrichment_dem,eGRN,AUCell,create_scplus_mudata}
                                ...

Infer Enhancer driven Gene Regulatory Networks.

positional arguments:
  {TF_to_gene,region_to_gene,motif_enrichment_cistarget,motif_enrichment_dem,eGRN,AUCell,create_scplus_mudata}

options:
  -h, --help            show this help message and exit
```


## Metadata
- **Skill**: not generated
