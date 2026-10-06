# pvacseq CWL Generation Report

## pvacseq_run

### Tool Description
Run the pVACseq pipeline to identify neoantigens from a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pvacseq:4.0.10--py36_0
- **Homepage**: https://github.com/griffithlab/pVAC-Seq
- **Package**: https://anaconda.org/channels/bioconda/packages/pvacseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pvacseq/overview
- **Total Downloads**: 13.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/griffithlab/pVAC-Seq
- **Stars**: N/A
### Original Help Text
```text
usage: pvacseq run [-h] [-e EPITOPE_LENGTH] [-l PEPTIDE_SEQUENCE_LENGTH]
                   [--iedb-install-directory IEDB_INSTALL_DIRECTORY]
                   [-i ADDITIONAL_INPUT_FILE_LIST]
                   [--net-chop-method {cterm,20s}] [--netmhc-stab] [-t]
                   [-m {lowest,median}] [-b BINDING_THRESHOLD]
                   [-c MINIMUM_FOLD_CHANGE] [--normal-cov NORMAL_COV]
                   [--tdna-cov TDNA_COV] [--trna-cov TRNA_COV]
                   [--normal-vaf NORMAL_VAF] [--tdna-vaf TDNA_VAF]
                   [--trna-vaf TRNA_VAF] [--expn-val EXPN_VAL]
                   [--net-chop-threshold NET_CHOP_THRESHOLD]
                   [-a {sample_name}] [-s FASTA_SIZE] [-r IEDB_RETRIES]
                   [-d DOWNSTREAM_SEQUENCE_LENGTH] [-k]
                   input_file sample_name allele
                   {NNalign,NetMHC,NetMHCIIpan,NetMHCcons,NetMHCpan,PickPocket,SMM,SMMPMBEC,SMMalign}
                   [{NNalign,NetMHC,NetMHCIIpan,NetMHCcons,NetMHCpan,PickPocket,SMM,SMMPMBEC,SMMalign} ...]
                   output_dir

positional arguments:
  input_file            A VEP-annotated single-sample VCF containing
                        transcript, Wildtype protein sequence, and Downstream
                        protein sequence information
  sample_name           The name of the sample being processed. This will be
                        used as a prefix for output files
  allele                Name of the allele to use for epitope prediction.
                        Multiple alleles can be specified using a comma-
                        separated list. For a list of available alleles, use:
                        `pvacseq valid_alleles`
  {NNalign,NetMHC,NetMHCIIpan,NetMHCcons,NetMHCpan,PickPocket,SMM,SMMPMBEC,SMMalign}
                        The epitope prediction algorithms to use. Multiple
                        prediction algorithms can be specified, separated by
                        spaces
  output_dir            The directory for writing all result files

optional arguments:
  -h, --help            show this help message and exit
  -e EPITOPE_LENGTH, --epitope-length EPITOPE_LENGTH
                        Length of subpeptides (neoepitopes) to predict.
                        Multiple epitope lengths can be specified using a
                        comma-separated list. Typical epitope lengths vary
                        between 8-11. Required for Class I prediction
                        algorithms
  -l PEPTIDE_SEQUENCE_LENGTH, --peptide-sequence-length PEPTIDE_SEQUENCE_LENGTH
                        Length of the peptide sequence to use when creating
                        the FASTA. Default: 21
  --iedb-install-directory IEDB_INSTALL_DIRECTORY
                        Directory that contains the local installation of IEDB
                        MHC I and/or MHC II
  -i ADDITIONAL_INPUT_FILE_LIST, --additional-input-file-list ADDITIONAL_INPUT_FILE_LIST
                        yaml file of additional files to be used as inputs,
                        e.g. cufflinks output files. For an example of this
                        yaml file run `pvacseq config_files
                        additional_input_file_list`.
  --net-chop-method {cterm,20s}
                        NetChop prediction method to use ("cterm" for C term
                        3.0, "20s" for 20S 3.0).
  --netmhc-stab         Run NetMHCStabPan after all filtering and add
                        stability predictions to predicted epitopes
  -t, --top-result-per-mutation
                        Output only the top scoring result for each allele-
                        peptide length combination for each variant. Default:
                        False
  -m {lowest,median}, --top-score-metric {lowest,median}
                        The ic50 scoring metric to use when filtering epitopes
                        by binding-threshold or minimum fold change. lowest:
                        Best MT Score/Corresponding Fold Change - lowest MT
                        ic50 binding score/corresponding fold change of all
                        chosen prediction methods. median: Median MT
                        Score/Median Fold Change - median MT ic50 binding
                        score/fold change of all chosen prediction methods.
                        Default: median
  -b BINDING_THRESHOLD, --binding-threshold BINDING_THRESHOLD
                        Report only epitopes where the mutant allele has ic50
                        binding scores below this value. Default: 500
  -c MINIMUM_FOLD_CHANGE, --minimum-fold-change MINIMUM_FOLD_CHANGE
                        Minimum fold change between mutant binding score and
                        wild-type score. The default is 0, which filters no
                        results, but 1 is often a sensible choice (requiring
                        that binding is better to the MT than WT). Default: 0
  --normal-cov NORMAL_COV
                        Normal Coverage Cutoff. Sites above this cutoff will
                        be considered. Default: 5
  --tdna-cov TDNA_COV   Tumor DNA Coverage Cutoff. Sites above this cutoff
                        will be considered. Default: 10
  --trna-cov TRNA_COV   Tumor RNA Coverage Cutoff. Sites above this cutoff
                        will be considered. Default: 10
  --normal-vaf NORMAL_VAF
                        Normal VAF Cutoff. Sites BELOW this cutoff in normal
                        will be considered. Default: 2
  --tdna-vaf TDNA_VAF   Tumor DNA VAF Cutoff. Sites above this cutoff will be
                        considered. Default: 40
  --trna-vaf TRNA_VAF   Tumor RNA VAF Cutoff. Sites above this cutoff will be
                        considered. Default: 40
  --expn-val EXPN_VAL   Gene and Transcript Expression cutoff. Sites above
                        this cutoff will be considered. Default: 1
  --net-chop-threshold NET_CHOP_THRESHOLD
                        NetChop prediction threshold. Default: 0.5
  -a {sample_name}, --additional-report-columns {sample_name}
                        Additional columns to output in the final report
  -s FASTA_SIZE, --fasta-size FASTA_SIZE
                        Number of fasta entries per IEDB request. For some
                        resource-intensive prediction algorithms like
                        Pickpocket and NetMHCpan it might be helpful to reduce
                        this number. Needs to be an even number.
  -r IEDB_RETRIES, --iedb-retries IEDB_RETRIES
                        Number of retries when making requests to the IEDB
                        RESTful web interface. Must be less than or equal to
                        100.Default: 5
  -d DOWNSTREAM_SEQUENCE_LENGTH, --downstream-sequence-length DOWNSTREAM_SEQUENCE_LENGTH
                        Cap to limit the downstream sequence length for
                        frameshifts when creating the fasta file. Use 'full'
                        to include the full downstream sequence. Default: 1000
  -k, --keep-tmp-files  Keep intermediate output files. This migt be useful
                        for debugging purposes.
```

