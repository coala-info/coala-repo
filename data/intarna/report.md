# intarna CWL Generation Report

## intarna_IntaRNA

### Tool Description
IntaRNA predicts RNA-RNA interactions.

### Metadata
- **Docker Image**: quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3
- **Homepage**: https://github.com/BackofenLab/IntaRNA
- **Package**: https://anaconda.org/channels/bioconda/packages/intarna/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/intarna/overview
- **Total Downloads**: 209.4K
- **Last updated**: 2025-08-16
- **GitHub**: https://github.com/BackofenLab/IntaRNA
- **Stars**: N/A
### Original Help Text
```text
IntaRNA predicts RNA-RNA interactions.

The following basic program arguments are supported:

Query:
  -q [ --query ] arg            either an RNA sequence or the stream/file name 
                                from where to read the query sequences (should 
                                be the shorter sequences to increase 
                                efficiency); use 'STDIN' to read from standard 
                                input stream; sequences have to use IUPAC 
                                nucleotide encoding; output alias is [seq2]

Target:
  -t [ --target ] arg           either an RNA sequence or the stream/file name 
                                from where to read the target sequences (should
                                be the longer sequences to increase 
                                efficiency); use 'STDIN' to read from standard 
                                input stream; sequences have to use IUPAC 
                                nucleotide encoding; output alias is [seq1]

Helix (only if --model=B):
  --helixMinBP arg (=2)         minimal number of base pairs inside a helix 
                                (arg in range [2,4])
  --helixMaxBP arg (=10)        maximal number of base pairs inside a helix 
                                (arg in range [2,20])
  --helixMaxIL arg (=0)         maximal size for each internal loop size in a 
                                helix (arg in range [0,2]).
  --helixMinPu arg (=0)         minimal unpaired probability (per sequence) of 
                                considered helices (arg in range [0,1]).
  --helixMaxE arg (=0)          maximal energy (excluding) a helix may have 
                                (arg in range [-999,999]).
  --helixFullE [=arg(=1)] (=0)  if given (or true), the overall energy of a 
                                helix (including E_init, ED, dangling ends, ..)
                                will be used for helixMaxE checks; otherwise 
                                only loop-terms are considered.

Seed:
  --noSeed [=arg(=1)] (=0)      if given (or true), no seed is enforced within 
                                the predicted interactions
  --seedTQ arg                  comma separated list of explicit seed base pair
                                encoding(s) in the format 
                                startTbpsT&startQbpsQ, e.g. '3|||.|&7||.||', 
                                where 'startT/Q' are the indices of the 5' seed
                                ends in target/query sequence and 'bpsT/Q' the 
                                respective dot-bar base pair encodings. This 
                                disables all other seed constraints and seed 
                                identification.
  --seedBP arg (=7)             number of inter-molecular base pairs within the
                                seed region (arg in range [2,20])

Interaction:
  -m [ --mode ] arg (=H)        prediction mode : 
                                 'H' = heuristic (fast and low memory), 
                                 'M' = exact (slow), 
                                 'S' = seed-only
  --model arg (=X)              interaction model : 
                                 'S' = single-site, minimum-free-energy 
                                interaction (interior loops only), 
                                 'X' = single-site, minimum-free-energy 
                                interaction via seed-extension (interior loops 
                                only), 
                                 'B' = single-site, helix-block-based, 
                                minimum-free-energy interaction (blocks of 
                                stable helices and interior loops only), 
                                 'P' = single-site interaction with minimal 
                                free ensemble energy per site (interior loops 
                                only)
  --acc arg (=C)                accessibility computation :
                                 'N' no accessibility contributions
                                 'C' computation of accessibilities (see --accW
                                and --accL)
  --intLenMax arg (=0)          interaction site : maximal window size to be 
                                considered for interaction (arg in range 
                                [0,99999]; 0 refers to the full sequence 
                                length). If --accW is provided, the smaller 
                                window size of both is used.
  --intLoopMax arg (=10)        interaction site : maximal number of unpaired 
                                bases between neighbored interacting bases to 
                                be considered in interactions (arg in range 
                                [0,30]; 0 enforces stackings only)

Output:
  --out arg (=STDOUT)           output (multi-arg) : provide a file name for 
                                output (will be overwritten) or 'STDOUT/STDERR'
                                to write to the according stream (according to 
                                --outMode).
                                Use one of the following PREFIXES 
                                (colon-separated) to generate ADDITIONAL 
                                output:
                                 'qMinE:' (query) for each position the minimal
                                energy of any interaction covering the position
                                (CSV format)
                                 'qSpotProb:' (query) for each position the 
                                probability that is is covered by an 
                                interaction covering (CSV format)
                                 'qAcc:' (query) ED accessibility values 
                                ('qPu'-like format).
                                 'qPu:' (query) unpaired probabilities values 
                                (RNAplfold format).
                                 'tMinE:' (target) for each position the 
                                minimal energy of any interaction covering the 
                                position (CSV format)
                                 'tSpotProb:' (target) for each position the 
                                probability that is is covered by an 
                                interaction covering (CSV format)
                                 'tAcc:' (target) ED accessibility values 
                                ('tPu'-like format).
                                 'tPu:' (target) unpaired probabilities values 
                                (RNAplfold format).
                                 'pMinE:' (target+query) for each index pair 
                                the minimal energy of any interaction covering 
                                the pair (CSV format)
                                 'spotProb:' (target+query) tracks for a given 
                                set of interaction spots their probability to 
                                be covered by an interaction. If no spots are 
                                provided, probabilities for all index 
                                combinations are computed. Spots are encoded by
                                comma-separated 'idxT&idxQ' pairs 
                                (target-query). For each spot a probability is 
                                provided in concert with the probability that 
                                none of the spots (encoded by '0&0') is covered
                                (CSV format). The spot encoding is followed 
                                colon-separated by the output stream/file name,
                                eg. '--out="spotProb:3&76,59&2:STDERR"'. NOTE: 
                                value has to be quoted due to '&' symbol!
                                For each, provide a file name or STDOUT/STDERR 
                                to write to the respective output stream.
  --outSep arg (=;)             column separator to be used in tabular CSV 
                                output
  --outMode arg (=N)            output mode :
                                 'N' normal output (ASCII char + energy),
                                 'D' detailed output (ASCII char + 
                                energy/position details),
                                 'C' CSV output (see --outCsvCols),
                                 'E' ensemble information
  -n [ --outNumber ] arg (=1)   number of (sub)optimal interactions to report 
                                (arg in range [0,1000])
  --outOverlap arg (=B)         suboptimal output : interactions can overlap 
                                 'N' in none of the sequences, 
                                 'T' in the target only, 
                                 'Q' in the query only, 
                                 'B' in both sequences

General:
  --threads arg (=1)            maximal number of threads to be used for 
                                parallel computation of query-target 
                                combinations. A value of 0 requests all 
                                available CPUs. Note, the number of threads 
                                multiplies the required memory used for 
                                computation! (arg in range [0,20])
  --version                     print version
  --personality arg             IntaRNA personality to be used, which defines 
                                default values, available program arguments and
                                tool behavior
  --parameterFile arg           file from where to read additional command line
                                arguments
  -h [ --help ]                 show the help page for basic parameters
  --fullhelp                    show the extended help page for all available 
                                parameters

Run --fullhelp for the extended list of parameters

You can find more detailed documentation of IntaRNA on 

  https://backofenlab.github.io/IntaRNA/
```


