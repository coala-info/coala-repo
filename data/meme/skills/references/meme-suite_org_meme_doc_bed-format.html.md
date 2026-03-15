# The MEME Suite

## Motif-based sequence analysis tools

## BED Genomic Loci Format

### Description

Various MEME Suite programs require as input a file containing
genomic loci. These input files must be in tab-delimited BED format, which must be **plain text**,
not WORD, .doc, .docx, .rtf or any other word-processor format.

### Format Specification

BED (Browser Extensible Data) format provides a flexible way to define the loci of genomic regions.
Below, we give a brief description of BED format, as used by some of the MEME Suite tools.
For a more complete definition, please see the original document at UCSC describing the
 [BED Format](https://genome.ucsc.edu/FAQ/FAQformat.html#format1).

The first three required BED fields are:

1. **chrom** - The name of the chromosome (e.g. chr3, chrY, chr2\_random) or scaffold
   (e.g. scaffold10671).
2. **chromStart** - The starting position of the feature in the chromosome or scaffold.
   The first base in a chromosome is numbered 0.
3. **chromEnd** - The ending position of the feature in the chromosome or scaffold. The
   *chromEnd* base is not included in the display of the feature, however,
   the number in [position format](https://genome.ucsc.edu/FAQ/FAQtracks#tracks1) will be represented. For example,
   the first 100 bases of chromosome 1 are defined as *chrom=1, chromStart=0, chromEnd=100*,
   and span the bases numbered 0-99 in our software (not 0-100), but will represent the
   position notation chr1:1-100.

The 9 additional optional BED fields are:

4. **name** - Defines the name of the BED line.
   The MEME Suite tools ignore the contents of this field.
5. **score** - A score between 0 and 1000.- **strand** - Defines the strand. Either "." (=no strand) or "+" or "-".
   - **thickStart** - The MEME Suite tools ignore the contents of this field.
   - **thickEnd** - The MEME Suite tools ignore the contents of this field.
   - **itemRgb** - The MEME Suite tools ignore the contents of this field.
   - **blockCount** - The MEME Suite tools ignore the contents of this field.
   - **blockSizes** - The MEME Suite tools ignore the contents of this field.
   - **blockStarts** - The MEME Suite tools ignore the contents of this field.

**Note:**  Lines starting with "#" or "track" or "browser" are treated as comments and ignored.