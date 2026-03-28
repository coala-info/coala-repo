[bioconvert
![Logo](_static/logo.png)](index.html)

* [1. Installation](installation.html)
* [2. User Guide](user_guide.html)
* [3. Tutorial](tutorial.html)
* [4. Developer guide](developer_guide.html)
* [5. Benchmarking](benchmarking.html)
* [6. Gallery](auto_examples/index.html)
* [7. References](references.html)
* 8. Formats
  + [8.1. TWOBIT](#twobit)
  + [8.2. AGP](#agp)
  + [8.3. ABI](#abi)
  + [8.4. ASQG](#asqg)
  + [8.5. BAI](#bai)
  + [8.6. BAM](#bam)
  + [8.7. BCF](#bcf)
  + [8.8. BCL](#bcl)
  + [8.9. BED for plink](#bed-for-plink)
  + [8.10. BEDGRAPH](#bedgraph)
  + [8.11. BED](#bed)
  + [8.12. BED3](#bed3)
  + [8.13. BED4](#bed4)
  + [8.14. BED5](#bed5)
  + [8.15. BED6](#bed6)
  + [8.16. BED12](#bed12)
  + [8.17. BIGBED](#bigbed)
  + [8.18. BIGWIG](#bigwig)
  + [8.19. BIM](#bim)
  + [8.20. BZ2](#bz2)
  + [8.21. COV](#cov)
  + [8.22. CRAM](#cram)
  + [8.23. CLUSTAL](#clustal)
  + [8.24. CSV](#csv)
  + [8.25. DSRC](#dsrc)
  + [8.26. EMBL](#embl)
  + [8.27. FAM](#fam)
  + [8.28. FAA](#faa)
  + [8.29. FASTA](#fasta)
  + [8.30. FastG](#fastg)
  + [8.31. FastQ](#fastq)
  + [8.32. GENBANK](#genbank)
  + [8.33. GENPEPT](#genpept)
  + [8.34. GFA](#gfa)
  + [8.35. GTF](#gtf)
  + [8.36. GFF](#gff)
  + [8.37. GZ](#gz)
  + [8.38. JSON](#json)
  + [8.39. MAF (Mutation Annotation Format)](#maf-mutation-annotation-format)
  + [8.40. MAF (Multiple Alignement Format)](#maf-multiple-alignement-format)
  + [8.41. MAP](#map)
  + [8.42. NEWICK](#newick)
  + [8.43. NEXUS](#nexus)
  + [8.44. ODS](#ods)
  + [8.45. PAF (Pairwise mApping Format)](#paf-pairwise-mapping-format)
  + [8.46. PDB](#pdb)
  + [8.47. PED](#ped)
  + [8.48. PHYLOXML](#phyloxml)
  + [8.49. PHYLIP](#phylip)
  + [8.50. PLINK flat files (MAP/PED)](#plink-flat-files-map-ped)
  + [8.51. PLINK binary files (BED/BIM/FAM)](#plink-binary-files-bed-bim-fam)
  + [8.52. QUAL](#qual)
  + [8.53. SAM](#sam)
  + [8.54. SCF](#scf)
  + [8.55. SRA](#sra)
  + [8.56. TSV](#tsv)
  + [8.57. STOCKHOLM](#stockholm)
  + [8.58. VCF](#vcf)
  + [8.59. WIG](#wig)
  + [8.60. WIGGLE (WIG)](#wiggle-wig)
  + [8.61. XLS](#xls)
  + [8.62. XLSX](#xlsx)
  + [8.63. XMFA](#xmfa)
  + [8.64. YAML](#yaml)
  + [8.65. Others](#others)
    - [8.65.1. ASN1](#asn1)
    - [8.65.2. GCG](#gcg)
    - [8.65.3. GVF](#gvf)
  + [8.66. IG](#ig)
    - [8.66.1. PIR](#pir)
* [9. Glossary](glossary.html)
* [10. Faqs](faqs.html)
* [11. Bibliography](bibliography.html)

[bioconvert](index.html)

* 8. Formats
* [View page source](_sources/formats.rst.txt)

---

# 8. Formats[](#formats "Link to this heading")

Here below, we provide a list of formats used in bioinformatics or computational
biology. Most of these formats are used in **Bioconvert** and available for
conversion to another formats. Some are available for book-keeping.

We hope that this page will be useful to all developers and scientists. Would
you like to contribute, please edit the file in our github **doc/formats.rst**.

If you wish to update this page, please see the [Developer guide](developer_guide.html#developer-guide) page.

## 8.1. TWOBIT[](#twobit "Link to this heading")

Format:
:   binary

Status:
:   available

Type:
:   sequence

A **2bit** file stores multiple DNA sequences (up to 4 Gb total) in a compact
randomly-accessible format. The file contains masking information as well as the
DNA itself.

The file begins with a 16-byte header containing the following fields:

> * signature: the number 0x1A412743 in the architecture of the machine that
>   created the file
> * version: zero for now. Readers should abort if they see a version number
>   higher than 0
> * sequenceCount: the number of sequences in the file
> * reserved: always zero for now

All fields are 32 bits unless noted. If the signature value is not as given, the
reader program should byte-swap the signature and check if the swapped version
matches. If so, all multiple-byte entities in the file will have to be
byte-swapped. This enables these binary files to be used unchanged on different
architectures.

The header is followed by a file index, which contains one entry for each
sequence. Each index entry contains three fields:

> * nameSize: a byte containing the length of the name field
> * name: the sequence name itself (in ASCII-compatible byte string), of
>   variable length depending on nameSize
> * offset: the 32-bit offset of the sequence data relative to the start of
>   the file, not aligned to any 4-byte padding boundary

The index is followed by the sequence records, which contain nine fields:

> * dnaSize - number of bases of DNA in the sequence
> * nBlockCount - the number of blocks of Ns in the file (representing
>   unknown sequence)
> * nBlockStarts - an array of length nBlockCount of 32 bit integers
>   indicating the (0-based) starting position of a block of Ns
> * nBlockSizes - an array of length nBlockCount of 32 bit integers
>   indicating the length of a block of Ns
> * maskBlockCount - the number of masked (lower-case) blocks
> * maskBlockStarts - an array of length maskBlockCount of 32 bit integers
>   indicating the (0-based) starting position of a masked block
> * maskBlockSizes - an array of length maskBlockCount of 32 bit integers
>   indicating the length of a masked block
> * reserved - always zero for now
> * packedDna - the DNA packed to two bits per base, represented as
>   so: T - 00, C - 01, A - 10, G - 11. The first base is in the most
>   significant 2-bit byte; the last base is in the least significant 2 bits.
>   For example, the sequence TCAG is represented as 00011011.

Bioconvert conversions

[`TWOBIT2FASTA`](ref_converters.html#bioconvert.twobit2fasta.TWOBIT2FASTA "bioconvert.twobit2fasta.TWOBIT2FASTA")

Reference:

* <http://genome.ucsc.edu/FAQ/FAQformat.html#format7>

## 8.2. AGP[](#agp "Link to this heading")

Format:
:   human-readable

Status:

Type:
:   assembly

AGP files are used to describe the assembly of a sequences from smaller
fragments. The large object can be a contig, a scaffold (supercontig), or a chromosome. Each
line (row) of the AGP file describes a different piece of the object, and has
the column entries defined below. Several format exists: 1.0, 2.0, 2.1

you can validate your AGP file using this website:
<https://www.ncbi.nlm.nih.gov/projects/genome/assembly/agp/agp_validate.cgi>

References

* <https://www.ebi.ac.uk/ena/submit/agp-files>
* <https://www.ncbi.nlm.nih.gov/assembly/agp/AGP_Validation/>

## 8.3. ABI[](#abi "Link to this heading")

Format:
:   binary

Status:
:   available

Type:
:   sequence

ABI are trace files that include the PHRED quality scores for the base calls.
This allows ABI to FASTQ conversion. Note that each ABI file contains one and only one sequence (no need for indexing the file). The trace data contains probablities of the four nucleotide bases along the sequencing run together with the sequence deduced from that data. ABI trace is a binary format.

File format produced by ABI sequencing machine. It produces ABI “Sanger” capillary sequence

Bioconvert conversions:

[`ABI2QUAL`](ref_converters.html#bioconvert.abi2qual.ABI2QUAL "bioconvert.abi2qual.ABI2QUAL"),
[`ABI2FASTQ`](ref_converters.html#bioconvert.abi2fastq.ABI2FASTQ "bioconvert.abi2fastq.ABI2FASTQ"),
[`ABI2FASTA`](ref_converters.html#bioconvert.abi2fasta.ABI2FASTA "bioconvert.abi2fasta.ABI2FASTA")

See also

[SCF](#format-scf), [`SCF2FASTA`](ref_converters.html#bioconvert.scf2fasta.SCF2FASTA "bioconvert.scf2fasta.SCF2FASTA"),
[`SCF2FASTQ`](ref_converters.html#bioconvert.scf2fastq.SCF2FASTQ "bioconvert.scf2fastq.SCF2FASTQ"),

References

* ftp://saf.bio.caltech.edu/pub/software/molbio/abitools.zip
* <https://github.com/jkbonfield/io_lib/>
* <http://www6.appliedbiosystems.com/support/software_community/ABIF_File_Format.pdf>

## 8.4. ASQG[](#asqg "Link to this heading")

Format:
:   human-readable

Status:
:   not included (deprecated)

Type:
:   assembly

The ASQG format describes an assembly graph. Each line is a tab-delimited
record. The first field in each record describes the record type. The three
types are:

* HT: Header record. This record contains metadata tags for the file version
  (VN tag) and parameters associated with the graph (for example the minimum
  overlap length).
* VT: Vertex records. The second field contains the vertex identifier, the
  third field contains the sequence. Subsequent fields contain optional tags.
* ED: Edge description records. Fields are:
  :   + sequence 1 name
      + sequence 2 name
      + sequence 1 overlap start (0 based)
      + sequence 1 overlap end (inclusive)
      + sequence 1 length
      + sequence 2 overlap start (0 based)
      + sequence 2 overlap end (inclusive)
      + sequence 2 length
      + sequence 2 orientation (1 for reversed with respect to sequence 1)
      + number of differences in overlap (0 for perfect overlaps, which is the default).

Example:

```
HT  VN:i:1  ER:f:0  OL:i:45 IN:Z:reads.fa   CN:i:1  TE:i:0
VT  read1   GATCGATCTAGCTAGCTAGCTAGCTAGTTAGATGCATGCATGCTAGCTGG
VT  read2   CGATCTAGCTAGCTAGCTAGCTAGTTAGATGCATGCATGCTAGCTGGATA
VT  read3   ATCTAGCTAGCTAGCTAGCTAGTTAGATGCATGCATGCTAGCTGGATATT
ED  read2 read1 0 46 50 3 49 50 0 0
ED  read3 read2 0 47 50 2 49 50 0 0
```

References

* <https://github.com/jts/sga/wiki/ASQG-Format>

## 8.5. BAI[](#bai "Link to this heading")

Format:
:   binary

Status:
:   not included

Type:
:   index

The index file of a BAM file is a BAI file format. The BAI files are
not used in **Bioconvert**.

## 8.6. BAM[](#bam "Link to this heading")

Format:
:   binary

Status:
:   included

Type:
:   Sequence alignement

The BAM (Binary Alignment Map) is the binary version of the Sequence
Alignment Map ([SAM](#format-sam)) format. It is a compact and index-able representation
of nucleotide sequence alignments.

Bioconvert Conversions

[`BAM2SAM`](ref_converters.html#bioconvert.bam2sam.BAM2SAM "bioconvert.bam2sam.BAM2SAM"),
[`BAM2CRAM`](ref_converters.html#bioconvert.bam2cram.BAM2CRAM "bioconvert.bam2cram.BAM2CRAM"),
[`BAM2BEDGRAPH`](ref_converters.html#bioconvert.bam2bedgraph.BAM2BEDGRAPH "bioconvert.bam2bedgraph.BAM2BEDGRAPH"),
`BAM2COV`,
[`BAM2BIGWIG`](ref_converters.html#bioconvert.bam2bigwig.BAM2BIGWIG "bioconvert.bam2bigwig.BAM2BIGWIG"),
[`BAM2FASTA`](ref_converters.html#bioconvert.bam2fasta.BAM2FASTA "bioconvert.bam2fasta.BAM2FASTA"),
[`BAM2FASTQ`](ref_converters.html#bioconvert.bam2fastq.BAM2FASTQ "bioconvert.bam2fastq.BAM2FASTQ"),
[`BAM2JSON`](ref_converters.html#bioconvert.bam2json.BAM2JSON "bioconvert.bam2json.BAM2JSON"),
[`BAM2TSV`](ref_converters.html#bioconvert.bam2tsv.BAM2TSV "bioconvert.bam2tsv.BAM2TSV"),
[`BAM2WIGGLE`](ref_converters.html#bioconvert.bam2wiggle.BAM2WIGGLE "bioconvert.bam2wiggle.BAM2WIGGLE")

References

* <http://samtools.github.io/hts-specs/SAMv1.pdf>
* <http://genome.ucsc.edu/goldenPath/help/bam.html>

See also

The [SAM](#format-sam) and [BAI](#format-bai) formats.

## 8.7. BCF[](#bcf "Link to this heading")

Format:
:   binary

Status:
:   included

Type:
:   variant

Binary version of the Variant Call Format ([VCF](#format-vcf)).

Bioconvert conversions

[`BCF2VCF`](ref_converters.html#bioconvert.bcf2vcf.BCF2VCF "bioconvert.bcf2vcf.BCF2VCF"), [`VCF2BCF`](ref_converters.html#bioconvert.vcf2bcf.VCF2BCF "bioconvert.vcf2bcf.VCF2BCF").
[`BCF2WIGGLE`](ref_converters.html#bioconvert.bcf2wiggle.BCF2WIGGLE "bioconvert.bcf2wiggle.BCF2WIGGLE")

## 8.8. BCL[](#bcl "Link to this heading")

Format:
:   binary

Status:
:   not included

Type:
:   sequence

BCL is the raw format used by Illumina sequencer. This data is converted into
[FastQ](#format-fastq) thanks to a tool called bcl2fastq. This type of conversion is not included
in **Bioconvert**. Indeed, Illumina provides a **bcl2fastq** executable and its user guide is available online. In most cases, the BCL files are already converted and users will only get the FastQ files so we will not provide such converter.

References

* <https://support.illumina.com/content/dam/illumina-support/documents/documentation/software_documentation/bcl2fastq/bcl2fastq_letterbooklet_15038058brpmi.pdf>
* <http://bioinformatics.cvr.ac.uk/blog/how-to-demultiplex-illumina-data-and-generate-fastq-files-using-bcl2fastq/>

## 8.9. BED for plink[](#bed-for-plink "Link to this heading")

Format:
:   binary

Status:
:   included

Type:
:   genotypic

This BED format is the binary PED file. Not to be confused with BED format used
with BAM files. Please see [PLINK binary files (BED/BIM/FAM)](#format-plink-binary) section.

## 8.10. BEDGRAPH[](#bedgraph "Link to this heading")

Format:
:   human-readable

Status:
:   included

Type:
:   database

BedGraph is a subset of BED12 format. It is a 4-columns tab-delimited file with
chromosome name, start and end positions and the fourth column is a number that is
often used to show coverage depth. So, this is the same format as the
[BED4](#format-bed4) format.
Example:

```
chr1    0     75  0
chr1    75   176  1
chr1    176  177  2
```

See also

[BED](#format-bed)

## 8.11. BED[](#bed "Link to this heading")

Format:
:   human-readable

Status:
:   not included

Type:
:   database

A Browser Extensible Data (BED) file is a tab-delimited text file. It is a
concise way to represent genomic features and annotations.

The BED file is a very versatile format, which makes it difficult to handle in **Bioconvert**. So, let us describe exhaustively the BED format.

Although the BED description format supports up to 12 columsn, only the first 3
are required for some tools such as the UCSC browser, Galaxy, or bedtools
software.

So, in general BED lines have 3 required fields and nine additional
optional fields.

Generally, all BED files have the same extensions (.bed) irrespective of the
number of columns. We can refer to the 3-columns version as BED3, the 4-columns
BED as [BED4](#format-bed4) and so on.

The number of fields per line must be consistent. If some fields are empty,
additional column information must be filled for consistency (e.g., with a “.”).
BED fields can be whitespace-delimited or tab-delimited although some
variations of BED types such as “bed Detail” require a tab character
delimitation for the detail columns (see Note box here below).

Note

*BED detail* format

It is an extension of BED format plus 2 additional fields.
The first one is an ID, which can be used in place of the name field
for creating links from the details pages. The second additional field
is a description of the item, which can be a long description and can
consist of html.

Requirements:
:   > * fields must be tab-separated
    > * “type=bedDetail” must be included in the track line,
    > * the name and position fields should uniquely describe items
    >   so that the correct ID and description will be displayed on
    >   the details pages.

    The following example uses the first 4 columns of BED format,
    but up to 12 may be used. Note the header, which contains the
    type=bedDetail string.:

    ```
    track name=HbVar type=bedDetail descriptio