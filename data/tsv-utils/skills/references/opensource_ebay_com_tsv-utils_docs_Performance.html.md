- [View On GitHub](https://github.com/eBay/tsv-utils)

# eBay's TSV Utilities

Command line tools for large tabular data files.

---

Project maintained by [eBay](https://github.com/eBay)
Hosted on GitHub Pages — Theme by [mattgraham](https://twitter.com/michigangraham)

*Visit the [main page](/tsv-utils/)*

# Performance Studies

* [Comparative Benchmark Study](#comparative-benchmark-study)
* [2018 Benchmark Summary](#2018-benchmark-summary)
* [LTO and PGO studies](#lto-and-pgo-studies)

Jump to the [2018 Benchmark Summary](#2018-benchmark-summary) for an overview of how tsv-utils performance compares to other tools.

## Comparative Benchmark Study

Performance is a key motivation for using D rather than an interpreted language like Python or Perl. It is also a consideration in choosing between D and C/C++. To gauge D's performance, benchmarks were run comparing eBay's TSV Utilities to a number of similar tools written in other native compiled programming languages. Included were traditional Unix tools as well as several specialized toolkits. Programming languages involved were C, Go, and Rust.

The larger goal was to see how D programs would compare when written in a straightforward style, as if by a team of well qualified programmers in the course of normal development. Attention was given to choosing good algorithms and identifying poorly performing code constructs, but no heroic measures were used to gain performance. D's standard library was used extensively, without writing custom versions of core algorithms or containers. Unnecessary GC allocation was avoided, but GC was used rather than manual memory management. Higher-level I/O primitives were used rather than custom buffer management.

This larger goal was also the motivation for using multiple benchmarks and a variety of tools. Single points of comparison are more likely to be biased (less reliable) due to the differing goals and quality of the specific application.

The study was conducted in March 2017. An update done in April 2018 using the fastest tools from the initial study.

* [March 2017 Comparative Benchmark Study](/tsv-utils/docs/comparative-benchmarks-2017.html)
* [April 2018 Comparative Benchmark Update](/tsv-utils/docs/comparative-benchmarks-2018.html)

The D programs performed extremely well, exceeding the author's expectations. Six benchmarks were used in the 2017 study, the D tools were the fastest on each, often by significant margins. This is impressive given that very little low-level programming was done. In the 2018 update the TSV Utilities were first or second on all benchmarks. The TSV Utilities were faster than in 2017, but several of the other tools had gotten faster as well.

As with most benchmarks, there are caveats. The tools used for comparison are not exact equivalents, and in many cases have different design goals and capabilities likely to impact performance. Tasks performed are highly I/O dependent and follow similar computational patterns, so the results may not transfer to other applications.

Despite the limitations of the benchmarks, this is certainly a good result. The benchmarks engage a fair range of programming constructs, and the comparison basis includes nine distinct implementations and several long tenured Unix tools. As a practical matter, performance of the tools has changed the author's personal work habits, as calculations that used to take 15-20 seconds are now instantaneous, and calculations that took minutes often finish in 10 seconds or so.

## 2018 Benchmark Summary

The graphs below summarize the results of the 2018 benchmark study. Each graph shows the times of the top-4 tools on that test. Times are in seconds. Times for TSV Utilities tools are shown with a green bar.

The benchmarks are described in detail in the [Comparative Benchmark Study](#comparative-benchmark-study) section (above) and the [2017](/tsv-utils/docs/comparative-benchmarks-2017.html) and [2018](/tsv-utils/docs/comparative-benchmarks-2018.html) comparative benchmark reports. These reports include goals, methodology, test details, caveats, conclusions, etc.

### Numeric row filter

**Test:** Filter rows using numeric tests on individual fields. (*Times in seconds*.)
**File:** 4.8 GB; 7 million lines.

|  |  |
| --- | --- |
| ![](images/numeric-row-filter_linux_2018.jpg) | ![](images/numeric-row-filter_macos_2018.jpg) |

### Regular expression row filter

**Test:** Filter rows using regular expressions. (*Times in seconds*.)
**File:** 2.7 GB; 14 million lines.

|  |  |
| --- | --- |
| ![](images/regex-row-filter_linux_2018.jpg) | ![](images/regex-row-filter_macos_2018.jpg) |

### Column selection

**Test:** Select a subset of columns (aka. "cut"). (*Times in seconds*.)
**File:** 4.8 GB; 7 million lines

|  |  |
| --- | --- |
| ![](images/column-selection_linux_2018.jpg) | ![](images/column-selection_macos_2018.jpg) |

### Column selection: short lines

**Test:** Select a subset of columns. Run against data with short lines. (*Times in seconds*.)
**File:** 1.7 GB; 86 million lines

|  |  |
| --- | --- |
| ![](images/column-selection-narrow_linux_2018.jpg) | ![](images/column-selection-narrow_macos_2018.jpg) |

### Join two files

**Test:** Join two files on a common key. (*Times in seconds*.)
**File:** 4.8 GB; 7 million lines

|  |  |
| --- | --- |
| ![](images/join-two-files_linux_2018.jpg) | ![](images/join-two-files_macos_2018.jpg) |

### Summary statistics

**Test:** Calculate summary statistics (count, sum, mean, etc) on individual fields. (*Times in seconds*.)
**File:** 4.8 GB; 7 million lines

|  |  |
| --- | --- |
| ![](images/summary-statistics_linux_2018.jpg) | ![](images/summary-statistics_macos_2018.jpg) |

### Convert CSV to TSV

**Test:** Convert CSV data to TSV. (*Times in seconds*.)
**File:** 2.7 GB; 14 million lines

|  |  |
| --- | --- |
| ![](images/csv2tsv_linux_2018.jpg) | ![](images/csv2tsv_macos_2018.jpg) |

## LTO and PGO studies

In the fall of 2017 eBay's TSV Utilities were used as the basis for studying Link Time Optimization (LTO) and Profile Guided Optimization (PGO). In D, the LLVM versions of these technologies are made available via LDC, the LLVM-based D Compiler.

Both LTO and PGO resulted in significant performance gains. Details are on the [LTO and PGO Evaluation](/tsv-utils/docs/lto-pgo-study.html) page.

Additional information about LTO and PGO can be found on the [Building with LTO and PGO](/tsv-utils/docs/BuildingWithLTO.html) page. The slide decks from presentations at [Silicon Valley D Meetup (December 2017)](/tsv-utils/docs/dlang-meetup-14dec2017.pdf) and [DConf 2018](/tsv-utils/docs/dconf2018.pdf) also contain useful information, including additional references to other resources about LTO and PGO.