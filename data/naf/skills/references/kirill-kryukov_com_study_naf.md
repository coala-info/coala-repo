# NAF

Nucleotide Archival Format

NAF is a format for storing DNA, RNA and protein sequences.
It's lossless, very compact, has extremely fast decompression, and does not use a reference genome.
NAF is intended to replace gzipped FASTA and FASTQ for sequence data exchange and storage.

### Features

* Stores DNA, RNA or protein sequences, with or without qualities.
* Compresses from FASTA or FASTQ.
* Archive is a single file.
* Not limited in number of stored sequences, or in sequence length.
* Supports IUPAC's ambiguous nucleotide codes.
* Supports storing mask (lower/upper case).
* Very fast decompression.
* Even faster when decompressing only sequence or only names.

### Tools for working with NAF format

* [ennaf](#tools) (compressor / encoder)
* [unnaf](#tools) (decompressor)

How to remember:
After compressing your data with *ennaf*, you suddenly have *enough* space.
However if you decompress it back with *unnaf*, your space is again *un-enough*.

### License

NAF format and this web-site is in public domain.
Compressor and decompressor are open source under the [zlib/libpng license](https://en.wikipedia.org/wiki/Zlib_License),
free for nearly any use.

### Example benchmark

Test dataset: human genome (3.3 GB)

![](images/Human-genome-ratio-vs-cd-speed-lin.svg)

 See benchmarks below for details and other datasets.

---

## Benchmarks

FASTA:

* [Human genome](benchmark-fasta-human-genome.html)
* [*Helicobacter* genomes](benchmark-fasta-helicobacter.html)
* [SILVA 16S rRNA database](benchmark-fasta-silva.html)
* [GenomeSync genomes](compactness-genomesync.html)

FASTQ:

* [SRR554369\_1](benchmark-fastq-SRR554369_1.html)

[Text vs DNA mode](benchmark-text-vs-dna-Spur.html)

For a more systematic benchmark, please see [Sequence Compression Benchmark](http://kirr.dyndns.org/sequence-compression-benchmark/).

## Format

NAF aims to find balance between simplicity, strong compression, and fast decompression.
NAF is based on several simple ideas:

* Separating sequence data from names
* Separating accession numbers from the rest of sequence names
* Storing continuous concatenated DNA of all sequences
* Storing lengths separately from sequences
* Storing mask separately from sequences
* Encoding each nucleotide in 4 bits
* Using Zstandard compressor for fast decompression

Since NAF is a binary format, it can't be manipulated with grep, head, and other text utilities,
unlike FASTA and FASTQ, but similarly to gzipped FASTA and gzipped FASTQ (or to any other compressed format).

See [NAF format specification](https://github.com/KirillKryukov/naf/blob/master/NAFv2.pdf) for details.

## Tools

NAF compressor and decompressor are available at github: <https://github.com/KirillKryukov/naf>.

## Citation

If you use NAF, please cite:

* Kirill Kryukov, Mahoko Takahashi Ueda, So Nakagawa, Tadashi Imanishi (2019)
  "Nucleotide Archival Format (NAF) enables efficient lossless reference-free compression of DNA sequences"
  [Bioinformatics, 35(19), 3826-3828](https://academic.oup.com/bioinformatics/article/35/19/3826/5364265),
  doi: [10.1093/bioinformatics/btz144](https://doi.org/10.1093/bioinformatics/btz144).

Previously available at
<http://biorxiv.org/cgi/content/short/501130v2>,
doi: [10.1101/501130](https://doi.org/10.1101/501130).

## Users

* [GenomeSync](http://genomesync.org/) - Changed from bzip2 to NAF in November 2018, saving 142 GB.

## News

October 1, 2019

NAF paper is officially [published](https://academic.oup.com/bioinformatics/article/35/19/3826/5364265) at Bioinfofrmatics.

October 1, 2019

NAF tools version 1.1.0 are [released](https://github.com/KirillKryukov/naf/releases/tag/v1.1.0).

February 25, 2019

NAF paper is online at Bioinformatics: [btz144](https://academic.oup.com/bioinformatics/advance-article/doi/10.1093/bioinformatics/btz144/5364265)

January 17, 2019

NAF tools version 1.0.0 are released.

[Archived news](news-archive.html)

## Contact

Any comments, suggestions or requests are welcome.
Please email to: kkryukov@gmail.com .

* © 2018-2019 [Kirill Kryukov](http://kirill-kryukov.com/kirr/)