## intarna_IntaRNAsTar

### Tool Description
IntaRNA predicts RNA-RNA interactions.

### Metadata
- **Docker Image**: quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3
- **Homepage**: https://github.com/BackofenLab/IntaRNA
- **Package**: https://anaconda.org/channels/bioconda/packages/intarna/overview
- **Validation**: PASS

### Original Help Text
```text
IntaRNA predicts RNA-RNA interactions.

The following basic program arguments are supported:

Query:
  -q [ --query ] arg            either an RNA sequence or the stream/file name 
                                from where to read the query sequences (should 
                                be the shorter sequences to increase 
                                efficiency); use 'STDIN' to read from standard 
                                input stream; sequences have to use IUPAC 
                                nucleotide encoding; output alias is [seq2]

Target:
  -t [ --target ] arg           either an RNA sequence or the stream/file name 
                                from where to read the target sequences (should
                                be the longer sequences to increase 
                                efficiency); use 'STDIN' to read from standard 
                                input stream; sequences have to use IUPAC 
                                nucleotide encoding; output alias is [seq1]

Helix (only if --model=B):
  --helixMinBP arg (=2)         minimal number of base pairs inside a helix 
                                (arg in range [2,4])
  --helixMaxBP arg (=10)        maximal number of base pairs inside a helix 
                                (arg in range [2,20])
  --helixMaxIL arg (=0)         maximal size for each internal loop size in a 
                                helix (arg in range [0,2]).
  --helixMinPu arg (=0)         minimal unpaired probability (per sequence) of 
                                considered helices (arg in range [0,1]).
  --helixMaxE arg (=0)          maximal energy (excluding) a helix may have 
                                (arg in range [-999,999]).
  --helixFullE [=arg(=1)] (=0)  if given (or true), the overall energy of a 
                                helix (including E_init, ED, dangling ends, ..)
                                will be used for helixMaxE checks; otherwise 
                                only loop-terms are considered.

Seed:
  --noSeed [=arg(=1)] (=0)      if given (or true), no seed is enforced within 
                                the predicted interactions
  --seedTQ arg                  comma separated list of explicit seed base pair
                                encoding(s) in the format 
                                startTbpsT&startQbpsQ, e.g. '3|||.|&7||.||', 
                                where 'startT/Q' are the indices of the 5' seed
                                ends in target/query sequence and 'bpsT/Q' the 
                                respective dot-bar base pair encodings. This 
                                disables all other seed constraints and seed 
                                identification.
  --seedBP arg (=7)             number of inter-molecular base pairs within the
                                seed region (arg in range [2,20])

Interaction:
  -m [ --mode ] arg (=H)        prediction mode : 
                                 'H' = heuristic (fast and low memory), 
                                 'M' = exact (slow), 
                                 'S' = seed-only
  --model arg (=X)              interaction model : 
                                 'S' = single-site, minimum-free-energy 
                                interaction (interior loops only), 
                                 'X' = single-site, minimum-free-energy 
                                interaction via seed-extension (interior loops 
                                only), 
                                 'B' = single-site, helix-block-based, 
                                minimum-free-energy interaction (blocks of 
                                stable helices and interior loops only), 
                                 'P' = single-site interaction with minimal 
                                free ensemble energy per site (interior loops 
                                only)
  --acc arg (=C)                accessibility computation :
                                 'N' no accessibility contributions
                                 'C' computation of accessibilities (see --accW
                                and --accL)
  --intLenMax arg (=60)         interaction site : maximal window size to be 
                                considered for interaction (arg in range 
                                [0,99999]; 0 refers to the full sequence 
                                length). If --accW is provided, the smaller 
                                window size of both is used.
  --intLoopMax arg (=8)         interaction site : maximal number of unpaired 
                                bases between neighbored interacting bases to 
                                be considered in interactions (arg in range 
                                [0,30]; 0 enforces stackings only)

Output:
  --out arg (=STDOUT)           output (multi-arg) : provide a file name for 
                                output (will be overwritten) or 'STDOUT/STDERR'
                                to write to the according stream (according to 
                                --outMode).
                                Use one of the following PREFIXES 
                                (colon-separated) to generate ADDITIONAL 
                                output:
                                 'qMinE:' (query) for each position the minimal
                                energy of any interaction covering the position
                                (CSV format)
                                 'qSpotProb:' (query) for each position the 
                                probability that is is covered by an 
                                interaction covering (CSV format)
                                 'qAcc:' (query) ED accessibility values 
                                ('qPu'-like format).
                                 'qPu:' (query) unpaired probabilities values 
                                (RNAplfold format).
                                 'tMinE:' (target) for each position the 
                                minimal energy of any interaction covering the 
                                position (CSV format)
                                 'tSpotProb:' (target) for each position the 
                                probability that is is covered by an 
                                interaction covering (CSV format)
                                 'tAcc:' (target) ED accessibility values 
                                ('tPu'-like format).
                                 'tPu:' (target) unpaired probabilities values 
                                (RNAplfold format).
                                 'pMinE:' (target+query) for each index pair 
                                the minimal energy of any interaction covering 
                                the pair (CSV format)
                                 'spotProb:' (target+query) tracks for a given 
                                set of interaction spots their probability to 
                                be covered by an interaction. If no spots are 
                                provided, probabilities for all index 
                                combinations are computed. Spots are encoded by
                                comma-separated 'idxT&idxQ' pairs 
                                (target-query). For each spot a probability is 
                                provided in concert with the probability that 
                                none of the spots (encoded by '0&0') is covered
                                (CSV format). The spot encoding is followed 
                                colon-separated by the output stream/file name,
                                eg. '--out="spotProb:3&76,59&2:STDERR"'. NOTE: 
                                value has to be quoted due to '&' symbol!
                                For each, provide a file name or STDOUT/STDERR 
                                to write to the respective output stream.
  --outSep arg (=;)             column separator to be used in tabular CSV 
                                output
  --outMode arg (=C)            output mode :
                                 'N' normal output (ASCII char + energy),
                                 'D' detailed output (ASCII char + 
                                energy/position details),
                                 'C' CSV output (see --outCsvCols),
                                 'E' ensemble information
  -n [ --outNumber ] arg (=1)   number of (sub)optimal interactions to report 
                                (arg in range [0,1000])
  --outOverlap arg (=Q)         suboptimal output : interactions can overlap 
                                 'N' in none of the sequences, 
                                 'T' in the target only, 
                                 'Q' in the query only, 
                                 'B' in both sequences

General:
  --threads arg (=1)            maximal number of threads to be used for 
                                parallel computation of query-target 
                                combinations. A value of 0 requests all 
                                available CPUs. Note, the number of threads 
                                multiplies the required memory used for 
                                computation! (arg in range [0,20])
  --version                     print version
  --personality arg             IntaRNA personality to be used, which defines 
                                default values, available program arguments and
                                tool behavior
  --parameterFile arg           file from where to read additional command line
                                arguments
  -h [ --help ]                 show the help page for basic parameters
  --fullhelp                    show the extended help page for all available 
                                parameters

Run --fullhelp for the extended list of parameters


############################################################################

Note, you are using the 'IntaRNAsTar' personality, which alters some default values!

############################################################################

You can find more detailed documentation of IntaRNA on 

  https://backofenlab.github.io/IntaRNA/
```


