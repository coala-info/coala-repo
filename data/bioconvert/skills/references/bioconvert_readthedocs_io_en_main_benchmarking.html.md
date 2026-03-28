[bioconvert
![Logo](_static/logo.png)](index.html)

* [1. Installation](installation.html)
* [2. User Guide](user_guide.html)
* [3. Tutorial](tutorial.html)
* [4. Developer guide](developer_guide.html)
* 5. Benchmarking
  + [5.1. Introduction](#introduction)
  + [5.2. Multiple benchmarking for more robustness](#multiple-benchmarking-for-more-robustness)
    - [5.2.1. Zenodo](#zenodo)
* [6. Gallery](auto_examples/index.html)
* [7. References](references.html)
* [8. Formats](formats.html)
* [9. Glossary](glossary.html)
* [10. Faqs](faqs.html)
* [11. Bibliography](bibliography.html)

[bioconvert](index.html)

* 5. Benchmarking
* [View page source](_sources/benchmarking.rst.txt)

---

# 5. Benchmarking[](#benchmarking "Link to this heading")

## 5.1. Introduction[](#introduction "Link to this heading")

Converters (e.g. [`FASTQ2FASTA`](ref_converters.html#bioconvert.fastq2fasta.FASTQ2FASTA "bioconvert.fastq2fasta.FASTQ2FASTA")) may have several
methods implemented. A developer may also want to compare his/her methods with
those available in Bioconvert.

In order to help developers comparing their methods, we provide a benchmark
framework.

Of course, the first thing to do is to add your new method inside the converter (see [Developer guide](developer_guide.html#developer-guide)) and use the method `boxplot_benchmark()`.

Then, you have two options. Either use the bioconvert command or use the bioconvert Python library. In both case you will first need a local data set as input file. We do not provide such files inside Bioconvert. We have a tool to generate random FastQ file inside the `fastq()` for the example below but this is not generalised for all input formats.

So, you could use the following code to run the benchmark fro Python:

```
# Generate the dummy data, saving the results in a temporary file
from easydev import TempFile
from bioconvert.simulator.fastq import FastqSim

infile = TempFile(suffix=".fastq")
outfile = TempFile(suffix=".fasta")
fs = FastqSim(infile.name)
fs.nreads = 1000 # 1,000,000 by default
fs.simulate()

# Perform the benchmarking
from bioconvert.fastq2fasta import FASTQ2FASTA
c = FASTQ2FASTA(infile.name, outfile.name)
c.compute_benchmark(N=10)

# you may study the memory or CPU usage using mode="CPU" or mode="memory"
c.boxplot_benchmark(mode="time")

infile.delete()
outfile.delete()
```

([`Source code`](_downloads/d36f328003ed81f63638e4db81715140/benchmarking-1.py))

Here, the boxplot\_benchmark methods is called 10 times for each available method.

Be aware that the pure Python methods may be faster for small data and slower for large data.
Indeed, each method has an intrinsec delay to start the processing. Therefore,
benchmarking needs large files to be meaningful !

If we use 1,000,000 reads instead of just 1,000, we would get different results
(which may change depending on your system and IO performance):

![_images/benchmark_1000000.png](_images/benchmark_1000000.png)

Here, what you see more robust and reproducible results.

## 5.2. Multiple benchmarking for more robustness[](#multiple-benchmarking-for-more-robustness "Link to this heading")

With the previous method, even though you can decrease the error bars using more trials per method, we still suffer from
local computation or IO access that may bias the results. We provide a Snakefile here: [`Snakefile_benchmark`](_downloads/5e669913c2b283b733d36aa168ccb007/Snakefile_benchmark)
that allows to run the previous benchmarking several times. So at the end you have a benchmark … of benchmarks
somehow. We found it far more robust. Here is an example for the fastq2fasta case where each method was run 3 times and
in each case, 10 instances of conversion were performed. The orange vertical lines give the median and a final statement
indicates whther the final best method is significantly better than the others.

![_images/multi_benchmark.png](_images/multi_benchmark.png)

Note

The computation can be long and the Snakefile allows to parallelised the computation.

### 5.2.1. Zenodo[](#zenodo "Link to this heading")

The benchmarking requires input files, which can be large. Those files are stored on Zenodo: <https://zenodo.org/communities/bioconvert/>

[Previous](developer_guide.html "4. Developer guide")
[Next](auto_examples/index.html "6. Gallery")

---

© Copyright .
Last updated on Mar 09, 2026.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).