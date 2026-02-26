# taxsbp CWL Generation Report

## taxsbp

### Tool Description
Parses taxonomic information for sequences and assigns them to bins.

### Metadata
- **Docker Image**: quay.io/biocontainers/taxsbp:1.1.1--py_0
- **Homepage**: https://github.com/pirovc/taxsbp
- **Package**: https://anaconda.org/channels/bioconda/packages/taxsbp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/taxsbp/overview
- **Total Downloads**: 13.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pirovc/taxsbp
- **Stars**: N/A
### Original Help Text
```text
usage: taxsbp [-h] -i <input_file> [-o <output_file>] -n <nodes_file>
              [-m <merged_file>] [-l <bin_len>] [-b <bins>]
              [-f <fragment_len>] [-a <overlap_len>] [-p <pre_cluster>]
              [-e <bin_exclusive>] [-s <specialization>] [-u <update_file>]
              [-w] [-t] [-v]

optional arguments:
  -h, --help            show this help message and exit
  -i <input_file>, --input-file <input_file>
                        Tab-separated with the fields: sequence id <tab>
                        sequence length <tab> taxonomic id [<tab>
                        specialization]
  -o <output_file>, --output-file <output_file>
                        Path to the output tab-separated file. Fields:
                        sequence id <tab> sequence start <tab> sequence end
                        <tab> sequence length <tab> taxonomic id <tab> bin id
                        [<tab> specialization]. Default: STDOUT
  -n <nodes_file>, --nodes-file <nodes_file>
                        nodes.dmp from NCBI Taxonomy
  -m <merged_file>, --merged-file <merged_file>
                        merged.dmp from NCBI Taxonomy
  -l <bin_len>, --bin-len <bin_len>
                        Maximum bin length (in bp). Use this parameter insted
                        of -b to define the number of bins. Default: length of
                        the biggest group [Mutually exclusive -b]
  -b <bins>, --bins <bins>
                        Approximate number of bins (estimated by total
                        length/bin number). [Mutually exclusive -l]
  -f <fragment_len>, --fragment-len <fragment_len>
                        Fragment sequences into pieces
  -a <overlap_len>, --overlap-len <overlap_len>
                        Overlap length between fragments [Only valid with -a]
  -p <pre_cluster>, --pre-cluster <pre_cluster>
                        Pre-cluster sequences into any existing rank, leaves
                        or specialization. Entries will not be divided in bins
                        ['leaves',specialization name,rank name]
  -e <bin_exclusive>, --bin-exclusive <bin_exclusive>
                        Make bins rank, leaves or specialization exclusive.
                        Bins will not have mixed entries. When the chosen rank
                        is not present on a sequence lineage, this sequence
                        will be leaf/specialization exclusive.
                        ['leaves',specialization name,rank name]
  -s <specialization>, --specialization <specialization>
                        Specialization name (e.g. assembly, strain). If given,
                        TaxSBP will cluster entries on a specialized level
                        after the leaf. The specialization identifier should
                        be provided as an extra collumn in the input_file and
                        should respect the taxonomic hiercharchy: One leaf can
                        have multiple specializations but a specialization is
                        present in only one leaf
  -u <update_file>, --update-file <update_file>
                        Previously generated clusters to be updated. Output
                        only new sequences
  -w, --allow-merge     When updating, allow merging of existing bins. Will
                        output the whole set, not only new bins
  -t, --silent          Do not print warning to STDERR
  -v, --version         show program's version number and exit
```