## intarna_IntaRNAexact

### Tool Description
IntaRNA predicts RNA-RNA interactions.

### Metadata
- **Docker Image**: quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3
- **Homepage**: https://github.com/BackofenLab/IntaRNA
- **Package**: https://anaconda.org/channels/bioconda/packages/intarna/overview
- **Validation**: PASS

### Original Help Text
```text
IntaRNA predicts RNA-RNA interactions.

The following basic program arguments are supported:

Query:
  -q [ --query ] arg            either an RNA sequence or the stream/file name 
                                from where to read the query sequences (should 
                                be the shorter sequences to increase 
                                efficiency); use 'STDIN' to read from standard 
                                input stream; sequences have to use IUPAC 
                                nucleotide encoding; output alias is [seq2]

Target:
  -t [ --target ] arg           either an RNA sequence or the stream/file name 
                                from where to read the target sequences (should
                                be the longer sequences to increase 
                                efficiency); use 'STDIN' to read from standard 
                                input stream; sequences have to use IUPAC 
                                nucleotide encoding; output alias is [seq1]

Helix (only if --model=B):
  --helixMinBP arg (=2)         minimal number of base pairs inside a helix 
                                (arg in range [2,4])
  --helixMaxBP arg (=10)        maximal number of base pairs inside a helix 
                                (arg in range [2,20])
  --helixMaxIL arg (=0)         maximal size for each internal loop size in a 
                                helix (arg in range [0,2]).
  --helixMinPu arg (=0)         minimal unpaired probability (per sequence) of 
                                considered helices (arg in range [0,1]).
  --helixMaxE arg (=0)          maximal energy (excluding) a helix may have 
                                (arg in range [-999,999]).
  --helixFullE [=arg(=1)] (=0)  if given (or true), the overall energy of a 
                                helix (including E_init, ED, dangling ends, ..)
                                will be used for helixMaxE checks; otherwise 
                                only loop-terms are considered.

Seed:
  --noSeed [=arg(=1)] (=0)      if given (or true), no seed is enforced within 
                                the predicted interactions
  --seedTQ arg                  comma separated list of explicit seed base pair
                                encoding(s) in the format 
                                startTbpsT&startQbpsQ, e.g. '3|||.|&7||.||', 
                                where 'startT/Q' are the indices of the 5' seed
                                ends in target/query sequence and 'bpsT/Q' the 
                                respective dot-bar base pair encodings. This 
                                disables all other seed constraints and seed 
                                identification.
  --seedBP arg (=7)             number of inter-molecular base pairs within the
                                seed region (arg in range [2,20])

Interaction:
  -m [ --mode ] arg (=M)        prediction mode : 
                                 'H' = heuristic (fast and low memory), 
                                 'M' = exact (slow), 
                                 'S' = seed-only
  --model arg (=X)              interaction model : 
                                 'S' = single-site, minimum-free-energy 
                                interaction (interior loops only), 
                                 'X' = single-site, minimum-free-energy 
                                interaction via seed-extension (interior loops 
                                only), 
                                 'B' = single-site, helix-block-based, 
                                minimum-free-energy interaction (blocks of 
                                stable helices and interior loops only), 
                                 'P' = single-site interaction with minimal 
                                free ensemble energy per site (interior loops 
                                only)
  --acc arg (=C)                accessibility computation :
                                 'N' no accessibility contributions
                                 'C' computation of accessibilities (see --accW
                                and --accL)
  --intLenMax arg (=60)         interaction site : maximal window size to be 
                                considered for interaction (arg in range 
                                [0,99999]; 0 refers to the full sequence 
                                length). If --accW is provided, the smaller 
                                window size of both is used.
  --intLoopMax arg (=10)        interaction site : maximal number of unpaired 
                                bases between neighbored interacting bases to 
                                be considered in interactions (arg in range 
                                [0,30]; 0 enforces stackings only)

Output:
  --out arg (=STDOUT)           output (multi-arg) : provide a file name for 
                                output (will be overwritten) or 'STDOUT/STDERR'
                                to write to the according stream (according to 
                                --outMode).
                                Use one of the following PREFIXES 
                                (colon-separated) to generate ADDITIONAL 
                                output:
                                 'qMinE:' (query) for each position the minimal
                                energy of any interaction covering the position
                                (CSV format)
                                 'qSpotProb:' (query) for each position the 
                                probability that is is covered by an 
                                interaction covering (CSV format)
                                 'qAcc:' (query) ED accessibility values 
                                ('qPu'-like format).
                                 'qPu:' (query) unpaired probabilities values 
                                (RNAplfold format).
                                 'tMinE:' (target) for each position the 
                                minimal energy of any interaction covering the 
                                position (CSV format)
                                 'tSpotProb:' (target) for each position the 
                                probability that is is covered by an 
                                interaction covering (CSV format)
                                 'tAcc:' (target) ED accessibility values 
                                ('tPu'-like format).
                                 'tPu:' (target) unpaired probabilities values 
                                (RNAplfold format).
                                 'pMinE:' (target+query) for each index pair 
                                the minimal energy of any interaction covering 
                                the pair (CSV format)
                                 'spotProb:' (target+query) tracks for a given 
                                set of interaction spots their probability to 
                                be covered by an interaction. If no spots are 
                                provided, probabilities for all index 
                                combinations are computed. Spots are encoded by
                                comma-separated 'idxT&idxQ' pairs 
                                (target-query). For each spot a probability is 
                                provided in concert with the probability that 
                                none of the spots (encoded by '0&0') is covered
                                (CSV format). The spot encoding is followed 
                                colon-separated by the output stream/file name,
                                eg. '--out="spotProb:3&76,59&2:STDERR"'. NOTE: 
                                value has to be quoted due to '&' symbol!
                                For each, provide a file name or STDOUT/STDERR 
                                to write to the respective output stream.
  --outSep arg (=;)             column separator to be used in tabular CSV 
                                output
  --outMode arg (=N)            output mode :
                                 'N' normal output (ASCII char + energy),
                                 'D' detailed output (ASCII char + 
                                energy/position details),
                                 'C' CSV output (see --outCsvCols),
                                 'E' ensemble information
  -n [ --outNumber ] arg (=1)   number of (sub)optimal interactions to report 
                                (arg in range [0,1000])
  --outOverlap arg (=B)         suboptimal output : interactions can overlap 
                                 'N' in none of the sequences, 
                                 'T' in the target only, 
                                 'Q' in the query only, 
                                 'B' in both sequences

General:
  --threads arg (=1)            maximal number of threads to be used for 
                                parallel computation of query-target 
                                combinations. A value of 0 requests all 
                                available CPUs. Note, the number of threads 
                                multiplies the required memory used for 
                                computation! (arg in range [0,20])
  --version                     print version
  --personality arg             IntaRNA personality to be used, which defines 
                                default values, available program arguments and
                                tool behavior
  --parameterFile arg           file from where to read additional command line
                                arguments
  -h [ --help ]                 show the help page for basic parameters
  --fullhelp                    show the extended help page for all available 
                                parameters

Run --fullhelp for the extended list of parameters


############################################################################

Note, you are using the 'IntaRNAexact' personality, which alters some default values!

############################################################################

You can find more detailed documentation of IntaRNA on 

  https://backofenlab.github.io/IntaRNA/
```


