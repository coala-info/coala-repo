# pastml CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pastml | PASS |  |
| pastml_geomap | Failed | image problem: geomap crashes with numpy AttributeError (np.str was removed) in generate_geomap.py |
| pastml_name_tree | PASS |  |
| pastml_transition_counter | PASS |  |

## pastml

### Tool Description
Ancestral character reconstruction and visualisation for rooted phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/pastml:1.9.51--pyhdfd78af_0
- **Homepage**: https://pastml.pasteur.fr
- **Package**: https://anaconda.org/channels/bioconda/packages/pastml/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pastml/overview
- **Total Downloads**: 12.5K
- **Last updated**: 2025-04-29
- **GitHub**: https://github.com/evolbioinfo/pastml
- **Stars**: N/A
### Original Help Text
```text
usage: pastml [-h] -t TREE [-d DATA] [-s DATA_SEP] [-i ID_INDEX]
              [-c [COLUMNS ...]]
              [--prediction_method [{MPPA,MAP,JOINT,DOWNPASS,ACCTRAN,DELTRAN,COPY,ALL,ML,MP} ...]]
              [--forced_joint] [-m [{JC,F81,EFT,HKY,JTT,CUSTOM_RATES} ...]]
              [--parameters [PARAMETERS ...]]
              [--rate_matrix [RATE_MATRIX ...]] [--reoptimise] [--smoothing]
              [--frequency_smoothing] [-n NAME_COLUMN]
              [--root_date [ROOT_DATE ...]]
              [--tip_size_threshold TIP_SIZE_THRESHOLD]
              [--timeline_type {SAMPLED,NODES,LTT}] [--offline]
              [--colours [COLOURS ...]] [--focus [FOCUS ...]]
              [--resolve_polytomies] [-o OUT_DATA] [--work_dir WORK_DIR]
              [--html_compressed HTML_COMPRESSED] [--pajek PAJEK]
              [--pajek_timing {VERTICAL,HORIZONTAL,TRIM}] [--html HTML]
              [--html_mixed HTML_MIXED] [-v] [--version] [--threads THREADS]
              [--recursion_limit RECURSION_LIMIT] [--upload_to_itol]
              [--itol_id ITOL_ID] [--itol_project ITOL_PROJECT]
              [--itol_tree_name ITOL_TREE_NAME]

Ancestral character reconstruction and visualisation for rooted phylogenetic
trees.

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --threads THREADS     Number of threads PastML can use for parallesation. By
                        default detected automatically based on the system.
                        Note that PastML will at most use as many threads as
                        the number of characters (-c option) being analysed
                        plus one.
  --recursion_limit RECURSION_LIMIT
                        Set the recursion limit in python. If your tree is
                        very large and pastml produces an overflow error, you
                        could try to set the recursion limit to a large number
                        (e.g., 10000). By default the standard recursion limit
                        is used and should be sufficient for trees of up to
                        several thousand tips.

tree-related arguments:
  -t TREE, --tree TREE  input tree(s) in newick format (must be rooted).

annotation-file-related arguments:
  -d DATA, --data DATA  annotation file in tab/csv format with the first row
                        containing the column names. If not given, the
                        annotations should be contained in the tree file
                        itself.
  -s DATA_SEP, --data_sep DATA_SEP
                        column separator for the annotation table. By default
                        is set to tab, i.e. for a tab-delimited file. Set it
                        to ',' if your file is csv.
  -i ID_INDEX, --id_index ID_INDEX
                        index of the annotation table column containing tree
                        tip names, indices start from zero (by default is set
                        to 0).

ancestral-character-reconstruction-related arguments:
  -c [COLUMNS ...], --columns [COLUMNS ...]
                        names of the annotation table columns that contain
                        characters to be analysed. If not specified, all
                        columns are considered.
  --prediction_method [{MPPA,MAP,JOINT,DOWNPASS,ACCTRAN,DELTRAN,COPY,ALL,ML,MP} ...]
                        ancestral character reconstruction (ACR) method, can
                        be one of the max likelihood (ML) methods: JOINT, MAP,
                        MPPA, one of the max parsimony (MP) methods: DOWNPASS,
                        ACCTRAN, DELTRAN; or COPY to keep the annotated
                        character states as-is without inference. One can also
                        specify one of the meta-methods ALL, ML, MP that would
                        perform ACR with multiple methods (all of them for
                        ALL, all the ML methods for ML, or all the MP methods
                        for MP) and save/visualise the results as multiple
                        characters suffixed with the corresponding method.When
                        multiple ancestral characters are specified (see -c,
                        --columns), the same method can be used for all of
                        them (if only one method is specified), or different
                        methods can be used (specified in the same order as
                        -c, --columns). If multiple methods are given, but not
                        for all the characters, for the rest of them the
                        default method (MPPA) is chosen.
  --forced_joint        add JOINT state to the MPPA state selection even if it
                        is not selected by Brier score.
  -m [{JC,F81,EFT,HKY,JTT,CUSTOM_RATES} ...], --model [{JC,F81,EFT,HKY,JTT,CUSTOM_RATES} ...]
                        evolutionary model for ML methods (ignored by MP
                        methods). When multiple ancestral characters are
                        specified (see -c, --columns), the same model can be
                        used for all of them (if only one model is specified),
                        or different models can be used (specified in the same
                        order as -c, --columns). If multiple models are given,
                        but not for all the characters, for the rest of them
                        the default model (F81) is chosen.
  --parameters [PARAMETERS ...]
                        optional way to fix some of the ML-method parameters
                        by specifying files that contain them. Should be in
                        the same order as the ancestral characters (see -c,
                        --columns) for which the reconstruction is to be
                        preformed. Could be given only for the first few
                        characters. Each file should be tab-delimited, with
                        two columns: the first one containing parameter names,
                        and the second, named "value", containing parameter
                        values. Parameters can include character state
                        frequencies (parameter name should be the
                        corresponding state, and parameter value - the float
                        frequency value, between 0 and 1),tree branch scaling
                        factor (parameter name scaling_factor),and tree branch
                        smoothing factor (parameter name smoothing_factor),
  --rate_matrix [RATE_MATRIX ...]
                        (only for CUSTOM_RATES model) path to the file(s)
                        containing the rate matrix(ces). Should be in the same
                        order as the ancestral characters (see -c, --columns)
                        for which the reconstruction is to be preformed. Could
                        be given only for the first few characters. The rate
                        matrix file should specify character states in its
                        first line, preceded by # and separated by spaces. The
                        following lines should contain a symmetric squared
                        rate matrix with positive rates(and zeros on the
                        diagonal), separated by spaces, in the same order at
                        the character states specified in the first line.For
                        example, for four states, A, C, G, T and the rates
                        A<->C 1, A<->G 4, A<->T 1, C<->G 1, C<->T 4, G<->T
                        1,the rate matrix file would look like: # A C G T 0 1
                        4 1 1 0 1 4 4 1 0 1 1 4 1 0
  --reoptimise          if the parameters are specified, they will be
                        considered as an optimisation starting point instead
                        and optimised.
  --smoothing           Apply a smoothing factor (optimised) to branch lengths
                        during likelihood calculation.
  --frequency_smoothing
                        Apply a smoothing factor (optimised) to state
                        frequencies (given as input parameters, see
                        --parameters) during likelihood calculation. If the
                        selected model (--model) does not allow for frequency
                        optimisation, this option will be ignored. If
                        --reoptimise is also specified, the frequencies will
                        only be smoothed but not reoptimised.

visualisation-related arguments:
  -n NAME_COLUMN, --name_column NAME_COLUMN
                        name of the character to be used for node names in the
                        compressed map visualisation (must be one of those
                        specified via -c, --columns). If the annotation table
                        contains only one column it will be used by default.
  --root_date [ROOT_DATE ...]
                        date(s) of the root(s) (for dated tree(s) only), if
                        specified, used to visualise a timeline based on dates
                        (otherwise it is based on distances to root).
  --tip_size_threshold TIP_SIZE_THRESHOLD
                        recursively remove the tips of size less than
                        threshold-th largest tipfrom the compressed map (set
                        to 1e10 to keep all tips). The larger it is the less
                        tips will be trimmed.
  --timeline_type {SAMPLED,NODES,LTT}
                        type of timeline visualisation: at each date/distance
                        to root selected on the slider either (SAMPLED) - all
                        the lineages sampled after it are hidden; or (NODES) -
                        all the nodes with a more recent date/larger distance
                        to root are hidden; or (LTT) - all the nodes whose
                        branch started after this date/distance to root are
                        hidden, and the external branches are cut to the
                        specified date/distance to root if needed;
  --offline             By default (without --offline option) PastML assumes
                        that there is an internet connection available, which
                        permits it to fetch CSS and JS scripts needed for
                        visualisation online.With --offline option turned on,
                        PastML will store all the needed CSS/JS scripts in the
                        folder specified by --work_dir, so that internet
                        connection is not needed (but you must not move the
                        output html files to any location other that the one
                        specified by --html/--html_compressed).
  --colours [COLOURS ...]
                        optional way to specify the colours used for character
                        state visualisation. Should be in the same order as
                        the ancestral characters (see -c, --columns) for which
                        the reconstruction is to be preformed. Could be given
                        only for the first few characters. Each file should be
                        tab-delimited, with two columns: the first one
                        containing character states, and the second, named
                        "colour", containing colours, in HEX format (e.g.
                        #a6cee3).
  --focus [FOCUS ...]   optional way to put a focus on certain character state
                        values, so that the nodes in these states are
                        displayed even if they do not pass the trimming
                        threshold (--tip_size_threshold). Should be in the
                        form character:state.
  --resolve_polytomies  When specified, the polytomies with a state change
                        (i.e. a parent node, P, in state A has more than 2
                        children, including m > 1 children, C_1, ..., C_m, in
                        state B) are resolved by grouping together same-state
                        (different from the parent state) nodes (i.e. a new
                        internal node N in state B is created and becomes the
                        child of P and the parent of C_1, ..., C_m).

output-related arguments:
  -o OUT_DATA, --out_data OUT_DATA
                        path to the output annotation file with the
                        reconstructed ancestral character states.
  --work_dir WORK_DIR   path to the folder where pastml parameter, named tree
                        and marginal probability (for marginal ML methods
                        (MAP, MPPA) only) files are to be stored. Default is
                        <path_to_input_file>/<input_file_name>_pastml. If the
                        folder does not exist, it will be created.
  --html_compressed HTML_COMPRESSED
                        path to the output compressed map visualisation file
                        (html).
  --pajek PAJEK         path to the output vertically compressed visualisation
                        file (Pajek NET Format). Prooduced only if
                        --html_compressed is specified.
  --pajek_timing {VERTICAL,HORIZONTAL,TRIM}
                        the type of the compressed visualisation to be saved
                        in Pajek NET Format (if --pajek is specified). Can be
                        either VERTICAL (default, after the nodes underwent
                        vertical compression), HORIZONTAL (after the nodes
                        underwent vertical and horizontal compression) or TRIM
                        (after the nodes underwent vertical and horizontal
                        compression and minor node trimming)
  --html HTML           path to the output full tree visualisation file
                        (html).
  --html_mixed HTML_MIXED
                        path to the output mostly compressed map visualisation
                        file (html), where the nodes in states specified with
                        --focus are uncompressed.
  -v, --verbose         print information on the progress of the analysis (to
                        console)

iTOL-related arguments:
  --upload_to_itol      create iTOL annotations for the reconstructed
                        characters associated with the named tree (i.e. the
                        one found in --work_dir). If additionally --itol_id
                        and --itol_project are specified, the annotated tree
                        will be automatically uploaded to iTOL
                        (https://itol.embl.de/).
  --itol_id ITOL_ID     iTOL user batch upload ID that enables uploading to
                        your iTOL account (see
                        https://itol.embl.de/help.cgi#batch).
  --itol_project ITOL_PROJECT
                        iTOL project the annotated tree should be associated
                        with (must exist, and --itol_id must be specified). By
                        default set to 'Sample project'.
  --itol_tree_name ITOL_TREE_NAME
                        name for the tree uploaded to iTOL.
```

