# [BEDOPS v2.4.41](../index.html%20)

* ←
  [4.7. Working with many input files at once with `bedops` and `bedmap`](usage-examples/multiple-inputs.html "Previous document")
* [6. Reference](reference.html "Next document")
  →

* [Home](../index.html)

# 5. Performance[¶](#performance "Permalink to this headline")

In this document, we compare the performance of our set operations and compression utilities with common alternatives. In-house performance measures include speed, memory usage, and compression efficiency on a dual-core machine with 18 GB of virtual memory. Additionally, we report independently-generated performance statistics collected by a research group that has recently released a similar analysis toolkit.

## 5.1. Test environment and data[¶](#test-environment-and-data "Permalink to this headline")

Timed results were derived using actual running times (also known as wall-clock times), averaged over 3 runs. All timed tests were performed using a single 64-bit Linux machine with a dual-core 3 GHz Intel Xeon processor, 8 GB of physical RAM, and 18 GB of total virtual memory. All caches were purged in between sequential program runs to remove hardware biases.

Random subsamples of [phyloP conservation](http://compgen.bscb.cornell.edu/phast/) for the human genome were used as inputs for testing whenever the full phyloP results were not used. The full phyloP results were downloaded from [UCSC](http://hgdownload.cse.ucsc.edu/goldenPath/hg19/phyloP46way/).

## 5.2. Set operations with `bedops`[¶](#set-operations-with-bedops "Permalink to this headline")

In this section, we provide time and memory measurements of various [bedops](reference/set-operations/bedops.html#bedops) operations against analogous [BEDTools](http://code.google.com/p/bedtools/) utilities.

### 5.2.1. Direct merge (sorted)[¶](#direct-merge-sorted "Permalink to this headline")

The performance of the `mergeBed` program (with the `-i` option) from the BEDTools suite (v2.12.0) was compared with that of the `--merge` option of our [bedops](reference/set-operations/bedops.html#bedops) utility.

[![../_images/performance_bedops_merge_sorted.png](../_images/performance_bedops_merge_sorted.png)](../_images/performance_bedops_merge_sorted.png)

As measured, the `mergeBed` program loads all data from a file into memory and creates an index before computing results, incurring longer run times and higher memory costs that can lead to failures. The [bedops](reference/set-operations/bedops.html#bedops) utility minimizes memory consumption by retaining only the information required to compute the next line of output.

### 5.2.2. Complement and intersection[¶](#complement-and-intersection "Permalink to this headline")

The `complementBed` (with `-i` and `-g` options) and `intersectBed` (with `-u`, `-a`, and `-b` options) programs from the BEDTools suite (v2.12.0) also were compared to our [bedops](reference/set-operations/bedops.html#bedops) program.

[![../_images/performance_bedops_complement_sorted.png](../_images/performance_bedops_complement_sorted.png)](../_images/performance_bedops_complement_sorted.png)
[![../_images/performance_bedops_intersect_sorted.png](../_images/performance_bedops_intersect_sorted.png)](../_images/performance_bedops_intersect_sorted.png)

Both BEDTools programs were unable to complete operations after 51M elements with the allocated 18 GB of memory. The [bedops](reference/set-operations/bedops.html#bedops) program continued operating on the full dataset.

Important

It is our understanding that the BEDTools’ `intersectBed` program was modified to accept (optionally) sorted data for improved performance some time after these results were published.

A [more recent study](#independent-testing) suggests `bedops --intersect` still offers better memory and running time performance characteristics than recent versions of BEDTools.

### 5.2.3. Direct merge (unsorted)[¶](#direct-merge-unsorted "Permalink to this headline")

In typical pipelines, where utilities are chained together to perform more complex operations, the performance and scalability gaps between BEDOPS and competitive tool suites widen. We show here the use of [sort-bed](reference/file-management/sorting/sort-bed.html#sort-bed) on unsorted BED input, piping it to BEDOPS tools:

[![../_images/performance_bedops_merge_unsorted.png](../_images/performance_bedops_merge_unsorted.png)](../_images/performance_bedops_merge_unsorted.png)

Time performance of [bedops](reference/set-operations/bedops.html#bedops) stays under that of `mergeBed` (BEDTools v2.12), while continuing past the point where `mergeBed` fails. Memory limitations of the system are easily overcome by using the `--max-mem` operator with [sort-bed](reference/file-management/sorting/sort-bed.html#sort-bed), allowing the `--merge` operation to continue unimpeded even with ever-larger unsorted BED inputs.

### 5.2.4. Discussion[¶](#discussion "Permalink to this headline")

The [bedops](reference/set-operations/bedops.html#bedops) utility performs a wide range of set operations (merge, intersect, union, symmetric difference, and so forth). As with all main utilities in BEDOPS, the program requires [sorted](reference/file-management/sorting/sort-bed.html#sort-bed) inputs and creates sorted results on output. As such, sorting is, at most, a *one-time cost* to operate on data any number of times in the most efficient way. Also, as shown in an [independent study](#independent-testing), BEDOPS also sorts data more efficiently than other tools. Further, our utility can sort BED inputs of any size.

Another important feature of [bedops](reference/set-operations/bedops.html#bedops) that separates it from the competition is its ability to work with [any number of inputs](usage-examples/multiple-inputs.html#multiple-inputs) at once. Every operation (union, difference, intersection, and so forth) accepts an arbitrary number of inputs, and each input can be of any size.

## 5.3. Compression characteristics of `starch`[¶](#compression-characteristics-of-starch "Permalink to this headline")

The [starch](reference/file-management/compression/starch.html#starch) utility offers high-quality BED compression into a format with a smaller footprint than common alternatives. The format is designed to help manage data bloat in this genomic era. Further, the format actually enables improved access times to the vast majority of datasets, as compared with raw (uncompressed) and naively-compressed data.

Here, we provide two measures of this format’s utility: comparing the compression efficiency of the `bzip2`-backed Starch format against common, “naive” `bzip2`-compression of UCSC [BedGraph](http://genome.ucsc.edu/goldenPath/help/bedgraph.html) and [WIG](http://genome.ucsc.edu/goldenPath/help/wiggle.html) forms of BED data, and by comparing the time required to extract the records for any one chromosome from these formats as well as from a raw (uncompressed) BED file.

### 5.3.1. Compression efficiency[¶](#compression-efficiency "Permalink to this headline")

After just 10K rows (roughly 300 kB of raw BED data storing phyloP conservation scores), compression into the Starch format begins to consistently outperform `bzip2` compression of the same data stored in either variable-step WIG or UCSC BedGraph formats.

[![../_images/performance_starch_efficiency.png](../_images/performance_starch_efficiency.png)](../_images/performance_starch_efficiency.png)

For very large raw BED datasets, the Starch format stores the original data in approximately 5% of the original input size. These improved compression results generalize to compressed versions of the fixed-step WIG format, as well. For more information, refer to the Supplemental Data in our [Bioinformatics](http://bioinformatics.oxfordjournals.org/content/28/14/1919.abstract) paper.

### 5.3.2. Extraction time[¶](#extraction-time "Permalink to this headline")

Data were sorted per sort-bed with chromosomes in lexicographical order. Extractions by chromosomes were significantly faster in general with the Starch format, even over raw (sequentially-processed) BED inputs:

[![../_images/performance_unstarch_extractiontime.png](../_images/performance_unstarch_extractiontime.png)](../_images/performance_unstarch_extractiontime.png)

Under the assumption that chromosomes create very natural partitions of the data, the Starch format was designed using a chromosome-indexing scheme. This mechanism for random access further helps to improve data processing times within a clustered environment. Again, for more information, refer to the Supplemental Data in our [Bioinformatics](http://bioinformatics.oxfordjournals.org/content/28/14/1919.abstract) paper.

Important

Our [bedextract](reference/set-operations/bedextract.html#bedextract) program similarly makes it possible to extract data quickly by chromosome in any properly sorted BED file. However, for large (or many) data sets, deep compression has serious benefit. In our lab, more than 99% of all files are not touched (even) on a monthly basis—and new results are generated every day. Why would we want to keep all of that data in fully-bloated BED form? The workhorse programs of BEDOPS accept inputs in Starch format directly, just as they do raw BED files, to help manage ‘big data’.

## 5.4. Independent testing[¶](#independent-testing "Permalink to this headline")

### 5.4.1. Genomic Region Operation Kit (GROK)[¶](#genomic-region-operation-kit-grok "Permalink to this headline")

Ovaska, et al. independently developed a genomic analysis toolkit called Genomic Region Operation Kit (GROK), which is described in more detail in [their publication in IEEE/ACM Transactions on Computational Biology and Bioinformatics](http://ieeexplore.ieee.org/xpl/login.jsp?tp=&arnumber=6399464&isnumber=4359833).

In it, they compare the performance characteristics of their GROK toolkit with their analogs in the BEDTools and BEDOPS suites, which they summarize as follows:

Results

Results of the benchmark analyses are shown in Table VII. GROK and BEDTools perform at comparable levels for speed and memory efficiency. In this benchmark BEDOPS is the fastest and least memory consuming method, which was expected due to performance optimized implementation of its operations 9. The optimized performance of BEDOPS, however, entails stronger assumptions for the input than GROK and BEDTools, in particular the requirement for pre-sorting the input BED files.

Operational input was a 14 MB BED file containing annotations of human gene and exon coordinates, totaling ~423k records. We summarize the results of operations on that input here:

[![../_images/performance_independent_grok.png](../_images/performance_independent_grok.png)](../_images/performance_independent_grok.png)

Remember that with BEDOPS, sorting is, at most, a *one-time cost* to operate on data any number of times in the most efficient way. Since the programs in BEDOPS produce sorted outputs, you never need to sort results before using them in downstream analyses.

## 5.5. Worst-case memory performance[¶](#worst-case-memory-performance "Permalink to this headline")

Non-sorting utilities operate efficiently with large inputs by keeping memory overhead low. The worst-case design scenario, however, causes the [bedops](reference/set-operations/bedops.html#bedops) or [bedmap](reference/statistics/bedmap.html#bedmap) programs to load all data from a single chromosome from a single input file into memory. For [bedops](reference/set-operations/bedops.html#bedops), the worst-case scenario applies only to the `--element-of` and `--not-element-of` options.

Fortunately, worst-case situations are conceptually easy to understand, and their underlying questions often require no windowing logic to answer, so simpler approaches can sometimes be used. Conceptually, any summary analysis over an entire chromosome triggers the worst-case scenario. For example, to determine the number of sequencing tags mapped to a given chromosome, [bedmap](reference/statistics/bedmap.html#bedmap) loads all tag data for that one chromosome into memory, whereas a one-line `awk` statement can provide the answer with minimal memory overhead.

We note that the worst case memory performance of non-sorting BEDOPS utilities still improves upon the best case performance of current alternatives.

[![Logo](../_static/logo_with_label_v3.png)](../index.html)

### [Table of Contents](../index.html)

* 5. Performance
  + [5.1. Test environment and data](#test-environment-and-data)
  + [5.2. Set operations with `bedops`](#set-operations-with-bedops)
    - [5.2.1. Direct merge (sorted)](#direct-merge-sorted)
    - [5.2.2. Complement and intersection](#complement-and-intersection)
    - [5.2.3. Direct merge (unsorted)](#direct-merge-unsorted)
    - [5.2.4. Discussion](#discussion)
  + [5.3. Compression characteristics of `starch`](#compression-characteristics-of-starch)
    - [5.3.1. Compression efficiency](#compression-efficiency)
    - [5.3.2. Extraction time](#extraction-time)
  + [5.4. Independent testing](#independent-testing)
    - [5.4.1. Genomic Region Operation Kit (GROK)](#genomic-region-operation-kit-grok)
  + [5.5. Worst-case memory performance](#worst-case-memory-performance)

* ←
  [4.7. Working with many input files at once with `bedops` and `bedmap`](usage-examples/multiple-inputs.html "Previous document")
* [6. Reference](reference.html "Next document")
  →

* [Home](../index.html)

© 2011-2022, Shane Neph, Alex Reynolds.
Created using [Sphinx](http://sphinx-doc.org/)
1.8.6
with the [better](http://github.com/irskep/sphinx-better-theme) theme.