## pvacseq_binding_filter

### Tool Description
Filter pVACseq final report epitopes based on binding affinity and fold change.

### Metadata
- **Docker Image**: quay.io/biocontainers/pvacseq:4.0.10--py36_0
- **Homepage**: https://github.com/griffithlab/pVAC-Seq
- **Package**: https://anaconda.org/channels/bioconda/packages/pvacseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pvacseq binding_filter [-h] [-b BINDING_THRESHOLD]
                              [-c MINIMUM_FOLD_CHANGE] [-m {lowest,median}]
                              input_file output_file

positional arguments:
  input_file            The final report .tsv file to filter
  output_file           Output .tsv file containing list of filtered epitopes
                        based on binding affinity

optional arguments:
  -h, --help            show this help message and exit
  -b BINDING_THRESHOLD, --binding-threshold BINDING_THRESHOLD
                        Report only epitopes where the mutant allele has ic50
                        binding scores below this value. Default: 500
  -c MINIMUM_FOLD_CHANGE, --minimum-fold-change MINIMUM_FOLD_CHANGE
                        Minimum fold change between mutant binding score and
                        wild-type score. The default is 0, which filters no
                        results, but 1 is often a sensible option (requiring
                        that binding is better to the MT than WT). Default: 0
  -m {lowest,median}, --top-score-metric {lowest,median}
                        The ic50 scoring metric to use when filtering epitopes
                        by binding-threshold or minimum fold change. lowest:
                        Best MT Score/Corresponding Fold Change - lowest MT
                        ic50 binding score/corresponding fold change of all
                        chosen prediction methods. median: Median MT
                        Score/Median Fold Change - median MT ic50 binding
                        score/fold change of all chosen prediction methods.
                        Default: median