## intarna_IntaRNAhelix

### Tool Description
IntaRNA predicts RNA-RNA interactions.

### Metadata
- **Docker Image**: quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3
- **Homepage**: https://github.com/BackofenLab/IntaRNA
- **Package**: https://anaconda.org/channels/bioconda/packages/intarna/overview
- **Validation**: PASS

### Original Help Text
```text
IntaRNA predicts RNA-RNA interactions.

The following basic program arguments are supported:

Query:
  -q [ --query ] arg            either an RNA sequence or the stream/file name 
                                from where to read the query sequences (should 
                                be the shorter sequences to increase 
                                efficiency); use 'STDIN' to read from standard 
                                input stream; sequences have to use IUPAC 
                                nucleotide encoding; output alias is [seq2]

Target:
  -t [ --target ] arg           either an RNA sequence or the stream/file name 
                                from where to read the target sequences (should
                                be the longer sequences to increase 
                                efficiency); use 'STDIN' to read from standard 
                                input stream; sequences have to use IUPAC 
                                nucleotide encoding; output alias is [seq1]

Helix (only if --model=B):
  --helixMinBP arg (=2)         minimal number of base pairs inside a helix 
                                (arg in range [2,4])
  --helixMaxBP arg (=10)        maximal number of base pairs inside a helix 
                                (arg in range [2,20])
  --helixMaxIL arg (=0)         maximal size for each internal loop size in a 
                                helix (arg in range [0,2]).
  --helixMinPu arg (=0)         minimal unpaired probability (per sequence) of 
                                considered helices (arg in range [0,1]).
  --helixMaxE arg (=0)          maximal energy (excluding) a helix may have 
                                (arg in range [-999,999]).
  --helixFullE [=arg(=1)] (=0)  if given (or true), the overall energy of a 
                                helix (including E_init, ED, dangling ends, ..)
                                will be used for helixMaxE checks; otherwise 
                                only loop-terms are considered.

Seed:
  --noSeed [=arg(=1)] (=0)      if given (or true), no seed is enforced within 
                                the predicted interactions
  --seedTQ arg                  comma separated list of explicit seed base pair
                                encoding(s) in the format 
                                startTbpsT&startQbpsQ, e.g. '3|||.|&7||.||', 
                                where 'startT/Q' are the indices of the 5' seed
                                ends in target/query sequence and 'bpsT/Q' the 
                                respective dot-bar base pair encodings. This 
                                disables all other seed constraints and seed 
                                identification.
  --seedBP arg (=7)             number of inter-molecular base pairs within the
                                seed region (arg in range [2,20])

Interaction:
  -m [ --mode ] arg (=H)        prediction mode : 
                                 'H' = heuristic (fast and low memory), 
                                 'M' = exact (slow), 
                                 'S' = seed-only
  --model arg (=B)              interaction model : 
                                 'S' = single-site, minimum-free-energy 
                                interaction (interior loops only), 
                                 'X' = single-site, minimum-free-energy 
                                interaction via seed-extension (interior loops 
                                only), 
                                 'B' = single-site, helix-block-based, 
                                minimum-free-energy interaction (blocks of 
                                stable helices and interior loops only), 
                                 'P' = single-site interaction with minimal 
                                free ensemble energy per site (interior loops 
                                only)
  --acc arg (=C)                accessibility computation :
                                 'N' no accessibility contributions
                                 'C' computation of accessibilities (see --accW
                                and --accL)
  --intLenMax arg (=0)          interaction site : maximal window size to be 
                                considered for interaction (arg in range 
                                [0,99999]; 0 refers to the full sequence 
                                length). If --accW is provided, the smaller 
                                window size of both is used.
  --intLoopMax arg (=10)        interaction site : maximal number of unpaired 
                                bases between neighbored interacting bases to 
                                be considered in interactions (arg in range 
                                [0,30]; 0 enforces stackings only)

Output:
  --out arg (=STDOUT)           output (multi-arg) : provide a file name for 
                                output (will be overwritten) or 'STDOUT/STDERR'
                                to write to the according stream (according to 
                                --outMode).
                                Use one of the following PREFIXES 
                                (colon-separated) to generate ADDITIONAL 
                                output:
                                 'qMinE:' (query) for each position the minimal
                                energy of any interaction covering the position
                                (CSV format)
                                 'qSpotProb:' (query) for each position the 
                                probability that is is covered by an 
                                interaction covering (CSV format)
                                 'qAcc:' (query) ED accessibility values 
                                ('qPu'-like format).
                                 'qPu:' (query) unpaired probabilities values 
                                (RNAplfold format).
                                 'tMinE:' (target) for each position the 
                                minimal energy of any interaction covering the 
                                position (CSV format)
                                 'tSpotProb:' (target) for each position the 
                                probability that is is covered by an 
                                interaction covering (CSV format)
                                 'tAcc:' (target) ED accessibility values 
                                ('tPu'-like format).
                                 'tPu:' (target) unpaired probabilities values 
                                (RNAplfold format).
                                 'pMinE:' (target+query) for each index pair 
                                the minimal energy of any interaction covering 
                                the pair (CSV format)
                                 'spotProb:' (target+query) tracks for a given 
                                set of interaction spots their probability to 
                                be covered by an interaction. If no spots are 
                                provided, probabilities for all index 
                                combinations are computed. Spots are encoded by
                                comma-separated 'idxT&idxQ' pairs 
                                (target-query). For each spot a probability is 
                                provided in concert with the probability that 
                                none of the spots (encoded by '0&0') is covered
                                (CSV format). The spot encoding is followed 
                                colon-separated by the output stream/file name,
                                eg. '--out="spotProb:3&76,59&2:STDERR"'. NOTE: 
                                value has to be quoted due to '&' symbol!
                                For each, provide a file name or STDOUT/STDERR 
                                to write to the respective output stream.
  --outSep arg (=;)             column separator to be used in tabular CSV 
                                output
  --outMode arg (=N)            output mode :
                                 'N' normal output (ASCII char + energy),
                                 'D' detailed output (ASCII char + 
                                energy/position details),
                                 'C' CSV output (see --outCsvCols),
                                 'E' ensemble information
  -n [ --outNumber ] arg (=1)   number of (sub)optimal interactions to report 
                                (arg in range [0,1000])
  --outOverlap arg (=B)         suboptimal output : interactions can overlap 
                                 'N' in none of the sequences, 
                                 'T' in the target only, 
                                 'Q' in the query only, 
                                 'B' in both sequences

General:
  --threads arg (=1)            maximal number of threads to be used for 
                                parallel computation of query-target 
                                combinations. A value of 0 requests all 
                                available CPUs. Note, the number of threads 
                                multiplies the required memory used for 
                                computation! (arg in range [0,20])
  --version                     print version
  --personality arg             IntaRNA personality to be used, which defines 
                                default values, available program arguments and
                                tool behavior
  --parameterFile arg           file from where to read additional command line
                                arguments
  -h [ --help ]                 show the help page for basic parameters
  --fullhelp                    show the extended help page for all available 
                                parameters

Run --fullhelp for the extended list of parameters


############################################################################

Note, you are using the 'IntaRNAhelix' personality, which alters some default values!

############################################################################

You can find more detailed documentation of IntaRNA on 

  https://backofenlab.github.io/IntaRNA/
```


