# nseg CWL Generation Report

## nseg

### Tool Description
Identify low and high complexity regions in DNA sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/nseg:1.0.1--h516909a_0
- **Homepage**: https://github.com/jebrosen/nseg
- **Package**: https://anaconda.org/channels/bioconda/packages/nseg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nseg/overview
- **Total Downloads**: 30.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jebrosen/nseg
- **Stars**: N/A
### Original Help Text
```text
Usage: nseg <file> <window> <locut> <hicut> <options>
         <file>   - filename containing fasta-formatted sequence(s) 
         <window> - OPTIONAL window size (default 21) 
         <locut>  - OPTIONAL low (trigger) complexity (default 1.4) 
         <hicut>  - OPTIONAL high (extension) complexity (default locut + 0.2) 
	 <options> 
            -x  each input sequence is represented by a single output 
                sequence with low-complexity regions replaced by 
                strings of 'x' characters 
            -c <chars> number of sequence characters/line (default 60)
            -m <size> minimum length for a high-complexity segment 
                (default 0).  Shorter segments are merged with adjacent 
                low-complexity segments 
            -l  show only low-complexity segments (fasta format) 
            -h  show only high-complexity segments (fasta format) 
            -a  show all segments (fasta format) 
            -n  do not add complexity information to the header line 
            -o  show overlapping low-complexity segments (default merge) 
            -t <maxtrim> maximum trimming of raw segment (default 100) 
            -p  prettyprint each segmented sequence (tree format) 
            -q  prettyprint each segmented sequence (block format) 
            -z <period>
```


## Metadata
- **Skill**: generated
