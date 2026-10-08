# macse CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| macse_alignsequences | PASS |  |
| macse_aligntwoprofiles | PASS |  |
| macse_enrichalignment | PASS |  |
| macse_exportalignment | PASS |  |
| macse_mergetwomasks | PASS |  |
| macse_multiprograms | PASS |  |
| macse_refinealignment | PASS |  |
| macse_reportgapsaa2nt | PASS |  |
| macse_reportmaskaa2nt | PASS |  |
| macse_splitalignment | PASS |  |
| macse_translatent2aa | PASS |  |
| macse_trimalignment | PASS |  |
| macse_trimnonhomologousfragments | PASS |  |
| macse_trimsequences | PASS |  |

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

alignSequences: aligns nucleotide (NT) coding sequences using their amino acid (AA) translations

  -help: display full help instead of displaying only mandatory options
  -allow_NT: extra nucleotide characters to consider as N (example: -allow_NT "#?")
      allow_NT  = <empty string>
  -alphabet_AA: compressed amino acid (AA) alphabet used to estimate initial pairwise distances and homologous sequence fragments
      alphabet_AA  = SE_B_8
  -ambi_OFF: disables ambiguities management (e.g. a 'TCN' codon will be translated into an unknown amino acid instead of a serine (S))
      ambi_OFF  = false
  -fs: cost of a frameshift in (reliable) sequences
      fs  = 30.0
  -fs_lr: cost of a frameshift in less reliable sequences (those of seq_lr file)
      fs_lr  = 10.0
  -fs_lr_term: cost of a terminal frameshift (those in the first and last codon) in a less reliable sequence 
      fs_lr_term  = 7.0
  -fs_term: cost of a terminal frameshift (those in the first and last codon) in a reliable sequence
      fs_term  = 10.0
  -gap_ext: cost of internal gap extension
      gap_ext  = 1.0
  -gap_ext_term: cost of terminal gap extension (e.g. those before the first nucleotide and after the last one)
      gap_ext_term  = 0.9
  -gap_op: cost of internal gap opening
      gap_op  = 7.0
  -gap_op_term: cost of terminal gap opening (e.g. those before the first nucleotide and after the last one)
      gap_op_term  = 6.3
  -gc_def: default genetic code specified by its standard NCBI numbering  (i.e. code used for sequences for which no specific code is provided in the gc_file (see genetic code list below))
      gc_def  = 1
  -gc_file: tabular file containing on each line a sequence name and the standard NCBI numbering specifying its genetic code. Any of the following field separators could be used: space, tabulation, comma, semicolon.
      gc_file  = <empty string>
  -local_realign_dec: if smaller than 1 each refinement loop will be faster than the previous one by focusing on a smaller interval during alignment improvement steps (the lower this value the faster the refinements, possible values [0-1])
      local_realign_dec  = 0.5
  -local_realign_init: if smaller than 1 the first refinement loop will consider only local improvement (the lower this value the faster the initial refinement, possible values [0-1])
      local_realign_init  = 0.5
  -max_refine_iter: the max number of refinement iterations when optimizing alignment (-1 = no iteration limit)
      max_refine_iter  = -1
  -optim: optimization parameter (0 = none, 1 = basic leaf cut, 2 = standard branch cut)
      optim  = 2
  -out_AA: output FASTA file containing aligned amino acid sequences
      out_AA  = <empty string>
  -out_NT: output FASTA file containing aligned nucleotide sequences
      out_NT  = <empty string>
  -score_matrix: amino acid score matrix to use (see list below)
      score_matrix  = BLOSUM62
  -seq: input FASTA file containing (reliable) nucleotide sequences
      seq  = <empty string>
  -seq_lr: input FASTA file containing less reliable nucleotide sequences (e.g. pseudogenes)
      seq_lr  = <empty string>
  -stop: cost of a stop codon in (reliable) sequences, it should be less than twice the cost of a frameshift in those sequences
      stop  = 50.0
  -stop_lr: cost of a stop codon in less reliable sequences, it should be less than twice the cost of a frameshift in those sequences
      stop_lr  = 17.0

====================================================================================================
# List of genetic codes.
----------------------------------------------------------------------------------------------------
01_The_Standard_Code
02_The_Vertebrate_Mitochondrial_Code
03_The_Yeast_Mitochondrial_Code
04_The_Mold_Protozoan_and_Coelenterate_Mitochondrial_Code_and_the_Mycoplasma_Spiroplasma_Code
05_The_Invertebrate_Mitochondrial_Code
06_The_Ciliate_Dasycladacean_and_Hexamita_Nuclear_Code
09_The_Echinoderm_and_Flatworm_Mitochondrial_Code
10_The_Euplotid_Nuclear_Code
11_The_Bacterial_Archaeal_and_Plant_Plastid_Code
12_The_Alternative_Yeast_Nuclear_Code
13_The_Ascidian_Mitochondrial_Code
14_The_Alternative_Flatworm_Mitochondrial_Code
15_Blepharisma_Nuclear_Code
16_Chlorophycean_Mitochondrial_Code
21_Trematode_Mitochondrial_Code
22_Scenedesmus_obliquus_mitochondrial_Code
23_Thraustochytrium_Mitochondrial_Code
24_Rhabdopleuridae_Mitochondrial_Code
25_Candidate_Division_SR1_and_Gracilibacteria
26_Pachysolen_tannophilus_Nuclear_Code
27_Karyorelict_Nuclear_Code
28_Condylostoma_Nuclear_Code
29_Mesodinium_Nuclear_Code
30_Peritrich_Nuclear_Code
31_Blastocrithidia_Nuclear_Code
32_Seleno_Protein_Code
33_Cephalodiscidae_Mitochondrial_UAA-Tyr_Code
====================================================================================================


====================================================================================================
# List of score matrices.
----------------------------------------------------------------------------------------------------
BLOSUM62
VTML200_BIS
VTML240
====================================================================================================


====================================================================================================
# List of compressed alphabets.
----------------------------------------------------------------------------------------------------
Dayhoff_6
Li_A_10
Li_B_10
Murphy_10
SE_B_10
SE_B_14
SE_B_6
SE_B_8
SE_V_10
Solis_D_10
Solis_G_10
====================================================================================================
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

