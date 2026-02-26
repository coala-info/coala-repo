# cath-tools CWL Generation Report

## cath-tools_cath-ssap

### Tool Description
Run a SSAP pairwise structural alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/cath-tools:0.16.5--h78a066a_0
- **Homepage**: https://github.com/UCLOrengoGroup/cath-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cath-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cath-tools/overview
- **Total Downloads**: 11.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/UCLOrengoGroup/cath-tools
- **Stars**: N/A
### Original Help Text
```text
Usage: cath-ssap [options] <protein1> <protein2>

Run a SSAP pairwise structural alignment
[algorithm devised by C A Orengo and W R Taylor, see --citation-help]

cath-ssap uses two types of structural comparison:
  1. Fast SSAP: a quick secondary-structure based SSAP alignment
  2. Slow SSAP: residue alignment only

If both structures have more than one SS element, a fast SSAP is run first. If the fast SSAP score isn't good, another fast SSAP is run with looser cutoffs. If the (best) fast SSAP score isn't good, a slow SSAP is run. Only the best of these scores is output. These behaviours can be configured using the parameters below.)

Miscellaneous:
  -h [ --help ]                            Output help message
  -v [ --version ]                         Output version information

Standard SSAP options:
  --debug                                  Output debugging information
  -o [ --outfile ] <file>                  [DEPRECATED] Output scores to <file> rather than to stdout
  --clique-file <file>                     Read clique from <file>
  --domin-file <file>                      Read domin from <file>
  --max-score-to-fast-rerun <score> (=65)  Run a second fast SSAP with looser cutoffs if the first fast SSAP's score falls below <score>
  --max-score-to-slow-rerun <score> (=75)  Perform a slow SSAP if the (best) fast SSAP score falls below <score>
  --slow-ssap-only                         Don't try any fast SSAPs; only use slow SSAP
  --local-ssap-score                       [DEPRECATED] Normalise the SSAP score over the length of the smallest domain rather than the largest
  --all-scores                             [DEPRECATED] Output all SSAP scores from fast and slow runs, not just the highest
  --prot-src-files <set> (=PDB)            Read the protein data from the set of files <set>, of available sets:
                                           PDB, PDB_DSSP, PDB_DSSP_SEC, WOLF_SEC
  --supdir <dir>                           [DEPRECATED] Output a superposition to directory <dir>
  --aligndir <dir> (=".")                  Write alignment to directory <dir>
  --min-score-for-files <score> (=0)       Only output alignment/superposition files if the SSAP score exceeds <score>
  --min-sup-score <score> (=-0.25)         [DEPRECATED] Calculate superposition based on the residue-pairs with scores greater than <score>
  --rasmol-script                          [DEPRECATED] Write a rasmol superposition script to load and colour the superposed structures
  --xmlsup                                 [DEPRECATED] Write a small xml superposition file, from which a larger superposition file can be reconstructed

Conversion between a protein's name and its data files:
  --pdb-path <path> (=.)                   Search for PDB files using the path <path>
  --dssp-path <path> (=.)                  Search for DSSP files using the path <path>
  --wolf-path <path> (=.)                  Search for wolf files using the path <path>
  --sec-path <path> (=.)                   Search for sec files using the path <path>
  --pdb-prefix <pre>                       Prepend the prefix <pre> to a protein's name to form its PDB filename
  --dssp-prefix <pre>                      Prepend the prefix <pre> to a protein's name to form its DSSP filename
  --wolf-prefix <pre>                      Prepend the prefix <pre> to a protein's name to form its wolf filename
  --sec-prefix <pre>                       Prepend the prefix <pre> to a protein's name to form its sec filename
  --pdb-suffix <suf>                       Append the suffix <suf> to a protein's name to form its PDB filename
  --dssp-suffix <suf> (=.dssp)             Append the suffix <suf> to a protein's name to form its DSSP filename
  --wolf-suffix <suf> (=.wolf)             Append the suffix <suf> to a protein's name to form its wolf filename
  --sec-suffix <suf> (=.sec)               Append the suffix <suf> to a protein's name to form its sec filename

Regions:
  --align-regions <regions>                Handle region(s) <regions> as the alignment part of the structure.
                                           May be specified multiple times, in correspondence with the structures.
                                           Format is: D[5inwB02]251-348:B,408-416A:B
                                           (Put <regions> in quotes to prevent the square brackets confusing your shell ("No match"))

Detailed help:
  --alignment-help                         Help on alignment format
  --citation-help                          Help on SSAP authorship & how to cite it
  --scores-help                            Help on scores format

Please tell us your cath-tools bugs/suggestions : https://github.com/UCLOrengoGroup/cath-tools/issues/new
```