## pastml_geomap

### Tool Description
Visualisation of locations.

### Metadata
- **Docker Image**: quay.io/biocontainers/pastml:1.9.51--pyhdfd78af_0
- **Homepage**: https://github.com/evolbioinfo/pastml
- **Package**: https://anaconda.org/channels/bioconda/packages/pastml/overview
- **Validation**: PASS

### Original Help Text
```text
usage: geomap [-h] -d DATA [-s DATA_SEP] [-i ID_INDEX] -c COUNTRY -l LOCATION
              [-t TREE] [-o HTML] [--colours COLOURS]

Visualisation of locations.

options:
  -h, --help            show this help message and exit

annotation-related arguments:
  -d DATA, --data DATA  the annotation file in tab/csv format with the first
                        row containing the column names.
  -s DATA_SEP, --data_sep DATA_SEP
                        the column separator for the data table. By default is
                        set to tab, i.e. for tab file. Set it to ',' if your
                        file is csv.
  -i ID_INDEX, --id_index ID_INDEX
                        the index of the column in the data table that
                        contains the tree tip names, indices start from zero
                        (by default is set to 0).
  -c COUNTRY, --country COUNTRY
                        name of the data table column that contains countries.
  -l LOCATION, --location LOCATION
                        name of the data table column that contains locations
                        (to be mapped to colours).

tree-related arguments:
  -t TREE, --tree TREE  the input tree in newick format (to only consider ids
                        present in the tree).

output-related arguments:
  -o HTML, --html HTML  the output map visualisation file (html).
  --colours COLOURS     optional way to specify the colours used for location
                        visualisation. Should be a path to a tab-delimited
                        file, with two columns: the first one containing
                        possible locations, and the second, named "colour",
                        containing colours, in HEX format (e.g. #a6cee3).
```

