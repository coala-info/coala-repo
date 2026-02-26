# metametamerge CWL Generation Report

## metametamerge_MetaMetaMerge.py

### Tool Description
MetaMetaMerge by Vitor C. Piro (vitorpiro@gmail.com, http://github.com/pirovc)

### Metadata
- **Docker Image**: quay.io/biocontainers/metametamerge:1.1--py35_1
- **Homepage**: https://github.com/pirovc/metametamerge/
- **Package**: https://anaconda.org/channels/bioconda/packages/metametamerge/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metametamerge/overview
- **Total Downloads**: 14.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pirovc/metametamerge
- **Stars**: N/A
### Original Help Text
```text
usage: MetaMetaMerge.py [-h] -i [<input_files> [<input_files> ...]] -d
                        [<database_profiles> [<database_profiles> ...]] -t
                        <tool_identifier> -c <tool_method> -n <names_file> -e
                        <nodes_file> -m <merged_file> [-b <bins>]
                        [-r <cutoff>] [-f <mode>] [-s <ranks>] -o
                        <output_file> [-p <output_type>]
                        [--output-parsed-profiles] [--detailed] [--verbose]
                        [-v]

MetaMetaMerge by Vitor C. Piro (vitorpiro@gmail.com, http://github.com/pirovc)

optional arguments:
  -h, --help            show this help message and exit
  -i [<input_files> [<input_files> ...]], --input-files [<input_files> [<input_files> ...]]
                        Input (binning or profiling) files. Bioboxes or tsv
                        format (see README)
  -d [<database_profiles> [<database_profiles> ...]], --database-profiles [<database_profiles> [<database_profiles> ...]]
                        Database profiles on the same order of the input files
                        (see README)
  -t <tool_identifier>, --tool-identifier <tool_identifier>
                        Comma-separated identifiers on the same order of the
                        input files
  -c <tool_method>, --tool-method <tool_method>
                        Comma-separated methods on the same order of the input
                        files (p -> profiling / b -> binning)
  -n <names_file>, --names-file <names_file>
                        names.dmp from the NCBI Taxonomy database
  -e <nodes_file>, --nodes-file <nodes_file>
                        nodes.dmp from the NCBI Taxonomy database
  -m <merged_file>, --merged-file <merged_file>
                        merged.dmp from the NCBI Taxonomy database
  -b <bins>, --bins <bins>
                        Number of bins. Default: 4
  -r <cutoff>, --cutoff <cutoff>
                        Minimum abundance/Maximum results for each taxonomic
                        level (0: off / 0-1: minimum relative abundance / >=1:
                        maximum number of identifications). Default: 0.0001
  -f <mode>, --mode <mode>
                        Result mode (precise, very-precise, linear, sensitive,
                        very-sensitive, no-cutoff). Default: linear
  -s <ranks>, --ranks <ranks>
                        Comma-separated list of ranks to be independently
                        merged (superkingdom,phylum,class,order,family,genus,s
                        pecies,all). Default: species
  -o <output_file>, --output-file <output_file>
                        Output file
  -p <output_type>, --output-type <output_type>
                        Output type (tsv, bioboxes). Default: bioboxes
  --output-parsed-profiles
                        Output parsed and converted profiles for all input
                        files (without cutoff)
  --detailed            Generate an additional detailed output with individual
                        normalized abundances for each tool, where: 0 -> not
                        identified but present in the database, -1 not present
                        in the database.
  --verbose             Verbose output log
  -v, --version         show program's version number and exit
```