alignTwoProfiles: aligns two previously computed nucleotide alignments (also called profiles) without questioning them

  -help: display full help instead of displaying only mandatory options
  -allow_NT: extra nucleotide characters to consider as N (example: -allow_NT "#?")
      allow_NT  = <empty string>
  -ambi_OFF: disables ambiguities management (e.g. a 'TCN' codon will be translated into an unknown amino acid instead of a serine (S))
      ambi_OFF  = false
  -fs: cost of a frameshift in (reliable) sequences
      fs  = 30.0
  -fs_lr: cost of a frameshift in less reliable sequences (those of seq_lr file)
      fs_lr  = 10.0
  -fs_lr_term: cost of a terminal frameshift (those in the first and last codon) in a less reliable sequence 
      fs_lr_term  = 7.0
  -fs_term: cost of a terminal frameshift (those in the first and last codon) in a reliable sequence
      fs_term  = 10.0
  -gap_ext: cost of internal gap extension
      gap_ext  = 1.0
  -gap_ext_term: cost of terminal gap extension (e.g. those before the first nucleotide and after the last one)
      gap_ext_term  = 0.9
  -gap_op: cost of internal gap opening
      gap_op  = 7.0
  -gap_op_term: cost of terminal gap opening (e.g. those before the first nucleotide and after the last one)
      gap_op_term  = 6.3
  -gc_def: default genetic code specified by its standard NCBI numbering  (i.e. code used for sequences for which no specific code is provided in the gc_file (see genetic code list below))
      gc_def  = 1
  -gc_file: tabular file containing on each line a sequence name and the standard NCBI numbering specifying its genetic code. Any of the following field separators could be used: space, tabulation, comma, semicolon.
      gc_file  = <empty string>
  -out_AA: output FASTA file containing aligned amino acid sequences
      out_AA  = <empty string>
  -out_NT: output FASTA file containing aligned nucleotide sequences
      out_NT  = <empty string>
  -p1: FASTA file containing the first alignment/profile
      p1  = <empty string>
  -p2: FASTA file containing the second alignment/profile
      p2  = <empty string>
  -score_matrix: amino acid score matrix to use (see list below)
      score_matrix  = BLOSUM62
  -seq: input FASTA file containing (reliable) nucleotide sequences
      seq  = <empty string>
  -seq_lr: input FASTA file containing less reliable nucleotide sequences (e.g. pseudogenes)
      seq_lr  = <empty string>
  -stop: cost of a stop codon in (reliable) sequences, it should be less than twice the cost of a frameshift in those sequences
      stop  = 50.0
  -stop_lr: cost of a stop codon in less reliable sequences, it should be less than twice the cost of a frameshift in those sequences
      stop_lr  = 17.0

====================================================================================================
# List of genetic codes.
----------------------------------------------------------------------------------------------------
01_The_Standard_Code
02_The_Vertebrate_Mitochondrial_Code
03_The_Yeast_Mitochondrial_Code
04_The_Mold_Protozoan_and_Coelenterate_Mitochondrial_Code_and_the_Mycoplasma_Spiroplasma_Code
05_The_Invertebrate_Mitochondrial_Code
06_The_Ciliate_Dasycladacean_and_Hexamita_Nuclear_Code
09_The_Echinoderm_and_Flatworm_Mitochondrial_Code
10_The_Euplotid_Nuclear_Code
11_The_Bacterial_Archaeal_and_Plant_Plastid_Code
12_The_Alternative_Yeast_Nuclear_Code
13_The_Ascidian_Mitochondrial_Code
14_The_Alternative_Flatworm_Mitochondrial_Code
15_Blepharisma_Nuclear_Code
16_Chlorophycean_Mitochondrial_Code
21_Trematode_Mitochondrial_Code
22_Scenedesmus_obliquus_mitochondrial_Code
23_Thraustochytrium_Mitochondrial_Code
24_Rhabdopleuridae_Mitochondrial_Code
25_Candidate_Division_SR1_and_Gracilibacteria
26_Pachysolen_tannophilus_Nuclear_Code
27_Karyorelict_Nuclear_Code
28_Condylostoma_Nuclear_Code
29_Mesodinium_Nuclear_Code
30_Peritrich_Nuclear_Code
31_Blastocrithidia_Nuclear_Code
32_Seleno_Protein_Code
33_Cephalodiscidae_Mitochondrial_UAA-Tyr_Code
====================================================================================================


====================================================================================================
# List of score matrices.
----------------------------------------------------------------------------------------------------
BLOSUM62
VTML200_BIS
VTML240
====================================================================================================
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

enrichAlignment: adds sequences to a pre-existing nucleotide alignment

  -help: display full help instead of displaying only mandatory options
  -align: input FASTA file containing aligned nucleotide sequences
      align  = <empty string>
  -allow_NT: extra nucleotide characters to consider as N (example: -allow_NT "#?")
      allow_NT  = <empty string>
  -alphabet_AA: compressed amino acid (AA) alphabet used to estimate initial pairwise distances and homologous sequence fragments
      alphabet_AA  = SE_B_8
  -ambi_OFF: disables ambiguities management (e.g. a 'TCN' codon will be translated into an unknown amino acid instead of a serine (S))
      ambi_OFF  = false
  -fixed_alignment_ON: if this option is set all added sequences are compared to the original alignment and their alignments are merged. This automatically sets maxINS_inSeq to 0, since the resulting alignment is meaningless otherwise (option mainly useful for metabarcoding data).
      fixed_alignment_ON  = false
  -fs: cost of a frameshift in (reliable) sequences
      fs  = 30.0
  -fs_lr: cost of a frameshift in less reliable sequences (those of seq_lr file)
      fs_lr  = 10.0
  -fs_lr_term: cost of a terminal frameshift (those in the first and last codon) in a less reliable sequence 
      fs_lr_term  = 7.0
  -fs_term: cost of a terminal frameshift (those in the first and last codon) in a reliable sequence
      fs_term  = 10.0
  -gap_ext: cost of internal gap extension
      gap_ext  = 1.0
  -gap_ext_term: cost of terminal gap extension (e.g. those before the first nucleotide and after the last one)
      gap_ext_term  = 0.9
  -gap_op: cost of internal gap opening
      gap_op  = 7.0
  -gap_op_term: cost of terminal gap opening (e.g. those before the first nucleotide and after the last one)
      gap_op_term  = 6.3
  -gc_def: default genetic code specified by its standard NCBI numbering  (i.e. code used for sequences for which no specific code is provided in the gc_file (see genetic code list below))
      gc_def  = 1
  -gc_file: tabular file containing on each line a sequence name and the standard NCBI numbering specifying its genetic code. Any of the following field separators could be used: space, tabulation, comma, semicolon.
      gc_file  = <empty string>
  -maxDEL_inSeq: maximum number of amino acid deletions allowed within a sequence to be actually added to the alignment (default no limit)
      maxDEL_inSeq  = -1
  -maxFS_inSeq: maximum number of frameshifts allowed within a sequence to be actually added to the alignment (default no limit)
      maxFS_inSeq  = -1
  -maxINS_inSeq: maximum number of internal amino acid insertions allowed within a sequence to be actually added to the alignment (default no limit)
      maxINS_inSeq  = -1
  -maxSTOP_inSeq: maximum number of internal STOP codons allowed within a sequence to be actually added to the alignment (default no limit)
      maxSTOP_inSeq  = -1
  -maxTotalINS_inSeq: maximum number of amino acid insertions (internal or not) allowed within a sequence to be actually added to the alignment (default no limit)
      maxTotalINS_inSeq  = -1
  -max_NT_trimmed: if a frameshift (FS) appears near the end of the sequence, the max_NT_trimmed nucleotides can be trimmed at the beginning and/or at the end of the sequence to remove those FS and unreliable sequence extremities they pinpointed (default 0, no trimming allowed)
      max_NT_trimmed  = 0
  -new_seq_alterable_ON: if this option is set, the sequences to add can be slightly altered (suppressing 1 or 2 nucleotides) to prevent FS inducing gaps in the reference alignment, so that such sequences can be added even with maxINS_inSeq set to 0 (option mainly useful for metabarcoding data).
      new_seq_alterable_ON  = false
  -out_AA: output FASTA file containing aligned amino acid sequences
      out_AA  = <empty string>
  -out_NT: output FASTA file containing aligned nucleotide sequences
      out_NT  = <empty string>
  -out_tested_seq_info: output CSV file that will contain information about the number of STOP, FS and INDEL events for each tested sequence
      out_tested_seq_info  = <empty string>
  -output_only_added_seq_ON: with this option, only newly added sequences appear in the output alignment files, this allows to easily parallelize the enrichment when using the fixed alignment option (fixedRefAlignment): simply concatenate the multiple output FASTA files with your original alignment
      output_only_added_seq_ON  = false
  -score_matrix: amino acid score matrix to use (see list below)
      score_matrix  = BLOSUM62
  -seq: input FASTA file containing (reliable) nucleotide sequences
      seq  = <empty string>
  -seq_lr: input FASTA file containing less reliable nucleotide sequences (e.g. pseudogenes)
      seq_lr  = <empty string>
  -stop: cost of a stop codon in (reliable) sequences, it should be less than twice the cost of a frameshift in those sequences
      stop  = 50.0
  -stop_lr: cost of a stop codon in less reliable sequences, it should be less than twice the cost of a frameshift in those sequences
      stop_lr  = 17.0

