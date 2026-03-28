# macse CWL Generation Report

## macse_alignsequences

### Tool Description
MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.

### Metadata
- **Docker Image**: quay.io/biocontainers/macse:2.07--hdfd78af_0
- **Homepage**: https://bioweb.supagro.inra.fr/macse/
- **Package**: https://anaconda.org/channels/bioconda/packages/macse/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/macse/overview
- **Total Downloads**: 11.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
This is MACSE V2.07 If you find MACSE useful, please cite:

MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons
Vincent Ranwez, Emmanuel J P Douzery, Cedric Cambon, Nathalie Chantret, Frederic Delsuc
Molecular Biology and Evolution, 2020, 35(10):2582-2584, https://doi.org/10.1093/molbev/msy159

MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
Vincent Ranwez, Sebastien Harispe, Frederic Delsuc, Emmanuel JP Douzery
PLoS One 2011, 6(9):e22594, https://doi.org/10.1371/journal.pone.0022594


usage: [-prog PROGRAM_NAME] [-debug] [-help]

PROGRAMS:
  'alignSequences'	 aligns nucleotide (NT) coding sequences using their amino acid (AA) translations
  'alignTwoProfiles'	 aligns two previously computed nucleotide alignments (also called profiles) without questioning them
  'enrichAlignment'	 adds sequences to a pre-existing nucleotide alignment
  'exportAlignment'	 allows to export a MACSE alignment and to compute some statistics, it can...
  'mergeTwoMasks'	 indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability)....
  'multiPrograms'	 sequentially executes multiple MACSE commands contained in a text file (one per line)....
  'refineAlignment'	 improves the input nucleotide alignment
  'reportGapsAA2NT'	 uses a amino acid alignment to align nucleotide sequences....
  'reportMaskAA2NT'	 uses a filtered amino acid alignment to filter a nucleotide alignment....
  'splitAlignment'	 splits one alignment, to extract a subset of sequences and/or sites....
  'translateNT2AA'	 translates nucleotides into amino acids
  'trimAlignment'	 trims the input alignment by removing gappy sites at the beginning/end of the alignment....
  'trimNonHomologousFragments'	 identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments....
  'trimSequences'	 removes the 3' and 5' parts of the input sequence that are non homologous to an alignment....


cli.exceptions.parsing.ProgramNotFoundException: Program  could not be found.
```


## macse_aligntwoprofiles

### Tool Description
Aligns two previously computed nucleotide alignments (also called profiles) without questioning them

### Metadata
- **Docker Image**: quay.io/biocontainers/macse:2.07--hdfd78af_0
- **Homepage**: https://bioweb.supagro.inra.fr/macse/
- **Package**: https://anaconda.org/channels/bioconda/packages/macse/overview
- **Validation**: PASS

### Original Help Text
```text
This is MACSE V2.07 If you find MACSE useful, please cite:

MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons
Vincent Ranwez, Emmanuel J P Douzery, Cedric Cambon, Nathalie Chantret, Frederic Delsuc
Molecular Biology and Evolution, 2020, 35(10):2582-2584, https://doi.org/10.1093/molbev/msy159

MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
Vincent Ranwez, Sebastien Harispe, Frederic Delsuc, Emmanuel JP Douzery
PLoS One 2011, 6(9):e22594, https://doi.org/10.1371/journal.pone.0022594


usage: [-prog PROGRAM_NAME] [-debug] [-help]

PROGRAMS:
  'alignSequences'	 aligns nucleotide (NT) coding sequences using their amino acid (AA) translations
  'alignTwoProfiles'	 aligns two previously computed nucleotide alignments (also called profiles) without questioning them
  'enrichAlignment'	 adds sequences to a pre-existing nucleotide alignment
  'exportAlignment'	 allows to export a MACSE alignment and to compute some statistics, it can...
  'mergeTwoMasks'	 indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability)....
  'multiPrograms'	 sequentially executes multiple MACSE commands contained in a text file (one per line)....
  'refineAlignment'	 improves the input nucleotide alignment
  'reportGapsAA2NT'	 uses a amino acid alignment to align nucleotide sequences....
  'reportMaskAA2NT'	 uses a filtered amino acid alignment to filter a nucleotide alignment....
  'splitAlignment'	 splits one alignment, to extract a subset of sequences and/or sites....
  'translateNT2AA'	 translates nucleotides into amino acids
  'trimAlignment'	 trims the input alignment by removing gappy sites at the beginning/end of the alignment....
  'trimNonHomologousFragments'	 identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments....
  'trimSequences'	 removes the 3' and 5' parts of the input sequence that are non homologous to an alignment....


