# vamb CWL Generation Report

## vamb_bin

### Tool Description
Binning module of VAMB

### Metadata
- **Docker Image**: quay.io/biocontainers/vamb:5.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/RasmussenLab/vamb
- **Package**: https://anaconda.org/channels/bioconda/packages/vamb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vamb/overview
- **Total Downloads**: 22.1K
- **Last updated**: 2025-04-29
- **GitHub**: https://github.com/RasmussenLab/vamb
- **Stars**: N/A
### Original Help Text
```text
usage: vamb bin [-h] [--version] {default,taxvamb,avamb} ...

positional arguments:
  {default,taxvamb,avamb}
    default             default binner based on a variational autoencoder. See
                        the paper 'Improved metagenome binning and assembly
                        using deep variational autoencoders'
    taxvamb             taxonomy informed binner based on a bi-modal
                        variational autoencoder. See the paper 'TaxVAMB:
                        taxonomic annotations improve metagenome binning'
    avamb               ==SUPPRESS==

Help and version:
  -h, --help            Print help and exit
  --version             show program's version number and exit
```


## vamb_taxometer

### Tool Description
Refine taxonomy using composition and abundance information.

### Metadata
- **Docker Image**: quay.io/biocontainers/vamb:5.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/RasmussenLab/vamb
- **Package**: https://anaconda.org/channels/bioconda/packages/vamb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vamb taxometer [options]

Refine taxonomy using composition and abundance information.

Required arguments: Outdir, unrefined taxonomy, at least one composition input and at least one abundance input

Help and version:
  -h, --help        Print help and exit
  --version         show program's version number and exit

Output:
  --outdir          Output directory to create

General optional arguments:
  -m                Ignore contigs shorter than this [2000]
  -p                number of threads to use where customizable [8]
  --norefcheck      Skip reference name hashing check [False]
  --cuda            Use GPU to train & cluster [False]
  --seed            Random seed (determinism not guaranteed)

Composition input:
  --fasta           Path to fasta file
  --composition     Path to .npz of composition

Abundance input:
  --bamdir          Dir with .bam files to use
  --abundance_tsv   Path to TSV file of precomputed abundances with header
                    being "contigname(\t<samplename>)*"
  --abundance       Path to .npz of abundances

Taxonomy input:
  --taxonomy        Path to the taxonomy file
```


## vamb_recluster

### Tool Description
Use marker genes to re-cluster (DBScan) or refine (K-means) clusters.

### Metadata
- **Docker Image**: quay.io/biocontainers/vamb:5.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/RasmussenLab/vamb
- **Package**: https://anaconda.org/channels/bioconda/packages/vamb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vamb recluster [options]

Use marker genes to re-cluster (DBScan) or refine (K-means) clusters.
        
Required arguments:
  K-means algorithm: Outdir, at least one composition input, at least one marker gene input,
    latent path and clusters path
  DBScan algorithm with --no_predictor: Outdir, at least one composition input,
    at least one marker gene input, latent path and taxonomy
  DBScan algorithm without --no_predictor: Outdir, at least one composition input,
    at least one abundance input, at least one marker gene input, latent path and taxonomy

Help and version:
  -h, --help        Print help and exit
  --version         show program's version number and exit

Output:
  --outdir          Output directory to create

General optional arguments:
  -m                Ignore contigs shorter than this [2000]
  -p                number of threads to use where customizable [8]
  --norefcheck      Skip reference name hashing check [False]
  --cuda            Use GPU to train & cluster [False]
  --seed            Random seed (determinism not guaranteed)

Composition input:
  --fasta           Path to fasta file
  --composition     Path to .npz of composition

Abundance input:
  --bamdir          Dir with .bam files to use
  --abundance_tsv   Path to TSV file of precomputed abundances with header
                    being "contigname(\t<samplename>)*"
  --abundance       Path to .npz of abundances

Marker gene input:
  --markers         Path to the marker .npz file
  --hmm_path        Path to the .hmm file of marker gene profiles

Bin output options:
  --minfasta        Minimum bin size to output as fasta [None = no files]
  -o []             Binsplit separator [C if present] (pass empty string to
                    disable)

K-means reclustering arguments:
  --latent_path     Path to latent space .npz file
  --clusters_path   Path to TSV file with clusters
  --algorithm       Which reclustering algorithm to use ('kmeans', 'dbscan')
                    [kmeans]

Taxonomy input:
  --taxonomy        Path to the taxonomy file
  --no_predictor    Do not complete input taxonomy with Taxometer [False]
```


## Metadata
- **Skill**: generated
