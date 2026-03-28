[![](/static/logos/ETElogo.250x78.jpeg)](/)

* [Home](/)
* [Gallery](/gallery/)
* [Documentation](/docs/latest/index.html)
  + [Python API Tutorial](/docs/latest/tutorial/index.html)
  + [Python API Reference](/docs/latest/reference/index.html)
  + [Phylogenomic Tools Index](/documentation/tools/)
  + [Phylogenomic Tools Cookbook](/cookbook)
* [TreeView](/treeview/)
* [Support](/support/) * [About](/about/)
  * [Download](/download/)

    ![](https://img.shields.io/pypi/v/ete3.svg?label=latest)

[Cookbook index](/cookbook/)

# The ETE Cookbook[¶](#The-ETE-Cookbook)

This document provides real-case examples, tips and tricks on how to use the ete-tools and the ETE Python API.

This is a work continuously in progress. If you feel like contributing with fixes or new recipes, please get in touch and join us at [this cookbook repository](https://github.com/etetoolkit/cookbook).

## Tree building (ete-build)[¶](#Tree-building-(ete-build))

* [Basic concepts behind ete-build](ete_build_basics.ipynb)
* [Compose custom workflows](ete_build_workflows.ipynb)
* [Runninng multiple workflows at once](ete_build_metaworkflow.ipynb)
* [Create new workflows and application bindings](ete_build_new_workflows.ipynb)
* [Combining amino-acid and nucleotide sequences](ete_build_mixed_types.ipynb)
* [Using manual alignments](ete_build_manual_algs.ipynb)

  **Species trees:**
* [Building species trees](ete_build_supermatrix.ipynb) (Concatenated alignments)

  **Available workflows and apps**
* [List workflows, apps and configurations](ete_build_list_apps.ipynb)

  **Tips, troubleshooting and debuging:**
* [Tips and optional arguments](ete_build_tips.ipynb)
* [Details on workflow execution and intermediate data](ete_build_temp_data.ipynb)
* [Troubleshooting](ete_build_troubleshoot.ipynb)

## Testing evolutionary hypothesis (ete-evol)[¶](#Testing-evolutionary-hypothesis-(ete-evol))

* [Testing evolutionary models on branches](ete_evol_lysozyme_branch.ipynb) (Reproducing results from Yang Z (MBE, 1998))
* [Testing evolutionary models on sites](ete_evol_hiv-env_site.ipynb) (Reproducing results from Yang Z (MBE, 2005)
* [Testing evolutionary models on sites in a given lineage](ete_evol_lysozyme_branch-site.ipynb) (Reproducing results from Yang Z (MBE, 2005)
* [Running a Codeml from configuration file](ete_evol_codeml_configuration_files.ipynb) (running directly PAML examples)

Citation:

*ETE 3: Reconstruction, analysis and visualization of phylogenomic data.*
Jaime Huerta-Cepas, Francois Serra and Peer Bork.
Mol Biol Evol 2016; [doi: 10.1093/molbev/msw046](http://mbe.oxfordjournals.org/content/early/2016/03/21/molbev.msw046)

* ETE is free software (GPL)
* [**Contact:** [email protected]](email)
* [![](/static/img/logo_embl.black.png)](embl.de)