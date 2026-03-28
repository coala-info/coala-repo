# [NAF](/study/naf/) Compactness on GenomeSync

## GenomeSync

GenomeSync is a large collection of genomes.
Each genome is stored in its own FASTA file.
A snapshot from October 12, 2018 was used in this comparison:

* Number of genomes: 186,876
* Total size of FASTA files: 2,358,338,313,621 bytes
* Total sequence length: 2,305,343,951,477 bp
* Smallest genome: 285 bytes (virus)
* Largest genome: 32,810,782,832 bytes (salamander)

## Compressors used

The entire GenomeSync database was compressed with 6 compressors.
Each genome was compressed independently from others and stored in its own file.

|  |  |  |
| --- | --- | --- |
| Compressor | Version | Options |
| gzip | 1.8 | gzip -c9 |
| bzip2 | 1.0.6 | bzip2 -cz9 |
| brotli | 1.0.6 | brotli -cZ |
| zstd | 1.3.5 | zstd --ultra -22 -c |
| xz | 5.2.4 | xz -zkce9 |
| ennaf | 0.1.2 | ennaf --in-format fasta |

## Compressed size

In this chart the compressed size includes only content of each file, not the total allocated size on disk.

![](images/GenomeSync-compressed-size-6-formats-bar-chart.svg)

Switching from gzip to NAF saves 182 GB.
This not only reduces the required storage space, but also network transfer time,
as well as analysis time when using those genomes.

## Cumulative ratio

For the following charts, the genomes are progressively added one by one,
in the order from small to large ones (by FASTA file size).
With each added genome, the curent total compression ratio is plotted against the current total accumulated FASTA size.

![](images/GenomeSync-Cumulative-FASTA-size-vs-Compression-ratio-for-6-formats.svg)

The above chart shows that NAF keeps a large gap from other formats through the entire range.
gzip ratio stays about the same, bzip2 ratio improves slightly, and the other formats improve a lot with larger genomes.

The next chart shows exactly same data, only with log scale on the X axis.

![](images/GenomeSync-Cumulative-FASTA-size-vs-Compression-ratio-for-6-formats-log-scale.svg)

This chart shows that for tiny viral genomes brotli gives the best compression, and xz the worst.
NAF starts above gzip, but quickly improves with increased genome size.

* © 2018-2019 [Kirill Kryukov](http://kirill-kryukov.com/kirr/)