cli.exceptions.parsing.ProgramNotFoundException: Program  could not be found.
```


## macse_enrichalignment

### Tool Description
MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.

### Metadata
- **Docker Image**: quay.io/biocontainers/macse:2.07--hdfd78af_0
- **Homepage**: https://bioweb.supagro.inra.fr/macse/
- **Package**: https://anaconda.org/channels/bioconda/packages/macse/overview
- **Validation**: PASS

### Original Help Text
```text
This is MACSE V2.07 If you find MACSE useful, please cite:

MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons
Vincent Ranwez, Emmanuel J P Douzery, Cedric Cambon, Nathalie Chantret, Frederic Delsuc
Molecular Biology and Evolution, 2020, 35(10):2582-2584, https://doi.org/10.1093/molbev/msy159

MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
Vincent Ranwez, Sebastien Harispe, Frederic Delsuc, Emmanuel JP Douzery
PLoS One 2011, 6(9):e22594, https://doi.org/10.1371/journal.pone.0022594


usage: [-prog PROGRAM_NAME] [-debug] [-help]

PROGRAMS:
  'alignSequences'	 aligns nucleotide (NT) coding sequences using their amino acid (AA) translations
  'alignTwoProfiles'	 aligns two previously computed nucleotide alignments (also called profiles) without questioning them
  'enrichAlignment'	 adds sequences to a pre-existing nucleotide alignment
  'exportAlignment'	 allows to export a MACSE alignment and to compute some statistics, it can...
  'mergeTwoMasks'	 indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability)....
  'multiPrograms'	 sequentially executes multiple MACSE commands contained in a text file (one per line)....
  'refineAlignment'	 improves the input nucleotide alignment
  'reportGapsAA2NT'	 uses a amino acid alignment to align nucleotide sequences....
  'reportMaskAA2NT'	 uses a filtered amino acid alignment to filter a nucleotide alignment....
  'splitAlignment'	 splits one alignment, to extract a subset of sequences and/or sites....
  'translateNT2AA'	 translates nucleotides into amino acids
  'trimAlignment'	 trims the input alignment by removing gappy sites at the beginning/end of the alignment....
  'trimNonHomologousFragments'	 identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments....
  'trimSequences'	 removes the 3' and 5' parts of the input sequence that are non homologous to an alignment....


cli.exceptions.parsing.ProgramNotFoundException: Program  could not be found.
```


## macse_exportalignment

### Tool Description
allows to export a MACSE alignment and to compute some statistics, it can...

### Metadata
- **Docker Image**: quay.io/biocontainers/macse:2.07--hdfd78af_0
- **Homepage**: https://bioweb.supagro.inra.fr/macse/
- **Package**: https://anaconda.org/channels/bioconda/packages/macse/overview
- **Validation**: PASS

### Original Help Text
```text
This is MACSE V2.07 If you find MACSE useful, please cite:

MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons
Vincent Ranwez, Emmanuel J P Douzery, Cedric Cambon, Nathalie Chantret, Frederic Delsuc
Molecular Biology and Evolution, 2020, 35(10):2582-2584, https://doi.org/10.1093/molbev/msy159

MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
Vincent Ranwez, Sebastien Harispe, Frederic Delsuc, Emmanuel JP Douzery
PLoS One 2011, 6(9):e22594, https://doi.org/10.1371/journal.pone.0022594


usage: [-prog PROGRAM_NAME] [-debug] [-help]

