# Using sourmash LCA to do taxonomic classification[¶](#using-sourmash-lca-to-do-taxonomic-classification "Link to this heading")

The `sourmash lca` sub-commands do k-mer classification using an
“lowest common ancestor” approach. See “Some discussion” below for
links and details.

This tutorial should run without modification on Linux or Mac OS X,
under [Miniconda](https://docs.conda.io/en/latest/miniconda.html).

You’ll need about 5 GB of free disk space to download the database,
and about 5 GB of RAM to search it. The tutorial should take about
20 minutes total to run.

Note, we have successfully tested it on
[binder.pangeo.io](https://binder.pangeo.io/v2/gh/binder-examples/r-conda/master?urlpath=urlpath%3Drstudio)
if you want to give it a try!

## Install miniconda[¶](#install-miniconda "Link to this heading")

If you don’t have the `conda` command installed, you’ll need to install
miniconda for Python 3.x.

On Linux, this should work:

```
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b
echo export PATH="$HOME/miniconda3/bin:$PATH" >> ~/.bash_profile
source ~/.bash_profile
```

otherwise, follow
[the miniconda install](https://docs.conda.io/en/latest/miniconda.html).

## Enable [bioconda](https://bioconda.github.io/)[¶](#enable-bioconda "Link to this heading")

```
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
```

## Install sourmash[¶](#install-sourmash "Link to this heading")

To install sourmash, create a new environment named `smash` and install sourmash:

```
conda create -y -n smash sourmash
```

and then activate:

```
conda activate smash
```

You should now be able to use the `sourmash` command:

```
sourmash info
```

## Download some files[¶](#download-some-files "Link to this heading")

Next, download a genbank LCA database for k=31:

```
curl -L -o genbank-k31.lca.json.gz https://osf.io/4f8n3/download
```

Download a random genome from genbank:

```
curl -L -o some-genome.fa.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/178/875/GCF_000178875.2_ASM17887v2/GCF_000178875.2_ASM17887v2_genomic.fna.gz
```

Create a signature for this genome:

```
sourmash sketch dna -p scaled=1000,k=31 --name-from-first some-genome.fa.gz
```

Now, classify the signature with sourmash `lca classify`,

```
sourmash lca classify --db genbank-k31.lca.json.gz \
    --query some-genome.fa.gz.sig
```

and this will give you a taxonomic identification of your genome bin,
classified using all of the genbank microbial genomes:

```
loaded 1 LCA databases. ksize=31, scaled=10000
finding query signatures...
outputting classifications to stdout
ID,status,superkingdom,phylum,class,order,family,genus,species,strain
... classifying NC_016901.1 Shewanella baltica OS678, complete genome (file 1 of"NC_016901.1 Shewanella baltica OS678, complete genome",found,Bacteria,Proteobacteria,Gammaproteobacteria,Alteromonadales,Shewanellaceae,Shewanella,Shewanella baltica,
classified 1 signatures total
```

You can also summarize the taxonomic distribution of the content with
`lca summarize`:

```
sourmash lca summarize --db genbank-k31.lca.json.gz \
    --query some-genome.fa.gz.sig
```

which will show you:

```
loaded 1 LCA databases. ksize=31, scaled=10000
finding query signatures...
loaded 1 signatures from 1 files total.
97.9%   520   Bacteria;Proteobacteria;Gammaproteobacteria;Alteromonadales;Shewanellaceae;Shewanella
97.9%   520   Bacteria;Proteobacteria;Gammaproteobacteria;Alteromonadales;Shewanellaceae
97.9%   520   Bacteria;Proteobacteria;Gammaproteobacteria;Alteromonadales
99.6%   529   Bacteria;Proteobacteria;Gammaproteobacteria
99.6%   529   Bacteria;Proteobacteria
99.6%   529   Bacteria
45.4%   241   Bacteria;Proteobacteria;Gammaproteobacteria;Alteromonadales;Shewanellaceae;Shewanella;Shewanella baltica
```

To apply this to your own genome(s), replace `some-genome.fa.gz` above
with your own filename(s).

You can also specify multiple databases and multiple query signatures
on the command line; separate them with `--db` or `--query`.

### Building your own LCA database[¶](#building-your-own-lca-database "Link to this heading")

(This is an abbreviated version of [this blog post](http://ivory.idyll.org/blog/2017-classify-genome-bins-with-custom-db-try-again.html), updated to use the `sourmash lca` commands.)

Download some pre-calculated signatures:

```
curl -L https://osf.io/bw8d7/download -o delmont-subsample-sigs.tar.gz
tar xzf delmont-subsample-sigs.tar.gz
```

Next, grab the associated taxonomy spreadsheet

```
curl -O -L https://github.com/ctb/2017-sourmash-lca/raw/master/tara-delmont-SuppTable3.csv
```

Build a sourmash LCA database named `delmont.lca.json`:

```
sourmash lca index -f tara-delmont-SuppTable3.csv delmont.lca.json delmont-subsample-sigs/*.sig
```

### Using the LCA database to classify signatures[¶](#using-the-lca-database-to-classify-signatures "Link to this heading")

We can now use `delmont.lca.json` to classify signatures with k-mers
according to the database we just created. (Note, the database is
completely self-contained at this point.)

Let’s classify a single signature:

```
sourmash lca classify --db delmont.lca.json \
    --query delmont-subsample-sigs/TARA_RED_MAG_00003.fa.gz.sig
```

and you should see:

```
loaded 1 databases for LCA use.
ksize=31 scaled=10000
outputting classifications to stdout
ID,status,superkingdom,phylum,class,order,family,genus,species
TARA_RED_MAG_00003,found,Bacteria,Proteobacteria,Gammaproteobacteria,,,,
classified 1 signatures total
```

You can classify a bunch of signatures and also specify an output
location for the CSV:

```
sourmash lca classify --db delmont.lca.json \
    --query delmont-subsample-sigs/*.sig \
    -o out.csv
```

The `lca classify` command supports multiple databases as well as
multiple queries; e.g. `sourmash lca classify --db delmont.lca.json other.lca.json` will classify based on the combination of taxonomies
in the two databases.

## Some discussion[¶](#some-discussion "Link to this heading")

Sourmash LCA is using k-mers to do taxonomic classification, using the
“lowest common ancestor” approach (pioneered by
[Kraken](http://ccb.jhu.edu/software/kraken/MANUAL.html), and described
[here](http://ivory.idyll.org/blog/2017-something-about-kmers.html)),
to identify each k-mer. From this it can either find a consensus
taxonomy between all the k-mers (`sourmash classify`) or it can summarize
the mixture of k-mers present in one or more signatures (`sourmash summarize`).

The `sourmash lca index` command can be used to prepare custom taxonomy
databases; sourmash will happily ingest any taxonomy, whether or not
it matches NCBI. See
[the spreadsheet from Delmont et al., 2017](https://github.com/ctb/2017-sourmash-lca/blob/master/tara-delmont-SuppTable3.csv)
for an example format.

[Return to index](index.html)

[![Logo](_static/logo.png)

# sourmash](index.html)

Quickly search, compare, and analyze genomic and metagenomic data sets

### Navigation

* [Tutorials and examples](sidebar.html)
* [How-To Guides](sidebar.html#how-to-guides)
* [Frequently Asked Questions](sidebar.html#frequently-asked-questions)
* [How sourmash works under the hood](sidebar.html#how-sourmash-works-under-the-hood)
* [Reference material](sidebar.html#reference-material)
* [Developing and extending sourmash](sidebar.html#developing-and-extending-sourmash)
* [Full table of contents for all docs](sidebar.html#full-table-of-contents-for-all-docs)
* [Using sourmash from the command line](command-line.html)
* [Prepared databases](databases.html)
* [`sourmash` Python API examples](api-example.html)
* [How to cite sourmash](cite.html)

### Related Topics

* [Documentation overview](index.html)

### This Page

* [Show Source](_sources/tutorials-lca.md.txt)

### Quick search

©2016-2023, C. Titus Brown, Luiz Irber, and N. Tessa Pierce-Ward.
|
Powered by [Sphinx 9.0.4](https://www.sphinx-doc.org/)
& [Alabaster 1.0.0](https://alabaster.readthedocs.io)
|
[Page source](_sources/tutorials-lca.md.txt)