====================================================================================================
# List of genetic codes.
----------------------------------------------------------------------------------------------------
01_The_Standard_Code
02_The_Vertebrate_Mitochondrial_Code
03_The_Yeast_Mitochondrial_Code
04_The_Mold_Protozoan_and_Coelenterate_Mitochondrial_Code_and_the_Mycoplasma_Spiroplasma_Code
05_The_Invertebrate_Mitochondrial_Code
06_The_Ciliate_Dasycladacean_and_Hexamita_Nuclear_Code
09_The_Echinoderm_and_Flatworm_Mitochondrial_Code
10_The_Euplotid_Nuclear_Code
11_The_Bacterial_Archaeal_and_Plant_Plastid_Code
12_The_Alternative_Yeast_Nuclear_Code
13_The_Ascidian_Mitochondrial_Code
14_The_Alternative_Flatworm_Mitochondrial_Code
15_Blepharisma_Nuclear_Code
16_Chlorophycean_Mitochondrial_Code
21_Trematode_Mitochondrial_Code
22_Scenedesmus_obliquus_mitochondrial_Code
23_Thraustochytrium_Mitochondrial_Code
24_Rhabdopleuridae_Mitochondrial_Code
25_Candidate_Division_SR1_and_Gracilibacteria
26_Pachysolen_tannophilus_Nuclear_Code
27_Karyorelict_Nuclear_Code
28_Condylostoma_Nuclear_Code
29_Mesodinium_Nuclear_Code
30_Peritrich_Nuclear_Code
31_Blastocrithidia_Nuclear_Code
32_Seleno_Protein_Code
33_Cephalodiscidae_Mitochondrial_UAA-Tyr_Code
====================================================================================================


====================================================================================================
# List of score matrices.
----------------------------------------------------------------------------------------------------
BLOSUM62
VTML200_BIS
VTML240
====================================================================================================


====================================================================================================
# List of compressed alphabets.
----------------------------------------------------------------------------------------------------
Dayhoff_6
Li_A_10
Li_B_10
Murphy_10
SE_B_10
SE_B_14
SE_B_6
SE_B_8
SE_V_10
Solis_D_10
Solis_G_10
====================================================================================================
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

exportAlignment: allows to export a MACSE alignment and to compute some statistics, it can
	 1. replace stop codons and codons with frameshifts (and AA) by alternative codons (and AA) that other programs can handle (e.g. GC! => GCN or NNN) 
	 2. generate consensus sequences 
	 3. compute per sequence statistics 
	 4. compute per site statistics.

  -help: display full help instead of displaying only mandatory options
  -align: input FASTA file containing aligned nucleotide sequences
      align  = <empty string>
  -allow_NT: extra nucleotide characters to consider as N (example: -allow_NT "#?")
      allow_NT  = <empty string>
  -ambi_OFF: disables ambiguities management (e.g. a 'TCN' codon will be translated into an unknown amino acid instead of a serine (S))
      ambi_OFF  = false
  -canonize_ON: if used, MACSE will output modified NT sequences so that the same codon will be used for each instance of a given amino acid (useful to generate a consensus nucleotide sequence reflecting amino acid frequencies)
      canonize_ON  = false
  -charForRemainingFS: if after replacement done at the codon level some '!' remain, this character will be used to replace them (default: no replacement,  meaningful possibilities are 'N', '-', 'X' or '?')
      charForRemainingFS  = !
  -codonForExternalFS: codon which will replace external frameshift codons, i.e. used if the first or last codon contains a frameshift (default: no replacement, meaningful possibilities are "NNN" or "---") 
      codonForExternalFS  = <empty string>
  -codonForFinalStop: codon which will replace terminal stop codons, i.e. used if the last codon is a stop (default: no replacement,  meaningful possibilities are "NNN" or "---")
      codonForFinalStop  = <empty string>
  -codonForInternalFS: codon which will replace internal frameshifts (default: no replacement,  meaningful possibilities are "NNN" or "---")
      codonForInternalFS  = <empty string>
  -codonForInternalStop: codon which will replace internal stop codons (default: no replacement,  meaningful possibilities are "NNN" or "---")
      codonForInternalStop  = <empty string>
  -cons_threshold: if the most frequent amino acid of a site has a lower frequency than this threshold the consensus codon will be the unknown amino acid 'X' (values in [0-1])
      cons_threshold  = 0.6
  -gc_def: default genetic code specified by its standard NCBI numbering  (i.e. code used for sequences for which no specific code is provided in the gc_file (see genetic code list below))
      gc_def  = 1
  -gc_file: tabular file containing on each line a sequence name and the standard NCBI numbering specifying its genetic code. Any of the following field separators could be used: space, tabulation, comma, semicolon.
      gc_file  = <empty string>
  -keep_gap_only_sites_ON: with this option gap only sites are not removed (mainly useful for parallelisation)
      keep_gap_only_sites_ON  = false
  -name_cons_seq: name of the consensus sequence in the output FASTA files
      name_cons_seq  = consSeq
  -out_AA: output FASTA file containing aligned amino acid sequences
      out_AA  = <empty string>
  -out_AA_consensus: output FASTA file that will contain the consensus amino acid sequence, only real amino acids are considered, i.e. !, * and - are ignored
      out_AA_consensus  = <empty string>
  -out_NT: output FASTA file containing aligned nucleotide sequences
      out_NT  = <empty string>
  -out_NT_consensus: output FASTA file that will contain a nucleotide sequence so that its translation with the default genetic code results in the consensus amino acid sequence, there is no attempt to select the most frequent codon
      out_NT_consensus  = <empty string>
  -out_stat_per_seq: output CSV file that will contain the number of insertions, deletions, stop codons (and more) within each sequence
      out_stat_per_seq  = <empty string>
  -out_stat_per_site: output CSV file that will contain, for each site, the frequency of each nucleotide
      out_stat_per_site  = <empty string>