## cath-tools_cath-resolve-hits

### Tool Description
Collapse a list of domain matches to your query sequence(s) down to the non-overlapping subset (ie domain architecture) that maximises the sum of the hits' scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/cath-tools:0.16.5--h78a066a_0
- **Homepage**: https://github.com/UCLOrengoGroup/cath-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cath-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cath-resolve-hits [options] <input_file>

Collapse a list of domain matches to your query sequence(s) down to the
non-overlapping subset (ie domain architecture) that maximises the sum of the
hits' scores.

When <input_file> is -, the input is read from standard input.

The input data may contain unsorted hits for different query protein sequences.

However, if your input data is already grouped by query protein sequence, then
specify the --input-hits-are-grouped flag for faster runs that use less memory.

Miscellaneous:
  -h [ --help ]                                  Output help message
  -v [ --version ]                               Output version information

Input:
  --input-format <format> (=raw_with_scores)     Parse the input data from <format>, one of available formats:
                                                    hmmer_domtblout  - HMMER domtblout format (must assume all hits are continuous)
                                                    hmmscan_out      - HMMER hmmscan output format (can be used to deduce discontinuous hits)
                                                    hmmsearch_out    - HMMER hmmsearch output format (can be used to deduce discontinuous hits)
                                                    raw_with_scores  - "raw" format with scores
                                                    raw_with_evalues - "raw" format with evalues
  --min-gap-length <length> (=30)                When parsing starts/stops from alignment data, ignore gaps of less than <length> residues
  --input-hits-are-grouped                       Rely on the input hits being grouped by query protein
                                                 (so the run is faster and uses less memory)

Segment overlap/removal:
  --overlap-trim-spec <trim> (=30/10)            Allow different hits' segments to overlap a bit by trimming all segments using spec <trim>
                                                 of the form n/m (n is a segment length; m is the *total* length to be trimmed off both ends)
                                                 For longer segments, total trim stays at m; for shorter, it decreases linearly (to 0 for length 1).
                                                 To choose: set m to the biggest total trim you'd want for a really long segment;
                                                            then, set n to length of the shortest segment you'd want to have that total trim
  --min-seg-length <length> (=7)                 Ignore all segments that are fewer than <length> residues long

Hit preference:
  --long-domains-preference <val> (=0)           Prefer longer hits to degree <val>
                                                 (<val> may be negative to prefer shorter; 0 leaves scores unaffected)
  --high-scores-preference <val> (=0)            Prefer higher scores to degree <val>
                                                 (<val> may be negative to reduce preference for higher scores; 0 leaves scores unaffected)
  --apply-cath-rules                             [DEPRECATED] Apply rules specific to CATH-Gene3D during the parsing and processing
  --naive-greedy                                 Use a naive, greedy approach to resolving (not recommended except for comparison)

Hit filtering:
  --worst-permissible-evalue <evalue> (=0.001)   Ignore any hits with an evalue worse than <evalue>
  --worst-permissible-bitscore <bitscore> (=10)  Ignore any hits with a bitscore worse than <bitscore>
  --worst-permissible-score <score>              Ignore any hits with a score worse than <score>
  --filter-query-id <id>                         Ignore all input data except that for query protein(s) <id>
                                                 (may be specified multiple times for multiple query proteins)
  --limit-queries [=<num>(=1)]                   Only process the first <num> query protein(s) encountered in the input data

