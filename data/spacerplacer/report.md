# spacerplacer CWL Generation Report

## spacerplacer

### Tool Description
SpacerPlacer: An Ancestral Reconstruction Algorithm for CRISPR Arrays

### Metadata
- **Docker Image**: quay.io/biocontainers/spacerplacer:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/fbaumdicker/SpacerPlacer
- **Package**: https://anaconda.org/channels/bioconda/packages/spacerplacer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/spacerplacer/overview
- **Total Downloads**: 119
- **Last updated**: 2025-04-24
- **GitHub**: https://github.com/fbaumdicker/SpacerPlacer
- **Stars**: N/A
### Original Help Text
```text
usage: spacerplacer [-h] [--verbosity {0,1,2}] [--seed SEED]
                    [--tree_path TREE_PATH]
                    [-it {spacer_fasta,sf,pickled,ccdb,crisprcasdb,ccf_json,crisprcasfinder_json}]
                    [--cluster_spacers]
                    [--cluster_spacers_max_distance CLUSTER_SPACERS_MAX_DISTANCE]
                    [--min_evidence_level MIN_EVIDENCE_LEVEL]
                    [--rec_model {gtr}] [--insertion_rate INSERTION_RATE]
                    [--deletion_rate DELETION_RATE]
                    [--extend_branches EXTEND_BRANCHES]
                    [--tree_distance_function {likelihood}]
                    [--tree_construction_method {upgma,nj}]
                    [--tree_insertion_rate TREE_INSERTION_RATE]
                    [--tree_deletion_rate TREE_DELETION_RATE]
                    [--tree_alpha TREE_ALPHA]
                    [--tree_lh_fct {simple,ode_based}]
                    [--combine_non_unique_arrays] [--no_plot_reconstruction]
                    [--no_plot_order_graph] [--dpi_rec DPI_REC]
                    [--figsize_rec WIDTH HEIGHT {px, mm, in}]
                    [--show_spacer_name_row] [--do_show]
                    [--lh_fct {simple,ode_based}] [--no_alpha_bias_correction]
                    [--no_rho_bias_correction]
                    [--significance_level SIGNIFICANCE_LEVEL]
                    [--determine_orientation]
                    [--orientation_decision_boundary ORIENTATION_DECISION_BOUNDARY]
                    [--save_reconstructed_events]
                    input_path output_path

SpacerPlacer: An Ancestral Reconstruction Algorithm for CRISPR Arrays

positional arguments:
  input_path            Path to input file or folder containing input files.
                        The required input format is described in the readme.
  output_path           Path to output folder. The output folder will be
                        created, if it does not exist. The output folder will
                        contain files as described in the readme.

options:
  -h, --help            show this help message and exit
  --verbosity {0,1,2}   Verbosity level: 0: no output, 1: minimal output, 2:
                        maximal output (default 1).
  --seed SEED           Seed for the random number generator only impact on
                        MAFFT.
  --tree_path TREE_PATH
                        Path to tree json file or folder with newick files. If
                        none is provided, trees are estimated by SpacerPlacer.
                        The trees can be given in a newick format or as a
                        dictionary in a json file (such a json file is also
                        returned by SpacerPlacer).
  -it {spacer_fasta,sf,pickled,ccdb,crisprcasdb,ccf_json,crisprcasfinder_json}, --input_type {spacer_fasta,sf,pickled,ccdb,crisprcasdb,ccf_json,crisprcasfinder_json}
                        Determines the input type, i.e. either already
                        preprocessed fasta style spacer arrays, a pickled file
                        with CRISPR group(s) (our own data structure), DNA
                        data (extracted from CRISPRCasdb) in a structure
                        described in the github repository or directly from
                        result.json files returned by CRISPRCasFinder.
  --cluster_spacers     If given, the spacers of the input data are clustered
                        (using levenshtein distance).The clustering process is
                        described in the paper.
  --cluster_spacers_max_distance CLUSTER_SPACERS_MAX_DISTANCE
                        Determines the maximum Levenshtein distance for
                        spacers to be clustered, i.e. identified with each
                        other (same spacer id) within repeat groups.
  --min_evidence_level MIN_EVIDENCE_LEVEL
                        Determines the minimum evidence level for the
                        CRISPRCasFinder results to be included in the
                        reconstruction. The evidence level is given in the
                        CRISPRCasFinder output. The default (4) is the highest
                        possible value.
  --rec_model {gtr}     Determines the reconstruction model. Currently
                        redundant, as only "gtr" is implemented.
  --insertion_rate INSERTION_RATE
                        Insertion rate of the reconstruction model. Generally
                        should be chosen to be small compared to the deletion
                        rate. Otherwise may lead to high number of independent
                        acquisitions and worse reconstructions. The ratio
                        between insertion and deletion rate can be tuned in
                        case of reconstructions with excessive independent
                        acquisitions or excessive accumulations of insertions
                        at the root. Default insertion and deletion rates are
                        provided and work well for the tested datasets.
  --deletion_rate DELETION_RATE
                        Deletion rate of the reconstruction model. Generally
                        should be chosen to be large compared to the insertion
                        rate. Otherwise may lead to high number of independent
                        acquisitions and worse reconstructions. The ratio
                        between insertion and deletion rate can be tuned in
                        case of reconstructions with excessive independent
                        acquisitions or excessive accumulations of insertions
                        at the root. Default insertion and deletion rates are
                        provided and work well for the tested datasets.
  --extend_branches EXTEND_BRANCHES
                        Extends branches of the tree by the given value. This
                        is useful, if the tree is not well resolved to allow
                        placement of events on small (or length=0) branches.
  --tree_distance_function {likelihood}
                        Determines the distance function used for the tree
                        estimation with UPGMA. Currently redundant, as only
                        "likelihood" is implemented.
  --tree_construction_method {upgma,nj}
                        Determines the tree construction method used for the
                        tree estimation. Currently UPGMA (upgma) and neighbor
                        joining (nj) are implemented.
  --tree_insertion_rate TREE_INSERTION_RATE
                        The user can provide their own insertion rate for the
                        tree estimation based on the block deletion likelihood
                        function. In the default case, well performing
                        parameters are chosen depending on the used likelihood
                        function ("simple", "ode_based").
  --tree_deletion_rate TREE_DELETION_RATE
                        The user can provide their own deletion rate for the
                        tree estimation based on the block deletion likelihood
                        function. In the default case, well performing
                        parameters are chosen depending on the used likelihood
                        function ("simple", "ode_based").
  --tree_alpha TREE_ALPHA
                        The user can provide their own deletion rate for the
                        tree estimation based on the block deletion likelihood
                        function. In the default case, well performing
                        parameters are chosen depending on the used likelihood
                        function ("simple", "ode_based").
  --tree_lh_fct {simple,ode_based}
                        Determines the likelihood function used for the tree
                        estimation with UPGMA. Details about the likelihood
                        functions can be found in the paper. The default
                        "simple" has been found to perform better in
                        simulations.
  --combine_non_unique_arrays
                        If given, arrays with the exactly the same spacer
                        content are combined before the tree estimation and
                        reconstruction. This might be helpful reduce clutter
                        (especially in visualization).Arrays with the same
                        spacer content can not be separated in the tree
                        estimation anyway. The default is NOT to combine
                        arrays with the same spacer content. If arrays are
                        combined, the combined array names are saved in
                        detailed results csv under column "combined array
                        names".
  --no_plot_reconstruction
                        If given, the reconstruction is not plotted.
  --no_plot_order_graph
                        If given, the Partial Spacer Insertion Order is not
                        plotted.
  --dpi_rec DPI_REC     DPI for the reconstruction plot pdf. Default is 90.
  --figsize_rec WIDTH HEIGHT {px, mm, in}
                        Provide the width and height of the reconstruction
                        plot in the provided unit "px" (pixel), "mm"
                        (millimeter) or "in" (inches). By default the size is
                        determined by the drawing function.
  --show_spacer_name_row
                        If given, the spacer original names are shown in the
                        reconstruction plot (above the alignment and the
                        respective spacer ids). This can be useful for
                        detailed analysis of the reconstruction. By default
                        the spacer names are shown.
  --do_show             If given, the plots are shown directly. Might lead to
                        crash due to some issue with pyqt5.
  --lh_fct {simple,ode_based}
                        Determines the likelihood function used for the Block
                        deletion model estimates and the likelihood ratio
                        test. "simple" allows bias corrections in rho and
                        alpha and was found to perform better in simulations.
                        "ode_based" is the less performant, but, in theory,
                        more precise likelihood function.
  --no_alpha_bias_correction
                        If given, omits the alpha bias correction. Best
                        performance is achieved with the bias correction. Bias
                        correction is only possible, if simple likelihood
                        function is used.
  --no_rho_bias_correction
                        If given, omits the rho bias correction. Best
                        performance is achieved with the bias correction. Bias
                        correction is only possible, if simple likelihood
                        function is used.
  --significance_level SIGNIFICANCE_LEVEL
                        Determines the significance level for the likelihood
                        ratio test between the Independent Deletion Model and
                        the Block Deletion Model. The test statistic
                        (-2*ln(lh_idm/ln_bdm) = 2*ln(lh_bdm - ln_idm) is chi-
                        squared distributed with one single degree of freedom
                        by Wilks' Theorem.
  --determine_orientation
                        If given, both a forward and a reverse reconstruction
                        is made and the orientation of the arrays is
                        determined by SpacerPlacer. Otherwise, the orientation
                        is accepted as provided. Note, if the tree is
                        estimated by SpacerPlacer, a separate tree ist
                        estimated for the reversed array, i.e. the trees
                        between forward and reverse orientation might differ.
  --orientation_decision_boundary ORIENTATION_DECISION_BOUNDARY
                        Determines the decision boundary for the orientation
                        decision. If the modulus of the difference between the
                        likelihoods of the two orientations is smaller than
                        the decision boundary, the orientation is set to "not
                        determined" (ND). Otherwise, the orientation is set to
                        the orientation with the higher likelihood. The
                        decision boundary is given in logscale.The default
                        value 5 was determined empirically and works well for
                        the tested datasets.
  --save_reconstructed_events
                        If given, the tree and reconstructed events along the
                        tree are saved in "reconstructed_events". On the basis
                        of this data, the reconstruction is visualized and the
                        events can be analyzed in more detail. Currently only
                        works, if the the reconstruction is visualized.
```

