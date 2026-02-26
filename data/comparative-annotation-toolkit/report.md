# comparative-annotation-toolkit CWL Generation Report

## comparative-annotation-toolkit_faToTwoBit

### Tool Description
Convert DNA from fasta to 2bit format

### Metadata
- **Docker Image**: quay.io/biocontainers/comparative-annotation-toolkit:0.1--pyh2407274_1
- **Homepage**: https://github.com/ComparativeGenomicsToolkit/Comparative-Annotation-Toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/comparative-annotation-toolkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/comparative-annotation-toolkit/overview
- **Total Downloads**: 6.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ComparativeGenomicsToolkit/Comparative-Annotation-Toolkit
- **Stars**: N/A
### Original Help Text
```text
faToTwoBit - Convert DNA from fasta to 2bit format
usage:
   faToTwoBit in.fa [in2.fa in3.fa ...] out.2bit
options:
   -long          use 64-bit offsets for index.   Allow for twoBit to contain more than 4Gb of sequence. 
                  NOT COMPATIBLE WITH OLDER CODE.
   -noMask        Ignore lower-case masking in fa file.
   -stripVersion  Strip off version number after '.' for GenBank accessions.
   -ignoreDups    Convert first sequence only if there are duplicate sequence
                  names.  Use 'twoBitDup' to find duplicate sequences.
```


## comparative-annotation-toolkit_gff3ToGenePred

### Tool Description
convert a GFF3 file to a genePred file

### Metadata
- **Docker Image**: quay.io/biocontainers/comparative-annotation-toolkit:0.1--pyh2407274_1
- **Homepage**: https://github.com/ComparativeGenomicsToolkit/Comparative-Annotation-Toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/comparative-annotation-toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
gff3ToGenePred - convert a GFF3 file to a genePred file
usage:
   gff3ToGenePred inGff3 outGp
options:
  -warnAndContinue - on bad genePreds being created, put out warning but continue
  -useName - rather than using 'id' as name, use the 'name' tag
  -rnaNameAttr=attr - If this attribute exists on an RNA record, use it as the genePred
   name column
  -geneNameAttr=attr - If this attribute exists on a gene record, use it as the genePred
   name2 column
  -attrsOut=file - output attributes of mRNA record to file.  These are per-genePred row,
   not per-GFF3 record. Thery are derived from GFF3 attributes, not the attributes themselves.
  -processAllGeneChildren - output genePred for all children of a gene regardless of feature
  -unprocessedRootsOut=file - output GFF3 root records that were not used.  This will not be a
   valid GFF3 file.  It's expected that many non-root records will not be used and they are not
   reported.
  -bad=file   - output genepreds that fail checks to file
  -maxParseErrors=50 - Maximum number of parsing errors before aborting. A negative
   value will allow an unlimited number of errors.  Default is 50.
  -maxConvertErrors=50 - Maximum number of conversion errors before aborting. A negative
   value will allow an unlimited number of errors.  Default is 50.
  -honorStartStopCodons - only set CDS start/stop status to complete if there are
   corresponding start_stop codon records
  -defaultCdsStatusToUnknown - default the CDS status to unknown rather
   than complete.
  -allowMinimalGenes - normally this programs assumes that genes contains
   transcripts which contain exons.  If this option is specified, genes with exons
   as direct children of genes and stand alone genes with no exon or transcript
   children will be converted.
  -refseqHacks - enable various hacks to make RefSeq conversion work:
     This turns on -useName, -allowMinimalGenes, and -processAllGeneChildren.
     It try harder to find an accession in attributes

This converts:
   - top-level gene records with RNA records
   - top-level RNA records
   - RNA records that contain:
       - exon and CDS
       - CDS, five_prime_UTR, three_prime_UTR
       - only exon for non-coding
   - top-level gene records with transcript records
   - top-level transcript records
   - transcript records that contain:
       - exon
where RNA can be mRNA, ncRNA, or rRNA, and transcript can be either
transcript or primary_transcript
The first step is to parse GFF3 file, up to 50 errors are reported before
aborting.  If the GFF3 files is successfully parse, it is converted to gene,
annotation.  Up to 50 conversion errors are reported before aborting.

