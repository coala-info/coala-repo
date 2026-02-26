# genewalk CWL Generation Report

## genewalk

### Tool Description
Run GeneWalk on a list of genes provided in a text file.

### Metadata
- **Docker Image**: quay.io/biocontainers/genewalk:1.6.3--pyh7e72e81_0
- **Homepage**: https://github.com/churchmanlab/genewalk
- **Package**: https://anaconda.org/channels/bioconda/packages/genewalk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genewalk/overview
- **Total Downloads**: 11.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/churchmanlab/genewalk
- **Stars**: N/A
### Original Help Text
```text
usage: genewalk [-h] [--version] --project PROJECT --genes GENES --id_type
                {hgnc_symbol,hgnc_id,ensembl_id,mgi_id,rgd_id,entrez_human,entrez_mouse,custom}
                [--stage {all,node_vectors,null_distribution,statistics,visual}]
                [--base_folder BASE_FOLDER]
                [--network_source {pc,indra,edge_list,sif,sif_annot,sif_full}]
                [--network_file NETWORK_FILE] [--nproc NPROC]
                [--nreps_graph NREPS_GRAPH] [--nreps_null NREPS_NULL]
                [--alpha_fdr ALPHA_FDR] [--dim_rep DIM_REP]
                [--save_dw SAVE_DW] [--random_seed RANDOM_SEED]

Run GeneWalk on a list of genes provided in a text file.

options:
  -h, --help            show this help message and exit
  --version             Print the version of GeneWalk and exit.
  --project PROJECT     A name for the project which determines the folder
                        within the base folder in which the intermediate and
                        final results are written. Must contain only
                        characters that are valid in folder names.
  --genes GENES         Path to a text file with a list of genes of interest,
                        for exampledifferentially expressed genes. The type of
                        gene identifiers used in the text file are provided in
                        the id_type argument.
  --id_type {hgnc_symbol,hgnc_id,ensembl_id,mgi_id,rgd_id,entrez_human,entrez_mouse,custom}
                        The type of gene IDs provided in the text file in the
                        genes argument. Possible values are: hgnc_symbol,
                        hgnc_id, ensembl_id, mgi_id,rgd_id, entrez_human,
                        entrez_mouse, and custom. If custom, a network_source
                        of sif_annot or sif_full must be used.
  --stage {all,node_vectors,null_distribution,statistics,visual}
                        The stage of processing to run. Default: all
  --base_folder BASE_FOLDER
                        The base folder used to store GeneWalk temporary and
                        result files for a given project. Default:
                        /root/genewalk
  --network_source {pc,indra,edge_list,sif,sif_annot,sif_full}
                        The source of the network to be used. Possible values
                        are: pc, indra, edge_list, sif, sif_annot, and
                        sif_full. In case of indra, edge_list, sif, sif_annot,
                        and sif_full, the network_file argument must be
                        specified. Default: pc
  --network_file NETWORK_FILE
                        If network_source is indra, this argument points to a
                        Python pickle file in which a list of INDRA Statements
                        constituting the network is contained. In case
                        network_source is edge_list, sif, sif_annot or
                        sif_full, the network_file argument points to a text
                        file representing the network. See README section
                        Custom input networks for full description of file
                        format requirements.
  --nproc NPROC         The number of processors to use in a multiprocessing
                        environment. Default: 1
  --nreps_graph NREPS_GRAPH
                        The number of repeats to run when calculating node
                        vectors on the GeneWalk graph. Default: 3
  --nreps_null NREPS_NULL
                        The number of repeats to run when calculating node
                        vectors on the random network graphs for constructing
                        the null distribution. Default: 3
  --alpha_fdr ALPHA_FDR
                        The false discovery rate to use when outputting the
                        final statistics table. If 1 (default), all
                        similarities are output, otherwise only the ones whose
                        false discovery rate are below this parameter are
                        included. For visualization a default value of 0.1 for
                        both global and gene-specific plots is used. Lower
                        this value to increase the stringency of the regulator
                        gene selection procedure. Default: 1
  --dim_rep DIM_REP     Dimension of vector representations (embeddings). This
                        value should only be increased if genewalk with the
                        default value generates no statistically significant
                        results, for instance with very large (>2500) input
                        gene lists. Alternatively, it can be decreased in case
                        (nearly) all GO annotations are significant, for
                        instance with very short gene lists. Default: 8
  --save_dw SAVE_DW     If True, the full DeepWalk object for each repeat is
                        saved in the project folder. This can be useful for
                        debugging but the files are typically very large.
                        Default: False
  --random_seed RANDOM_SEED
                        If provided, the random number generator is seeded
                        with the given value. This should only be used if the
                        goal is to deterministically reproduce a prior result
                        obtained with the same random seed.
```