PROGRAMS:
  'alignSequences'	 aligns nucleotide (NT) coding sequences using their amino acid (AA) translations
  'alignTwoProfiles'	 aligns two previously computed nucleotide alignments (also called profiles) without questioning them
  'enrichAlignment'	 adds sequences to a pre-existing nucleotide alignment
  'exportAlignment'	 allows to export a MACSE alignment and to compute some statistics, it can...
  'mergeTwoMasks'	 indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability)....
  'multiPrograms'	 sequentially executes multiple MACSE commands contained in a text file (one per line)....
  'refineAlignment'	 improves the input nucleotide alignment
  'reportGapsAA2NT'	 uses a amino acid alignment to align nucleotide sequences....
  'reportMaskAA2NT'	 uses a filtered amino acid alignment to filter a nucleotide alignment....
  'splitAlignment'	 splits one alignment, to extract a subset of sequences and/or sites....
  'translateNT2AA'	 translates nucleotides into amino acids
  'trimAlignment'	 trims the input alignment by removing gappy sites at the beginning/end of the alignment....
  'trimNonHomologousFragments'	 identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments....
  'trimSequences'	 removes the 3' and 5' parts of the input sequence that are non homologous to an alignment....


cli.exceptions.parsing.ProgramNotFoundException: Program  could not be found.
```


## macse_mergetwomasks

### Tool Description
Indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability)....

### Metadata
- **Docker Image**: quay.io/biocontainers/macse:2.07--hdfd78af_0
- **Homepage**: https://bioweb.supagro.inra.fr/macse/
- **Package**: https://anaconda.org/channels/bioconda/packages/macse/overview
- **Validation**: PASS

### Original Help Text
```text
This is MACSE V2.07 If you find MACSE useful, please cite:

MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons
Vincent Ranwez, Emmanuel J P Douzery, Cedric Cambon, Nathalie Chantret, Frederic Delsuc
Molecular Biology and Evolution, 2020, 35(10):2582-2584, https://doi.org/10.1093/molbev/msy159

MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
Vincent Ranwez, Sebastien Harispe, Frederic Delsuc, Emmanuel JP Douzery
PLoS One 2011, 6(9):e22594, https://doi.org/10.1371/journal.pone.0022594


usage: [-prog PROGRAM_NAME] [-debug] [-help]

PROGRAMS:
  'alignSequences'	 aligns nucleotide (NT) coding sequences using their amino acid (AA) translations
  'alignTwoProfiles'	 aligns two previously computed nucleotide alignments (also called profiles) without questioning them
  'enrichAlignment'	 adds sequences to a pre-existing nucleotide alignment
  'exportAlignment'	 allows to export a MACSE alignment and to compute some statistics, it can...
  'mergeTwoMasks'	 indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability)....
  'multiPrograms'	 sequentially executes multiple MACSE commands contained in a text file (one per line)....
  'refineAlignment'	 improves the input nucleotide alignment
  'reportGapsAA2NT'	 uses a amino acid alignment to align nucleotide sequences....
  'reportMaskAA2NT'	 uses a filtered amino acid alignment to filter a nucleotide alignment....
  'splitAlignment'	 splits one alignment, to extract a subset of sequences and/or sites....
  'translateNT2AA'	 translates nucleotides into amino acids
  'trimAlignment'	 trims the input alignment by removing gappy sites at the beginning/end of the alignment....
  'trimNonHomologousFragments'	 identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments....
  'trimSequences'	 removes the 3' and 5' parts of the input sequence that are non homologous to an alignment....


cli.exceptions.parsing.ProgramNotFoundException: Program  could not be found.
```


## macse_multiprograms

### Tool Description
MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.

### Metadata
- **Docker Image**: quay.io/biocontainers/macse:2.07--hdfd78af_0
- **Homepage**: https://bioweb.supagro.inra.fr/macse/
- **Package**: https://anaconda.org/channels/bioconda/packages/macse/overview
- **Validation**: PASS

### Original Help Text
```text
This is MACSE V2.07 If you find MACSE useful, please cite:

MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons
Vincent Ranwez, Emmanuel J P Douzery, Cedric Cambon, Nathalie Chantret, Frederic Delsuc
Molecular Biology and Evolution, 2020, 35(10):2582-2584, https://doi.org/10.1093/molbev/msy159

MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
Vincent Ranwez, Sebastien Harispe, Frederic Delsuc, Emmanuel JP Douzery
PLoS One 2011, 6(9):e22594, https://doi.org/10.1371/journal.pone.0022594


usage: [-prog PROGRAM_NAME] [-debug] [-help]

PROGRAMS:
  'alignSequences'	 aligns nucleotide (NT) coding sequences using their amino acid (AA) translations
  'alignTwoProfiles'	 aligns two previously computed nucleotide alignments (also called profiles) without questioning them
  'enrichAlignment'	 adds sequences to a pre-existing nucleotide alignment
  'exportAlignment'	 allows to export a MACSE alignment and to compute some statistics, it can...
  'mergeTwoMasks'	 indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability)....
  'multiPrograms'	 sequentially executes multiple MACSE commands contained in a text file (one per line)....
  'refineAlignment'	 improves the input nucleotide alignment
  'reportGapsAA2NT'	 uses a amino acid alignment to align nucleotide sequences....
  'reportMaskAA2NT'	 uses a filtered amino acid alignment to filter a nucleotide alignment....
  'splitAlignment'	 splits one alignment, to extract a subset of sequences and/or sites....
  'translateNT2AA'	 translates nucleotides into amino acids
  'trimAlignment'	 trims the input alignment by removing gappy sites at the beginning/end of the alignment....
  'trimNonHomologousFragments'	 identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments....
  'trimSequences'	 removes the 3' and 5' parts of the input sequence that are non homologous to an alignment....


cli.exceptions.parsing.ProgramNotFoundException: Program  could not be found.
```


## macse_refinealignment

### Tool Description
improves the input nucleotide alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/macse:2.07--hdfd78af_0
- **Homepage**: https://bioweb.supagro.inra.fr/macse/
- **Package**: https://anaconda.org/channels/bioconda/packages/macse/overview
- **Validation**: PASS

### Original Help Text
```text
This is MACSE V2.07 If you find MACSE useful, please cite:

MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons
Vincent Ranwez, Emmanuel J P Douzery, Cedric Cambon, Nathalie Chantret, Frederic Delsuc
Molecular Biology and Evolution, 2020, 35(10):2582-2584, https://doi.org/10.1093/molbev/msy159

MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
Vincent Ranwez, Sebastien Harispe, Frederic Delsuc, Emmanuel JP Douzery
PLoS One 2011, 6(9):e22594, https://doi.org/10.1371/journal.pone.0022594


usage: [-prog PROGRAM_NAME] [-debug] [-help]

PROGRAMS:
  'alignSequences'	 aligns nucleotide (NT) coding sequences using their amino acid (AA) translations
  'alignTwoProfiles'	 aligns two previously computed nucleotide alignments (also called profiles) without questioning them
  'enrichAlignment'	 adds sequences to a pre-existing nucleotide alignment
  'exportAlignment'	 allows to export a MACSE alignment and to compute some statistics, it can...
  'mergeTwoMasks'	 indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability)....
  'multiPrograms'	 sequentially executes multiple MACSE commands contained in a text file (one per line)....
  'refineAlignment'	 improves the input nucleotide alignment
  'reportGapsAA2NT'	 uses a amino acid alignment to align nucleotide sequences....
  'reportMaskAA2NT'	 uses a filtered amino acid alignment to filter a nucleotide alignment....
  'splitAlignment'	 splits one alignment, to extract a subset of sequences and/or sites....
  'translateNT2AA'	 translates nucleotides into amino acids
  'trimAlignment'	 trims the input alignment by removing gappy sites at the beginning/end of the alignment....
  'trimNonHomologousFragments'	 identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments....
  'trimSequences'	 removes the 3' and 5' parts of the input sequence that are non homologous to an alignment....