====================================================================================================
# List of genetic codes.
----------------------------------------------------------------------------------------------------
01_The_Standard_Code
02_The_Vertebrate_Mitochondrial_Code
03_The_Yeast_Mitochondrial_Code
04_The_Mold_Protozoan_and_Coelenterate_Mitochondrial_Code_and_the_Mycoplasma_Spiroplasma_Code
05_The_Invertebrate_Mitochondrial_Code
06_The_Ciliate_Dasycladacean_and_Hexamita_Nuclear_Code
09_The_Echinoderm_and_Flatworm_Mitochondrial_Code
10_The_Euplotid_Nuclear_Code
11_The_Bacterial_Archaeal_and_Plant_Plastid_Code
12_The_Alternative_Yeast_Nuclear_Code
13_The_Ascidian_Mitochondrial_Code
14_The_Alternative_Flatworm_Mitochondrial_Code
15_Blepharisma_Nuclear_Code
16_Chlorophycean_Mitochondrial_Code
21_Trematode_Mitochondrial_Code
22_Scenedesmus_obliquus_mitochondrial_Code
23_Thraustochytrium_Mitochondrial_Code
24_Rhabdopleuridae_Mitochondrial_Code
25_Candidate_Division_SR1_and_Gracilibacteria
26_Pachysolen_tannophilus_Nuclear_Code
27_Karyorelict_Nuclear_Code
28_Condylostoma_Nuclear_Code
29_Mesodinium_Nuclear_Code
30_Peritrich_Nuclear_Code
31_Blastocrithidia_Nuclear_Code
32_Seleno_Protein_Code
33_Cephalodiscidae_Mitochondrial_UAA-Tyr_Code
====================================================================================================
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

mergeTwoMasks: indicates nucleotides kept after applying mask1 filtering then mask2 filtering (useful for traceability).
	 Nucleotides of mask2 sequences should hence be the unmasked nucleotides of mask1. Upper case letters indicate kept nucleotides, lower case letters indicate masked nucleotides. 

  -help: display full help instead of displaying only mandatory options
  -mask_file1: first mask file in FASTA format, masked nucleotides are in lower case while other nucleotides are in UPPER CASE
      mask_file1  = <empty string>
  -mask_file2: second mask file in FASTA format, masked nucleotides are in lower case while other nucleotides are in UPPER CASE
      mask_file2  = <empty string>
  -out_mask_detail: output FASTA file containing the resulting masking, masked nucleotides are in lower case while other nucleotides are in UPPER CASE
      out_mask_detail  = <empty string>
  -out_trim_info: output CSV file containing information about the triming/filtering process 								
      out_trim_info  = <empty string>
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

multiPrograms: sequentially executes multiple MACSE commands contained in a text file (one per line).
	 This allows basic scripting for non bioinformaticians.

  -help: display full help instead of displaying only mandatory options
  -MACSE_command_file: a file containing a list of MACSE commands. Each line contains a single MACSE command starting by "-prog" (i.e. omitting "java -jar macse.jar"). The character '@' can be used before each file path to point towards the directory containing this command file.
      MACSE_command_file  = <empty string>
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

refineAlignment: improves the input nucleotide alignment

  -help: display full help instead of displaying only mandatory options
  -align: input FASTA file containing aligned nucleotide sequences
      align  = <empty string>
  -allow_NT: extra nucleotide characters to consider as N (example: -allow_NT "#?")
      allow_NT  = <empty string>
  -alphabet_AA: compressed amino acid (AA) alphabet used to estimate initial pairwise distances and homologous sequence fragments
      alphabet_AA  = SE_B_8
  -ambi_OFF: disables ambiguities management (e.g. a 'TCN' codon will be translated into an unknown amino acid instead of a serine (S))
      ambi_OFF  = false
  -fs: cost of a frameshift in (reliable) sequences
      fs  = 30.0
  -fs_lr: cost of a frameshift in less reliable sequences (those of seq_lr file)
      fs_lr  = 10.0
  -fs_lr_term: cost of a terminal frameshift (those in the first and last codon) in a less reliable sequence 
      fs_lr_term  = 7.0
  -fs_term: cost of a terminal frameshift (those in the first and last codon) in a reliable sequence
      fs_term  = 10.0
  -gap_ext: cost of internal gap extension
      gap_ext  = 1.0
  -gap_ext_term: cost of terminal gap extension (e.g. those before the first nucleotide and after the last one)
      gap_ext_term  = 0.9
  -gap_op: cost of internal gap opening
      gap_op  = 7.0
  -gap_op_term: cost of terminal gap opening (e.g. those before the first nucleotide and after the last one)
      gap_op_term  = 6.3
  -gc_def: default genetic code specified by its standard NCBI numbering  (i.e. code used for sequences for which no specific code is provided in the gc_file (see genetic code list below))
      gc_def  = 1
  -gc_file: tabular file containing on each line a sequence name and the standard NCBI numbering specifying its genetic code. Any of the following field separators could be used: space, tabulation, comma, semicolon.
      gc_file  = <empty string>
  -local_realign_dec: if smaller than 1 each refinement loop will be faster than the previous one by focusing on a smaller interval during alignment improvement steps (the lower this value the faster the refinements, possible values [0-1])
      local_realign_dec  = 0.5
  -local_realign_init: if smaller than 1 the first refinement loop will consider only local improvement (the lower this value the faster the initial refinement, possible values [0-1])
      local_realign_init  = 0.5
  -max_refine_iter: the max number of refinement iterations when optimizing alignment (-1 = no iteration limit)
      max_refine_iter  = -1
  -optim: optimization parameter (0 = none, 1 = basic leaf cut, 2 = standard branch cut)
      optim  = 2
  -out_AA: output FASTA file containing aligned amino acid sequences
      out_AA  = <empty string>
  -out_NT: output FASTA file containing aligned nucleotide sequences
      out_NT  = <empty string>
  -score_matrix: amino acid score matrix to use (see list below)
      score_matrix  = BLOSUM62
  -seq: input FASTA file containing (reliable) nucleotide sequences
      seq  = <empty string>
  -seq_lr: input FASTA file containing less reliable nucleotide sequences (e.g. pseudogenes)
      seq_lr  = <empty string>
  -stop: cost of a stop codon in (reliable) sequences, it should be less than twice the cost of a frameshift in those sequences
      stop  = 50.0
  -stop_lr: cost of a stop codon in less reliable sequences, it should be less than twice the cost of a frameshift in those sequences
      stop_lr  = 17.0

