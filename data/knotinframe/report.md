# knotinframe CWL Generation Report

## knotinframe

### Tool Description
predict ribosomal -1 frameshift sites with a simple pseudoknot as secondary structure in DNA and RNA sequences. The prediction is based on a comparison between the minimal free energy (mfe) structure calculated by an RNAfold [1] like program and the mfe-structure computed by a modified version of pKiss, called pknotsRG-frameshift [2].

### Metadata
- **Docker Image**: quay.io/biocontainers/knotinframe:2.3.2--h9948957_2
- **Homepage**: https://bibiserv.cebitec.uni-bielefeld.de/knotinframe
- **Package**: https://anaconda.org/channels/bioconda/packages/knotinframe/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/knotinframe/overview
- **Total Downloads**: 8.7K
- **Last updated**: 2025-09-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
# knotinframe: predict ribosomal -1 frameshift sites
#              version 2.2.0 (12.07.2024)
#              Stefan Janssen (bibi-help@techfak.uni-bielefeld.de)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

USAGE: 
perl knotinframe [-options] <fasta file name or RNA sequence>

  knotinframe is a pipeline to predict ribosomal -1 frameshift sites with a
  simple pseudoknot as secondary structure in DNA and RNA sequences. The
  prediction is based on a comparison between the minimal free energy (mfe)
  structure calculated by an RNAfold [1] like program and the mfe-structure
  computed by a modified version of pKiss, called pknotsRG-frameshift [2].

GENERAL OPTIONS:
  --numberOutputs <int> : Some sequences have a high amount of possible
                          slippery site candidates, thus output is cut off
                          after printing the best --numberOutputs results,
                          which is 10 by default.

  --windowSize <int> : If a slippery site is detected a sub-string downstream
                       is analysed. --windowSize sets the maximal length of
                       this sub-string, which is 120 by default. Must be a
                       multiple of --windowIncrement!

  --windowIncrement <int> : The --windowSize bp long sub-string, downstream to
                            the slippery site, is analysed in different chunks
                            sizes. These chunks grow with --windowIncrement bp.
                            Maximal size if --windowSize. Default value is 20.

  --minKnottedEnergy <float> : The pseudoknot structure induces the ribosomal
                               frame shift, thus it should have a stability of
                               at least -7.4 kcal/mol. Theis et al. [5] call
                               this the "low energy filter (LEF)" and the
                               parameter "alpha".

  --minEnergyDifference <float> : The candidate sub-sequence should be more
                                  likely fold a pseudoknot than a nested
                                  structure. Thus, candidates where (nested
                                  energy + --minEnergyDifference < knotted
                                  energy) are ruled out. Theis et al. [5] call
                                  this the "energy difference filter (EDF)" and
                                  the according parameter "beta". Default is
                                  -8.71 kcal/mol.

FOLDING OPTIONS:
  --temperature <float> : Rescale energy parameters to a temperature of temp C.
                          <float> must be a floating point number.
                          Default is 37 C.

  --param <paramfile> : Read energy parameters from paramfile, instead of using
                        the default parameter set. See the RNAlib (Vienna RNA
                        package) documentation for details on the file format.
                        Default are parameters released by the Turner group in
                        2004 (see [4] and [3]).

SYSTEM OPTIONS:
  --binPath <string> : knotinframe expects that according Bellman's GAP
                       compiled binaries are located in the same directory as
                       the Perl wrapper is. Should you moved them into another
                       directory, you must set --binPath to this new location!

  --binPrefix <string> : knotinframe expects a special naming schema for the
                         according Bellman's GAP compiled binaries. The binary
                         name is composed of two components:
                         1) the program prefix (on default "knotinframe_"),
                         2) the folding mode, i.e. "knotted" or "nested".
                         .
                         With --binPrefix you can change the prefix into some
                         arbitary one.

  --help : show this brief help on version and usage

  --verbose <int> : Prints the actual command for Bellman's GAP binary.

  --varna <string> : Provide a file name to which a HTML formatted version of
                     the output should be saved in.

REFERENCES:
[1] Ronny Lorenz, Stephan H Bernhart, Christian Hoener zu Siederdissen, Hakim
    Tafer, Christoph Flamm, Peter F Stadler, Ivo L Hofacker.
    "ViennaRNA Package 2.0."
    Algorithms Molecular Biology 2011. doi:10.1186/1748-7188-6-26.

[2] Corinna Theis, Stefan Janssen, Robert Giegerich
    "Prediction of RNA secondary structure including kissing hairpin motifs."
    Algorithms in Bioinformatics 2010. doi:10.1007/978-3-642-15294-8_5

[3] Douglas H Turner, David H Mathews.
    "NNDB: The nearest neighbor parameter database for predicting stability of
    nucleic acid secondary structure."
    Nucleic Acids Research 2009. doi:10.1093/nar/gkp892

[4] David H Mathews, Matthew D Disney, Jessica L Childs, Susan J Schroeder,
    Michael Zuker, Douglas H Turner.
    "Incorporating chemical modification constraints into a dynamic programming
    algorithm for prediction of RNA secondary structure."
    Proceedings of the National Academy of Sciences of the United States of
    America 2004. doi:10.1073/pnas.0401799101

[5] Corinna Theis, Jens Reeder, Robert Giegerich.
    "KnotInFrame: prediction of -1 ribosomal frameshift events."
    Nucleic Acids Research 2008. doi:10.1093/nar/gkn578

CITATION:
    If you use this program in your work you might want to cite:

[6] Stefan Janssen, Robert Giegerich.
    "The RNA shapes studio."
    Bioinformatics 2014. doi:10.1093/bioinformatics/btu649
```

