# Getting started[¶](#getting-started "Permalink to this headline")

*Getting started* walks you through the installation of koios and to submit your first program.
See the [examples](examples.html) to get a better overview that koios has to offer.

## Installation[¶](#installation "Permalink to this headline")

Installing PyBDA is easy.

1. Make sure to have `python3` installed. PyBDA does not support
   previous versions. The best way to do that is to download and install [anaconda](https://www.continuum.io/downloads) and create a
   virtual [environment](https://conda.io/docs/using/envs.html) like this:

   ```
   conda create -y -n pybda python=3.6
   source activate pybda
   ```

Note

Make sure to use Python version 3.6 since some dependencies PyBDA uses so far don’t work with versions 3.7 or 3.8.

2. I recommend installing PyBDA
   from [Bioconda](https://bioconda.github.io/recipes/pybda/README.html?highlight=pybda#recipe-Recipe%20&#x27;pybda&#x27;):

   ```
   conda install -c bioconda pybda
   ```

> You can however also directly install using [PyPI](https://pypi.org/project/pybda/):
>
> ```
> pip install pybda
> ```
>
> or by downloading the \_latest\_ [release](https://github.com/cbg-ethz/pybda/releases)
>
> ```
> tar -zxvf pybda*.tar.gz
> pip install pybda
> ```
>
> I obviously recommend installation using the first option.

3. Download Spark from [Apache Spark](https://spark.apache.org/downloads.html) (use the *prebuilt for Apache Hadoop* package type)
   and install the unpacked folder into a custom path like `` `/opt/local/spark` ``. Put an alias into your `` `.bashrc` `` (or whatever shell you are using)

   ```
   echo "alias spark-submit='opt/local/spark/bin/spark-submit'" >> .bashrc
   ```
4. That is it.

## Usage[¶](#usage "Permalink to this headline")

Using PyBDA requires providing two things:

* a config file that specifies the methods you want to use, paths to files, and parameters,
* and the `IP` to a running spark-cluster which runs the algorithms and methods to be executed. If no cluster
  environment is available you can also run PyBDA locally. This, of course, somehow limits what PyBDA can do for you,
  since it’s real strength lies in distributed computation.

### Config[¶](#config "Permalink to this headline")

Running PyBDA requires a `yaml` configuration file that specifies several key-value pairs.
The config file consists of

* general arguments, such as file names,
* method specific arguments,
* arguments for Apache Spark.

#### General arguments[¶](#general-arguments "Permalink to this headline")

The following table shows the arguments that are **mandatory** and need to be set in every application.

| *Parameter* | *Explanation* |
| --- | --- |
| `spark` | path to Apache spark `spark-submit` executable |
| `infile` | tab-separated input file to use for any of the methods |
| `outfolder` | folder where all results are written to. |
| `meta` | names of the columns that represent meta information (“n”-separated) |
| `features` | names of the columns that represent numerical features, i.e. columns that are used for analysis (“n”-separated). |
| `sparkparams` | specifies parameters that are handed over to Apache Spark (which we cover in the section below) |

#### Method specific arguments[¶](#method-specific-arguments "Permalink to this headline")

The following tables show the arguments required for the single methods, i.e. dimension reduction,
clustering and regression.

| *Parameter* | *Argument* | *Explanation* |
| --- | --- | --- |
| **Dimension reduction** | | |
| `dimension_reduction` | `factor_analysis`/`pca`/`kpca`/`lda`/`ica` | Specifies which method to use for dimension reduction |
| `n_components` | e.g `2,3,4` or `2` | Comma-separated list of integers specifying the number of variables in the lower dimensional space to use per reduction |
| `response` | (only for `lda`) | Name of column in `infile` that is the response. Only required for linear discriminant analysis. |
| **Clustering** | | |
| `clustering` | `kmeans`/`gmm` | Specifies which method to use for clustering |
| `n_centers` | e.g `2,3,4` or `2` | Comma-separated list of integers specifying the number of clusters to use per cluystering |
| **Regression** | | |
| `regression` | `glm`/`forest`/`gbm` | Specifies which method to use for regression |
| `response` | | Name of column in `infile` that is the response |
| `family` | `gaussian`/`binomial` | Distribution family of the response variable |

The abbreveations of the methods are explained in the following list.

* `factor_analysis` [for factor analysis](https://en.wikipedia.org/wiki/Factor_analysis),
* `forest` for [random forests](https://en.wikipedia.org/wiki/Random_forest),
* `gbm` for stochastic [gradient boosting](https://en.wikipedia.org/wiki/Gradient_boosting),
* `glm` for [generalized linear regression models](https://en.wikipedia.org/wiki/Generalized_linear_model),
* `gmm` for [Gaussian mixture models](https://en.wikipedia.org/wiki/Mixture_model#Gaussian_mixture_model),
* `ica` for [independent component analysis](https://en.wikipedia.org/wiki/Independent_component_analysis),
* `lda` for [linear discriminant analysis](https://en.wikipedia.org/wiki/Linear_discriminant_analysis),
* `kmeans` for [K-means](https://en.wikipedia.org/wiki/K-means_clustering),
* `kpca` for [kernel principal component analysis](https://en.wikipedia.org/wiki/Kernel_principal_component_analysis) using Fourier features to approximate the kernel map,
* `pca` for [principal component analysis](https://en.wikipedia.org/wiki/Principal_component_analysis).

#### Example[¶](#example "Permalink to this headline")

For instance, consider the config file below:

Contents of `data/pybda-usecase.config` file[¶](#id1 "Permalink to this code")

```
spark: spark-submit
infile: data/single_cell_imaging_data.tsv
predict: data/single_cell_imaging_data.tsv
outfolder: data/results
meta: data/meta_columns.tsv
features: data/feature_columns.tsv
dimension_reduction: pca
n_components: 5
clustering: kmeans
n_centers: 50, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200
regression: forest
family: binomial
response: is_infected
sparkparams:
  - "--driver-memory=3G"
  - "--executor-memory=6G"
debug: true
```

It would execute the following jobs:

1. dimension reduction (PCA) on the input file with 5 components,
2. clustering on the result of the dimensionality reduction with multiple cluster centers (`k`-means),
3. binomial-family random forest (i.e. logistic) on the input file with response *is\_infected* and features from `data/feature_columns.tsv`

In addition we would allow Spark to use 3G driver memory, 6G executor memory and set the configuration variable `spark.driver.maxResultSize`
to 3G (all configurations can be found [here](https://spark.apache.org/docs/latest/configuration.html#available-properties)).

Note

PyBDA first parses through the config file and builds a DAG of the methods that should be executed. If it finds dimensionality reduction *and* clustering, it will first embed the data in a lower dimensional space und use the result of this for clustering (i.e. in order to remove correlated features). The same does *not* happen with regression.

#### Spark parameters[¶](#spark-parameters "Permalink to this headline")

The Spark [documentation](https://spark.apache.org/docs/latest/submitting-applications.html)
for submitting applications provides details which arguments are valid here. You provide them as list in the yaml file as key `sparkparams`:
Below, the most important two are listed:

`"--driver-memory=xG"`
:   Amount of memory to use for the driver process in gigabyte, i.e. where SparkContext is initialized.

`"--executor-memory=xG"`
:   Amount of memory to use per executor process in giga byte.

`"--conf spark.driver.maxResultSize=3G"`
:   Limit of total size of serialized results of all partitions for each Spark action.

### Spark[¶](#spark "Permalink to this headline")

In order for PyBDA to work you need to have a working
*standalone spark environment* set up, running and listening to some `IP`.
You can find a good introduction
[here](https://spark.apache.org/docs/latest/spark-standalone.html) on how
to start the standalone Spark cluster. Alternatively, as mentioned above, a desktop PC suffices as well, but will limit what PyBDA can do for you.

**We assume that you know how to use Apache Spark and start a cluster.**
However, for the sake of demonstration the next two sections give a short introduction how Spark clusters are set up.

#### Local Spark context[¶](#local-spark-context "Permalink to this headline")

On a local resource, such as a laptop or desktop computer, there is no need to start a Spark cluster.
In such a scenario the `IP` PyBDA requires for submitting jobs is just called `local`.

Alternatively, you can always *simulate* a cluster environment. You start the Spark environment using:

```
$SPARK_HOME/sbin/start-master.sh
$SPARK_HOME/sbin/start-slave.sh <IP>
```

where `$SPARK_HOME` is the installation path of Spark and `IP` the IP to which we will submit jobs.
When calling `start-master.sh` Spark will log the `IP` it uses. Thus you need to have a look there to find it. Usually the line looks something like:

```
2019-01-23 21:57:29 INFO  Master:54 - Starting Spark master at spark://<COMPUTERNAME>:7077
```

In the above case the `IP` is `spark://<COMPUTERNAME>:7077`. Thus you start the slave using

```
$SPARK_HOME/sbin/start-slave.sh spark://<COMPUTERNAME>:7077
```

That is it.

#### Cluster environment[¶](#cluster-environment "Permalink to this headline")

If you are working on a cluster, you can use `sparkhpc` to set up a Spark instance (find the documenation [here](https://sparkhpc.readthedocs.io/en/latest/)).

Note

If you want to use `sparkhpc` , please read its documentation to understand how Spark clusters are started.

Sparkhpc can be used to start a standalone cluster on an LSF/SGE high-performance computing environment. In order for them to work make sure to have
**openmpi and Java installed**. Sparkhpc installs with PyBDA, but in case it didn’t just reinstall it:

```
pip install sparkhpc
```

Sparkhpc helps you setting up spark clusters for LSF and Slurm cluster environments. If you have one of those start a Spark cluster, for instance, using:

```
sparkcluster start --memory-per-executor 50000 --memory-per-core 10000 --walltime 4:00 --cores-per-executor 5 2 &
sparkcluster launch &
```

Warning

For your own cluster, you should modify the number of workers, nodes, cores and memory.

In the above call we would request 2 nodes with 5 cores each. Every core would receive 10G of memory, while the entuire executor would receive 50G of memory.

After the job has started, you need to call

```
sparkcluster info
```

in order to receive the Spark `IP`.

### Calling[¶](#calling "Permalink to this headline")

If you made it thus far, you successfully

1. modified the config file,
2. started a Spark standalone cluster and have the `IP` to which the Spark cluster listens.

Now we can finally start our application.

For dimension reduction:

```
pybda dimension-reduction data/pybda-usecase.config IP
```

For clustering:

```
pybda clustering data/pybda-usecase.config IP
```

For regression:

```
pybda regression data/pybda-usecase.config IP
```

And, finally, if you want to execute all methods (i.e., regression/clustering/dimension reduction/…) you would call PyBDA with a `run` argument:

```
pybda run data/pybda-usecase.config IP
```

In all cases, the methods create `tsv` files, plots and statistics.

## References[¶](#references "Permalink to this headline")

Murphy, Kevin P. Machine learning: a probabilistic perspective. MIT press (2012).

Breiman, Leo. “Random forests.” Machine learning 45.1 (2001): 5-32.

Friedman, Jerome H. “Stochastic gradient boosting.” Computational Statistics & Data Analysis 38.4 (2002): 367-378.

Trevor, Hastie, Tibshirani Robert, and Friedman JH. “The elements of statistical learning: data mining, inference, and prediction.” (2009).

Hyvärinen, Aapo, Juha Karhunen, and Erkki Oja. Independent component analysis. Vol. 46. John Wiley & Sons (2004).

Köster, Johannes, and Sven Rahmann. “Snakemake—a scalable bioinformatics workflow engine.” Bioinformatics 28.19 (2012): 2520-2522.

Meng, Xiangrui, et al. “MLlib: Machine Learning in Apache Spark.” The Journal of Machine Learning Research 17.1 (2016): 1235-1241

Rahimi, Ali, and Benjamin Recht. “Random features for large-scale kernel machines.” Advances in Neural Information Processing Systems (2008).

Zaharia, Matei, et al. “Apache Spark: a unified engine for big data processing.” Communications of the ACM 59.11 (2016): 56-65.

[![](_static/sticker_pybda.png "PyBDA")](index.html)

### Contents

* [Home](index.html)
* Getting started
* [Examples](examples.html)
* [FAQ](faq.html)
* [Contributing](contributing.html)

---

* [GitHub](https://github.com/cbg-ethz/pybda)

©2018-2019, Simon Dirmeier.