cli.exceptions.parsing.ProgramNotFoundException: Program  could not be found.
```


## macse_reportgapsaa2nt

### Tool Description
uses a amino acid alignment to align nucleotide sequences....

### Metadata
- **Docker Image**: quay.io/biocontainers/macse:2.07--hdfd78af_0
- **Homepage**: https://bioweb.supagro.inra.fr/macse/
- **Package**: https://anaconda.org/channels/bioconda/packages/macse/overview
- **Validation**: PASS

### Original Help Text
```text
This is MACSE V2.07 If you find MACSE useful, please cite:

MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons
Vincent Ranwez, Emmanuel J P Douzery, Cedric Cambon, Nathalie Chantret, Frederic Delsuc
Molecular Biology and Evolution, 2020, 35(10):2582-2584, https://doi.org/10.1093/molbev/msy159

MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
Vincent Ranwez, Sebastien Harispe, Frederic Delsuc, Emmanuel JP Douzery
PLoS One 2011, 6(9):e22594, https://doi.org/10.1371/journal.pone.0022594


usage: [-prog PROGRAM_NAME] [-debug] [-help]

PROGRAMS:
  'alignSequences'	 aligns nucleotide (NT) coding sequences using their amino acid (AA) translations
  'alignTwoProfiles'	 aligns two previously computed nucleotide alignments (also called profiles) without questioning them
  'enrichAlignment'	 adds sequences to a pre-existing nucleotide alignment
  'exportAlignment'	 allows to export a MACSE alignment and to compute some statistics, it can...
  'mergeTwoMasks'	 indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability)....
  'multiPrograms'	 sequentially executes multiple MACSE commands contained in a text file (one per line)....
  'refineAlignment'	 improves the input nucleotide alignment
  'reportGapsAA2NT'	 uses a amino acid alignment to align nucleotide sequences....
  'reportMaskAA2NT'	 uses a filtered amino acid alignment to filter a nucleotide alignment....
  'splitAlignment'	 splits one alignment, to extract a subset of sequences and/or sites....
  'translateNT2AA'	 translates nucleotides into amino acids
  'trimAlignment'	 trims the input alignment by removing gappy sites at the beginning/end of the alignment....
  'trimNonHomologousFragments'	 identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments....
  'trimSequences'	 removes the 3' and 5' parts of the input sequence that are non homologous to an alignment....


cli.exceptions.parsing.ProgramNotFoundException: Program  could not be found.
```


## macse_reportmaskaa2nt

### Tool Description
Uses a filtered amino acid alignment to filter a nucleotide alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/macse:2.07--hdfd78af_0
- **Homepage**: https://bioweb.supagro.inra.fr/macse/
- **Package**: https://anaconda.org/channels/bioconda/packages/macse/overview
- **Validation**: PASS

### Original Help Text
```text
This is MACSE V2.07 If you find MACSE useful, please cite:

MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons
Vincent Ranwez, Emmanuel J P Douzery, Cedric Cambon, Nathalie Chantret, Frederic Delsuc
Molecular Biology and Evolution, 2020, 35(10):2582-2584, https://doi.org/10.1093/molbev/msy159

MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
Vincent Ranwez, Sebastien Harispe, Frederic Delsuc, Emmanuel JP Douzery
PLoS One 2011, 6(9):e22594, https://doi.org/10.1371/journal.pone.0022594


usage: [-prog PROGRAM_NAME] [-debug] [-help]

PROGRAMS:
  'alignSequences'	 aligns nucleotide (NT) coding sequences using their amino acid (AA) translations
  'alignTwoProfiles'	 aligns two previously computed nucleotide alignments (also called profiles) without questioning them
  'enrichAlignment'	 adds sequences to a pre-existing nucleotide alignment
  'exportAlignment'	 allows to export a MACSE alignment and to compute some statistics, it can...
  'mergeTwoMasks'	 indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability)....
  'multiPrograms'	 sequentially executes multiple MACSE commands contained in a text file (one per line)....
  'refineAlignment'	 improves the input nucleotide alignment
  'reportGapsAA2NT'	 uses a amino acid alignment to align nucleotide sequences....
  'reportMaskAA2NT'	 uses a filtered amino acid alignment to filter a nucleotide alignment....
  'splitAlignment'	 splits one alignment, to extract a subset of sequences and/or sites....
  'translateNT2AA'	 translates nucleotides into amino acids
  'trimAlignment'	 trims the input alignment by removing gappy sites at the beginning/end of the alignment....
  'trimNonHomologousFragments'	 identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments....
  'trimSequences'	 removes the 3' and 5' parts of the input sequence that are non homologous to an alignment....


