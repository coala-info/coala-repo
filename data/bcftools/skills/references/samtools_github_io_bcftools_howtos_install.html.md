General

* [Main page](index.html)
* [Manual page](../bcftools.html)
* [Installation](install.html)
* [Publications](publications.html)

Calling

* [CNV calling](cnv-calling.html)
* [Consequence calling](csq-calling.html)
* [Consensus calling](consensus-sequence.html)
* [ROH calling](roh-calling.html)
* [Variant calling and filtering](variant-calling.html)

Tips and Tricks

* [Converting formats](convert.html)
* [Adding annotation](annotate.html)
* [Extracting information](query.html)
* [Filtering expressions](filtering.html)
* [Performance and Scaling](scaling.html)
* [Plugins](plugins.html)
* [FAQ](FAQ.html)

## Installation

### For the impatient

The latest source code can be downloaded from github using:

```
git clone --recurse-submodules https://github.com/samtools/htslib.git
git clone https://github.com/samtools/bcftools.git
cd bcftools
 # The following is optional:
 #   autoheader && autoconf && ./configure --enable-libgsl --enable-perl-filters
make
```

|  |  |
| --- | --- |
| Important | In order to use the BCFtools plugins, this environment variable must be set and point to the correct location:  `export BCFTOOLS_PLUGINS=/path/to/bcftools/plugins` |

### Detailed instructions

If the simple copy and paste approach above did not work, see
[DETAILED INSTRUCTIONS](https://raw.githubusercontent.com/samtools/bcftools/develop/INSTALL).

### Feedback

We welcome your feedback, please help us improve this page by
either opening an [issue on github](https://github.com/samtools/bcftools/issues) or [editing it directly](https://github.com/samtools/bcftools/tree/gh-pages/howtos) and sending
a pull request.