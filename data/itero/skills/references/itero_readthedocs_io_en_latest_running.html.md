[itero](index.html)

latest

Contents:

* [Purpose](purpose.html)
* [Installation](installation.html)
* Running itero
  + [itero on a single node](#itero-on-a-single-node)
  + [itero across MPI nodes](#itero-across-mpi-nodes)

* [License](license.html)
* [Changelog](changelog.html)
* [Funding](funding.html)

[itero](index.html)

* [Docs](index.html) »
* Running itero
* [Edit on GitHub](https://github.com/faircloth-lab/itero/blob/master/docs/running.rst)

---

# Running itero[¶](#running-itero "Permalink to this headline")

[itero](https://github.com/faircloth-lab/itero) has both a **local** mode and an **MPI** mode. The **local** mode is for execution on a single node, while the **MPI** mode executes individual locus assemblies in parallel using an MPI-enabled HPC cluster. To run the program, you must first create a configuration file denoting the samples you wish you assemble. That file has the following format:

```
[reference]
/path/to/the/locus/seeds.fasta

[individuals]
taxon-one:/path/to/fastq/R1/and/R2/files/for/taxon/1/
taxon-two:/path/to/fastq/R1/and/R2/files/for/taxon/2/
taxon-three:/path/to/fastq/R1/and/R2/files/for/taxon/3/
```

## [itero](https://github.com/faircloth-lab/itero) on a single node[¶](#itero-on-a-single-node "Permalink to this headline")

You then run the *local* version using a command similar to:

```
itero assemble local --config ndna-test.conf
    --output local
    --local-cores 16
    --iterations 6
```

This will run itero on a single node and will first use 16 cores to perform bwa alignments. The code will then distribute locus-specific assemblies across all cores on the node (1 assembly per core; 16 in parallel).

## [itero](https://github.com/faircloth-lab/itero) across MPI nodes[¶](#itero-across-mpi-nodes "Permalink to this headline")

You run the *MPI* version using a command similar to:

```
mpirun -hostfile hostfile -n 96 itero assemble mpi --config ndna-test.conf \
    --output mpi \
    --local-cores 16 \
    --iterations 6
```

If each of your nodes has 16 cores, this will first use 16 cores for the needed bwa alignments of reads to seeds. The code will then distribute locus-specific assemblies across all 96 cores in your cluster (1 assembly per core; 96 in parallel).

[Next](license.html "License")
 [Previous](installation.html "Installation")

---

© Copyright 2018, Brant C. Faircloth
Revision `25c7fb69`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).