====================================================================================================
# List of genetic codes.
----------------------------------------------------------------------------------------------------
01_The_Standard_Code
02_The_Vertebrate_Mitochondrial_Code
03_The_Yeast_Mitochondrial_Code
04_The_Mold_Protozoan_and_Coelenterate_Mitochondrial_Code_and_the_Mycoplasma_Spiroplasma_Code
05_The_Invertebrate_Mitochondrial_Code
06_The_Ciliate_Dasycladacean_and_Hexamita_Nuclear_Code
09_The_Echinoderm_and_Flatworm_Mitochondrial_Code
10_The_Euplotid_Nuclear_Code
11_The_Bacterial_Archaeal_and_Plant_Plastid_Code
12_The_Alternative_Yeast_Nuclear_Code
13_The_Ascidian_Mitochondrial_Code
14_The_Alternative_Flatworm_Mitochondrial_Code
15_Blepharisma_Nuclear_Code
16_Chlorophycean_Mitochondrial_Code
21_Trematode_Mitochondrial_Code
22_Scenedesmus_obliquus_mitochondrial_Code
23_Thraustochytrium_Mitochondrial_Code
24_Rhabdopleuridae_Mitochondrial_Code
25_Candidate_Division_SR1_and_Gracilibacteria
26_Pachysolen_tannophilus_Nuclear_Code
27_Karyorelict_Nuclear_Code
28_Condylostoma_Nuclear_Code
29_Mesodinium_Nuclear_Code
30_Peritrich_Nuclear_Code
31_Blastocrithidia_Nuclear_Code
32_Seleno_Protein_Code
33_Cephalodiscidae_Mitochondrial_UAA-Tyr_Code
====================================================================================================


====================================================================================================
# List of score matrices.
----------------------------------------------------------------------------------------------------
BLOSUM62
VTML200_BIS
VTML240
====================================================================================================


====================================================================================================
# List of compressed alphabets.
----------------------------------------------------------------------------------------------------
Dayhoff_6
Li_A_10
Li_B_10
Murphy_10
SE_B_10
SE_B_14
SE_B_6
SE_B_8
SE_V_10
Solis_D_10
Solis_G_10
====================================================================================================
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

reportGapsAA2NT: uses a amino acid alignment to align nucleotide sequences.
 This program reports the gaps observed in the aligned amino acid sequences onto the corresponding (unaligned) nucleotide sequences.
	 The input aligned AA sequences should be the translations of the input unaligned NT sequences.
	 Useful to rapidly align coding nucleotide sequences without accounting for further frameshifts, 1/ use translateNT2AA to obtain AA sequences, 2/ align those AA sequences with the external tool of your choice (e.g. mafft, muscle) 3/ use this subprogram to derive the nucleotide alignment from the AA one.
	 Alternatively, 1/ a rough MACSE alignment can be generated to spot possible frameshifts (e.g. using alignSequences with options -max_refine_iter 3 -local_realign_init 0.2), 2/ the resulting amino acid sequences (with FS replaced by X) aligned by external tools, and 3/ the gaps reported to the nucleotide sequences.

  -help: display full help instead of displaying only mandatory options
  -AA_seq_as_pattern_ON: use this option to indicate that the AA file does not contain a real alignment but a single sequence that contains as many AA as the NT alignment has codons and whose gaps indicate where gaps should be inserted in the NT alignment. Useful for a divide and conquer strategy: 1. build separate alignments (e.g per taxonomic group), 2. build their consensus, 3. align those consensus sequences at the AA level, and use the result to combine the initial NT alignments using this option.
      AA_seq_as_pattern_ON  = false
  -align_AA: input FASTA file containing aligned amino acid sequences
      align_AA  = <empty string>
  -allow_NT: extra nucleotide characters to consider as N (example: -allow_NT "#?")
      allow_NT  = <empty string>
  -out_NT: output FASTA file containing aligned nucleotide sequences
      out_NT  = <empty string>
  -seq: input FASTA file containing (reliable) nucleotide sequences
      seq  = <empty string>
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

reportMaskAA2NT: uses a filtered amino acid alignment to filter a nucleotide alignment.
 This program uses a nucleotide alignment and a filtered (masked) version of its amino acid translation to derived the filtered version of the input nucleotide alignment.
	 By default some post processings are done to also mask isolated codons (those surrounded only by gaps or masked codons).
	 Sequences with not enough remaining codons can also be completely removed from the alignment.
	 Extremities of the alignment can also be trimmed, each gappy site being removed until reaching the first non-gappy ones (works at the codon level).  

  -help: display full help instead of displaying only mandatory options
  -align: input FASTA file containing aligned nucleotide sequences
      align  = <empty string>
  -align_AA: input FASTA file containing aligned amino acid sequences
      align_AA  = <empty string>
  -allow_NT: extra nucleotide characters to consider as N (example: -allow_NT "#?")
      allow_NT  = <empty string>
  -dist_isolate_AA: if the nearest non-gap character is farther away, the residue is considered to be an isolated one and will be removed/masked (-1 no filtering) 
      dist_isolate_AA  = -1
  -mask_AA: character used to indicate a filtered amino acid
      mask_AA  = ?
  -min_NT_to_keep_seq: minimal number of unmasked nucleotides a sequence should have to be kept (number of NT when >1 or fraction of initial sequence alignment length when <=1)								
      min_NT_to_keep_seq  = 0.0
  -min_homology_to_keep_seq: minimal percentage of homology (unmasked proportion, value in [0-1]) a sequence must have with others to be kept (including non-homologous NT at the beginning/end of the sequence)
      min_homology_to_keep_seq  = 0.1
  -min_internal_homology_to_keep_seq: minimal percentage of homology (unmasked proportion, value in [0-1]) a sequence must have with others to be kept (excluding non-homologous NT at the beginning/end of the sequence)
      min_internal_homology_to_keep_seq  = 0.5
  -min_percent_NT_at_ends: trims alignmnent by removing sites from the end of the alignment up to the first site for which the percentage of nucleotides is greater than this value
      min_percent_NT_at_ends  = 0.0
  -min_seq_to_keep_site: if a site has less non informative characters than this value, this site will be removed
      min_seq_to_keep_site  = 1
  -out_NT: output FASTA file containing aligned nucleotide sequences
      out_NT  = <empty string>
  -out_mask_detail: output FASTA file containing the resulting masking, masked nucleotides are in lower case while other nucleotides are in UPPER CASE
      out_mask_detail  = <empty string>
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

