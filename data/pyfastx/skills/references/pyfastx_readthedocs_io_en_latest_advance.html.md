[pyfastx](index.html)

Contents:

* [Installation](installation.html)
* [FASTX](usage.html)
* [FASTA](usage.html#fasta)
* [Sequence](usage.html#sequence)
* [FASTQ](usage.html#fastq)
* [Read](usage.html#read)
* [FastaKeys](usage.html#fastakeys)
* [FastqKeys](usage.html#fastqkeys)
* [Command line interface](commandline.html)
* Multiple processes
  + [Example one](#example-one)
* [Drawbacks](drawbacks.html)
* [Changelog](changelog.html)
* [API Reference](api_reference.html)
* [Acknowledgements](acknowledgements.html)

[pyfastx](index.html)

* Multiple processes
* [View page source](_sources/advance.rst.txt)

---

# Multiple processes[](#multiple-processes "Link to this heading")

Pyfastx can be used with [multiprocessing](https://docs.python.org/3.7/library/multiprocessing.html) module to speed up the random access. Prior to reading sequences from subprocesses, you have to ensure that index file has been created from main process. The index file of pyfastx is just a SQLite3 database file which supports for concurrency. We provide two simple examples for using pyfastx with multiprocessing pool.

## Example one[](#example-one "Link to this heading")

```
import random
import pyfastx
import multiprocessing as mp

# process worker
# randomly fetch five sequences and print to stdout
def worker(woker_num, seq_counts):
    #recreate the Fasta object in subprocess
    fa = pyfastx.Fasta('test.fa')

    for i in random.sample(range(seq_counts), 5):
        print("worker {} print:\n{}".format(worker_num, fa[i].raw))

if __name__ == '__main__':
    #ensure index file has been created in main process
    fa = pyfastx.Fasta('test.fa')

    #get sequence counts
    c = len(fa)

    #start the process pool
    pool = mp.Pool()

    #add five task workers to run
    for n in range(5):
        pool.apply_async(worker, args=(n, c))

    #wait for tasks to finish
    pool.close()
    pool.join()
```

[Previous](commandline.html "Command line interface")
[Next](drawbacks.html "Drawbacks")

---

© Copyright 2023, Lianming Du.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).