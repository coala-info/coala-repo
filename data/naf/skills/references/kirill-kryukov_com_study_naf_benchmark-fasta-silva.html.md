# [NAF](/study/naf/): FASTA Compression Benchmark

# SILVA Database

* Test dataset: SILVA 16S rRNA database (SILVA\_123\_SSURef\_Nr99\_tax\_silva.fasta), with U changed to T.
  + Size: 947,966,398 bytes
  + Number of sequences: 597,607* Method: [Benchmark setup](benchmark-setup.html)

## Best setting of each compressor

|  |  |
| --- | --- |
| ![](images/SILVA-ctd-time-100Mbps.svg) | ![](images/SILVA-td-time-100Mbps.svg) |

|  |  |
| --- | --- |
| ![](images/SILVA-ctd-time-1Gbps.svg) | ![](images/SILVA-td-time-1Gbps.svg) |

![](images/SILVA-size.svg)

## Ratio vs Speed

Each line connects consecutive settings of one compressor.

|  |  |
| --- | --- |
| ![](images/SILVA-ratio-vs-cd-speed-lin.svg) | ![](images/SILVA-ratio-vs-d-speed-lin.svg) |

## Ratio vs Speed (log scale)

|  |  |
| --- | --- |
| ![](images/SILVA-ratio-vs-cd-speed-log.svg) | ![](images/SILVA-ratio-vs-d-speed-log.svg) |

## Size vs Time (log scale)

|  |  |
| --- | --- |
| ![](images/SILVA-size-vs-cd-time-log.svg) | ![](images/SILVA-size-vs-d-time-log.svg) |

* © 2018-2019 [Kirill Kryukov](http://kirill-kryukov.com/kirr/)