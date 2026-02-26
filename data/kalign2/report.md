# kalign2 CWL Generation Report

## kalign2_kalign

### Tool Description
Kalign is free software. You can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation.

### Metadata
- **Docker Image**: quay.io/biocontainers/kalign2:2.04--h7b50bb2_8
- **Homepage**: http://msa.sbc.su.se/cgi-bin/msa.cgi
- **Package**: https://anaconda.org/channels/bioconda/packages/kalign2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kalign2/overview
- **Total Downloads**: 322.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Kalign version 2.04, Copyright (C) 2004, 2005, 2006 Timo Lassmann

        Kalign is free software. You can redistribute it and/or modify
        it under the terms of the GNU General Public License as
        published by the Free Software Foundation.

reading from STDIN: found 0 sequences

        Usage: kalign2   [INFILE] [OUTFILE] [OPTIONS]
        
	Options:

        -s,	-gapopen          Gap open penalty
        	-gap_open
        	-gpo
        	
        -e,	-gapextension     Gap extension penalty
        	-gap_ext
        	-gpe
        	
        -t,	-terminal_gap_extension_penalty	Terminal gap penalties
        	-tgpe
        	
        -m,	-matrix_bonus     A constant added to the substitution matrix.
        	-bonus
        	
        -c,	-sort            The order in which the sequences appear in the output alignment.
		                   <input, tree, gaps.>
		
        -g,	-feature          Selects feature mode and specifies which features are to be used:
		                   e.g. all, maxplp, STRUCT, PFAM-A....
           	-same_feature_score          Score for aligning same features
		-diff_feature_score          Penalty for aligning different features
        	
        -d,	-distance         Distance method.
		                   <wu,pair>
		
        -b,	-guide-tree       Guide tree method.
		-tree             <nj,upgma>
		
	-z,	-zcutoff         Parameter used in the wu-manber based distance calculation
		
        -i,	-input            The input file.
        	-infile
        	-in
        	
        -o,	-output           The output file.
        	-outfile
        	-out
        	
        -a,	-gap_inc           Parameter increases gap penalties depending on the number of existing gaps
        	
        -f,	-format           The output format:
		                   <fasta, msf, aln, clu, macsim>
		
	-q,	-quiet            Print nothing to STDERR.
		                  Read nothing from STDIN
	
	Examples:

	Using pipes:
		kalign2 [OPTIONS] < [INFILE]   > [OUTFILE]
		more [INFILE] |  kalign2 [OPTIONS] > [OUTFILE]
         
	Relaxed gap penalties:
		kalign2 -gpo 60 -gpe 9 -tgpe 0 -bonus 0 < [INFILE]   > [OUTFILE]
         
        Feature alignment with pairwise alignment based distance method and NJ guide tree:
        	kalign2 -in test.xml -distance pair -tree nj -sort gaps -feature STRUCT -format macsim -out test.macsim
        

WARNING: No sequences found.
```

