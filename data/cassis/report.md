# cassis CWL Generation Report

## cassis

### Tool Description
Compares two genomes based on orthologous genes or synteny blocks.

### Metadata
- **Docker Image**: quay.io/biocontainers/cassis:0.0.20120106--hdfd78af_1
- **Homepage**: http://pbil.univ-lyon1.fr/software/Cassis/
- **Package**: https://anaconda.org/channels/bioconda/packages/cassis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cassis/overview
- **Total Downloads**: 2.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage:
  cassis [options] <table> <type> <dirGR> <dirGO> <outputdir>

-------------------------------------------------------------------------------
Mandatory Parameters:

  <table> Path for the file that contains the table of orthologous genes or
          synteny blocks.

  <type> Type of the table: G for orthologous genes and B for synteny blocks.

  <dirGR> Path for the directory where the script can locate the FASTA files 
          of the chromosomes of the reference genome (GR).

  <dirGO> Path for the directory where the script can locate the FASTA files 
          of the chromosomes of the genome (GO) which will be compared with  
          the reference genome.

  <outputdir> Name of the directory where the script will write the results.
              The directory must exist (the script will not try to create it).

-------------------------------------------------------------------------------
Optional parameter:

  --lastzlevel N

  LASTZ level: N = 1, 2 or 3
  + Level 1 : LASTZ parameters for closely related species.
  + Level 2 : Default level
  + Level 3 : LASTZ parameters for distantly related species.
  [Default value = 2]


  --max_length_sr N

  Maximum length for sequence SR: N = integer bigger than zero
  If SR length is bigger than N, the breakpoint receives the
  status -6 and it is not processed by the segmentation step.
  [Default value = 1000000000]


  --max_length_sab N

  Maximum length for sequences SA and SB: N = integer bigger than zero
  If SA (or SB) length is bigger than N, the length is corrected
  to fit this limit value.
  [Default value = 3000000]
 

  --minimum_length N

  Minimum sequence length: N = integer bigger than zero
  If one or more sequences have length smaller than N, the breakpoint receives
  one of the status -2, -3 , -4 or -5 and  it is not processed by the 
  segmentation step.
  [Default value = 1 (for genes) or 50000 (for synteny blocks)]


  --extend_before [T/F]

  Extend before verify length: True [T] or FALSE [F]
  This parameter determines if the method verifies the minimum sequence length
  before (F) or after (T) extending the sequence.
  [Default value = T]


  --extend_by_adding_gene [T/F]

  Extend sequences SR, SA and SB: True [T] or FALSE [F]
  Extend sequences SR, SA and SB by adding the orthologous genes which are in
  the boundaries of them. (Orthologous genes: pairs (Ar,Ao) and (Br,Bo))
  Warning: This parameter is available only for table of orthologous genes.
  [Default value = T]


  --extend_ab_by_adding_gene [T/F]

  Extend sequences SA and SB: True [T] or FALSE [F]
  Extend sequences SA and SB by adding the non orthologous genes which are in
  the boundaries of them. (Non orthologous genes: Co and Do)
  Warning: This parameter is available only for table of orthologous genes.
  [Default value = T]


  --extend_by_adding_fragment N

  Extend sequences SR, SA and SB: N = integer bigger than or equal to zero
  Extend sequences SR, SA and SB by adding to them a fragment of length N 
  from the sides that are supposed to be orthologous. It is equivalent to add
  the orthologous genes (Ar,Ao) and (Br,Bo) to the sequences.
  Warning: This parameter is available only for table of synteny blocks.
  [Default value = 50000]


  --extend_ab_by_adding_fragment N

  Extend sequences SA and SB: N = integer bigger than or equal to zero
  Extend sequences SA and SB by adding to them a fragment of length N 
  from the sides that are not supposed to be orthologous. It is equivalent 
  to add the non orthologous genes Co and Do to the sequences.
  Warning: This parameter is available only for table of synteny blocks.
  [Default value = 50000]


-------------------------------------------------------------------------------
File Formats:

  + Table orthologous genes:

  The table of orthologous genes must have just one 2 one orthologous genes 
  that can be found in the genomes GR and GO.

      - g1      = Name of the gene in the genome GR
      - c1      = Chromosome of the genome GR where g1 is located
      - inf1    = Start position of the gene g1 in the chromosome c1
      - sup1    = End position of the gene g1 in the chromosome c1
      - strand1 = Strand of the gene g1 (1 or -1)
      - g2      = Name of the gene in the genome GO
      - c2      = Chromosome of the genome GO where g2 is located
      - inf2    = Start position of the gene g2 in the chromosome c2
      - sup2    = End position of the gene g2 in the chromosome c2
      - strand2 = Strand of the gene g2 (1 or -1)

  Warning: The file must NOT have header with the column names.

  + Table orthologous synteny blocks:

  The table of orthologous synteny blocks must have just one 2 one 
  orthologous synteny blocks that can be found in the genomes GR and
  GO.

      - id      = Name of the synteny block
      - c1      = Chromosome of the genome GR where the block is located
      - inf1    = Start position of the block in the chromosome c1
      - sup1    = End position of the block in the chromosome c1
      - c2      = Chromosome of the genome GO where the block is located
      - inf2    = Start position of the block in the chromosome c2
      - sup2    = End position of the block in the chromosome c2
      - strand  = If 1, the synteny blocks of the genomes GR and GO are on
                  the same strand. Otherwise, they are on different strands.

  Warning: The file must NOT have header with the column names.

  + FASTA files:
  
  The fasta files must be named with the following format: 

      <chromosomename>.fasta

    Chromosome Name      File 
          1              1.fasta
          2A             2A.fasta
          X              X.fasta

  The file must have just one sequence that is related to the chromosome which
  is specified by the name of the file. If the FASTA file have more than one 
  sequence, the file will be ignored.

