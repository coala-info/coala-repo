# traitar CWL Generation Report

## traitar_phenotype

### Tool Description
Annotate genomes and then run phenotyping

### Metadata
- **Docker Image**: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
- **Homepage**: http://github.com/aweimann/traitar
- **Package**: https://anaconda.org/channels/bioconda/packages/traitar/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/traitar/overview
- **Total Downloads**: 5.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/aweimann/traitar
- **Stars**: N/A
### Original Help Text
```text
usage: traitar phenotype [-h] [-c CPUS] [-x PARALLEL] [-o]
                         [-g {genbank,refseq,img,prodigal,metagenemark}]
                         [-p PRIMARY_MODELS] [-s SECONDARY_MODELS]
                         [-r REARRANGE_HEATMAP]
                         [--no_heatmap_sample_clustering]
                         [--no_heatmap_phenotype_clustering]
                         [-f {png,pdf,svg,jpg}]
                         pfam_dir input_dir sample2file
                         {from_genes,from_nucleotides,from_annotation_summary}
                         output_dir

Phenotype

positional arguments:
  pfam_dir              Download directory of pfam subcommand
  input_dir             directory with the input data
  sample2file           Mapping from samples to fasta files (also see gitHub help):
                         sample1_file_name{tab}sample1_name
                         sample2_file_name{tab}sample2_name
  {from_genes,from_nucleotides,from_annotation_summary}
                        Either from_genes if gene prediction amino acid fasta is available in otherwise from_nucleotides in this case Prodigal is used to determine the ORFs from the nucleotide fasta files in input_dir
  output_dir            Output directory (default: phenolyzer_output)

options:
  -h, --help            show this help message and exit
  -c CPUS, --cpus CPUS  CPUs used for running hmmsearch & other executables (default: 1)
  -x PARALLEL, --parallel PARALLEL
                        Number of samples to process in parallel (default: 1)
  -o, --overwrite       Overwrite output directories (default: False)
  -g {genbank,refseq,img,prodigal,metagenemark}, --gene_gff_type {genbank,refseq,img,prodigal,metagenemark}
                        If the input is amino acids the type of gene prediction GFF file can be specified for mapping the phenotype predictions to the genes (default: None)
  -p PRIMARY_MODELS, --primary_models PRIMARY_MODELS
                        Primary phenotype models archive
  -s SECONDARY_MODELS, --secondary_models SECONDARY_MODELS
                        Secondary phenotype models archive
  -r REARRANGE_HEATMAP, --rearrange_heatmap REARRANGE_HEATMAP
                        Recompute the phenotype heatmaps based on a subset of previously annotated and phenotyped samples(default: None)
  --no_heatmap_sample_clustering
                        if option is set, don't cluster the phenotype heatmaps by samples and keep input ordering
  --no_heatmap_phenotype_clustering
                        if option is set, don't cluster the heatmaps by phenotype and keep input ordering
  -f {png,pdf,svg,jpg}, --heatmap_format {png,pdf,svg,jpg}
                        choose file format for the heatmap

DESCRIPTION:
    Annotate genomes and then run phenotyping
    NOTE: you will likely want to use `--overwrite`
```


## traitar_annotate

### Tool Description
Annotate genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
- **Homepage**: http://github.com/aweimann/traitar
- **Package**: https://anaconda.org/channels/bioconda/packages/traitar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: traitar annotate [-h] [-c CPUS] [-x PARALLEL] [-o]
                        [-g {genbank,refseq,img,prodigal,metagenemark}]
                        pfam_dir input_dir sample2file
                        {from_genes,from_nucleotides,from_annotation_summary}
                        output_dir

Annotate

positional arguments:
  pfam_dir              Download directory of pfam subcommand
  input_dir             directory with the input data
  sample2file           Mapping from samples to fasta files (also see gitHub help):
                         sample1_file_name{tab}sample1_name
                         sample2_file_name{tab}sample2_name
  {from_genes,from_nucleotides,from_annotation_summary}
                        Either from_genes if gene prediction amino acid fasta is available in otherwise from_nucleotides in this case Prodigal is used to determine the ORFs from the nucleotide fasta files in input_dir
  output_dir            Output directory (default: phenolyzer_output)

options:
  -h, --help            show this help message and exit
  -c CPUS, --cpus CPUS  CPUs used for running hmmsearch & other executables (default: 1)
  -x PARALLEL, --parallel PARALLEL
                        Number of samples to process in parallel (default: 1)
  -o, --overwrite       Overwrite output directories (default: False)
  -g {genbank,refseq,img,prodigal,metagenemark}, --gene_gff_type {genbank,refseq,img,prodigal,metagenemark}
                        If the input is amino acids the type of gene prediction GFF file can be specified for mapping the phenotype predictions to the genes (default: None)