Input file must conform to the GFF3 specification:
   http://www.sequenceontology.org/gff3.shtml
```


## comparative-annotation-toolkit_pslMap

### Tool Description
map PSLs alignments to new targets using alignments of the old target to the new target. Given inPsl and mapPsl, where the target of inPsl is the query of mapPsl, create a new PSL with the query of inPsl aligned to all the targets of mapPsl. If inPsl is a protein to nucleotide alignment and mapPsl is a nucleotide to nucleotide alignment, the resulting alignment is nucleotide to nucleotide alignment of a hypothetical mRNA that would code for the protein. This is useful as it gives base alignments of spliced codons. A chain file may be used instead mapPsl.

### Metadata
- **Docker Image**: quay.io/biocontainers/comparative-annotation-toolkit:0.1--pyh2407274_1
- **Homepage**: https://github.com/ComparativeGenomicsToolkit/Comparative-Annotation-Toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/comparative-annotation-toolkit/overview
- **Validation**: PASS

### Original Help Text
```text
Error: wrong number of arguments
pslMap - map PSLs alignments to new targets using alignments of
the old target to the new target.  Given inPsl and mapPsl, where
the target of inPsl is the query of mapPsl, create a new PSL
with the query of inPsl aligned to all the targets of mapPsl.
If inPsl is a protein to nucleotide alignment and mapPsl is a
nucleotide to nucleotide alignment, the resulting alignment is
nucleotide to nucleotide alignment of a hypothetical mRNA that
would code for the protein.  This is useful as it gives base
alignments of spliced codons.  A chain file may be used instead
mapPsl.

usage:
   pslMap [options] inPsl mapFile outPsl

Options:
  -chainMapFile - mapFile is a chain file instead of a psl file
  -swapMap - swap query and target sides of map file.
  -swapIn - swap query and target sides of inPsl file.
  -suffix=str - append str to the query ids in the output
   alignment.  Useful with protein alignments, where the result
   is not actually and alignment of the protein.
  -keepTranslated - if either psl is translated, the output psl
   will be translated (both strands explicted).  Normally an
   untranslated psl will always be created
  -mapFileWithInQName - The first column of the mapFile PSL records are a qName,
   the remainder is a standard PSL.  When an inPsl record is mapped, only
   mapping records are used with the corresponding qName.
  -mapInfo=file - output a file with information about each mapping.
   The file has the following columns:
     o srcQName, srcQStart, srcQEnd, srcQSize - qName, etc of
       psl being mapped (source alignment)
     o srcTName, srcTStart, srcTEnd - tName, etc of psl being
       mapped
     o srcStrand - strand of psl being mapped
     o srcAligned - number of aligned based in psl being mapped
     o mappingQName, mappingQStart, mappingQEnd - qName, etc of
       mapping psl used to map alignment
     o mappingTName, mappingTStart, mappingTEnd - tName, etc of
       mapping psl
     o mappingStrand - strand of mapping psl
     o mappingId - chain id, or psl file row
     o mappedQName mappedQStart, mappedQEnd - qName, etc of
       mapped psl
     o mappedTName, mappedTStart, mappedTEnd - tName, etc of
       mapped psl
     o mappedStrand - strand of mapped psl
     o mappedAligned - number of aligned bases that were mapped
     o qStartTrunc - aligned bases at qStart not mapped due to
       mapping psl/chain not covering the entire soruce psl.
       This is from the start of the query in the positive
       direction.
     o qEndTrunc - similary for qEnd
   If the psl count not be mapped, the mapping* and mapped* columns are empty.
  -mappingPsls=pslFile - write mapping alignments that were used in
   PSL format to this file.  Transformations that were done, such as
   -swapMap, will be reflected in this file.  There will be a one-to-one
   correspondence of rows of this file to rows of the outPsl file.
  -simplifyMappingIds - simplifying mapping ids (inPsl target
   name and mapFile query name) before matching them. This
   first drops everything after the last `-', and then drops
   everything after the last remaining `.'.
  -verbose=n  - verbose output
     2 - show each overlap and the mapping
```