cli.exceptions.parsing.ProgramNotFoundException: Program  could not be found.
```


## macse_splitalignment

### Tool Description
splits one alignment, to extract a subset of sequences and/or sites.

### Metadata
- **Docker Image**: quay.io/biocontainers/macse:2.07--hdfd78af_0
- **Homepage**: https://bioweb.supagro.inra.fr/macse/
- **Package**: https://anaconda.org/channels/bioconda/packages/macse/overview
- **Validation**: PASS

### Original Help Text
```text
This is MACSE V2.07 If you find MACSE useful, please cite:

MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons
Vincent Ranwez, Emmanuel J P Douzery, Cedric Cambon, Nathalie Chantret, Frederic Delsuc
Molecular Biology and Evolution, 2020, 35(10):2582-2584, https://doi.org/10.1093/molbev/msy159

MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
Vincent Ranwez, Sebastien Harispe, Frederic Delsuc, Emmanuel JP Douzery
PLoS One 2011, 6(9):e22594, https://doi.org/10.1371/journal.pone.0022594


usage: [-prog PROGRAM_NAME] [-debug] [-help]

PROGRAMS:
  'alignSequences'	 aligns nucleotide (NT) coding sequences using their amino acid (AA) translations
  'alignTwoProfiles'	 aligns two previously computed nucleotide alignments (also called profiles) without questioning them
  'enrichAlignment'	 adds sequences to a pre-existing nucleotide alignment
  'exportAlignment'	 allows to export a MACSE alignment and to compute some statistics, it can...
  'mergeTwoMasks'	 indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability)....
  'multiPrograms'	 sequentially executes multiple MACSE commands contained in a text file (one per line)....
  'refineAlignment'	 improves the input nucleotide alignment
  'reportGapsAA2NT'	 uses a amino acid alignment to align nucleotide sequences....
  'reportMaskAA2NT'	 uses a filtered amino acid alignment to filter a nucleotide alignment....
  'splitAlignment'	 splits one alignment, to extract a subset of sequences and/or sites....
  'translateNT2AA'	 translates nucleotides into amino acids
  'trimAlignment'	 trims the input alignment by removing gappy sites at the beginning/end of the alignment....
  'trimNonHomologousFragments'	 identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments....
  'trimSequences'	 removes the 3' and 5' parts of the input sequence that are non homologous to an alignment....


cli.exceptions.parsing.ProgramNotFoundException: Program  could not be found.
```


## macse_translatent2aa

### Tool Description
MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.

### Metadata
- **Docker Image**: quay.io/biocontainers/macse:2.07--hdfd78af_0
- **Homepage**: https://bioweb.supagro.inra.fr/macse/
- **Package**: https://anaconda.org/channels/bioconda/packages/macse/overview
- **Validation**: PASS

### Original Help Text
```text
This is MACSE V2.07 If you find MACSE useful, please cite:

MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons
Vincent Ranwez, Emmanuel J P Douzery, Cedric Cambon, Nathalie Chantret, Frederic Delsuc
Molecular Biology and Evolution, 2020, 35(10):2582-2584, https://doi.org/10.1093/molbev/msy159

MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
Vincent Ranwez, Sebastien Harispe, Frederic Delsuc, Emmanuel JP Douzery
PLoS One 2011, 6(9):e22594, https://doi.org/10.1371/journal.pone.0022594


usage: [-prog PROGRAM_NAME] [-debug] [-help]

