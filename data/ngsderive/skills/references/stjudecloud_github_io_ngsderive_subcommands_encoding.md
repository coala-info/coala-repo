[ngsderive](../..)

* [Home](../..)
* Subcommands
  + [strandedness](../strandedness/)
  + [instrument](../instrument/)
  + [readlen](../readlen/)
  + [encoding](./)
  + [junction-annotation](../junction_annotation/)

* Search
* [Previous](../readlen/)
* [Next](../junction_annotation/)
* [Edit on GitHub](https://github.com/stjudecloud/ngsderive/edit/master/docs/subcommands/encoding.md)

* [encoding](#encoding)
  + [Limitations](#limitations)

# encoding

The `encoding` subcommand detects the likely PHRED score encoding schema used for FASTQ and BAM files. PHRED scores are encoded as ASCII characters, but which ASCII characters encode for which relative quality scores depends on the build and generation of the sequencing machine used. The `encoding` subcommand detects PHRED+33 (AKA Illumina1.8+ or Sanger), Illumina1.3, and Illumina1.0 quality encoding formats. The BAM specification calls for `PHRED+33`, however this is also the most permissive encoding. It is possible for a stricter encoding to be mis-translated as `PHRED+33` and appear to be of higher quality than it is in truth. This is due to Illumina1.3 using ASCII characters that are a subset of those in Illumina 1.0, and Illumina 1.0 using a subset of characters in Sanger format (that is Illumina1.3 ⊂ Illumina1.0 and Illumina1.0 ⊂ Sanger). This subcommand can be used to check if base scores are suspiciously high throughout a BAM, and a mis-translation may have occurred.

As a hypothetical example of a mis-translation; a FASTQ sequenced by an Illumina1.3 machine has PHRED quality scores ranging from 6-22. They would be encoded as ASCII values 70-86. If those ASCII values are not adjusted during BAM alignment, someone decoding the PHRED score according to the PHRED+33 specification would think the quality range for that sample was 37-53. This is erroneously high, and may convey undue confidence in the quality of the BAM.

`ngsderive`'s encoding check implementation is based on details of the encoding schemes described [here](https://en.wikipedia.org/wiki/FASTQ_format#Encoding).

## Limitations

* All 3 possible encodings have the same upper range, and only differ in terms of lower quality scores. Thus if the provided read data is all of high quality, it may be classified as a stricter encoding than was originally used to generate the data.

  If the downstream use of this value is needed to ensure all PHRED scores are within the derived encoding, use `--n-reads -1` to parse the entire file.

---

© 2020 St. Jude Children's Research Hospital

Documentation built with [MkDocs](https://www.mkdocs.org/).

#### Search

×Close

From here you can search these documents. Enter your search terms below.

#### Keyboard Shortcuts

×Close

| Keys | Action |
| --- | --- |
| `?` | Open this help |
| `n` | Next page |
| `p` | Previous page |
| `s` | Search |