DESCRIPTION:
    Annotate genomes
```


## traitar_pfam

### Tool Description
Download and uncompress pfam files.
The files are required for gene annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
- **Homepage**: http://github.com/aweimann/traitar
- **Package**: https://anaconda.org/channels/bioconda/packages/traitar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: traitar pfam [-h] [--local] download_dir

Download pfam files

positional arguments:
  download_dir  Download Pfam HMMs into this directory and untar and unzip them

options:
  -h, --help    show this help message and exit
  --local, -l   The Pfam HMMs are in the above directory with name "Pfam-A.hmm"

DESCRIPTION:
    Download and uncompress pfam files.
    The files are required for gene annotation.
```


## traitar_show

### Tool Description
show features important for classification

### Metadata
- **Docker Image**: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
- **Homepage**: http://github.com/aweimann/traitar
- **Package**: https://anaconda.org/channels/bioconda/packages/traitar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: traitar show [-h] [--predictor {phypat,phypat+PGL}]
                    [--strategy {non-zero,majority}] [-i] [-p MODELS_F]
                    phenotype

show features important for classification

positional arguments:
  phenotype             phenotype under investigation

options:
  -h, --help            show this help message and exit
  --predictor {phypat,phypat+PGL}
                        pick phypat or phypat+PGL classifier
  --strategy {non-zero,majority}
  -i, --include_negative
  -p MODELS_F, --models_f MODELS_F
                        phenotype models archive; if set look for the target in the phenotype in thegiven phenotype collection

DESCRIPTION:
    show features important for classification
```


## traitar_new

### Tool Description
create new phenotype model archive

### Metadata
- **Docker Image**: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
- **Homepage**: http://github.com/aweimann/traitar
- **Package**: https://anaconda.org/channels/bioconda/packages/traitar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: traitar new [-h]
                   models_dir pf_acc2desc pt_id2acc_desc {dbcan,pfam}
                   hmm_model_f archive_name

create new phenotype model archive

positional arguments:
  models_dir      directory with phenotype models to be included
  pf_acc2desc     a mapping between Pfam families and phenotype ids to accessions
  pt_id2acc_desc  a mapping between phenotype ids and descriptions
  {dbcan,pfam}    hmm database used
  hmm_model_f     hmm database compatible with the phenotype archive
  archive_name    name of the model, which is created

options:
  -h, --help      show this help message and exit

DESCRIPTION:
    create new phenotype model archive
```


## traitar_remove

### Tool Description
remove phenotypes from a given phenotype archive

### Metadata
- **Docker Image**: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
- **Homepage**: http://github.com/aweimann/traitar
- **Package**: https://anaconda.org/channels/bioconda/packages/traitar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: traitar remove [-h] [--keep] archive_f phenotypes out_f

remove phenotypes from a given phenotype archive

positional arguments:
  archive_f   phenotype model archive file, which shall be modified
  phenotypes  phenotypes to be removed
  out_f       out file for the modified phenotype tar archive

options:
  -h, --help  show this help message and exit
  --keep      instead of remove the given phenotypes keep them and forget the rest

DESCRIPTION:
    remove phenotypes from a given phenotype archive
```


## traitar_evaluate

### Tool Description
compare Traitar predictions against a given standard of truth

### Metadata
- **Docker Image**: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
- **Homepage**: http://github.com/aweimann/traitar
- **Package**: https://anaconda.org/channels/bioconda/packages/traitar/overview
- **Validation**: PASS

### Original Help Text
```text
usage: traitar evaluate [-h] [--are_pt_ids]
                        [--phenotype_archive PHENOTYPE_ARCHIVE]
                        [--min_samples MIN_SAMPLES]
                        traitar_pred_f gold_standard_f out

compare Traitar predictions against a given standard of truth

positional arguments:
  traitar_pred_f        phenotype prediction matrix as return by Traitar
  gold_standard_f       phenotype matrix with standard of truth
  out                   output directory

options:
  -h, --help            show this help message and exit
  --are_pt_ids          Set if the gold standard phenotype are indexed via phenotype IDs rather than accessions
  --phenotype_archive PHENOTYPE_ARCHIVE
                        Needed if gold standard uses an accession index for mapping
  --min_samples MIN_SAMPLES, -m MIN_SAMPLES
                        minimum number of positive and negative samples to consider phenotypes for calculation of the macro accuracy

DESCRIPTION:
    compare Traitar predictions against a given standard of truth
```


## Metadata
- **Skill**: generated