-------------------------------------------------------------------------------
SCRIPT OUTPUT:

  The script will write all results inside of the directory <outputdir>.
 
  Directories:

  + <outputdir>/alignments

    This directory will receive the results of the alignments of the sequences 
    SR vs SA and SR vs SB.

  + <outputdir>/dotplot

    This directory will receive the dotplot representation of the alignments of
    the sequences SR vs SA and SR vs SB.

  + <outputdir>/fasta

    This directory will receive the FASTA file of all sequences SR, SA and SB.

  + <outputdir>/segmentation

    This directory will receive all plots and results of the breakpoints that 
    were processed by the segmentation process.

  Files:

  + <outputdir>/NonRefinedBreakpoints.txt

    This file will receive all information about the breakpoints that were
    identified. It contains the data used by the segmentation process:

    id        - Breakpoint ID
    type      - Type of the breakpoint: inter or intra
    sRgeneA   - Name of the gene/block A in the sequence SR (genome GR)
    sRgeneB   - Name of the gene/block B in the sequence SR (genome GR)
    sRchr     - Chromosome of the genes/blocks A and B (genome GR)
    sRstrandA - Strand of the gene/block A (genome GR)
    sRstrandB - Strand of the gene/block B (genome GR)
    sRinf     - Inferior boundary of the sequence SR
    sRsup     - Superior boundary of the sequence SR
    sOgeneA   - Name of the gene/block A in the sequence SA (genome GO)
    sOgeneB   - Name of the gene/block B in the sequence SB (genome GO)
    sOchrA    - Chromosome of the gene/block A (genome GO)
    sOchrB    - Chromosome of the gene/block B (genome GO)
    sOstrandA - Strand of the gene/block A (genome GO)
    sOstrandB - Strand of the gene/block B (genome GO)
    sOinfA    - Inferior boundary of the sequence SA
    sOsupA    - Superior boundary of the sequence SA
    sOinfB    - Inferior boundary of the sequence SB
    sOsupB    - Superior boundary of the sequence SB
    bkpBegin  - Relative position of the breakpoint begin (related to sRinf)
    bkpEnd    - Relative position of the breakpoint end (related to sRinf)
    status    - Status of the breakpoint

    The status of the breakpoint can have one of the following values:
      1 : Valid breakpoint
     -2 : Sequence SR smaller than the allowed limit
     -3 : Sequence SA smaller than the allowed limit
     -4 : Sequence SB smaller than the allowed limit
     -5 : Sequence SA and SB smaller than the allowed limit
     -6 : Sequence SR bigger than the allowed limit

  + <outputdir>/segmentation.txt

    Final result of the segmentation process, this file will receive the 
    coordinates of the refined breakpoints:

    id        - Breakpoint id
    chr       - Chromosome where the breakpoint is located (Genome GR)
    oldbegin  - Old breakpoint begin position (in the chromosome sequence)
    oldend    - Old breakpoint end position (in the chromosome sequence)
    oldlength - Old breakpoint length
    newbegin  - New breakpoint begin position (in the chromosome sequence) 
                after the segmentation
    newend    - New breakpoint end position (in the chromosome sequence)
                after the segmentation
    newlength - New breakpoint length
    status    - Status of the breakpoint

    The status of the breakpoint can have one of the following values:
      1 : Segmentation result passed through the statistical test 
      0 : Segmentation result failed through the statistical test
     -1 : Segmentation was not performed because there are no hits on
          the alignments of the sequences SR vs SA and SR vs SB
     -2 : Segmentation was not performed because sequence SR is smaller
          than the allowed limit
     -3 : Segmentation was not performed because sequence SA is smaller 
          than the allowed limit
     -4 : Segmentation was not performed because sequence SB is smaller 
          than the allowed limit
     -5 : Segmentation was not performed because sequence SA and SB are 
          smaller than the allowed limit
     -6 : Segmentation was not performed because sequence SR is bigger 
          than the allowed limit
     -7 : Segmentation was not performed because R aborted the execution


ERROR: Invalid number of parameters.
```