## intarna_IntaRNAduplex

### Tool Description
IntaRNA predicts RNA-RNA interactions.

### Metadata
- **Docker Image**: quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3
- **Homepage**: https://github.com/BackofenLab/IntaRNA
- **Package**: https://anaconda.org/channels/bioconda/packages/intarna/overview
- **Validation**: PASS

### Original Help Text
```text
IntaRNA predicts RNA-RNA interactions.

The following basic program arguments are supported:

Query:
  -q [ --query ] arg            either an RNA sequence or the stream/file name 
                                from where to read the query sequences (should 
                                be the shorter sequences to increase 
                                efficiency); use 'STDIN' to read from standard 
                                input stream; sequences have to use IUPAC 
                                nucleotide encoding; output alias is [seq2]

Target:
  -t [ --target ] arg           either an RNA sequence or the stream/file name 
                                from where to read the target sequences (should
                                be the longer sequences to increase 
                                efficiency); use 'STDIN' to read from standard 
                                input stream; sequences have to use IUPAC 
                                nucleotide encoding; output alias is [seq1]

Helix (only if --model=B):
  --helixMinBP arg (=2)         minimal number of base pairs inside a helix 
                                (arg in range [2,4])
  --helixMaxBP arg (=10)        maximal number of base pairs inside a helix 
                                (arg in range [2,20])
  --helixMaxIL arg (=0)         maximal size for each internal loop size in a 
                                helix (arg in range [0,2]).
  --helixMinPu arg (=0)         minimal unpaired probability (per sequence) of 
                                considered helices (arg in range [0,1]).
  --helixMaxE arg (=0)          maximal energy (excluding) a helix may have 
                                (arg in range [-999,999]).
  --helixFullE [=arg(=1)] (=0)  if given (or true), the overall energy of a 
                                helix (including E_init, ED, dangling ends, ..)
                                will be used for helixMaxE checks; otherwise 
                                only loop-terms are considered.

Seed:
  --noSeed [=arg(=1)] (=0)      if given (or true), no seed is enforced within 
                                the predicted interactions
  --seedTQ arg                  comma separated list of explicit seed base pair
                                encoding(s) in the format 
                                startTbpsT&startQbpsQ, e.g. '3|||.|&7||.||', 
                                where 'startT/Q' are the indices of the 5' seed
                                ends in target/query sequence and 'bpsT/Q' the 
                                respective dot-bar base pair encodings. This 
                                disables all other seed constraints and seed 
                                identification.
  --seedBP arg (=7)             number of inter-molecular base pairs within the
                                seed region (arg in range [2,20])

Interaction:
  -m [ --mode ] arg (=H)        prediction mode : 
                                 'H' = heuristic (fast and low memory), 
                                 'M' = exact (slow), 
                                 'S' = seed-only
  --model arg (=X)              interaction model : 
                                 'S' = single-site, minimum-free-energy 
                                interaction (interior loops only), 
                                 'X' = single-site, minimum-free-energy 
                                interaction via seed-extension (interior loops 
                                only), 
                                 'B' = single-site, helix-block-based, 
                                minimum-free-energy interaction (blocks of 
                                stable helices and interior loops only), 
                                 'P' = single-site interaction with minimal 
                                free ensemble energy per site (interior loops 
                                only)
  --acc arg (=C)                accessibility computation :
                                 'N' no accessibility contributions
                                 'C' computation of accessibilities (see --accW
                                and --accL)
  --intLenMax arg (=0)          interaction site : maximal window size to be 
                                considered for interaction (arg in range 
                                [0,99999]; 0 refers to the full sequence 
                                length). If --accW is provided, the smaller 
                                window size of both is used.
  --intLoopMax arg (=10)        interaction site : maximal number of unpaired 
                                bases between neighbored interacting bases to 
                                be considered in interactions (arg in range 
                                [0,30]; 0 enforces stackings only)

Output:
  --out arg (=STDOUT)           output (multi-arg) : provide a file name for 
                                output (will be overwritten) or 'STDOUT/STDERR'
                                to write to the according stream (according to 
                                --outMode).
                                Use one of the following PREFIXES 
                                (colon-separated) to generate ADDITIONAL 
                                output:
                                 'qMinE:' (query) for each position the minimal
                                energy of any interaction covering the position
                                (CSV format)
                                 'qSpotProb:' (query) for each position the 
                                probability that is is covered by an 
                                interaction covering (CSV format)
                                 'qAcc:' (query) ED accessibility values 
                                ('qPu'-like format).
                                 'qPu:' (query) unpaired probabilities values 
                                (RNAplfold format).
                                 'tMinE:' (target) for each position the 
                                minimal energy of any interaction covering the 
                                position (CSV format)
                                 'tSpotProb:' (target) for each position the 
                                probability that is is covered by an 
                                interaction covering (CSV format)
                                 'tAcc:' (target) ED accessibility values 
                                ('tPu'-like format).
                                 'tPu:' (target) unpaired probabilities values 
                                (RNAplfold format).
                                 'pMinE:' (target+query) for each index pair 
                                the minimal energy of any interaction covering 
                                the pair (CSV format)
                                 'spotProb:' (target+query) tracks for a given 
                                set of interaction spots their probability to 
                                be covered by an interaction. If no spots are 
                                provided, probabilities for all index 
                                combinations are computed. Spots are encoded by
                                comma-separated 'idxT&idxQ' pairs 
                                (target-query). For each spot a probability is 
                                provided in concert with the probability that 
                                none of the spots (encoded by '0&0') is covered
                                (CSV format). The spot encoding is followed 
                                colon-separated by the output stream/file name,
                                eg. '--out="spotProb:3&76,59&2:STDERR"'. NOTE: 
                                value has to be quoted due to '&' symbol!
                                For each, provide a file name or STDOUT/STDERR 
                                to write to the respective output stream.
  --outSep arg (=;)             column separator to be used in tabular CSV 
                                output
  --outMode arg (=N)            output mode :
                                 'N' normal output (ASCII char + energy),
                                 'D' detailed output (ASCII char + 
                                energy/position details),
                                 'C' CSV output (see --outCsvCols),
                                 'E' ensemble information
  -n [ --outNumber ] arg (=1)   number of (sub)optimal interactions to report 
                                (arg in range [0,1000])
  --outOverlap arg (=B)         suboptimal output : interactions can overlap 
                                 'N' in none of the sequences, 
                                 'T' in the target only, 
                                 'Q' in the query only, 
                                 'B' in both sequences

General:
  --threads arg (=1)            maximal number of threads to be used for 
                                parallel computation of query-target 
                                combinations. A value of 0 requests all 
                                available CPUs. Note, the number of threads 
                                multiplies the required memory used for 
                                computation! (arg in range [0,20])
  --version                     print version
  --personality arg             IntaRNA personality to be used, which defines 
                                default values, available program arguments and
                                tool behavior
  --parameterFile arg           file from where to read additional command line
                                arguments
  -h [ --help ]                 show the help page for basic parameters
  --fullhelp                    show the extended help page for all available 
                                parameters

Run --fullhelp for the extended list of parameters


############################################################################

Note, you are using the 'IntaRNAduplex' personality, which alters some default values!

############################################################################

You can find more detailed documentation of IntaRNA on 

  https://backofenlab.github.io/IntaRNA/
```


