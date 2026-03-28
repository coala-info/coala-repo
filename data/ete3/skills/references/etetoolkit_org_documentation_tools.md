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

## ETE tools

The ETE toolkit offers a collection of command line tools
to run common operations in phylogenetics and comparative genomics. All tools are wrapped by the `ete3` command, which will
become available after ETE installation.

### Index of tools

* `[ete build](/documentation/ete-build)`: Build gene and species trees with a
  single command.

  ```
  ete3 build -a seqs.fasta -w soft_modeltest -o mytree/
  ```
* `[ete evol](/documentation/ete-evol)`: Run and visualize CodeML and SLR analyses.

  ```
  ete3 evol -t tree.nw --alg alg.fasta --models b_neut b_free --mark branchName -o test/
  ```
* `[ete compare](/documentation/ete-compare)`: Calculate distances between trees.

  ```
  ete3 compare -t tree1.nw -r tree2.nw
  ```
* `[ete ncbiquery](/documentation/ete-ncbiquery)`: Run fast inline queries to the NCBI taxonomy database.

  ```
  ete3 ncbiquery --search 9606 Hominidae "Canis familiaris" --info
  ```
* `[ete view](/documentation/ete-view)`: Visualize and generate tree images

  ```
  ete3 view -t tree.nw
  ```
* `ete annotate`: annotate tree nodes with external data or using NCBI taxonomy information.

  ```
  ete3 annotated -t tree.nw --ncbi
  ```
* `ete mod`: manipulate tree topology by rooting, pruning or sorting branches.
* `ete maptrees`: (experimental)

[![](/static/img/ete_tools_demo_small.gif)](/static/img/ete23_demo.gif)

*all ETE tools can be combined with other Unix commands by using pipes*

Citation:

*ETE 3: Reconstruction, analysis and visualization of phylogenomic data.*
Jaime Huerta-Cepas, Francois Serra and Peer Bork.
Mol Biol Evol 2016; [doi: 10.1093/molbev/msw046](http://mbe.oxfordjournals.org/content/early/2016/03/21/molbev.msw046)

* ETE is free software (GPL)
* [**Contact:** [email protected]](email)
* [![](/static/img/logo_embl.black.png)](embl.de)