splitAlignment: splits one alignment, to extract a subset of sequences and/or sites.
 Sites containing only gaps (and frameshifts if asked) after restriction are removed (works at the codon level).

  -help: display full help instead of displaying only mandatory options
  -align: input FASTA file containing aligned nucleotide sequences
      align  = <empty string>
  -amino_alignment_ON: use this option if the alignment file contains amino acids and not nucleotides
      amino_alignment_ON  = false
  -first_site: position of the first site to keep
      first_site  = 1
  -keep_FS_OFF: if this option is set, a site containing only gaps and frameshifts will be removed (as one containing only gaps). By default such sites are kept to preserve the reading frame.
      keep_FS_OFF  = false
  -last_site: position of the last site to keep
      last_site  = 2147483647
  -out_others: file that will contain the alignment with the subset of unselected sequences
      out_others  = <empty string>
  -out_subset: file that will contain the alignment with the subset of selected sequences
      out_subset  = <empty string>
  -restrict: file containing names of the sequences chosen to define the borders of the alignment (one sequence name per line, with or without the starting ">" character). All sites upstream (resp. downstream) the first (resp. last) non-gap codon of those sequences will be trimmed.
      restrict  = <empty string>
  -reverse_site_selection_ON: if this option is set, the sites normally kept will be those that will be removed 
      reverse_site_selection_ON  = false
  -site_intervals: file containing the list of site intervals that should be kept, one line per interval (start_position end_position); any of the following separators can be used: space, tabulation, comma, semicolon.
      site_intervals  = <empty string>
  -subset: file containing names of the sequences to keep in the restricted alignment (one sequence name per line, with or without the starting ">" character)
      subset  = <empty string>
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

translateNT2AA: translates nucleotides into amino acids

  -help: display full help instead of displaying only mandatory options
  -allow_NT: extra nucleotide characters to consider as N (example: -allow_NT "#?")
      allow_NT  = <empty string>
  -alphabet_AA: compressed amino acid (AA) alphabet used to estimate initial pairwise distances and homologous sequence fragments
      alphabet_AA  = SE_B_8
  -ambi_OFF: disables ambiguities management (e.g. a 'TCN' codon will be translated into an unknown amino acid instead of a serine (S))
      ambi_OFF  = false
  -canonize_ON: if used, MACSE will output modified NT sequences so that the same codon will be used for each instance of a given amino acid (useful to generate a consensus nucleotide sequence reflecting amino acid frequencies)
      canonize_ON  = false
  -gc_def: default genetic code specified by its standard NCBI numbering  (i.e. code used for sequences for which no specific code is provided in the gc_file (see genetic code list below))
      gc_def  = 1
  -gc_file: tabular file containing on each line a sequence name and the standard NCBI numbering specifying its genetic code. Any of the following field separators could be used: space, tabulation, comma, semicolon.
      gc_file  = <empty string>
  -ignore_gaps_ON: removes gaps before translation
      ignore_gaps_ON  = false
  -keep_final_stop_ON: translates the final stop codons into * (OFF by default, does not work with guessOneReadingFrame)
      keep_final_stop_ON  = false
  -maxSTOP_inSeq: maximum number of internal STOP codons allowed within a sequence to be actually added to the alignment (default no limit)
      maxSTOP_inSeq  = -1
  -out_AA: output FASTA file containing aligned amino acid sequences
      out_AA  = <empty string>
  -out_NT: output FASTA file containing aligned nucleotide sequences
      out_NT  = <empty string>
  -seq: input FASTA file containing (reliable) nucleotide sequences
      seq  = <empty string>
  -trim_pending_ON: if this option is enabled, the first and/or last codon(s) will be removed when incomplete (at most 4=2+2 nucleotides can be trimmed)
      trim_pending_ON  = false
  -use_compressed_alphabet_ON: if this option is enabled, the amino acid output file will contain the compressed amino acids corresponding to the chosen alphabet
      use_compressed_alphabet_ON  = false

====================================================================================================
# List of genetic codes.
----------------------------------------------------------------------------------------------------
01_The_Standard_Code
02_The_Vertebrate_Mitochondrial_Code
03_The_Yeast_Mitochondrial_Code
04_The_Mold_Protozoan_and_Coelenterate_Mitochondrial_Code_and_the_Mycoplasma_Spiroplasma_Code
05_The_Invertebrate_Mitochondrial_Code
06_The_Ciliate_Dasycladacean_and_Hexamita_Nuclear_Code
09_The_Echinoderm_and_Flatworm_Mitochondrial_Code
10_The_Euplotid_Nuclear_Code
11_The_Bacterial_Archaeal_and_Plant_Plastid_Code
12_The_Alternative_Yeast_Nuclear_Code
13_The_Ascidian_Mitochondrial_Code
14_The_Alternative_Flatworm_Mitochondrial_Code
15_Blepharisma_Nuclear_Code
16_Chlorophycean_Mitochondrial_Code
21_Trematode_Mitochondrial_Code
22_Scenedesmus_obliquus_mitochondrial_Code
23_Thraustochytrium_Mitochondrial_Code
24_Rhabdopleuridae_Mitochondrial_Code
25_Candidate_Division_SR1_and_Gracilibacteria
26_Pachysolen_tannophilus_Nuclear_Code
27_Karyorelict_Nuclear_Code
28_Condylostoma_Nuclear_Code
29_Mesodinium_Nuclear_Code
30_Peritrich_Nuclear_Code
31_Blastocrithidia_Nuclear_Code
32_Seleno_Protein_Code
33_Cephalodiscidae_Mitochondrial_UAA-Tyr_Code
====================================================================================================


