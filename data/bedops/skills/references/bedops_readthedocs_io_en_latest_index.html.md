# [BEDOPS v2.4.41](# )

* [1. Overview](content/overview.html "Next document")
  →

* Home

# BEDOPS: the fast, highly scalable and easily-parallelizable genome analysis toolkit[¶](#bedops-the-fast-highly-scalable-and-easily-parallelizable-genome-analysis-toolkit "Permalink to this headline")

**BEDOPS** is an open-source command-line toolkit that performs highly efficient and scalable Boolean and other set operations, statistical calculations, archiving, conversion and other management of genomic data of arbitrary scale. Tasks can be easily split by chromosome for distributing whole-genome analyses across a computational cluster.

You can read more about **BEDOPS** and how it can be useful for your research in the [Overview](content/overview.html#overview) documentation, as well as in the [original manuscript](http://bioinformatics.oxfordjournals.org/content/28/14/1919.abstract).

![](_static/downloads_v3.png)

![](_static/linux_v2.png)

* [x86-64 (64-bit)](https://github.com/bedops/bedops/releases/download/v2.4.41/bedops_linux_x86_64-v2.4.41.tar.bz2) binaries
* [Installation instructions](content/installation.html#linux) for Linux hosts

![](_static/macosx_v2.png)

* [Intel (64-bit, 10.10-10.15)](https://github.com/bedops/bedops/releases/download/v2.4.41/BEDOPS.2.4.41.pkg.zip) installer package
* [Installation instructions](content/installation.html#mac-os-x) for Mac OS X hosts

![](_static/source_v2.png)

* [Source code](https://github.com/bedops/bedops/archive/v2.4.41.tar.gz) (tar.gz)
* [Source code](https://github.com/bedops/bedops/archive/v2.4.41.zip) (zip)
* [Compilation instructions](content/installation.html#installation-via-source-code)

![](_static/reference_v2.png)

![](_static/set_operations_v2.png)

* [bedops](content/reference/set-operations/bedops.html) - apply set operations on any number of BED inputs
* [bedextract](content/reference/set-operations/bedextract.html) - efficiently extract BED features
* [closest-features](content/reference/set-operations/closest-features.html) - matches nearest features between BED files

![](_static/statistics_v2.png)

* [bedmap](content/reference/statistics/bedmap.html) - map overlapping BED elements onto target regions and optionally compute any number of common statistical operations

![](_static/file_management_v2.png)

* [sort-bed](content/reference/file-management/sorting/sort-bed.html) - apply lexicographical sort to BED data
* [starch](content/reference/file-management/compression/starch.html) and [unstarch](content/reference/file-management/compression/unstarch.html) - compress and extract BED data
* [starchcat](content/reference/file-management/compression/starchcat.html) - merge compressed archives
* [starchstrip](content/reference/file-management/compression/starchstrip.html) - filter archive by chromosomes
* [Conversion tools](content/reference/file-management/conversion.html) - convert common genomic formats to BED

![](_static/performance_v2.png)

* Parallel [bam2bed](content/reference/file-management/conversion/parallel_bam2bed.html) and [bam2starch](content/reference/file-management/conversion/parallel_bam2starch.html) - parallelized conversion and compression of BAM data
* [Set operations with bedops](content/performance.html#set-operations-with-bedops)
* [Compression characteristics of starch](content/performance.html#compression-characteristics-of-starch)
* [Independent testing](content/performance.html#independent-testing)

![](_static/toc_v2.png)

* [Table summary](content/summary.html) of **BEDOPS** toolkit
* [Starch v2.2](content/reference/file-management/compression/starch-specification.html) format specification
* [About nested elements](content/reference/set-operations/nested-elements.html)* [Revision history](content/revision-history.html)
  * [Github release instructions](content/release.html)
  * [Github repository](https://github.com/bedops/bedops)

![](_static/support_v2.png)

* [How to install **BEDOPS**](content/installation.html)
* [Usage examples](content/usage-examples.html) of **BEDOPS** tools in action
* [**BEDOPS** user forum](http://bedops.uwencode.org/forum/)
* [**BEDOPS** discusssion mailing list](http://groups.google.com/group/bedops-discuss)

# Citation[¶](#citation "Permalink to this headline")

If you use **BEDOPS** in your research, please cite the following manuscript:

> Shane Neph, M. Scott Kuehn, Alex P. Reynolds, et al. **BEDOPS: high-performance genomic feature operations**. *Bioinformatics* (2012) 28 (14): 1919-1920. [doi: 10.1093/bioinformatics/bts277](http://bioinformatics.oxfordjournals.org/content/28/14/1919.abstract)

# Contents[¶](#contents "Permalink to this headline")

* [1. Overview](content/overview.html)
  + [1.1. About BEDOPS](content/overview.html#about-bedops)
  + [1.2. Why you should use BEDOPS](content/overview.html#why-you-should-use-bedops)
    - [1.2.1. BEDOPS tools are flexible](content/overview.html#bedops-tools-are-flexible)
    - [1.2.2. BEDOPS tools are fast and efficient](content/overview.html#bedops-tools-are-fast-and-efficient)
    - [1.2.3. BEDOPS tools make your work embarrassingly easy to parallelize](content/overview.html#bedops-tools-make-your-work-embarrassingly-easy-to-parallelize)
    - [1.2.4. BEDOPS tools are open, documented and supported](content/overview.html#bedops-tools-are-open-documented-and-supported)
* [2. Installation](content/installation.html)
  + [2.1. Via pre-built packages](content/installation.html#via-pre-built-packages)
    - [2.1.1. Linux](content/installation.html#linux)
    - [2.1.2. Mac OS X](content/installation.html#mac-os-x)
  + [2.2. Via source code](content/installation.html#via-source-code)
    - [2.2.1. Linux](content/installation.html#installation-via-source-code-on-linux)
    - [2.2.2. Mac OS X](content/installation.html#installation-via-source-code-on-mac-os-x)
      * [2.2.2.1. Manual compilation](content/installation.html#manual-compilation)
      * [2.2.2.2. Installation via Bioconda](content/installation.html#installation-via-bioconda)
      * [2.2.2.3. Installation via Homebrew](content/installation.html#installation-via-homebrew)
    - [2.2.3. Docker](content/installation.html#docker)
    - [2.2.4. Cygwin](content/installation.html#cygwin)
  + [2.3. Building an OS X installer package for redistribution](content/installation.html#building-an-os-x-installer-package-for-redistribution)
* [3. Revision history](content/revision-history.html)
  + [3.1. Current version](content/revision-history.html#current-version)
    - [3.1.1. v2.4.41](content/revision-history.html#v2-4-41)
  + [3.2. Previous versions](content/revision-history.html#previous-versions)
    - [3.2.1. v2.4.40](content/revision-history.html#v2-4-40)
    - [3.2.2. v2.4.39](content/revision-history.html#v2-4-39)
    - [3.2.3. v2.4.38](content/revision-history.html#v2-4-38)
    - [3.2.4. v2.4.37](content/revision-history.html#v2-4-37)
    - [3.2.5. v2.4.36](content/revision-history.html#v2-4-36)
    - [3.2.6. v2.4.35](content/revision-history.html#v2-4-35)
    - [3.2.7. v2.4.34](content/revision-history.html#v2-4-34)
    - [3.2.8. v2.4.33](content/revision-history.html#v2-4-33)
    - [3.2.9. v2.4.32](content/revision-history.html#v2-4-32)
    - [3.2.10. v2.4.31](content/revision-history.html#v2-4-31)
    - [3.2.11. v2.4.30](content/revision-history.html#v2-4-30)
    - [3.2.12. v2.4.29](content/revision-history.html#v2-4-29)
    - [3.2.13. v2.4.28](content/revision-history.html#v2-4-28)
    - [3.2.14. v2.4.27](content/revision-history.html#v2-4-27)
    - [3.2.15. v2.4.26](content/revision-history.html#v2-4-26)
    - [3.2.16. v2.4.25](content/revision-history.html#v2-4-25)
    - [3.2.17. v2.4.24](content/revision-history.html#v2-4-24)
    - [3.2.18. v2.4.23](content/revision-history.html#v2-4-23)
    - [3.2.19. v2.4.22](content/revision-history.html#v2-4-22)
    - [3.2.20. v2.4.21](content/revision-history.html#v2-4-21)
    - [3.2.21. v2.4.20](content/revision-history.html#v2-4-20)
    - [3.2.22. v2.4.19](content/revision-history.html#v2-4-19)
    - [3.2.23. v2.4.18](content/revision-history.html#v2-4-18)
    - [3.2.24. v2.4.17](content/revision-history.html#v2-4-17)
    - [3.2.25. v2.4.16](content/revision-history.html#v2-4-16)
    - [3.2.26. v2.4.15](content/revision-history.html#v2-4-15)
    - [3.2.27. v2.4.14](content/revision-history.html#v2-4-14)
    - [3.2.28. v2.4.13](content/revision-history.html#v2-4-13)
    - [3.2.29. v2.4.12](content/revision-history.html#v2-4-12)
    - [3.2.30. v2.4.11](content/revision-history.html#v2-4-11)
    - [3.2.31. v2.4.10](content/revision-history.html#v2-4-10)
    - [3.2.32. v2.4.9](content/revision-history.html#v2-4-9)
    - [3.2.33. v2.4.8](content/revision-history.html#v2-4-8)
    - [3.2.34. v2.4.7](content/revision-history.html#v2-4-7)
    - [3.2.35. v2.4.6](content/revision-history.html#v2-4-6)
    - [3.2.36. v2.4.5](content/revision-history.html#v2-4-5)
    - [3.2.37. v2.4.4](content/revision-history.html#v2-4-4)
    - [3.2.38. v2.4.3](content/revision-history.html#v2-4-3)
    - [3.2.39. v2.4.2](content/revision-history.html#v2-4-2)
    - [3.2.40. v2.4.1](content/revision-history.html#v2-4-1)
    - [3.2.41. v2.4.0](content/revision-history.html#v2-4-0)
    - [3.2.42. v2.3.0](content/revision-history.html#v2-3-0)
    - [3.2.43. v2.2.0b](content/revision-history.html#v2-2-0b)
    - [3.2.44. v2.2.0](content/revision-history.html#v2-2-0)
    - [3.2.45. v2.1.1](content/revision-history.html#v2-1-1)
    - [3.2.46. v2.1.0](content/revision-history.html#v2-1-0)
    - [3.2.47. v2.0.0b](content/revision-history.html#v2-0-0b)
    - [3.2.48. v2.0.0a](content/revision-history.html#v2-0-0a)
    - [3.2.49. v1.2.5b](content/revision-history.html#v1-2-5b)
    - [3.2.50. v1.2.5](content/revision-history.html#v1-2-5)
    - [3.2.51. v1.2.3](content/revision-history.html#v1-2-3)
* [4. Usage examples](content/usage-examples.html)
  + [4.1. Visualizing the relationship of SNPs and generic genomic features](content/usage-examples/snp-visualization.html)
    - [4.1.1. BEDOPS tools in use](content/usage-examples/snp-visualization.html#bedops-tools-in-use)
    - [4.1.2. Script](content/usage-examples/snp-visualization.html#script)
    - [4.1.3. Discussion](content/usage-examples/snp-visualization.html#discussion)
    - [4.1.4. Downloads](content/usage-examples/snp-visualization.html#downloads)
  + [4.2. Collapsing multiple BED files into a master list by signal](content/usage-examples/master-list.html)
    - [4.2.1. BEDOPS tools in use](content/usage-examples/master-list.html#bedops-tools-in-use)
    - [4.2.2. Script](content/usage-examples/master-list.html#script)
    - [4.2.3. Discussion](content/usage-examples/master-list.html#discussion)
  + [4.3. Measuring the frequency of signed distances between SNPs and nearest DHSes](content/usage-examples/distance-frequencies.html)
    - [4.3.1. BEDOPS tools in use](content/usage-examples/distance-frequencies.html#bedops-tools-in-use)
    - [4.3.2. Script](content/usage-examples/distance-frequencies.html#script)
    - [4.3.3. Discussion](content/usage-examples/distance-frequencies.html#discussion)
    - [4.3.4. Downloads](content/usage-examples/distance-frequencies.html#downloads)
  + [4.4. Finding the subset of SNPs within DHSes](content/usage-examples/snps-within-dhses.html)
    - [4.4.1. BEDOPS tools in use](content/usage-examples/snps-within-dhses.html#bedops-tools-in-use)
    - [4.4.2. Script](content/usage-examples/snps-within-dhses.html#script)
    - [4.4.3. Discussion](content/usage-examples/snps-within-dhses.html#discussion)
    - [4.4.4. Downloads](content/usage-examples/snps-within-dhses.html#downloads)
  + [4.5. Smoothing raw tag count data across the genome](content/usage-examples/smoothing-tags.html)
    - [4.5.1. BEDOPS tools in use](content/usage-examples/smoothing-tags.html#bedops-tools-in-use)
    - [4.5.2. Script](content/usage-examples/smoothing-tags.html#script)
  + [4.6. Efficiently creating Starch-formatted archives with a cluster](content/usage-examples/starchcluster.html)
    - [4.6.1. BEDOPS tools in use](content/usage-examples/starchcluster.html#bedops-tools-in-use)
    - [4.6.2. Script](content/usage-examples/starchcluster.html#script)
    - [4.6.3. Discussion](content/usage-examples/starchcluster.html#discussion)
      * [4.6.3.1. Splitting BED files](content/usage-examples/starchcluster.html#splitting-bed-files)
      * [4.6.3.2. Compressing BED subsets](content/usage-examples/starchcluster.html#compressing-bed-subsets)
      * [4.6.3.3. Stitching together compressed sets](content/usage-examples/starchcluster.html#stitching-together-compressed-sets)
  + [4.7. Working with many input files at once with `bedops` and `bedmap`](content/usage-examples/multiple-inputs.html)
    - [4.7.1. Discussion](content/usage-examples/multiple-inputs.html#discussion)
* [5. Performance](content/performance.html)
  + [5.1. Test environment and data](content/performance.html#test-environment-and-data)
  + [5.2. Set operations with `bedops`](content/performance.html#set-operations-with-bedops)
    - [5.2.1. Direct merge (sorted)](content/performance.html#direct-merge-sorted)
    - [5.2.2. Complement and intersection](content/performance.html#complement-and-intersection)
    - [5.2.3. Direct merge (unsorted)](content/performance.html#direct-merge-unsorted)
    - [5.2.4. Discussion](content/performance.html#discussion)
  + [5.3. Compression characteristics of `starch`](content/performance.html#compression-characteristics-of-starch)
    - [5.3.1. Compression efficiency](content/performance.html#compression-efficiency)
    - [5.3.2. Extraction time](content/performance.html#extraction-time)
  + [5.4. Independent testing](content/performance.html#independent-testing)
    - [5.4.1. Genomic Region Operation Kit (GROK)](content/performance.html#genomic-region-operation-kit-grok)
  + [5.5. Worst-case memory performance](content/performance.html#worst-case-memory-performance)
* [6. Reference](content/reference.html)
  + [6.1. Set operations](content/reference/set-operations.html)
    - [6.1.1. bedops](content/reference/set-operations/bedops.html)
      * [6.1.1.1. Inputs and outputs](content/reference/set-operations/bedops.html#inputs-and-outputs)
        + [6.1.1.1.1. Input](content/reference/set-operations/bedops.html#input)
        + [6.1.1.1.2. Output](content/reference/set-operations/bedops.html#output)
      * [6.1.1.2. Usage](content/reference/set-operations/bedops.html#usage)
      * [6.1.1.3. Operations](content/reference/set-operations/bedops.html#operations)
        + [6.1.1.3.1. Everything (-u, –everything)](content/reference/set-operations/bedops.html#everything-u-everything)
        + [6.1.1.3.2. Element-of (-e, –element-of)](content/reference/set-operations/bedops.html#element-of-e-element-of)
        + [6.1.1.3.3. Not-element-of (-n, –not-element-of)](content/reference/set-operations/bedops.html#not-element-of-n-not-element-of)
        + [6.1.1.3.4. Complement (-c, –complement)](content/reference/set-opera