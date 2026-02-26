# repeatafterme CWL Generation Report

## repeatafterme_RAMExtend

### Tool Description
Perform a multiple sequence alignment (MSA) extension given an existing core MSA and the flanking sequences. The core may be a set of word matches, a previously development MSA, or the the result of any process that defines a core set of sequence relationships. The only requirement is that the sequences are aligned to nearly the same point along one or both of the core edges. The extension process is a form of anchored alignment where the details of the core alignment are considered fixed.

### Metadata
- **Docker Image**: quay.io/biocontainers/repeatafterme:0.0.7--h7b50bb2_0
- **Homepage**: https://github.com/Dfam-consortium/RepeatAfterMe
- **Package**: https://anaconda.org/channels/bioconda/packages/repeatafterme/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/repeatafterme/overview
- **Total Downloads**: 3.8K
- **Last updated**: 2025-07-03
- **GitHub**: https://github.com/Dfam-consortium/RepeatAfterMe
- **Stars**: N/A
### Original Help Text
```text
RAMExtend Version 0.0.7 - build 451 date 20250703

  Perform a multiple sequence alignment (MSA) extension given
  an existing core MSA and the flanking sequences.  The core
  may be a set of word matches, a previously development MSA,
  or the the result of any process that defines a core set of
  sequence relationships.  The only requirement is that the sequences are
  aligned to nearly the same point along one or both of the core
  edges.  The extension process is a form of anchored alignment
  where the details of the core alignment are considered fixed.

Usage: 
  RAMExtend -twobit <seq.2bit> -ranges <ranges.tsv> [opts]

--------------------------------------------------------------------------------------------
     -cons <seq.fa>        # Save the left/right consensus sequences to a FASTA file.
     -outtsv <final.tsv>   # Save the final sequence ranges to a TSV file.
     -outfa <seq.fa>       # Save all the final sequences ( original range + extension )
                           #   to a file.
     -addflanking <num>    # Include an additional<num> bp of sequence to each sequence
                           #   when using the -outfa option.
     -L <num>              # Size of region to extend left or right (10000). 
     -minimprovement <num> # Amount that a the alignment score needs to improve each step
                           #   to be considered progress (original: 3, nucleotide matrix: 27).
     -maxoccurrences <num> # Cap on the number of sequences to align (10,000). 
     -cappenalty <num>     # Cap on penalty for exiting alignment of a sequence 
                           #   (original: -20, nucleotide matrix:-90).
     -stopafter <num>      # Stop the alignment after this number of no-progress columns (100).
     -minlength <num>      # Minimum required length for a sequence to be reported (50).
     -outmat <file>        # Dump the dp matrix paths to a file for debugging.
     -version              # Print out one-line version information
     -v[v[v[v]]]           # How verbose do you want it to be?  -vvvv is super-verbose.

   New Scoring System Options:
     -matrix 14p43g |      # There are several internally-coded matrices available.
             18p43g |      #   The DNA substitution matrices are borrowed from RepeatMasker
             20p43g |      #   and are tuned for a 43% GC background.  The four encoded
             25p43g        #   matrices are are divergence tuned, ranging from 14% to 25%.
                           #   For example the '14p43g' matrix is tuned for 14% divergence
                           #   43% GC background.  Each matrix has it's own default gap_open,
                           #   gap_extension parameters.  These may be overrided by using the
                           #   -gapopen and -gapextn options.
     -gapopen <num>        # Affine gap open penalty to override per-matrix default
     -gapextn <num>        # Affine gap extension penalty to override per-matrix default

     -bandwidth <num>      # The maximum number of unbalanced gaps allowed (14)
                           #   Half the bandwidth of the banded Smith-Waterman
                           #   algorithm.  The default allows for at most 14bp
                           #   of unbalanced insertions/deletions in any aligned
                           #   sequence.  The full bandwidth is 2*bandwidth+1.
 or
   Original RepeatScout Scoring System:
     -matrix repeatscout   # The original RepeatScout scoring system is enabled if this
                           #   option is set.  This uses a simple match/mismatch penalty
                           #   and a linear gap model.  The original RepeatScout values
                           #   for these parameters may be overriden with the following
                           #   additional options:
     -match <num>          # If '-matrix repeatscout' used, apply this reward for match
                           #   (default +1)  
     -mismatch <num>       # If '-matrix repeatscout' used, apply this penalty for a mismatch
                           #   (default: -1) 
     -gap <num>            # If '-matrix repeatscout' used, apply this penalty for a gap
                           #   (default: -5)

Ranges:

   Ranges are supplied in the form of a modified BED-6 format:

      field-1:chrom     : sequence identifier
      field-2:chromStart: lower aligned position ( 0 based )
      field-3:chromEnd  : upper aligned position ( 0 based, half open )
      field-4:left-ext  : left extendable flag ( 0 = no, 1 = yes ) [BED-6 'name' field]
      field-5:right-ext : right extendable flag ( 0 = no, 1 = yes ) [BED-6 'score' field]
      field-6:strand    : strand ( '+' = forward, '-' = reverse )

   The fields are tab separated. Coordinates are zero-based half
   open.

   Left/Right extension flags are used to turn off extension for sequences that
   do not reach the edge of the core alignment (e.g. fragments aligning in the
   center of the core MSA, or one or the other edge only).  These sequences are
   less likely to include related flanking sequence and weigh down the extension
   score uneccesarily.  For these sequences it is desirable to flag one edge or
   the other as 'unextendable'.  The 'left'/'right' designations refer to the
   edges of the core MSA alignment. The 'left' flag may refer to the start or
   the end coordinate depending on the state of the orientation flag
   ('+' left=start, '-' left=end etc.).
```

