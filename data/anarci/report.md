# anarci CWL Generation Report

## anarci_ANARCI

### Tool Description
Antibody Numbering and Antigen Receptor ClassIfication

### Metadata
- **Docker Image**: quay.io/biocontainers/anarci:2024.05.21--pyhdfd78af_0
- **Homepage**: http://opig.stats.ox.ac.uk/webapps/newsabdab/sabpred/anarci/
- **Package**: https://anaconda.org/channels/bioconda/packages/anarci/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/anarci/overview
- **Total Downloads**: 214.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: ANARCI [-h] [--sequence INPUTSEQUENCE] [--outfile OUTFILE]
              [--scheme {m,c,k,imgt,kabat,chothia,martin,i,a,aho,wolfguy,w}]
              [--restrict {ig,tr,heavy,light,H,K,L,A,B} [{ig,tr,heavy,light,H,K,L,A,B} ...]]
              [--csv] [--outfile_hits HITFILE] [--hmmerpath HMMERPATH]
              [--ncpu NCPU] [--assign_germline]
              [--use_species {human,mouse,rat,rabbit,rhesus,pig,alpaca,cow}]
              [--bit_score_threshold BIT_SCORE_THRESHOLD]

ANARCI                                                 \\    //
Antibody Numbering and Antigen Receptor ClassIfication  \\  //
                                                          ||
(c) Oxford Protein Informatics Group (OPIG). 2015-17      ||

Usage:

ANARCI -i <inputsequence or fasta file>

Requirements:
 -  HMMER3 version 3.1b1 or higher - http://hmmer.janelia.org/ 

e.g. 
    ANARCI -i Example_sequence_files/12e8.fasta 
    This will number the files in 12e8.fasta with imgt numbering scheme and print to stdout.

    ANARCI -i Example_sequence_files/sequences.fasta -o Numbered_sequences.anarci -ht hit_tables.txt -s chothia -r ig 
    This will number the files in sequences.fasta with chothia numbering scheme only if they are an antibody chain (ignore TCRs).
    It will put the numbered sequences in Numbered_sequences.anarci and the alignment statistics in hit_tables.txt
    
    ANARCI -i Example_sequence_files/lysozyme.fasta
    No antigen receptors should be found. The program will just list the names of the sequences. 

    ANARCI -i EVQLQQSGAEVVRSGASVKLSCTASGFNIKDYYIHWVKQRPEKGLEWIGWIDPEIGDTEYVPKFQGKATMTADTSSNTAYLQLSSLTSEDTAVYYCNAGHDYDRGRFPYWGQGTLVTVSA
    Or just give a single sequence to be numbered. 

options:
  -h, --help            show this help message and exit
  --sequence INPUTSEQUENCE, -i INPUTSEQUENCE
                        A sequence or an input fasta file
  --outfile OUTFILE, -o OUTFILE
                        The output file to use. Default is stdout
  --scheme {m,c,k,imgt,kabat,chothia,martin,i,a,aho,wolfguy,w}, -s {m,c,k,imgt,kabat,chothia,martin,i,a,aho,wolfguy,w}
                        Which numbering scheme should be used. i, k, c, m, w
                        and a are shorthand for IMGT, Kabat, Chothia, Martin
                        (Extended Chothia), Wolfguy and Aho respectively.
                        Default IMGT
  --restrict {ig,tr,heavy,light,H,K,L,A,B} [{ig,tr,heavy,light,H,K,L,A,B} ...], -r {ig,tr,heavy,light,H,K,L,A,B} [{ig,tr,heavy,light,H,K,L,A,B} ...]
                        Restrict ANARCI to only recognise certain types of
                        receptor chains.
  --csv                 Write the output in csv format. Outfile must be
                        specified. A csv file is written for each chain type
                        <outfile>_<chain_type>.csv. Kappa and lambda are
                        considered together.
  --outfile_hits HITFILE, -ht HITFILE
                        Output file for domain hit tables for each sequence.
                        Otherwise not output.
  --hmmerpath HMMERPATH, -hp HMMERPATH
                        The path to the directory containing hmmer programs.
                        (including hmmscan)
  --ncpu NCPU, -p NCPU  Number of parallel processes to use. Default is 1.
  --assign_germline     Assign the v and j germlines to the sequence. The most
                        sequence identical germline is assigned.
  --use_species {human,mouse,rat,rabbit,rhesus,pig,alpaca,cow}
                        Use a specific species in the germline assignment. If
                        not specified, only human and mouse germlines will be
                        considered.
  --bit_score_threshold BIT_SCORE_THRESHOLD
                        Change the bit score threshold used to confirm an
                        alignment should be used.

Author: James Dunbar (dunbar@stats.ox.ac.uk)
        Charlotte Deane (deane@stats.ox.ac.uk)

Contact: opig@stats.ox.ac.uk

Copyright (C) 2017 Oxford Protein Informatics Group (OPIG)
Freely distributed under the BSD 3-Clause Licence.
```