====================================================================================================
# List of compressed alphabets.
----------------------------------------------------------------------------------------------------
Dayhoff_6
Li_A_10
Li_B_10
Murphy_10
SE_B_10
SE_B_14
SE_B_6
SE_B_8
SE_V_10
Solis_D_10
Solis_G_10
====================================================================================================
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

trimAlignment: trims the input alignment by removing gappy sites at the beginning/end of the alignment.
	 A sliding windows is used so that an isolated site with few gaps do not impede the triming of a gappy region at the beginning/end of the alignment.

  -help: display full help instead of displaying only mandatory options
  -align: input FASTA file containing aligned nucleotide sequences
      align  = <empty string>
  -allow_NT: extra nucleotide characters to consider as N (example: -allow_NT "#?")
      allow_NT  = <empty string>
  -half_window_size: the sliding window size is equal to (1 + 2*half_window_size)
      half_window_size  = 0
  -min_NT_at_ends: minimum number of sequences that should be present in the alignment extremities.
	 If this parameter and min_percent_NT_at_ends are both set, the smallest (non null) percentage will be used. This is useful to indicate that alignment ends should be trimmed until having at least XX sequences or YY% percentage of the sequences.
      min_NT_at_ends  = 0
  -min_percent_NT_at_ends: trims alignmnent by removing sites from the end of the alignment up to the first site for which the percentage of nucleotides is greater than this value
      min_percent_NT_at_ends  = 0.0
  -out_NT: output FASTA file containing aligned nucleotide sequences
      out_NT  = <empty string>
  -out_trim_info: output CSV file containing information about the triming/filtering process 								
      out_trim_info  = <empty string>
  -respect_first_RF_ON: if this option is set, the triming will preserve the (first) reading frame (the number of trimmed sites will be a mulitple of 3).
      respect_first_RF_ON  = false
  -trimed_seq_only_stat_ON: null
      trimed_seq_only_stat_ON  = false
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

trimNonHomologousFragments: identifies (and trims) sequence fragments that do not share homology with other sequences and remove those fragments.
	 The homology is based on Maximum Exact Matches (MEMs) between sequences translated in a compressed amino acid alphabet (in the 3 reading frames). 

  -help: display full help instead of displaying only mandatory options
  -allow_NT: extra nucleotide characters to consider as N (example: -allow_NT "#?")
      allow_NT  = <empty string>
  -alphabet_AA: compressed amino acid (AA) alphabet used to estimate initial pairwise distances and homologous sequence fragments
      alphabet_AA  = SE_B_8
  -ambi_OFF: disables ambiguities management (e.g. a 'TCN' codon will be translated into an unknown amino acid instead of a serine (S))
      ambi_OFF  = false
  -fs: cost of a frameshift in (reliable) sequences
      fs  = 30.0
  -fs_lr: cost of a frameshift in less reliable sequences (those of seq_lr file)
      fs_lr  = 10.0
  -fs_lr_term: cost of a terminal frameshift (those in the first and last codon) in a less reliable sequence 
      fs_lr_term  = 7.0
  -fs_term: cost of a terminal frameshift (those in the first and last codon) in a reliable sequence
      fs_term  = 10.0
  -gap_ext: cost of internal gap extension
      gap_ext  = 1.0
  -gap_ext_term: cost of terminal gap extension (e.g. those before the first nucleotide and after the last one)
      gap_ext_term  = 0.9
  -gap_op: cost of internal gap opening
      gap_op  = 7.0
  -gap_op_term: cost of terminal gap opening (e.g. those before the first nucleotide and after the last one)
      gap_op_term  = 6.3
  -gc_def: default genetic code specified by its standard NCBI numbering  (i.e. code used for sequences for which no specific code is provided in the gc_file (see genetic code list below))
      gc_def  = 1
  -gc_file: tabular file containing on each line a sequence name and the standard NCBI numbering specifying its genetic code. Any of the following field separators could be used: space, tabulation, comma, semicolon.
      gc_file  = <empty string>
  -min_MEM_length: minimal length of the Maximum Exact Matches used to identify sequence similarity. Higher values mean more stringent filtering.
      min_MEM_length  = 6
  -min_cov: null
      min_cov  = 3
  -min_homology_to_keep_seq: minimal percentage of homology (unmasked proportion, value in [0-1]) a sequence must have with others to be kept (including non-homologous NT at the beginning/end of the sequence)
      min_homology_to_keep_seq  = 0.1
  -min_internal_homology_to_keep_seq: minimal percentage of homology (unmasked proportion, value in [0-1]) a sequence must have with others to be kept (excluding non-homologous NT at the beginning/end of the sequence)
      min_internal_homology_to_keep_seq  = 0.5
  -min_trim_ext: non-homologous fragments at both extremities of a sequence are trimmed only if longer than this value							
      min_trim_ext  = 60
  -min_trim_in: non-homologous fragments within the sequences are trimmed only if longer than this value	
      min_trim_in  = 90
  -out_AA: output FASTA file containing aligned amino acid sequences
      out_AA  = <empty string>
  -out_NT: output FASTA file containing aligned nucleotide sequences
      out_NT  = <empty string>
  -out_mask_detail: output FASTA file containing the resulting masking, masked nucleotides are in lower case while other nucleotides are in UPPER CASE
      out_mask_detail  = <empty string>
  -out_trace: file containing debug information
      out_trace  = <empty string>
  -out_trim_info: output CSV file containing information about the triming/filtering process 								
      out_trim_info  = <empty string>
  -score_matrix: amino acid score matrix to use (see list below)
      score_matrix  = BLOSUM62
  -seq: input FASTA file containing (reliable) nucleotide sequences
      seq  = <empty string>
  -seq_lr: input FASTA file containing less reliable nucleotide sequences (e.g. pseudogenes)
      seq_lr  = <empty string>
  -stop: cost of a stop codon in (reliable) sequences, it should be less than twice the cost of a frameshift in those sequences
      stop  = 50.0
  -stop_lr: cost of a stop codon in less reliable sequences, it should be less than twice the cost of a frameshift in those sequences
      stop_lr  = 17.0