Output ([...]-to-file options may be specified multiple times):
  --hits-text-to-file <file>                     Write the resolved hits in plain text to file <file>
  --quiet                                        Suppress the default output of resolved hits in plain text to stdout
  --output-trimmed-hits                          When writing out the final hits, output the hits' starts/stop as they are *after trimming*
  --summarise-to-file <file>                     Write a brief text summary of the input data to file <file> (or '-' for stdout)
  --html-output-to-file <file>                   Write the results as HTML to file <file> (or '-' for stdout)
  --json-output-to-file <file>                   Write the results as JSON to file <file> (or '-' for stdout)
  --export-css-file <file>                       Export the CSS used in the HTML output to <file> (or '-' for stdout)

HTML:
  --restrict-html-within-body                    Restrict HTML output to the contents of the body tag.
                                                 The contents should be included inside a body tag of class crh-body
  --html-max-num-non-soln-hits <num> (=80)       Only display up to <num> non-solution hits in the HTML
  --html-exclude-rejected-hits                   Exclude hits rejected by the score filters from the HTML

Detailed help:
  --cath-rules-help                              Show help on the rules activated by the (DEPRECATED) --apply-cath-rules option
  --raw-format-help                              Show help about the raw input formats (raw_with_scores and raw_with_evalues)

The standard output is one line per selected hit, preceded by header lines (beginning "#"), the last of which (beginning "#FIELDS") lists the fields in the file, typically:
  #FIELDS query-id match-id score boundaries resolved