## pastml_name_tree

### Tool Description
Name internal tree nodes as PastMl would.

### Metadata
- **Docker Image**: quay.io/biocontainers/pastml:1.9.51--pyhdfd78af_0
- **Homepage**: https://github.com/evolbioinfo/pastml
- **Package**: https://anaconda.org/channels/bioconda/packages/pastml/overview
- **Validation**: PASS

### Original Help Text
```text
usage: name_tree [-h] -i IN_TREE [-o OUT_TREE] [--root_date [ROOT_DATE ...]]
                 [-c [COLUMNS ...]] [--version]

Name internal tree nodes as PastMl would.

options:
  -h, --help            show this help message and exit
  -i IN_TREE, --in_tree IN_TREE
                        input tree(s) in newick or nexus format (must be
                        rooted).
  -o OUT_TREE, --out_tree OUT_TREE
                        path where to save the named output tree(s) in newick
                        format.
  --root_date [ROOT_DATE ...]
                        date(s) of the root(s) (for dated tree(s) only), if
                        specified, the corresponding dates will be added to
                        the tree node annotations.
  -c [COLUMNS ...], --columns [COLUMNS ...]
                        names of the annotation columns of the input tree (if
                        any) to be kept in the output tree. If there are
                        LSD2-like date-related columns (date and date_CI)
                        present in the tree, they will be kept in any case, so
                        no need to specify them among columns here.
  --version             show program's version number and exit
```