====================================================================================================
# List of genetic codes.
----------------------------------------------------------------------------------------------------
01_The_Standard_Code
02_The_Vertebrate_Mitochondrial_Code
03_The_Yeast_Mitochondrial_Code
04_The_Mold_Protozoan_and_Coelenterate_Mitochondrial_Code_and_the_Mycoplasma_Spiroplasma_Code
05_The_Invertebrate_Mitochondrial_Code
06_The_Ciliate_Dasycladacean_and_Hexamita_Nuclear_Code
09_The_Echinoderm_and_Flatworm_Mitochondrial_Code
10_The_Euplotid_Nuclear_Code
11_The_Bacterial_Archaeal_and_Plant_Plastid_Code
12_The_Alternative_Yeast_Nuclear_Code
13_The_Ascidian_Mitochondrial_Code
14_The_Alternative_Flatworm_Mitochondrial_Code
15_Blepharisma_Nuclear_Code
16_Chlorophycean_Mitochondrial_Code
21_Trematode_Mitochondrial_Code
22_Scenedesmus_obliquus_mitochondrial_Code
23_Thraustochytrium_Mitochondrial_Code
24_Rhabdopleuridae_Mitochondrial_Code
25_Candidate_Division_SR1_and_Gracilibacteria
26_Pachysolen_tannophilus_Nuclear_Code
27_Karyorelict_Nuclear_Code
28_Condylostoma_Nuclear_Code
29_Mesodinium_Nuclear_Code
30_Peritrich_Nuclear_Code
31_Blastocrithidia_Nuclear_Code
32_Seleno_Protein_Code
33_Cephalodiscidae_Mitochondrial_UAA-Tyr_Code
====================================================================================================


====================================================================================================
# List of score matrices.
----------------------------------------------------------------------------------------------------
BLOSUM62
VTML200_BIS
VTML240
====================================================================================================


====================================================================================================
# List of compressed alphabets.
----------------------------------------------------------------------------------------------------
Dayhoff_6
Li_A_10
Li_B_10
Murphy_10
SE_B_10
SE_B_14
SE_B_6
SE_B_8
SE_V_10
Solis_D_10
Solis_G_10
====================================================================================================
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

trimSequences: removes the 3' and 5' parts of the input sequence that are non homologous to an alignment.
	 Each sequence is sequentially added with the input alignment, the first and last non gap site of the alignment are used as bounds every nucleotide of the sequence outside of this bounds is trimmed. 
	 Useful to remove 3' and 5' UTRs thanks to a reference alignment of homologous coding sequences or to adjust sequences to a specific barcoding locus.

  -help: display full help instead of displaying only mandatory options
  -align: input FASTA file containing aligned nucleotide sequences
      align  = <empty string>
  -allow_NT: extra nucleotide characters to consider as N (example: -allow_NT "#?")
      allow_NT  = <empty string>
  -ambi_OFF: disables ambiguities management (e.g. a 'TCN' codon will be translated into an unknown amino acid instead of a serine (S))
      ambi_OFF  = false
  -fs: cost of a frameshift in (reliable) sequences
      fs  = 30.0
  -fs_lr: cost of a frameshift in less reliable sequences (those of seq_lr file)
      fs_lr  = 10.0
  -fs_lr_term: cost of a terminal frameshift (those in the first and last codon) in a less reliable sequence 
      fs_lr_term  = 7.0
  -fs_term: cost of a terminal frameshift (those in the first and last codon) in a reliable sequence
      fs_term  = 10.0
  -gap_ext: cost of internal gap extension
      gap_ext  = 1.0
  -gap_ext_term: cost of terminal gap extension (e.g. those before the first nucleotide and after the last one)
      gap_ext_term  = 0.9
  -gap_op: cost of internal gap opening
      gap_op  = 7.0
  -gap_op_term: cost of terminal gap opening (e.g. those before the first nucleotide and after the last one)
      gap_op_term  = 6.3
  -gc_def: default genetic code specified by its standard NCBI numbering  (i.e. code used for sequences for which no specific code is provided in the gc_file (see genetic code list below))
      gc_def  = 1
  -gc_file: tabular file containing on each line a sequence name and the standard NCBI numbering specifying its genetic code. Any of the following field separators could be used: space, tabulation, comma, semicolon.
      gc_file  = <empty string>
  -out_AA: output FASTA file containing aligned amino acid sequences
      out_AA  = <empty string>
  -out_NT: output FASTA file containing aligned nucleotide sequences
      out_NT  = <empty string>
  -out_NT_annotated: output file containing the full sequences with trimmed fragments indicated in lower case
      out_NT_annotated  = <empty string>
  -out_NT_trimmed: output file containing the trimmed sequences
      out_NT_trimmed  = <empty string>
  -out_trim_stat: null
      out_trim_stat  = <empty string>
  -score_matrix: amino acid score matrix to use (see list below)
      score_matrix  = BLOSUM62
  -seq: input FASTA file containing (reliable) nucleotide sequences
      seq  = <empty string>
  -seq_lr: input FASTA file containing less reliable nucleotide sequences (e.g. pseudogenes)
      seq_lr  = <empty string>
  -stop: cost of a stop codon in (reliable) sequences, it should be less than twice the cost of a frameshift in those sequences
      stop  = 50.0
  -stop_lr: cost of a stop codon in less reliable sequences, it should be less than twice the cost of a frameshift in those sequences
      stop_lr  = 17.0

====================================================================================================
# List of genetic codes.
----------------------------------------------------------------------------------------------------
01_The_Standard_Code
02_The_Vertebrate_Mitochondrial_Code
03_The_Yeast_Mitochondrial_Code
04_The_Mold_Protozoan_and_Coelenterate_Mitochondrial_Code_and_the_Mycoplasma_Spiroplasma_Code
05_The_Invertebrate_Mitochondrial_Code
06_The_Ciliate_Dasycladacean_and_Hexamita_Nuclear_Code
09_The_Echinoderm_and_Flatworm_Mitochondrial_Code
10_The_Euplotid_Nuclear_Code
11_The_Bacterial_Archaeal_and_Plant_Plastid_Code
12_The_Alternative_Yeast_Nuclear_Code
13_The_Ascidian_Mitochondrial_Code
14_The_Alternative_Flatworm_Mitochondrial_Code
15_Blepharisma_Nuclear_Code
16_Chlorophycean_Mitochondrial_Code
21_Trematode_Mitochondrial_Code
22_Scenedesmus_obliquus_mitochondrial_Code
23_Thraustochytrium_Mitochondrial_Code
24_Rhabdopleuridae_Mitochondrial_Code
25_Candidate_Division_SR1_and_Gracilibacteria
26_Pachysolen_tannophilus_Nuclear_Code
27_Karyorelict_Nuclear_Code
28_Condylostoma_Nuclear_Code
29_Mesodinium_Nuclear_Code
30_Peritrich_Nuclear_Code
31_Blastocrithidia_Nuclear_Code
32_Seleno_Protein_Code
33_Cephalodiscidae_Mitochondrial_UAA-Tyr_Code
====================================================================================================


====================================================================================================
# List of score matrices.
----------------------------------------------------------------------------------------------------
BLOSUM62
VTML200_BIS
VTML240
====================================================================================================
```


## Metadata
- **Skill**: generated
