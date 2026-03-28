[Autometa](index.html)

latest

* [Getting Started](getting-started.html)
* [🍏 Nextflow Workflow 🍏](nextflow-workflow.html)
* [🐚 Bash Workflow 🐚](bash-workflow.html)
* [📓 Bash Step by Step Tutorial 📓](bash-step-by-step-tutorial.html)
* [Databases](databases.html)
* [Examining Results](examining-results.html)
* Benchmarking
  + [Benchmarking with the `autometa-benchmark` module](#benchmarking-with-the-autometa-benchmark-module)
    - [Taxon-profiling](#taxon-profiling)
      * [Example benchmarking with simulated communities](#example-benchmarking-with-simulated-communities)
    - [Clustering](#clustering)
      * [Example benchmarking with simulated communities](#id1)
    - [Binning](#binning)
      * [Example benchmarking with simulated communities](#id2)
  + [Autometa Test Datasets](#autometa-test-datasets)
    - [Descriptions](#descriptions)
      * [Simulated Communities](#simulated-communities)
      * [Synthetic Communities](#synthetic-communities)
    - [Download](#download)
      * [Using `autometa-download-dataset`](#using-autometa-download-dataset)
      * [Using `gdrive`](#using-gdrive)
  + [Advanced](#advanced)
    - [Data Handling](#data-handling)
      * [Aggregating benchmarking results](#aggregating-benchmarking-results)
    - [Downloading multiple test datasets at once](#downloading-multiple-test-datasets-at-once)
    - [Generating new simulated communities](#generating-new-simulated-communities)
* [Installation](installation.html)
* [Autometa Python API](autometa-python-api.html)
* [Usage](scripts/usage.html)
* [How to contribute](how-to-contribute.html)
* [Autometa modules](Autometa_modules/modules.html)
* [Legacy Autometa](legacy-autometa.html)
* [License](license.html)

[Autometa](index.html)

* Benchmarking
* [Edit on GitHub](https://github.com/KwanLab/Autometa/blob/main/docs/source/benchmarking.rst)

---

# Benchmarking[](#benchmarking "Permalink to this heading")

Note

The most recent Autometa benchmarking results covering multiple modules and input parameters are hosted on our
[KwanLab/metaBenchmarks](https://github.com/KwanLab/metaBenchmarks) Github repository and provide a range of
analyses covering multiple stages and parameter sets. These benchmarks are available with their own respective
modules so that the community may easily assess how Autometa’s novel (`taxon-profiling`, `clustering`,
`binning`, `refinement`) algorithms perform compared to current state-of-the-art methods. Tools were selected for
benchmarking based on their relevance to environmental, single-assembly, reference-free binning pipelines.

## Benchmarking with the `autometa-benchmark` module[](#benchmarking-with-the-autometa-benchmark-module "Permalink to this heading")

Autometa includes the `autometa-benchmark` entrypoint, a script to benchmark Autometa taxon-profiling, clustering
and binning-classification prediction results using clustering and classification evaluation metrics. To select the
appropriate benchmarking method, supply the `--benchmark` parameter with the respective choice. The three benchmarking
methods are detailed below.

Note

If you’d like to follow along with the benchmarking commands, you may download the test datasets
using:

```
autometa-download-dataset \
    --community-type simulated \
    --community-sizes 78Mbp \
    --file-names reference_assignments.tsv.gz binning.tsv.gz taxonomy.tsv.gz \
    --dir-path $HOME/Autometa/autometa/datasets/simulated
```

This will download three files:

* `reference_assignments`: tab-delimited file containing contigs with their reference genome assignments. `cols: [contig, reference_genome, taxid, organism_name, ftp_path, length]`
* `binning.tsv.gz`: tab-delimited file containing contigs with Autometa binning predictions, `cols: [contig, cluster]`
* `taxonomy.tsv.gz`: tab-delimited file containing contigs with Autometa taxon-profiling predictions `cols: [contig, kingdom, phylum, class, order, family, genus, species, taxid]`

### Taxon-profiling[](#taxon-profiling "Permalink to this heading")

#### Example benchmarking with simulated communities[](#example-benchmarking-with-simulated-communities "Permalink to this heading")

```
# Set community size (see above for selection/download of other community types)
community_size=78Mbp

# Inputs
## NOTE: predictions and reference were downloaded using autometa-download-dataset
predictions="$HOME/Autometa/autometa/datasets/simulated/${community_size}/taxonomy.tsv.gz" # required columns -> contig, taxid
reference="$HOME/Autometa/autometa/datasets/simulated/${community_size}/reference_assignments.tsv.gz"
ncbi=$HOME/Autometa/autometa/databases/ncbi

# Outputs
output_wide="${community_size}.taxon_profiling_benchmarks.wide.tsv.gz" # file path
output_long="${community_size}.taxon_profiling_benchmarks.long.tsv.gz" # file path
reports="${community_size}_taxon_profiling_reports" # directory path

autometa-benchmark \
    --benchmark classification \
    --predictions $predictions \
    --reference $reference \
    --ncbi $ncbi \
    --output-wide $output_wide \
    --output-long $output_long \
    --output-classification-reports $reports
```

Note

Using `--benchmark=classification` requires the path to a directory containing files (nodes.dmp, names.dmp, merged.dmp)
from NCBI’s taxdump tarball. This should be supplied using the `--ncbi` parameter.

### Clustering[](#clustering "Permalink to this heading")

#### Example benchmarking with simulated communities[](#id1 "Permalink to this heading")

```
# Set community size (see above for selection/download of other community types)
community_size=78Mbp

# Inputs
## NOTE: predictions and reference were downloaded using autometa-download-dataset
predictions="$HOME/Autometa/autometa/datasets/simulated/${community_size}/binning.tsv.gz" # required columns -> contig, cluster
reference="$HOME/Autometa/autometa/datasets/simulated/${community_size}/reference_assignments.tsv.gz"

# Outputs
output_wide="${community_size}.clustering_benchmarks.wide.tsv.gz"
output_long="${community_size}.clustering_benchmarks.long.tsv.gz"

autometa-benchmark \
    --benchmark clustering \
    --predictions $predictions \
    --reference $reference \
    --output-wide $output_wide \
    --output-long $output_long
```

### Binning[](#binning "Permalink to this heading")

#### Example benchmarking with simulated communities[](#id2 "Permalink to this heading")

```
# Set community size (see above for selection/download of other community types)
community_size=78Mbp

# Inputs
## NOTE: predictions and reference were downloaded using autometa-download-dataset
predictions="$HOME/Autometa/autometa/datasets/simulated/${community_size}/binning.tsv.gz" # required columns -> contig, cluster
reference="$HOME/Autometa/autometa/datasets/simulated/${community_size}/reference_assignments.tsv.gz"

# Outputs
output_wide="${community_size}.binning_benchmarks.wide.tsv.gz"
output_long="${community_size}.binning_benchmarks.long.tsv.gz"

autometa-benchmark \
    --benchmark binning-classification \
    --predictions $predictions \
    --reference $reference \
    --output-wide $output_wide \
    --output-long $output_long
```

## Autometa Test Datasets[](#autometa-test-datasets "Permalink to this heading")

### Descriptions[](#descriptions "Permalink to this heading")

#### Simulated Communities[](#simulated-communities "Permalink to this heading")

Autometa Simulated Communities[](#id3 "Permalink to this table")

| Community | Num. Genomes | Num. Control Sequences |
| --- | --- | --- |
| [78.125Mbp](https://drive.google.com/drive/folders/1McxKviIzkPyr8ovj8BG7n_IYk-QfHAgG?usp=sharing) | 21 | 4,044 |
| [156.25Mbp](https://drive.google.com/drive/folders/1AUyPh2p4HRqCiKCidkredEBYR1mh-zWN?usp=sharing) | 38 | 3,573 |
| [312.50Mbp](https://drive.google.com/drive/folders/1mt7tficWepc1Vlh-9I6BUmz6b6GBiO4p?usp=sharing) | 85 | 7,708 |
| [625Mbp](https://drive.google.com/drive/folders/1GZmxnal1HzpTnh7HRU6lSDhUCOLXmq5x?usp=sharing) | 166 | 17,590 |
| [1250Mbp](https://drive.google.com/drive/folders/17hnBBfmmAmj7on5JzSxR73zGVwhMDzUG?usp=sharing) | 319 | 41,507 |
| [2500Mbp](https://drive.google.com/drive/folders/1re57q-mwLLq_qzdFkdA2eJoh41uMeEvl?usp=sharing) | 656 | 67,702 |
| [5000Mbp](https://drive.google.com/drive/folders/1gFN2jUdY9o2kYDoBzLEIyggkHv58bTG3?usp=sharing) | 1,288 | 140,529 |
| [10000Mbp](https://drive.google.com/drive/folders/1YaEn6rQvBiXLgyIWkxc-EruiYAorCIes?usp=sharing) | 2,638 | 285,262 |

You can download all the Simulated communities using this [link](https://drive.google.com/drive/folders/1JFjVb-pfQTv4GXqvqRuTOZTfKdT0MwhN?usp=sharing).
Individual communities can be downloaded using the links in the above table.

For more information on simulated communities,
check the [README.md](https://drive.google.com/file/d/1Ti05Qp13FleuMQdnp3C5L-sXnIM25EZE/view?usp=sharing)
located in the `simulated_communities` directory.

#### Synthetic Communities[](#synthetic-communities "Permalink to this heading")

51 bacterial isolates were assembled into synthetic communities which we’ve titled `MIX51`.

The initial synthetic community was prepared using a mixture of fifty-one bacterial isolates.
The synthetic community’s DNA was extracted for sequencing, assembly and binning.

You can download the MIX51 community using this [link](https://drive.google.com/drive/folders/1x8d0o6HO5N72j7p_D_YxrSurBfpi9zmK?usp=sharing).

### Download[](#download "Permalink to this heading")

#### Using `autometa-download-dataset`[](#using-autometa-download-dataset "Permalink to this heading")

Autometa is packaged with a built-in module that allows any user to download any of the available test datasets.
To use retrieve these datasets one simply needs to run the `autometa-download-dataset` command.

For example, to download the reference assignments for a simulated community as well as the most recent Autometa
binning and taxon-profiling predictions for this community, provide the following parameters:

```
# choices for simulated: 78Mbp,156Mbp,312Mbp,625Mbp,1250Mbp,2500Mbp,5000Mbp,10000Mbp
autometa-download-dataset \
    --community-type simulated \
    --community-sizes 78Mbp \
    --file-names reference_assignments.tsv.gz binning.tsv.gz taxonomy.tsv.gz \
    --dir-path simulated
```

This will download `reference_assignments.tsv.gz`, `binning.tsv.gz`, `taxonomy.tsv.gz` to the `simulated/78Mbp` directory.

* `reference_assignments`: tab-delimited file containing contigs with their reference genome assignments. `cols: [contig, reference_genome, taxid, organism_name, ftp_path, length]`
* `binning.tsv.gz`: tab-delimited file containing contigs with Autometa binning predictions, `cols: [contig, cluster]`
* `taxonomy.tsv.gz`: tab-delimited file containing contigs with Autometa taxon-profiling predictions `cols: [contig, kingdom, phylum, class, order, family, genus, species, taxid]`

#### Using `gdrive`[](#using-gdrive "Permalink to this heading")

You can download the individual assemblies of different datasests with the help of `gdown` using command line
(This is what `autometa-download-dataset` is using behind the scenes). If you have installed `autometa` using
`mamba` then `gdown` should already be installed. If not, you can install it using
`mamba install -c conda-forge gdown` or `pip install gdown`.

##### Example for the 78Mbp simulated community[](#example-for-the-78mbp-simulated-community "Permalink to this heading")

1. Navigate to the 78Mbp community dataset using the [link](https://drive.google.com/drive/u/2/folders/1McxKviIzkPyr8ovj8BG7n_IYk-QfHAgG) mentioned above.
2. Get the file ID by navigating to any of the files and right clicking, then selecting the `get link` option.
   :   This will have a `copy link` button that you should use. The link for the metagenome assembly
       (ie. `metagenome.fna.gz`) should look like this : `https://drive.google.com/file/d/15CB8rmQaHTGy7gWtZedfBJkrwr51bb2y/view?usp=sharing`
3. The file ID is within the `/` forward slashes between `file/d/` and `/`, e.g:

```
# Pasted from copy link button:
https://drive.google.com/file/d/15CB8rmQaHTGy7gWtZedfBJkrwr51bb2y/view?usp=sharing
#                 begin file ID ^ ------------------------------^ end file ID
```

4. Copy the file ID
5. Now that we have the File ID, you can specify the ID or use the `drive.google.com` prefix. Both should work.

```
file_id="15CB8rmQaHTGy7gWtZedfBJkrwr51bb2y"
gdown --id ${file_id} -O metagenome.fna.gz
# or
gdown https://drive.google.com/uc?id=${file_id} -O metagenome.fna.gz
```

Note

Unfortunately, at the moment `gdown` doesn’t support downloading entire directories from Google drive.
There is an open [Pull request](https://github.com/wkentaro/gdown/pull/90#issue-569060398) on the `gdown` repository
addressing this specific issue which we are keeping a close eye on and will update this documentation when it is merged.

## Advanced[](#advanced "Permalink to this heading")

### Data Handling[](#data-handling "Permalink to this heading")

#### Aggregating benchmarking results[](#aggregating-benchmarking-results "Permalink to this heading")

##### When dataset index is unique[](#when-dataset-index-is-unique "Permalink to this heading")

```
import pandas as pd
import glob
df = pd.concat([
    pd.read_csv(fp, sep="\t", index_col="dataset")
    for fp in glob.glob("*.clustering_benchmarks.long.tsv.gz")
])
df.to_csv("benchmarks.tsv", sep='\t', index=True, header=True)
```

##### When dataset index is not unique[](#when-dataset-index-is-not-unique "Permalink to this heading")

```
import pandas as pd
import os
import glob
dfs = []
for fp in glob.glob("*.clustering_benchmarks.long.tsv.gz"):
    df = pd.read_csv(fp, sep="\t", index_col="dataset")
    df.index = df.index.map(lambda fpath: os.path.basename(fpath))
    dfs.append(df)
df = pd.concat(dfs)
df.to_csv("benchmarks.tsv", sep='\t', index=True, header=True)
```

### Downloading multiple test datasets at once[](#downloading-multiple-test-datasets-at-once "Permalink to this heading")

To download all of the simulated communities reference binning/taxonomy assignments as well as the Autometa
v2.0 binning/taxonomy predictions all at once, you can provide the multiple arguments to `--community-sizes`.

e.g. `--community-sizes 78Mbp 156Mbp 312Mbp 625Mbp 1250Mbp 2500Mbp 5000Mbp 10000Mbp`

An example of this is shown in the bash script below:

```
# choices: 78Mbp,156Mbp,312Mbp,625Mbp,1250Mbp,2500Mbp,5000Mbp,10000Mbp
community_sizes=(78Mbp 156Mbp 312Mbp 625Mbp 1250Mbp 2500Mbp 5000Mbp 10000Mbp)

autometa-download-dataset \
    --community-type simulated \
    --community-sizes ${community_sizes[@]} \
    --file-names reference_assignments.tsv.gz binning.tsv.gz taxonomy.tsv.gz \
    --dir-path simulated
```

### Generating new simulated communities[](#generating-new-simulated-communities "Permalink to this heading")

Communities were simulated using [ART](https://www.niehs.nih.gov/research/resources/software/biostatistics/art/index.cfm),
a sequencing read simulator, with a collect