```

## pvacseq_coverage_filter

### Tool Description
Filter pVACseq final report based on coverage and expression values

### Metadata
- **Docker Image**: quay.io/biocontainers/pvacseq:4.0.10--py36_0
- **Homepage**: https://github.com/griffithlab/pVAC-Seq
- **Package**: https://anaconda.org/channels/bioconda/packages/pvacseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pvacseq coverage_filter [-h] [--normal-cov NORMAL_COV]
                               [--tdna-cov TDNA_COV] [--trna-cov TRNA_COV]
                               [--normal-vaf NORMAL_VAF] [--tdna-vaf TDNA_VAF]
                               [--trna-vaf TRNA_VAF] [--expn-val EXPN_VAL]
                               input_file output_file

positional arguments:
  input_file            The final report .tsv file to filter
  output_file           Output .tsv file containing list of filtered epitopes
                        based on coverage and expression values

optional arguments:
  -h, --help            show this help message and exit
  --normal-cov NORMAL_COV
                        Normal Coverage Cutoff. Sites above this cutoff will
                        be considered. Default: 5
  --tdna-cov TDNA_COV   Tumor DNA Coverage Cutoff. Sites above this cutoff
                        will be considered. Default: 10
  --trna-cov TRNA_COV   Tumor RNA Coverage Cutoff. Sites above this cutoff
                        will be considered. Default: 10
  --normal-vaf NORMAL_VAF
                        Normal VAF Cutoff. Sites BELOW this cutoff in normal
                        will be considered. Default: 2
  --tdna-vaf TDNA_VAF   Tumor DNA VAF Cutoff. Sites above this cutoff will be
                        considered. Default: 40
  --trna-vaf TRNA_VAF   Tumor RNA VAF Cutoff. Sites above this cutoff will be
                        considered. Default: 40
  --expn-val EXPN_VAL   Gene and Transcript Expression cutoff. Sites above
                        this cutoff will be consideredDefault: 1
```

## pvacseq_generate_protein_fasta

### Tool Description
Generate a protein FASTA file from a VEP-annotated VCF for pVACseq analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/pvacseq:4.0.10--py36_0
- **Homepage**: https://github.com/griffithlab/pVAC-Seq
- **Package**: https://anaconda.org/channels/bioconda/packages/pvacseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pvacseq generate_protein_fasta [-h] [-d DOWNSTREAM_SEQUENCE_LENGTH]
                                      input_file peptide_sequence_length
                                      output_file

positional arguments:
  input_file            A VEP-annotated single-sample VCF containing
                        transcript, Wildtype protein sequence, and Downstream
                        protein sequence information
  peptide_sequence_length
                        Length of the peptide sequence to use when creating
                        the FASTA.
  output_file           The output fasta file

optional arguments:
  -h, --help            show this help message and exit
  -d DOWNSTREAM_SEQUENCE_LENGTH, --downstream-sequence-length DOWNSTREAM_SEQUENCE_LENGTH
                        Cap to limit the downstream sequence length for
                        frameshifts when creating the fasta file. Use 'full'
                        to include the full downstream sequence. Default: 1000
```

## pvacseq_download_example_data

### Tool Description
Download example data for pVACseq

### Metadata
- **Docker Image**: quay.io/biocontainers/pvacseq:4.0.10--py36_0
- **Homepage**: https://github.com/griffithlab/pVAC-Seq
- **Package**: https://anaconda.org/channels/bioconda/packages/pvacseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pvacseq download_example_data [-h] destination_directory

positional arguments:
  destination_directory
                        Directory for downloading example data

optional arguments:
  -h, --help            show this help message and exit
```

## pvacseq_install_vep_plugin

### Tool Description
Install the pVACseq VEP plugin into your VEP_plugins directory

### Metadata
- **Docker Image**: quay.io/biocontainers/pvacseq:4.0.10--py36_0
- **Homepage**: https://github.com/griffithlab/pVAC-Seq
- **Package**: https://anaconda.org/channels/bioconda/packages/pvacseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pvacseq install_vep_plugin [-h] vep_plugins_path

positional arguments:
  vep_plugins_path  Path to your VEP_plugins directory

optional arguments:
  -h, --help        show this help message and exit
```

## pvacseq_config_files

### Tool Description
Retrieve more information for specific config file types

### Metadata
- **Docker Image**: quay.io/biocontainers/pvacseq:4.0.10--py36_0
- **Homepage**: https://github.com/griffithlab/pVAC-Seq
- **Package**: https://anaconda.org/channels/bioconda/packages/pvacseq/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pvacseq config_files [-h] {additional_input_file_list}

positional arguments:
  {additional_input_file_list}
                        The config file type to retrieve more information for

optional arguments:
  -h, --help            show this help message and exit
```

## Metadata
- **Skill**: not generated
