MHCflurry

2.0.0

* [Introduction and setup](intro.html)
* [Command-line tutorial](commandline_tutorial.html)
* [Python library tutorial](python_tutorial.html)
* [Command-line reference](commandline_tools.html)
* [API Documentation](api.html)

MHCflurry

* »
* MHCflurry documentation
* [View page source](_sources/index.rst.txt)

---

# MHCflurry documentation[¶](#mhcflurry-documentation "Permalink to this headline")

* [Introduction and setup](intro.html)
  + [Installation (pip)](intro.html#installation-pip)
  + [Using conda](intro.html#using-conda)
* [Command-line tutorial](commandline_tutorial.html)
  + [Downloading models](commandline_tutorial.html#downloading-models)
  + [Generating predictions](commandline_tutorial.html#generating-predictions)
  + [Using the older, allele-specific models](commandline_tutorial.html#using-the-older-allele-specific-models)
  + [Scanning protein sequences for predicted MHC I ligands](commandline_tutorial.html#scanning-protein-sequences-for-predicted-mhc-i-ligands)
  + [Fitting your own models](commandline_tutorial.html#fitting-your-own-models)
  + [Environment variables](commandline_tutorial.html#environment-variables)
* [Python library tutorial](python_tutorial.html)
  + [Loading a predictor](python_tutorial.html#loading-a-predictor)
  + [Predicting for individual peptides](python_tutorial.html#predicting-for-individual-peptides)
  + [Scanning protein sequences](python_tutorial.html#scanning-protein-sequences)
  + [Lower level interfaces](python_tutorial.html#lower-level-interfaces)
* [Command-line reference](commandline_tools.html)
  + [mhcflurry-predict](commandline_tools.html#mhcflurry-predict)
  + [mhcflurry-predict-scan](commandline_tools.html#mhcflurry-predict-scan)
  + [mhcflurry-downloads](commandline_tools.html#mhcflurry-downloads)
    - [mhcflurry-downloads fetch](commandline_tools.html#mhcflurry-downloads-fetch)
    - [mhcflurry-downloads info](commandline_tools.html#mhcflurry-downloads-info)
    - [mhcflurry-downloads path](commandline_tools.html#mhcflurry-downloads-path)
    - [mhcflurry-downloads url](commandline_tools.html#mhcflurry-downloads-url)
  + [mhcflurry-class1-train-allele-specific-models](commandline_tools.html#mhcflurry-class1-train-allele-specific-models)
  + [mhcflurry-class1-select-allele-specific-models](commandline_tools.html#mhcflurry-class1-select-allele-specific-models)
  + [mhcflurry-class1-train-pan-allele-models](commandline_tools.html#mhcflurry-class1-train-pan-allele-models)
  + [mhcflurry-class1-select-pan-allele-models](commandline_tools.html#mhcflurry-class1-select-pan-allele-models)
  + [mhcflurry-class1-train-processing-models](commandline_tools.html#mhcflurry-class1-train-processing-models)
  + [mhcflurry-class1-select-processing-models](commandline_tools.html#mhcflurry-class1-select-processing-models)
  + [mhcflurry-class1-train-presentation-models](commandline_tools.html#mhcflurry-class1-train-presentation-models)
* [API Documentation](api.html)
  + [Submodules](api.html#submodules)
  + [mhcflurry.allele\_encoding module](api.html#module-mhcflurry.allele_encoding)
  + [mhcflurry.amino\_acid module](api.html#module-mhcflurry.amino_acid)
  + [mhcflurry.calibrate\_percentile\_ranks\_command module](api.html#module-mhcflurry.calibrate_percentile_ranks_command)
  + [mhcflurry.class1\_affinity\_predictor module](api.html#module-mhcflurry.class1_affinity_predictor)
  + [mhcflurry.class1\_neural\_network module](api.html#module-mhcflurry.class1_neural_network)
  + [mhcflurry.class1\_presentation\_predictor module](api.html#module-mhcflurry.class1_presentation_predictor)
  + [mhcflurry.class1\_processing\_neural\_network module](api.html#module-mhcflurry.class1_processing_neural_network)
  + [mhcflurry.class1\_processing\_predictor module](api.html#module-mhcflurry.class1_processing_predictor)
  + [mhcflurry.cluster\_parallelism module](api.html#module-mhcflurry.cluster_parallelism)
  + [mhcflurry.common module](api.html#module-mhcflurry.common)
  + [mhcflurry.custom\_loss module](api.html#module-mhcflurry.custom_loss)
  + [mhcflurry.data\_dependent\_weights\_initialization module](api.html#module-mhcflurry.data_dependent_weights_initialization)
  + [mhcflurry.downloads module](api.html#module-mhcflurry.downloads)
  + [mhcflurry.downloads\_command module](api.html#module-mhcflurry.downloads_command)
  + [mhcflurry.encodable\_sequences module](api.html#module-mhcflurry.encodable_sequences)
  + [mhcflurry.ensemble\_centrality module](api.html#module-mhcflurry.ensemble_centrality)
  + [mhcflurry.fasta module](api.html#module-mhcflurry.fasta)
  + [mhcflurry.flanking\_encoding module](api.html#module-mhcflurry.flanking_encoding)
  + [mhcflurry.hyperparameters module](api.html#module-mhcflurry.hyperparameters)
  + [mhcflurry.local\_parallelism module](api.html#module-mhcflurry.local_parallelism)
  + [mhcflurry.percent\_rank\_transform module](api.html#module-mhcflurry.percent_rank_transform)
  + [mhcflurry.predict\_command module](api.html#module-mhcflurry.predict_command)
  + [mhcflurry.predict\_scan\_command module](api.html#module-mhcflurry.predict_scan_command)
  + [mhcflurry.random\_negative\_peptides module](api.html#module-mhcflurry.random_negative_peptides)
  + [mhcflurry.regression\_target module](api.html#module-mhcflurry.regression_target)
  + [mhcflurry.scoring module](api.html#module-mhcflurry.scoring)
  + [mhcflurry.select\_allele\_specific\_models\_command module](api.html#module-mhcflurry.select_allele_specific_models_command)
  + [mhcflurry.select\_pan\_allele\_models\_command module](api.html#module-mhcflurry.select_pan_allele_models_command)
  + [mhcflurry.select\_processing\_models\_command module](api.html#module-mhcflurry.select_processing_models_command)
  + [mhcflurry.testing\_utils module](api.html#module-mhcflurry.testing_utils)
  + [mhcflurry.train\_allele\_specific\_models\_command module](api.html#module-mhcflurry.train_allele_specific_models_command)
  + [mhcflurry.train\_pan\_allele\_models\_command module](api.html#module-mhcflurry.train_pan_allele_models_command)
  + [mhcflurry.train\_presentation\_models\_command module](api.html#module-mhcflurry.train_presentation_models_command)
  + [mhcflurry.train\_processing\_models\_command module](api.html#module-mhcflurry.train_processing_models_command)
  + [mhcflurry.version module](api.html#module-mhcflurry.version)

[Next](intro.html "Introduction and setup")

---

© Copyright Timothy O'Donnell
Last updated on Jul 13, 2020.

Built with [Sphinx](http://sphinx-doc.org/) using a
[theme](https://github.com/rtfd/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).