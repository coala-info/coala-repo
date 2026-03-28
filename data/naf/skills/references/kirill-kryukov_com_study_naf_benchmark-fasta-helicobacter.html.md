# [NAF](/study/naf/): FASTA Compression Benchmark

# *Helicobacter* genomes

* Test dataset: 1,464 genomes of *Helicobacter* species ([list](files/helicobacter-genome-list.txt)), stored in a single file.
  + Originally from [GenBank](https://www.ncbi.nlm.nih.gov/genbank/),
    obtained via [GenomeSync](http://genomesync.org/) (on January 14, 2019)
  + Size: 2,497,823,276 bytes
  + Number of sequences: 98,154* Method: [Benchmark setup](benchmark-setup.html)
  * Compared compressors: [FASTA compressors](benchmark-list-of-fasta-compressors.html)

## Best setting of each compressor

|  |  |
| --- | --- |
| ![](images/Helicobacter-ctd-time-100Mbps.svg) | ![](images/Helicobacter-td-time-100Mbps.svg) |

|  |  |
| --- | --- |
| ![](images/Helicobacter-ctd-time-1Gbps.svg) | ![](images/Helicobacter-td-time-1Gbps.svg) |

![](images/Helicobacter-size.svg)

## Ratio vs Speed

Each line connects consecutive settings of one compressor.

|  |  |
| --- | --- |
| ![](images/Helicobacter-ratio-vs-cd-speed-lin.svg) | ![](images/Helicobacter-ratio-vs-d-speed-lin.svg) |

## Ratio vs Speed (log scale)

|  |  |
| --- | --- |
| ![](images/Helicobacter-ratio-vs-cd-speed-log.svg) | ![](images/Helicobacter-ratio-vs-d-speed-log.svg) |

## Size vs Time (log scale)

|  |  |
| --- | --- |
| ![](images/Helicobacter-size-vs-cd-time-log.svg) | ![](images/Helicobacter-size-vs-d-time-log.svg) |

* © 2018-2019 [Kirill Kryukov](http://kirill-kryukov.com/kirr/)