## intarna_IntaRNAseed

### Tool Description
IntaRNA predicts RNA-RNA interactions.

### Metadata
- **Docker Image**: quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3
- **Homepage**: https://github.com/BackofenLab/IntaRNA
- **Package**: https://anaconda.org/channels/bioconda/packages/intarna/overview
- **Validation**: PASS

### Original Help Text
```text
IntaRNA predicts RNA-RNA interactions.

The following basic program arguments are supported:

Query:
  -q [ --query ] arg            either an RNA sequence or the stream/file name 
                                from where to read the query sequences (should 
                                be the shorter sequences to increase 
                                efficiency); use 'STDIN' to read from standard 
                                input stream; sequences have to use IUPAC 
                                nucleotide encoding; output alias is [seq2]

Target:
  -t [ --target ] arg           either an RNA sequence or the stream/file name 
                                from where to read the target sequences (should
                                be the longer sequences to increase 
                                efficiency); use 'STDIN' to read from standard 
                                input stream; sequences have to use IUPAC 
                                nucleotide encoding; output alias is [seq1]

Helix (only if --model=B):
  --helixMinBP arg (=2)         minimal number of base pairs inside a helix 
                                (arg in range [2,4])
  --helixMaxBP arg (=10)        maximal number of base pairs inside a helix 
                                (arg in range [2,20])
  --helixMaxIL arg (=0)         maximal size for each internal loop size in a 
                                helix (arg in range [0,2]).
  --helixMinPu arg (=0)         minimal unpaired probability (per sequence) of 
                                considered helices (arg in range [0,1]).
  --helixMaxE arg (=0)          maximal energy (excluding) a helix may have 
                                (arg in range [-999,999]).
  --helixFullE [=arg(=1)] (=0)  if given (or true), the overall energy of a 
                                helix (including E_init, ED, dangling ends, ..)
                                will be used for helixMaxE checks; otherwise 
                                only loop-terms are considered.

Seed:
  --noSeed [=arg(=1)] (=0)      if given (or true), no seed is enforced within 
                                the predicted interactions
  --seedTQ arg                  comma separated list of explicit seed base pair
                                encoding(s) in the format 
                                startTbpsT&startQbpsQ, e.g. '3|||.|&7||.||', 
                                where 'startT/Q' are the indices of the 5' seed
                                ends in target/query sequence and 'bpsT/Q' the 
                                respective dot-bar base pair encodings. This 
                                disables all other seed constraints and seed 
                                identification.
  --seedBP arg (=7)             number of inter-molecular base pairs within the
                                seed region (arg in range [2,20])

Interaction:
  -m [ --mode ] arg (=S)        prediction mode : 
                                 'H' = heuristic (fast and low memory), 
                                 'M' = exact (slow), 
                                 'S' = seed-only
  --model arg (=X)              interaction model : 
                                 'S' = single-site, minimum-free-energy 
                                interaction (interior loops only), 
                                 'X' = single-site, minimum-free-energy 
                                interaction via seed-extension (interior loops 
                                only), 
                                 'B' = single-site, helix-block-based, 
                                minimum-free-energy interaction (blocks of 
                                stable helices and interior loops only), 
                                 'P' = single-site interaction with minimal 
                                free ensemble energy per site (interior loops 
                                only)
  --acc arg (=C)                accessibility computation :
                                 'N' no accessibility contributions
                                 'C' computation of accessibilities (see --accW
                                and --accL)
  --intLenMax arg (=0)          interaction site : maximal window size to be 
                                considered for interaction (arg in range 
                                [0,99999]; 0 refers to the full sequence 
                                length). If --accW is provided, the smaller 
                                window size of both is used.
  --intLoopMax arg (=10)        interaction site : maximal number of unpaired 
                                bases between neighbored interacting bases to 
                                be considered in interactions (arg in range 
                                [0,30]; 0 enforces stackings only)

Output:
  --out arg (=STDOUT)           output (multi-arg) : provide a file name for 
                                output (will be overwritten) or 'STDOUT/STDERR'
                                to write to the according stream (according to 
                                --outMode).
                                Use one of the following PREFIXES 
                                (colon-separated) to generate ADDITIONAL 
                                output:
                                 'qMinE:' (query) for each position the minimal
                                energy of any interaction covering the position
                                (CSV format)
                                 'qSpotProb:' (query) for each position the 
                                probability that is is covered by an 
                                interaction covering (CSV format)
                                 'qAcc:' (query) ED accessibility values 
                                ('qPu'-like format).
                                 'qPu:' (query) unpaired probabilities values 
                                (RNAplfold format).
                                 'tMinE:' (target) for each position the 
                                minimal energy of any interaction covering the 
                                position (CSV format)
                                 'tSpotProb:' (target) for each position the 
                                probability that is is covered by an 
                                interaction covering (CSV format)
                                 'tAcc:' (target) ED accessibility values 
                                ('tPu'-like format).
                                 'tPu:' (target) unpaired probabilities values 
                                (RNAplfold format).
                                 'pMinE:' (target+query) for each index pair 
                                the minimal energy of any interaction covering 
                                the pair (CSV format)
                                 'spotProb:' (target+query) tracks for a given 
                                set of interaction spots their probability to 
                                be covered by an interaction. If no spots are 
                                provided, probabilities for all index 
                                combinations are computed. Spots are encoded by
                                comma-separated 'idxT&idxQ' pairs 
                                (target-query). For each spot a probability is 
                                provided in concert with the probability that 
                                none of the spots (encoded by '0&0') is covered
                                (CSV format). The spot encoding is followed 
                                colon-separated by the output stream/file name,
                                eg. '--out="spotProb:3&76,59&2:STDERR"'. NOTE: 
                                value has to be quoted due to '&' symbol!
                                For each, provide a file name or STDOUT/STDERR 
                                to write to the respective output stream.
  --outSep arg (=;)             column separator to be used in tabular CSV 
                                output
  --outMode arg (=N)            output mode :
                                 'N' normal output (ASCII char + energy),
                                 'D' detailed output (ASCII char + 
                                energy/position details),
                                 'C' CSV output (see --outCsvCols),
                                 'E' ensemble information
  -n [ --outNumber ] arg (=1)   number of (sub)optimal interactions to report 
                                (arg in range [0,1000])
  --outOverlap arg (=B)         suboptimal output : interactions can overlap 
                                 'N' in none of the sequences, 
                                 'T' in the target only, 
                                 'Q' in the query only, 
                                 'B' in both sequences

General:
  --threads arg (=1)            maximal number of threads to be used for 
                                parallel computation of query-target 
                                combinations. A value of 0 requests all 
                                available CPUs. Note, the number of threads 
                                multiplies the required memory used for 
                                computation! (arg in range [0,20])
  --version                     print version
  --personality arg             IntaRNA personality to be used, which defines 
                                default values, available program arguments and
                                tool behavior
  --parameterFile arg           file from where to read additional command line
                                arguments
  -h [ --help ]                 show the help page for basic parameters
  --fullhelp                    show the extended help page for all available 
                                parameters

Run --fullhelp for the extended list of parameters


############################################################################

Note, you are using the 'IntaRNAseed' personality, which alters some default values!

############################################################################

You can find more detailed documentation of IntaRNA on 

  https://backofenlab.github.io/IntaRNA/
```


