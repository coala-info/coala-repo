[MHCflurry](index.html)

2.0.0

* [Introduction and setup](intro.html)
* [Command-line tutorial](commandline_tutorial.html)
* [Python library tutorial](python_tutorial.html)
* [Command-line reference](commandline_tools.html)
* API Documentation
  + [Submodules](#submodules)
  + [mhcflurry.allele\_encoding module](#module-mhcflurry.allele_encoding)
  + [mhcflurry.amino\_acid module](#module-mhcflurry.amino_acid)
  + [mhcflurry.calibrate\_percentile\_ranks\_command module](#module-mhcflurry.calibrate_percentile_ranks_command)
  + [mhcflurry.class1\_affinity\_predictor module](#module-mhcflurry.class1_affinity_predictor)
  + [mhcflurry.class1\_neural\_network module](#module-mhcflurry.class1_neural_network)
  + [mhcflurry.class1\_presentation\_predictor module](#module-mhcflurry.class1_presentation_predictor)
  + [mhcflurry.class1\_processing\_neural\_network module](#module-mhcflurry.class1_processing_neural_network)
  + [mhcflurry.class1\_processing\_predictor module](#module-mhcflurry.class1_processing_predictor)
  + [mhcflurry.cluster\_parallelism module](#module-mhcflurry.cluster_parallelism)
  + [mhcflurry.common module](#module-mhcflurry.common)
  + [mhcflurry.custom\_loss module](#module-mhcflurry.custom_loss)
  + [mhcflurry.data\_dependent\_weights\_initialization module](#module-mhcflurry.data_dependent_weights_initialization)
  + [mhcflurry.downloads module](#module-mhcflurry.downloads)
  + [mhcflurry.downloads\_command module](#module-mhcflurry.downloads_command)
  + [mhcflurry.encodable\_sequences module](#module-mhcflurry.encodable_sequences)
  + [mhcflurry.ensemble\_centrality module](#module-mhcflurry.ensemble_centrality)
  + [mhcflurry.fasta module](#module-mhcflurry.fasta)
  + [mhcflurry.flanking\_encoding module](#module-mhcflurry.flanking_encoding)
  + [mhcflurry.hyperparameters module](#module-mhcflurry.hyperparameters)
  + [mhcflurry.local\_parallelism module](#module-mhcflurry.local_parallelism)
  + [mhcflurry.percent\_rank\_transform module](#module-mhcflurry.percent_rank_transform)
  + [mhcflurry.predict\_command module](#module-mhcflurry.predict_command)
  + [mhcflurry.predict\_scan\_command module](#module-mhcflurry.predict_scan_command)
  + [mhcflurry.random\_negative\_peptides module](#module-mhcflurry.random_negative_peptides)
  + [mhcflurry.regression\_target module](#module-mhcflurry.regression_target)
  + [mhcflurry.scoring module](#module-mhcflurry.scoring)
  + [mhcflurry.select\_allele\_specific\_models\_command module](#module-mhcflurry.select_allele_specific_models_command)
  + [mhcflurry.select\_pan\_allele\_models\_command module](#module-mhcflurry.select_pan_allele_models_command)
  + [mhcflurry.select\_processing\_models\_command module](#module-mhcflurry.select_processing_models_command)
  + [mhcflurry.testing\_utils module](#module-mhcflurry.testing_utils)
  + [mhcflurry.train\_allele\_specific\_models\_command module](#module-mhcflurry.train_allele_specific_models_command)
  + [mhcflurry.train\_pan\_allele\_models\_command module](#module-mhcflurry.train_pan_allele_models_command)
  + [mhcflurry.train\_presentation\_models\_command module](#module-mhcflurry.train_presentation_models_command)
  + [mhcflurry.train\_processing\_models\_command module](#module-mhcflurry.train_processing_models_command)
  + [mhcflurry.version module](#module-mhcflurry.version)

[MHCflurry](index.html)

* »
* API Documentation
* [View page source](_sources/api.rst.txt)

---

# API Documentation[¶](#module-mhcflurry "Permalink to this headline")

Class I MHC ligand prediction package

*class* `mhcflurry.``Class1AffinityPredictor`(*allele\_to\_allele\_specific\_models=None*, *class1\_pan\_allele\_models=None*, *allele\_to\_sequence=None*, *manifest\_df=None*, *allele\_to\_percent\_rank\_transform=None*, *metadata\_dataframes=None*, *provenance\_string=None*)[[source]](_modules/mhcflurry/class1_affinity_predictor.html#Class1AffinityPredictor)[¶](#mhcflurry.Class1AffinityPredictor "Permalink to this definition")
:   Bases: `object`

    High-level interface for peptide/MHC I binding affinity prediction.

    This class manages low-level [`Class1NeuralNetwork`](#mhcflurry.Class1NeuralNetwork "mhcflurry.Class1NeuralNetwork") instances, each of which
    wraps a single Keras network. The purpose of [`Class1AffinityPredictor`](#mhcflurry.Class1AffinityPredictor "mhcflurry.Class1AffinityPredictor") is to
    implement ensembles, handling of multiple alleles, and predictor loading and
    saving. It also provides a place to keep track of metadata like prediction
    histograms for percentile rank calibration.

    Parameters
    :   **allele\_to\_allele\_specific\_models**dict of string -> list of [`Class1NeuralNetwork`](#mhcflurry.Class1NeuralNetwork "mhcflurry.Class1NeuralNetwork")
        :   Ensemble of single-allele models to use for each allele.

        **class1\_pan\_allele\_models**list of [`Class1NeuralNetwork`](#mhcflurry.Class1NeuralNetwork "mhcflurry.Class1NeuralNetwork")
        :   Ensemble of pan-allele models.

        **allele\_to\_sequence**dict of string -> string
        :   MHC allele name to fixed-length amino acid sequence (sometimes
            referred to as the pseudosequence). Required only if
            class1\_pan\_allele\_models is specified.

        **manifest\_df**`pandas.DataFrame`, optional
        :   Must have columns: model\_name, allele, config\_json, model.
            Only required if you want to update an existing serialization of a
            Class1AffinityPredictor. Otherwise this dataframe will be generated
            automatically based on the supplied models.

        **allele\_to\_percent\_rank\_transform**dict of string -> `PercentRankTransform`, optional
        :   `PercentRankTransform` instances to use for each allele

        **metadata\_dataframes**dict of string -> pandas.DataFrame, optional
        :   Optional additional dataframes to write to the models dir when
            save() is called. Useful for tracking provenance.

        **provenance\_string**string, optional
        :   Optional info string to use in \_\_str\_\_.

    *property* `manifest_df`[¶](#mhcflurry.Class1AffinityPredictor.manifest_df "Permalink to this definition")
    :   A pandas.DataFrame describing the models included in this predictor.

        Based on:
        - self.class1\_pan\_allele\_models
        - self.allele\_to\_allele\_specific\_models

        Returns
        :   pandas.DataFrame

    `clear_cache`()[[source]](_modules/mhcflurry/class1_affinity_predictor.html#Class1AffinityPredictor.clear_cache)[¶](#mhcflurry.Class1AffinityPredictor.clear_cache "Permalink to this definition")
    :   Clear values cached based on the neural networks in this predictor.

        Users should call this after mutating any of the following:
        :   * self.class1\_pan\_allele\_models
            * self.allele\_to\_allele\_specific\_models
            * self.allele\_to\_sequence

        Methods that mutate these instance variables will call this method on
        their own if needed.

    *property* `neural_networks`[¶](#mhcflurry.Class1AffinityPredictor.neural_networks "Permalink to this definition")
    :   List of the neural networks in the ensemble.

        Returns
        :   list of [`Class1NeuralNetwork`](#mhcflurry.Class1NeuralNetwork "mhcflurry.Class1NeuralNetwork")

    *classmethod* `merge`(*predictors*)[[source]](_modules/mhcflurry/class1_affinity_predictor.html#Class1AffinityPredictor.merge)[¶](#mhcflurry.Class1AffinityPredictor.merge "Permalink to this definition")
    :   Merge the ensembles of two or more [`Class1AffinityPredictor`](#mhcflurry.Class1AffinityPredictor "mhcflurry.Class1AffinityPredictor") instances.

        Note: the resulting merged predictor will NOT have calibrated percentile
        ranks. Call [`calibrate_percentile_ranks`](#mhcflurry.Class1AffinityPredictor.calibrate_percentile_ranks "mhcflurry.Class1AffinityPredictor.calibrate_percentile_ranks") on it if these are needed.

        Parameters
        :   **predictors**sequence of [`Class1AffinityPredictor`](#mhcflurry.Class1AffinityPredictor "mhcflurry.Class1AffinityPredictor")

        Returns
        :   [`Class1AffinityPredictor`](#mhcflurry.Class1AffinityPredictor "mhcflurry.Class1AffinityPredictor") instance

    `merge_in_place`(*others*)[[source]](_modules/mhcflurry/class1_affinity_predictor.html#Class1AffinityPredictor.merge_in_place)[¶](#mhcflurry.Class1AffinityPredictor.merge_in_place "Permalink to this definition")
    :   Add the models present in other predictors into the current predictor.

        Parameters
        :   **others**list of Class1AffinityPredictor
            :   Other predictors to merge into the current predictor.

        Returns
        :   **list of string**names of newly added models

    *property* `supported_alleles`[¶](#mhcflurry.Class1AffinityPredictor.supported_alleles "Permalink to this definition")
    :   Alleles for which predictions can be made.

        Returns
        :   list of string

    *property* `supported_peptide_lengths`[¶](#mhcflurry.Class1AffinityPredictor.supported_peptide_lengths "Permalink to this definition")
    :   (minimum, maximum) lengths of peptides supported by *all models*,
        inclusive.

        Returns
        :   (int, int) tuple

    `check_consistency`()[[source]](_modules/mhcflurry/class1_affinity_predictor.html#Class1AffinityPredictor.check_consistency)[¶](#mhcflurry.Class1AffinityPredictor.check_consistency "Permalink to this definition")
    :   Verify that self.manifest\_df is consistent with:
        - self.class1\_pan\_allele\_models
        - self.allele\_to\_allele\_specific\_models

        Currently only checks for agreement on the total number of models.

        Throws AssertionError if inconsistent.

    `save`(*models\_dir*, *model\_names\_to\_write=None*, *write\_metadata=True*)[[source]](_modules/mhcflurry/class1_affinity_predictor.html#Class1AffinityPredictor.save)[¶](#mhcflurry.Class1AffinityPredictor.save "Permalink to this definition")
    :   Serialize the predictor to a directory on disk. If the directory does
        not exist it will be created.

        The serialization format consists of a file called “manifest.csv” with
        the configurations of each Class1NeuralNetwork, along with per-network
        files giving the model weights. If there are pan-allele predictors in
        the ensemble, the allele sequences are also stored in the
        directory. There is also a small file “index.txt” with basic metadata:
        when the models were trained, by whom, on what host.

        Parameters
        :   **models\_dir**string
            :   Path to directory. It will be created if it doesn’t exist.

            **model\_names\_to\_write**list of string, optional
            :   Only write the weights for the specified models. Useful for
                incremental updates during training.

            **write\_metadata**boolean, optional
            :   Whether to write optional metadata

    *static* `load`(*models\_dir=None*, *max\_models=None*, *optimization\_level=None*)[[source]](_modules/mhcflurry/class1_affinity_predictor.html#Class1AffinityPredictor.load)[¶](#mhcflurry.Class1AffinityPredictor.load "Permalink to this definition")
    :   Deserialize a predictor from a directory on disk.

        Parameters
        :   **models\_dir**string
            :   Path to directory. If unspecified the default downloaded models are
                used.

            **max\_models**int, optional
            :   Maximum number of [`Class1NeuralNetwork`](#mhcflurry.Class1NeuralNetwork "mhcflurry.Class1NeuralNetwork") instances to load

            **optimization\_level**int
            :   If >0, model optimization will be attempted. Defaults to value of
                environment variable MHCFLURRY\_OPTIMIZATION\_LEVEL.

        Returns
        :   [`Class1AffinityPredictor`](#mhcflurry.Class1AffinityPredictor "mhcflurry.Class1AffinityPredictor") instance

    `optimize`(*warn=True*)[[source]](_modules/mhcflurry/class1_affinity_predictor.html#Class1AffinityPredictor.optimize)[¶](#mhcflurry.Class1AffinityPredictor.optimize "Permalink to this definition")
    :   EXPERIMENTAL: Optimize the predictor for faster predictions.

        Currently the only optimization implemented is to merge multiple pan-
        allele predictors at the tensorflow level.

        The optimization is performed in-place, mutating the instance.

        Returns
        :   bool
            :   Whether optimization was performed

    *static* `model_name`(*allele*, *num*)[[source]](_modules/mhcflurry/class1_affinity_predictor.html#Class1AffinityPredictor.model_name)[¶](#mhcflurry.Class1AffinityPredictor.model_name "Permalink to this definition")
    :   Generate a model name

        Parameters
        :   **allele**string

            **num**int

        Returns
        :   string

    *static* `weights_path`(*models\_dir*, *model\_name*)[[source]](_modules/mhcflurry/class1_affinity_predictor.html#Class1AffinityPredictor.weights_path)[¶](#mhcflurry.Class1AffinityPredictor.weights_path "Permalink to this definition")
    :   Generate the path to the weights file for a model

        Parameters
        :   **models\_dir**string

            **model\_name**string

        Returns
        :   string

    *property* `master_allele_encoding`[¶](#mhcflurry.Class1AffinityPredictor.master_allele_encoding "Permalink to this definition")
    :   An AlleleEncoding containing the universe of alleles specified by
        self.allele\_to\_sequence.

        Returns
        :   AlleleEncoding

    `fit_allele_specific_predictors`(*n\_models*, *architecture\_hyperparameters\_list*, *allele*, *peptides*, *affinities*, *inequalities=None*, *train\_rounds=None*, *models\_dir\_for\_save=None*, *verbose=0*, *progress\_preamble=''*, *progress\_print\_interval=5.0*)[[source]](_modules/mhcflurry/class1_affinity_predictor.html#Class1AffinityPredictor.fit_allele_specific_predictors)[¶](#mhcflurry.Class1AffinityPredictor.fit_allele_specific_predictors "Permalink to this definition")
    :   Fit one or more allele specific predictors for a single allele using one
        or more neural network architectures.

        The new predictors are saved in the Class1AffinityPredictor instance
        and will be used on subsequent calls to [`predict`](#mhcflurry.Class1AffinityPredictor.predict "mhcflurry.Class1AffinityPredictor.predict").

        Parameters
        :   **n\_models**int
            :   Number of neural networks to fit

            **architecture\_hyperparameters\_list**list of dict
            :   List of hyperparameter sets.

            **allele**string

            **peptides**`EncodableSequences` or list of string

            **affinities**list of float
            :   nM affinities

            **inequalities**list of string, each element one of “>”, “<”, or “=”
            :   See [`Class1NeuralNetwork.fit`](#mhcflur