# [NAF](/study/naf/): FASTA Compression Benchmark

# Human Genome

* Test dataset: The reference human genome GRCh38.p12 (RefSeq accession: GCF\_000001405.38).
  + Size: 3,298,102,737 bytes
  + Number of sequences: 594* Method: [Benchmark setup](benchmark-setup.html)
  * Compared compressors: [FASTA compressors](benchmark-list-of-fasta-compressors.html)

## Best setting of each compressor

|  |  |
| --- | --- |
| ![](images/Human-genome-ctd-time-100Mbps.svg) | ![](images/Human-genome-td-time-100Mbps.svg) |

|  |  |
| --- | --- |
| ![](images/Human-genome-ctd-time-1Gbps.svg) | ![](images/Human-genome-td-time-1Gbps.svg) |

![](images/Human-genome-size.svg)

## Ratio vs Speed

Each line connects consecutive settings of one compressor.

|  |  |
| --- | --- |
| ![](images/Human-genome-ratio-vs-cd-speed-lin.svg) | ![](images/Human-genome-ratio-vs-d-speed-lin.svg) |

## Ratio vs Speed (log scale)

|  |  |
| --- | --- |
| ![](images/Human-genome-ratio-vs-cd-speed-log.svg) | ![](images/Human-genome-ratio-vs-d-speed-log.svg) |

## Size vs Time (log scale)

|  |  |
| --- | --- |
| ![](images/Human-genome-size-vs-cd-time-log.svg) | ![](images/Human-genome-size-vs-d-time-log.svg) |

* © 2018-2019 [Kirill Kryukov](http://kirill-kryukov.com/kirr/)