(`boundaries` and `resolved` describe a domain's starts / stops; `resolved` may include adjustments made to resolve overlaps between hits)

Please tell us your cath-tools bugs/suggestions : https://github.com/UCLOrengoGroup/cath-tools/issues/new
```


## cath-tools_cath-superpose

### Tool Description
Superpose protein structures using an existing alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/cath-tools:0.16.5--h78a066a_0
- **Homepage**: https://github.com/UCLOrengoGroup/cath-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cath-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cath-superpose alignment_source pdb_file_source [superposition_outputs]

Superpose protein structures using an existing alignment

Please specify:
 * at most one superposition JSON or alignment (default: --do-the-ssaps)
 * one method of reading PDB files (number to match the alignment)

PyMOL is started if no alignment or superposition output option is specified

Miscellaneous:
  -h [ --help ]                            Output help message
  -v [ --version ]                         Output version information

[1mInput[0m:

Alignment source:
  --res-name-align                         Align residues by simply matching their names (numbers+insert)
                                           (for multiple models of the same structure)
  --fasta-aln-infile <file>                Read FASTA alignment from file <file>
  --ssap-aln-infile <file>                 Read SSAP alignment from file <file>
  --cora-aln-infile <file>                 Read CORA alignment from file <file>
  --ssap-scores-infile <file>              Glue pairwise alignments together using SSAP scores in file <file>
                                           Assumes all .list alignment files in same directory
  --do-the-ssaps [=<dir>(="")]             Do the required SSAPs in directory <dir>; use results as with --ssap-scores-infile
                                           Use a suitable temp directory if none is specified

Alignment refining:
  --align-refining <refn> (=NO)            Apply <refn> refining to the alignment, one of available values:
                                              NO    - Don't refine the alignment
                                              LIGHT - Refine any alignments with few entries; glue alignments one more entry at a time
                                              HEAVY - Perform heavy (slow) refining on the alignment, including when gluing alignments together
                                           This can change the method of gluing alignments under --ssap-scores-infile and --do-the-ssaps

Superposition source:
  --json-sup-infile <file>                 Read superposition from file <file>

ID options:
  --id arg                                 Structure ids

PDB files source:
  --pdb-infile <pdbfile>                   Read PDB from file <pdbfile> (may be specified multiple times)
  --pdbs-from-stdin                        Read PDBs from stdin (separated by line: "END   ")

Regions:
  --align-regions <regions>                Handle region(s) <regions> as the alignment part of the structure.
                                           May be specified multiple times, in correspondence with the structures.
                                           Format is: D[5inwB02]251-348:B,408-416A:B
                                           (Put <regions> in quotes to prevent the square brackets confusing your shell ("No match"))

[1mOutput[0m:

Alignment output:
  --aln-to-cath-aln-file arg               [EXPERIMENTAL] Write the alignment to a CATH alignment file
  --aln-to-cath-aln-stdout                 [EXPERIMENTAL] Print the alignment to stdout in CATH alignment format
  --aln-to-fasta-file arg                  Write the alignment to a FASTA file
  --aln-to-fasta-stdout                    Print the alignment to stdout in FASTA format
  --aln-to-ssap-file arg                   Write the alignment to a SSAP file
  --aln-to-ssap-stdout                     Print the alignment to stdout as SSAP
  --aln-to-html-file arg                   Write the alignment to a HTML file
  --aln-to-html-stdout                     Print the alignment to stdout as HTML

Superposition output:
  --sup-to-pdb-file arg                    Write the superposed structures to a single PDB file arg, separated using faked chain codes
  --sup-to-pdb-files-dir arg               Write the superposed structures to separate PDB files in directory arg
  --sup-to-stdout                          Print the superposed structures to stdout, separated using faked chain codes
  --sup-to-pymol                           Start up PyMOL for viewing the superposition
  --pymol-program arg (="pymol")           Use arg as the PyMOL executable for viewing; may optionally include the full path
  --sup-to-pymol-file arg                  Write the superposition to a PyMOL script arg
                                           (Recommended filename extension: .pml)
  --sup-to-json-file arg                   Write the superposition to JSON superposition file
                                           (Recommended filename extension: .sup_json)

Viewer (eg PyMOL, Jmol etc) options:
  --viewer-colours <colrs>                 Use <colrs> to colour successive entries in the viewer
                                           (format: colon-separated list of comma-separated triples of RGB values between 0 and 1)
                                           (will wrap-around when it runs out of colours)
  --gradient-colour-alignment              Colour the length of the alignment with a rainbow gradient (blue -> red)
  --show-scores-if-present                 Show the alignment scores
                                           (use with gradient-colour-alignment)
  --scores-to-equivs                       Show the alignment scores to equivalent positions, which increases relative scores where few entries are aligned
                                           (use with --gradient-colour-alignment and --show-scores-if-present)
  --normalise-scores                       When showing scores, normalise them to the highest score in the alignment
                                           (use with --gradient-colour-alignment and --show-scores-if-present)

Superposition content:
  --regions-context <context> (=alone)     Show the alignment regions in the context <context>, one of available options:
                                              alone    - alone
                                              in_chain - within the chain(s) in which the regions appear
                                              in_pdb   - within the PDB in which the regions appear
  --show-dna-within-dist <dist> (=4)       Show DNA within <dist>Å of the alignment regions
  --show-organic-within-dist <dist> (=10)  Show organic molecules within <dist>Å of the alignment regions

Usage examples:
 * cath-superpose --ssap-aln-infile 1cukA1bvsA.list --pdb-infile $PDBDIR/1cukA --pdb-infile $PDBDIR/1bvsA --sup-to-pymol
     (Superpose 1cukA and 1bvsA (in directory $PDBDIR) based on SSAP alignment file 1cukA1bvsA.list and then display in PyMOL)
 * cat pdb1 end_file pdb2 end_file pdb3 | cath-superpose --pdbs-from-stdin --sup-to-stdout --res-name-align
     (Superpose the structures from stdin based on matching residue names and then write them to stdout [common Genome3D use case])

Please tell us your cath-tools bugs/suggestions : https://github.com/UCLOrengoGroup/cath-tools/issues/new
```


## cath-tools_cath-cluster

### Tool Description
Cluster items based on the links between them.

### Metadata
- **Docker Image**: quay.io/biocontainers/cath-tools:0.16.5--h78a066a_0
- **Homepage**: https://github.com/UCLOrengoGroup/cath-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cath-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cath-cluster --link-dirn <dirn> --levels <levels> [options] <input_file>

Cluster items based on the links between them.

When <input_file> is -, the links are read from standard input.

The clustering is complete-linkage.

Miscellaneous:
  -h [ --help ]                 Output help message
  -v [ --version ]              Output version information

Input:
  --link-dirn <dirn>            Interpret each link value as <dirn>, one of:
                                   DISTANCE - A higher value means the corresponding two entries are more distant
                                   STRENGTH - A higher value means the corresponding tow entries are more connected
  --column-idx <colnum> (=3)    Parse the link values (distances/strengths) from column number <colnum>
                                Must be ≥ 3 because columns 1 and 2 must contain the IDs
  --names-infile <file>         [RECOMMENDED] Read names and sorting scores from file <file> (or '-' for stdin)

Clustering:
  --levels <levels>             Cluster at levels <levels>, which is ordered values separated by commas (eg 35,60,95,100)

Output:
  --clusters-to-file <file>     Write the clustering to file <file> (or '-' for stdout)
  --merges-to-file <file>       Write the ordered list of merges to file <file> (or '-' for stdout)
  --clust-spans-to-file <file>  Write links that form spanning trees for each cluster to file <file> (or '-' for stdout)
  --reps-to-file <file>         Write the list of representatives to file <file> (or '-' for stdout)

Links input format: `id1 id2 other columns afterwards`
...where --column-idx can be used to specify the column that contains the values

Names input format: `id score`
...where score is used to sort such that lower-scored entries appear earlier

Please tell us your cath-tools bugs/suggestions : https://github.com/UCLOrengoGroup/cath-tools/issues/new
```


## cath-tools_cath-refine-align

### Tool Description
Iteratively refine an existing alignment by attempting to optimise SSAP score

### Metadata
- **Docker Image**: quay.io/biocontainers/cath-tools:0.16.5--h78a066a_0
- **Homepage**: https://github.com/UCLOrengoGroup/cath-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cath-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cath-refine-align alignment_source protein_file_source [superposition_outputs]

Iteratively refine an existing alignment by attempting to optimise SSAP score

Please specify:
 * at most one alignment (default: --do-the-ssaps)
 * one method of reading proteins (number of proteins currently restricted to 2)

PyMOL is started if no alignment or superposition output option is specified

Miscellaneous:
  -h [ --help ]                      Output help message
  -v [ --version ]                   Output version information

[1mInput[0m:

Alignment source:
  --res-name-align                   Align residues by simply matching their names (numbers+insert)
                                     (for multiple models of the same structure)
  --fasta-aln-infile <file>          Read FASTA alignment from file <file>
  --ssap-aln-infile <file>           Read SSAP alignment from file <file>
  --cora-aln-infile <file>           Read CORA alignment from file <file>
  --ssap-scores-infile <file>        Glue pairwise alignments together using SSAP scores in file <file>
                                     Assumes all .list alignment files in same directory
  --do-the-ssaps [=<dir>(="")]       Do the required SSAPs in directory <dir>; use results as with --ssap-scores-infile
                                     Use a suitable temp directory if none is specified

Alignment refining:
  --align-refining <refn> (=HEAVY)   Apply <refn> refining to the alignment, one of available values:
                                        NO    - Don't refine the alignment
                                        LIGHT - Refine any alignments with few entries; glue alignments one more entry at a time
                                        HEAVY - Perform heavy (slow) refining on the alignment, including when gluing alignments together
                                     This can change the method of gluing alignments under --ssap-scores-infile and --do-the-ssaps

ID options:
  --id arg                           Structure ids

PDB files source:
  --pdb-infile <pdbfile>             Read PDB from file <pdbfile> (may be specified multiple times)
  --pdbs-from-stdin                  Read PDBs from stdin (separated by line: "END   ")

Regions:
  --align-regions <regions>          Handle region(s) <regions> as the alignment part of the structure.
                                     May be specified multiple times, in correspondence with the structures.
                                     Format is: D[5inwB02]251-348:B,408-416A:B
                                     (Put <regions> in quotes to prevent the square brackets confusing your shell ("No match"))

[1mOutput[0m:

Alignment output:
  --aln-to-cath-aln-file arg         [EXPERIMENTAL] Write the alignment to a CATH alignment file
  --aln-to-cath-aln-stdout           [EXPERIMENTAL] Print the alignment to stdout in CATH alignment format
  --aln-to-fasta-file arg            Write the alignment to a FASTA file
  --aln-to-fasta-stdout              Print the alignment to stdout in FASTA format
  --aln-to-ssap-file arg             Write the alignment to a SSAP file
  --aln-to-ssap-stdout               Print the alignment to stdout as SSAP
  --aln-to-html-file arg             Write the alignment to a HTML file
  --aln-to-html-stdout               Print the alignment to stdout as HTML

Superposition output:
  --sup-to-pdb-file arg              Write the superposed structures to a single PDB file arg, separated using faked chain codes
  --sup-to-pdb-files-dir arg         Write the superposed structures to separate PDB files in directory arg
  --sup-to-stdout                    Print the superposed structures to stdout, separated using faked chain codes
  --sup-to-pymol                     Start up PyMOL for viewing the superposition
  --pymol-program arg (="pymol")     Use arg as the PyMOL executable for viewing; may optionally include the full path
  --sup-to-pymol-file arg            Write the superposition to a PyMOL script arg
                                     (Recommended filename extension: .pml)
  --sup-to-json-file arg             Write the superposition to JSON superposition file
                                     (Recommended filename extension: .sup_json)

Viewer (eg PyMOL, Jmol etc) options:
  --viewer-colours <colrs>           Use <colrs> to colour successive entries in the viewer
                                     (format: colon-separated list of comma-separated triples of RGB values between 0 and 1)
                                     (will wrap-around when it runs out of colours)
  --gradient-colour-alignment        Colour the length of the alignment with a rainbow gradient (blue -> red)
  --show-scores-if-present           Show the alignment scores
                                     (use with gradient-colour-alignment)
  --scores-to-equivs                 Show the alignment scores to equivalent positions, which increases relative scores where few entries are aligned
                                     (use with --gradient-colour-alignment and --show-scores-if-present)
  --normalise-scores                 When showing scores, normalise them to the highest score in the alignment
                                     (use with --gradient-colour-alignment and --show-scores-if-present)

Please tell us your cath-tools bugs/suggestions : https://github.com/UCLOrengoGroup/cath-tools/issues/new
```


## cath-tools_cath-score-align

### Tool Description
Score an existing alignment using structural data

### Metadata
- **Docker Image**: quay.io/biocontainers/cath-tools:0.16.5--h78a066a_0
- **Homepage**: https://github.com/UCLOrengoGroup/cath-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cath-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cath-score-align alignment_source protein_file_source [superposition_outputs]

Score an existing alignment using structural data

Please specify:
 * at most one alignment (default: --do-the-ssaps)
 * one method of reading proteins (number of proteins currently restricted to 2

Miscellaneous:
  -h [ --help ]                   Output help message
  -v [ --version ]                Output version information

Alignment source:
  --res-name-align                Align residues by simply matching their names (numbers+insert)
                                  (for multiple models of the same structure)
  --fasta-aln-infile <file>       Read FASTA alignment from file <file>
  --ssap-aln-infile <file>        Read SSAP alignment from file <file>
  --cora-aln-infile <file>        Read CORA alignment from file <file>
  --ssap-scores-infile <file>     Glue pairwise alignments together using SSAP scores in file <file>
                                  Assumes all .list alignment files in same directory
  --do-the-ssaps [=<dir>(="")]    Do the required SSAPs in directory <dir>; use results as with --ssap-scores-infile
                                  Use a suitable temp directory if none is specified

Alignment refining:
  --align-refining <refn> (=NO)   Apply <refn> refining to the alignment, one of available values:
                                     NO    - Don't refine the alignment
                                     LIGHT - Refine any alignments with few entries; glue alignments one more entry at a time
                                     HEAVY - Perform heavy (slow) refining on the alignment, including when gluing alignments together
                                  This can change the method of gluing alignments under --ssap-scores-infile and --do-the-ssaps

PDB files source:
  --pdb-infile <pdbfile>          Read PDB from file <pdbfile> (may be specified multiple times)
  --pdbs-from-stdin               Read PDBs from stdin (separated by line: "END   ")

Please tell us your cath-tools bugs/suggestions : https://github.com/UCLOrengoGroup/cath-tools/issues/new
```

