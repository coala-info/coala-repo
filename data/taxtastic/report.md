# taxtastic CWL Generation Report

## taxtastic_taxit

### Tool Description
Creation, validation, and modification of reference packages for use with `pplacer` and related software.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/fhcrc/taxtastic
- **Package**: https://anaconda.org/channels/bioconda/packages/taxtastic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/taxtastic/overview
- **Total Downloads**: 35.4K
- **Last updated**: 2025-06-11
- **GitHub**: https://github.com/fhcrc/taxtastic
- **Stars**: N/A
### Original Help Text
```text
usage: taxit [-h] [-V] [-v] [-q]
             {help,add_nodes,add_to_taxtable,check,composition,create,extract_nodes,findcompany,get_descendants,get_lineage,info,lineage_table,lonelynodes,named,namelookup,new_database,refpkg_intersection,reroot,rollback,rollforward,rp,strip,taxids,taxtable,update,update_taxids} ...

Creation, validation, and modification of reference packages for use with
`pplacer` and related software.

positional arguments:
  {help,add_nodes,add_to_taxtable,check,composition,create,extract_nodes,findcompany,get_descendants,get_lineage,info,lineage_table,lonelynodes,named,namelookup,new_database,refpkg_intersection,reroot,rollback,rollforward,rp,strip,taxids,taxtable,update,update_taxids}
    help                Detailed help for actions using `help <action>`
    add_nodes           Add nodes and names to a database
    add_to_taxtable     Add nodes to an existing taxtable csv
    check               Validate a reference package
    composition         Show taxonomic composition of a reference package
    create              Create a reference package
    extract_nodes       Extract nodes from a given source in yaml format
    findcompany         Find company for lonely nodes
    get_descendants     Returns given taxids including descendant taxids
    get_lineage         Calculate the taxonomic lineage of a taxid
    info                Show information about reference packages.
    lineage_table       Create a table of lineages as taxonimic names for a
                        collection of sequences
    lonelynodes         Extracts tax ids of all lonely nodes in a taxtable
    named               Filters unclassified, unnamed taxonomy ids
    namelookup          Find primary name and tax_id from taxonomic names
    new_database        Download NCBI taxonomy and create a database
    refpkg_intersection
                        Find the intersection of a taxtable and a refpkg's
                        taxonomy.
    reroot              Taxonomically reroots a reference package
    rollback            Undo an operation performed on a refpkg
    rollforward         Restore a change to a refpkg immediately after being
                        reverted
    rp                  Resolve path; get the path to a file in the reference
                        package
    strip               Remove rollback and rollforward information from a
                        refpkg
    taxids              Convert a list of taxonomic names into a recursive
                        list of species
    taxtable            Create a tabular representation of taxonomic lineages
    update              Add or modify files or metadata in a refpkg
    update_taxids       Update obsolete tax_ids

options:
  -h, --help            show this help message and exit
  -V, --version         Print the version number and exit
  -v, --verbose         Increase verbosity of screen output (eg, -v is
                        verbose, -vv more so)
  -q, --quiet           Suppress output
```