## pastml_transition_counter

### Tool Description
Transition counting for PastML ACR

### Metadata
- **Docker Image**: quay.io/biocontainers/pastml:1.9.51--pyhdfd78af_0
- **Homepage**: https://github.com/evolbioinfo/pastml
- **Package**: https://anaconda.org/channels/bioconda/packages/pastml/overview
- **Validation**: PASS

### Original Help Text
```text
usage: transition_counter [-h] -t TREE [-d DATA] [-s DATA_SEP] [-i ID_INDEX]
                          -c COLUMN [-m {JC,F81,EFT,HKY,JTT,CUSTOM_RATES}]
                          --parameters PARAMETERS [--rate_matrix RATE_MATRIX]
                          [-n N_REPETITIONS] -o OUT_TRANSITIONS [-v]
                          [--html HTML] [--offline] [--work_dir WORK_DIR]
                          [--colours COLOURS] [--threshold THRESHOLD]
                          [--version]

Transition counting for PastML ACR

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit

tree-related arguments:
  -t TREE, --tree TREE  input tree(s) in newick format (must be rooted).

annotation-file-related arguments:
  -d DATA, --data DATA  annotation file in tab/csv format with the first row
                        containing the column names. If not given, the
                        annotations should be contained in the tree file
                        itself.
  -s DATA_SEP, --data_sep DATA_SEP
                        column separator for the annotation table. By default
                        is set to tab, i.e. for a tab-delimited file. Set it
                        to ',' if your file is csv.
  -i ID_INDEX, --id_index ID_INDEX
                        index of the annotation table column containing tree
                        tip names, indices start from zero (by default is set
                        to 0).

ancestral-character-reconstruction-related arguments:
  -c COLUMN, --column COLUMN
                        the name of the annotation table column that contain
                        the character to be analysed.
  -m {JC,F81,EFT,HKY,JTT,CUSTOM_RATES}, --model {JC,F81,EFT,HKY,JTT,CUSTOM_RATES}
                        evolutionary model for ML methods (ignored by MP
                        methods). When multiple ancestral characters are
                        specified (see -c, --columns), the same model can be
                        used for all of them (if only one model is specified),
                        or different models can be used (specified in the same
                        order as -c, --columns). If multiple models are given,
                        but not for all the characters, for the rest of them
                        the default model (F81) is chosen.
  --parameters PARAMETERS
                        the ML-method parameters, specified as a path to a
                        tab-delimited file with two columns: the first one
                        containing parameter names, and the second, named
                        "value", containing parameter values. Parameters can
                        include character state frequencies (parameter name
                        should be the corresponding state, and parameter value
                        - the float frequency value, between 0 and 1),tree
                        branch scaling factor (parameter name
                        scaling_factor),and tree branch smoothing factor
                        (parameter name smoothing_factor),
  --rate_matrix RATE_MATRIX
                        (only for CUSTOM_RATES model) path to the file
                        containing the rate matrix. The rate matrix file
                        should specify character states in its first line,
                        preceded by # and separated by spaces. The following
                        lines should contain a symmetric squared rate matrix
                        with positive rates(and zeros on the diagonal),
                        separated by spaces, in the same order at the
                        character states specified in the first line.For
                        example, for four states, A, C, G, T and the rates
                        A<->C 1, A<->G 4, A<->T 1, C<->G 1, C<->T 4, G<->T
                        1,the rate matrix file would look like:# A C G T0 1 4
                        11 0 1 44 1 0 11 4 1 0
  -n N_REPETITIONS, --n_repetitions N_REPETITIONS
                        (default 1000) Number of times the ancestral scenario
                        is drawn from the marginal probabilities.The
                        transition counts are averaged over all these
                        scenarios.

output-related arguments:
  -o OUT_TRANSITIONS, --out_transitions OUT_TRANSITIONS
                        path to the output transition count file.
  -v, --verbose         print information on the progress of the analysis (to
                        console)
  --html HTML           path to the output transition visualisation file
                        (html).
  --work_dir WORK_DIR   path to the folder where pastml will store all the
                        needed CSS/JS scripts for the --offline mode. Default
                        is <path_to_input_tree>/<input_tree_name>_pastml. If
                        the folder does not exist, it will be created.

visualisation-related arguments:
  --offline             By default (without --offline option) PastML assumes
                        that there is an internet connection available, which
                        permits it to fetch CSS and JS scripts needed for
                        visualisation online.With --offline option turned on,
                        PastML will store all the needed CSS/JS scripts in the
                        folder specified by --work_dir, so that internet
                        connection is not needed (but you must not move the
                        output html files to any location other that the one
                        specified by --html).
  --colours COLOURS     optional way to specify the colours used for character
                        state visualisation. A tab-delimited file, with two
                        columns: the first one containing character states,
                        and the second, named "colour", containing colours, in
                        HEX format (e.g. #a6cee3).
  --threshold THRESHOLD
                        Do not visualise the interactions below this threshold
                        value.
```