## intarna_IntaRNAens

### Tool Description
IntaRNA predicts RNA-RNA interactions.

### Metadata
- **Docker Image**: quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3
- **Homepage**: https://github.com/BackofenLab/IntaRNA
- **Package**: https://anaconda.org/channels/bioconda/packages/intarna/overview
- **Validation**: PASS

### Original Help Text
```text
IntaRNA predicts RNA-RNA interactions.

The following basic program arguments are supported:

Query:
  -q [ --query ] arg            either an RNA sequence or the stream/file name 
                                from where to read the query sequences (should 
                                be the shorter sequences to increase 
                                efficiency); use 'STDIN' to read from standard 
                                input stream; sequences have to use IUPAC 
                                nucleotide encoding; output alias is [seq2]

Target:
  -t [ --target ] arg           either an RNA sequence or the stream/file name 
                                from where to read the target sequences (should
                                be the longer sequences to increase 
                                efficiency); use 'STDIN' to read from standard 
                                input stream; sequences have to use IUPAC 
                                nucleotide encoding; output alias is [seq1]

Helix (only if --model=B):
  --helixMinBP arg (=2)         minimal number of base pairs inside a helix 
                                (arg in range [2,4])
  --helixMaxBP arg (=10)        maximal number of base pairs inside a helix 
                                (arg in range [2,20])
  --helixMaxIL arg (=0)         maximal size for each internal loop size in a 
                                helix (arg in range [0,2]).
  --helixMinPu arg (=0)         minimal unpaired probability (per sequence) of 
                                considered helices (arg in range [0,1]).
  --helixMaxE arg (=0)          maximal energy (excluding) a helix may have 
                                (arg in range [-999,999]).
  --helixFullE [=arg(=1)] (=0)  if given (or true), the overall energy of a 
                                helix (including E_init, ED, dangling ends, ..)
                                will be used for helixMaxE checks; otherwise 
                                only loop-terms are considered.

Seed:
  --noSeed [=arg(=1)] (=0)      if given (or true), no seed is enforced within 
                                the predicted interactions
  --seedTQ arg                  comma separated list of explicit seed base pair
                                encoding(s) in the format 
                                startTbpsT&startQbpsQ, e.g. '3|||.|&7||.||', 
                                where 'startT/Q' are the indices of the 5' seed
                                ends in target/query sequence and 'bpsT/Q' the 
                                respective dot-bar base pair encodings. This 
                                disables all other seed constraints and seed 
                                identification.
  --seedBP arg (=7)             number of inter-molecular base pairs within the
                                seed region (arg in range [2,20])

Interaction:
  -m [ --mode ] arg (=H)        prediction mode : 
                                 'H' = heuristic (fast and low memory), 
                                 'M' = exact (slow), 
                                 'S' = seed-only
  --model arg (=P)              interaction model : 
                                 'S' = single-site, minimum-free-energy 
                                interaction (interior loops only), 
                                 'X' = single-site, minimum-free-energy 
                                interaction via seed-extension (interior loops 
                                only), 
                                 'B' = single-site, helix-block-based, 
                                minimum-free-energy interaction (blocks of 
                                stable helices and interior loops only), 
                                 'P' = single-site interaction with minimal 
                                free ensemble energy per site (interior loops 
                                only)
  --acc arg (=C)                accessibility computation :
                                 'N' no accessibility contributions
                                 'C' computation of accessibilities (see --accW
                                and --accL)
  --intLenMax arg (=0)          interaction site : maximal window size to be 
                                considered for interaction (arg in range 
                                [0,99999]; 0 refers to the full sequence 
                                length). If --accW is provided, the smaller 
                                window size of both is used.
  --intLoopMax arg (=10)        interaction site : maximal number of unpaired 
                                bases between neighbored interacting bases to 
                                be considered in interactions (arg in range 
                                [0,30]; 0 enforces stackings only)

Output:
  --out arg (=STDOUT)           output (multi-arg) : provide a file name for 
                                output (will be overwritten) or 'STDOUT/STDERR'
                                to write to the according stream (according to 
                                --outMode).
                                Use one of the following PREFIXES 
                                (colon-separated) to generate ADDITIONAL 
                                output:
                                 'qMinE:' (query) for each position the minimal
                                energy of any interaction covering the position
                                (CSV format)
                                 'qSpotProb:' (query) for each position the 
                                probability that is is covered by an 
                                interaction covering (CSV format)
                                 'qAcc:' (query) ED accessibility values 
                                ('qPu'-like format).
                                 'qPu:' (query) unpaired probabilities values 
                                (RNAplfold format).
                                 'tMinE:' (target) for each position the 
                                minimal energy of any interaction covering the 
                                position (CSV format)
                                 'tSpotProb:' (target) for each position the 
                                probability that is is covered by an 
                                interaction covering (CSV format)
                                 'tAcc:' (target) ED accessibility values 
                                ('tPu'-like format).
                                 'tPu:' (target) unpaired probabilities values 
                                (RNAplfold format).
                                 'pMinE:' (target+query) for each index pair 
                                the minimal energy of any interaction covering 
                                the pair (CSV format)
                                 'spotProb:' (target+query) tracks for a given 
                                set of interaction spots their probability to 
                                be covered by an interaction. If no spots are 
                                provided, probabilities for all index 
                                combinations are computed. Spots are encoded by
                                comma-separated 'idxT&idxQ' pairs 
                                (target-query). For each spot a probability is 
                                provided in concert with the probability that 
                                none of the spots (encoded by '0&0') is covered
                                (CSV format). The spot encoding is followed 
                                colon-separated by the output stream/file name,
                                eg. '--out="spotProb:3&76,59&2:STDERR"'. NOTE: 
                                value has to be quoted due to '&' symbol!
                                For each, provide a file name or STDOUT/STDERR 
                                to write to the respective output stream.
  --outSep arg (=;)             column separator to be used in tabular CSV 
                                output
  --outMode arg (=N)            output mode :
                                 'N' normal output (ASCII char + energy),
                                 'D' detailed output (ASCII char + 
                                energy/position details),
                                 'C' CSV output (see --outCsvCols),
                                 'E' ensemble information
  -n [ --outNumber ] arg (=1)   number of (sub)optimal interactions to report 
                                (arg in range [0,1000])
  --outOverlap arg (=B)         suboptimal output : interactions can overlap 
                                 'N' in none of the sequences, 
                                 'T' in the target only, 
                                 'Q' in the query only, 
                                 'B' in both sequences

General:
  --threads arg (=1)            maximal number of threads to be used for 
                                parallel computation of query-target 
                                combinations. A value of 0 requests all 
                                available CPUs. Note, the number of threads 
                                multiplies the required memory used for 
                                computation! (arg in range [0,20])
  --version                     print version
  --personality arg             IntaRNA personality to be used, which defines 
                                default values, available program arguments and
                                tool behavior
  --parameterFile arg           file from where to read additional command line
                                arguments
  -h [ --help ]                 show the help page for basic parameters
  --fullhelp                    show the extended help page for all available 
                                parameters

Run --fullhelp for the extended list of parameters


############################################################################

Note, you are using the 'IntaRNAens' personality, which alters some default values!

############################################################################

You can find more detailed documentation of IntaRNA on 

  https://backofenlab.github.io/IntaRNA/
```