PROGRAMS:
  'alignSequences'	 aligns nucleotide (NT) coding sequences using their amino acid (AA) translations
  'alignTwoProfiles'	 aligns two previously computed nucleotide alignments (also called profiles) without questioning them
  'enrichAlignment'	 adds sequences to a pre-existing nucleotide alignment
  'exportAlignment'	 allows to export a MACSE alignment and to compute some statistics, it can...
  'mergeTwoMasks'	 indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability)....
  'multiPrograms'	 sequentially executes multiple MACSE commands contained in a text file (one per line)....
  'refineAlignment'	 improves the input nucleotide alignment
  'reportGapsAA2NT'	 uses a amino acid alignment to align nucleotide sequences....
  'reportMaskAA2NT'	 uses a filtered amino acid alignment to filter a nucleotide alignment....
  'splitAlignment'	 splits one alignment, to extract a subset of sequences and/or sites....
  'translateNT2AA'	 translates nucleotides into amino acids
  'trimAlignment'	 trims the input alignment by removing gappy sites at the beginning/end of the alignment....
  'trimNonHomologousFragments'	 identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments....
  'trimSequences'	 removes the 3' and 5' parts of the input sequence that are non homologous to an alignment....


cli.exceptions.parsing.ProgramNotFoundException: Program  could not be found.
```


## macse_trimalignment

### Tool Description
MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.

### Metadata
- **Docker Image**: quay.io/biocontainers/macse:2.07--hdfd78af_0
- **Homepage**: https://bioweb.supagro.inra.fr/macse/
- **Package**: https://anaconda.org/channels/bioconda/packages/macse/overview
- **Validation**: PASS

### Original Help Text
```text
This is MACSE V2.07 If you find MACSE useful, please cite:

MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons
Vincent Ranwez, Emmanuel J P Douzery, Cedric Cambon, Nathalie Chantret, Frederic Delsuc
Molecular Biology and Evolution, 2020, 35(10):2582-2584, https://doi.org/10.1093/molbev/msy159

MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
Vincent Ranwez, Sebastien Harispe, Frederic Delsuc, Emmanuel JP Douzery
PLoS One 2011, 6(9):e22594, https://doi.org/10.1371/journal.pone.0022594


usage: [-prog PROGRAM_NAME] [-debug] [-help]

PROGRAMS:
  'alignSequences'	 aligns nucleotide (NT) coding sequences using their amino acid (AA) translations
  'alignTwoProfiles'	 aligns two previously computed nucleotide alignments (also called profiles) without questioning them
  'enrichAlignment'	 adds sequences to a pre-existing nucleotide alignment
  'exportAlignment'	 allows to export a MACSE alignment and to compute some statistics, it can...
  'mergeTwoMasks'	 indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability)....
  'multiPrograms'	 sequentially executes multiple MACSE commands contained in a text file (one per line)....
  'refineAlignment'	 improves the input nucleotide alignment
  'reportGapsAA2NT'	 uses a amino acid alignment to align nucleotide sequences....
  'reportMaskAA2NT'	 uses a filtered amino acid alignment to filter a nucleotide alignment....
  'splitAlignment'	 splits one alignment, to extract a subset of sequences and/or sites....
  'translateNT2AA'	 translates nucleotides into amino acids
  'trimAlignment'	 trims the input alignment by removing gappy sites at the beginning/end of the alignment....
  'trimNonHomologousFragments'	 identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments....
  'trimSequences'	 removes the 3' and 5' parts of the input sequence that are non homologous to an alignment....


cli.exceptions.parsing.ProgramNotFoundException: Program  could not be found.
```


## macse_trimnonhomologousfragments

### Tool Description
identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments.

### Metadata
- **Docker Image**: quay.io/biocontainers/macse:2.07--hdfd78af_0
- **Homepage**: https://bioweb.supagro.inra.fr/macse/
- **Package**: https://anaconda.org/channels/bioconda/packages/macse/overview
- **Validation**: PASS

### Original Help Text
```text
This is MACSE V2.07 If you find MACSE useful, please cite:

MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons
Vincent Ranwez, Emmanuel J P Douzery, Cedric Cambon, Nathalie Chantret, Frederic Delsuc
Molecular Biology and Evolution, 2020, 35(10):2582-2584, https://doi.org/10.1093/molbev/msy159

MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
Vincent Ranwez, Sebastien Harispe, Frederic Delsuc, Emmanuel JP Douzery
PLoS One 2011, 6(9):e22594, https://doi.org/10.1371/journal.pone.0022594


usage: [-prog PROGRAM_NAME] [-debug] [-help]

PROGRAMS:
  'alignSequences'	 aligns nucleotide (NT) coding sequences using their amino acid (AA) translations
  'alignTwoProfiles'	 aligns two previously computed nucleotide alignments (also called profiles) without questioning them
  'enrichAlignment'	 adds sequences to a pre-existing nucleotide alignment
  'exportAlignment'	 allows to export a MACSE alignment and to compute some statistics, it can...
  'mergeTwoMasks'	 indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability)....
  'multiPrograms'	 sequentially executes multiple MACSE commands contained in a text file (one per line)....
  'refineAlignment'	 improves the input nucleotide alignment
  'reportGapsAA2NT'	 uses a amino acid alignment to align nucleotide sequences....
  'reportMaskAA2NT'	 uses a filtered amino acid alignment to filter a nucleotide alignment....
  'splitAlignment'	 splits one alignment, to extract a subset of sequences and/or sites....
  'translateNT2AA'	 translates nucleotides into amino acids
  'trimAlignment'	 trims the input alignment by removing gappy sites at the beginning/end of the alignment....
  'trimNonHomologousFragments'	 identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments....
  'trimSequences'	 removes the 3' and 5' parts of the input sequence that are non homologous to an alignment....


cli.exceptions.parsing.ProgramNotFoundException: Program  could not be found.
```


## macse_trimsequences

### Tool Description
removes the 3' and 5' parts of the input sequence that are non homologous to an alignment....

### Metadata
- **Docker Image**: quay.io/biocontainers/macse:2.07--hdfd78af_0
- **Homepage**: https://bioweb.supagro.inra.fr/macse/
- **Package**: https://anaconda.org/channels/bioconda/packages/macse/overview
- **Validation**: PASS

### Original Help Text
```text
This is MACSE V2.07 If you find MACSE useful, please cite:

MACSE v2: Toolkit for the Alignment of Coding Sequences Accounting for Frameshifts and Stop Codons
Vincent Ranwez, Emmanuel J P Douzery, Cedric Cambon, Nathalie Chantret, Frederic Delsuc
Molecular Biology and Evolution, 2020, 35(10):2582-2584, https://doi.org/10.1093/molbev/msy159

MACSE: Multiple Alignment of Coding SEquences accounting for frameshifts and stop codons.
Vincent Ranwez, Sebastien Harispe, Frederic Delsuc, Emmanuel JP Douzery
PLoS One 2011, 6(9):e22594, https://doi.org/10.1371/journal.pone.0022594


usage: [-prog PROGRAM_NAME] [-debug] [-help]

PROGRAMS:
  'alignSequences'	 aligns nucleotide (NT) coding sequences using their amino acid (AA) translations
  'alignTwoProfiles'	 aligns two previously computed nucleotide alignments (also called profiles) without questioning them
  'enrichAlignment'	 adds sequences to a pre-existing nucleotide alignment
  'exportAlignment'	 allows to export a MACSE alignment and to compute some statistics, it can...
  'mergeTwoMasks'	 indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability)....
  'multiPrograms'	 sequentially executes multiple MACSE commands contained in a text file (one per line)....
  'refineAlignment'	 improves the input nucleotide alignment
  'reportGapsAA2NT'	 uses a amino acid alignment to align nucleotide sequences....
  'reportMaskAA2NT'	 uses a filtered amino acid alignment to filter a nucleotide alignment....
  'splitAlignment'	 splits one alignment, to extract a subset of sequences and/or sites....
  'translateNT2AA'	 translates nucleotides into amino acids
  'trimAlignment'	 trims the input alignment by removing gappy sites at the beginning/end of the alignment....
  'trimNonHomologousFragments'	 identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments....
  'trimSequences'	 removes the 3' and 5' parts of the input sequence that are non homologous to an alignment....


cli.exceptions.parsing.ProgramNotFoundException: Program  could not be found.
```


## Metadata
- **Skill**: generated
