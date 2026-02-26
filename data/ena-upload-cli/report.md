# ena-upload-cli CWL Generation Report

## ena-upload-cli

### Tool Description
The program makes submission of data and respective metadata to European Nucleotide Archive (ENA) easy. The metadata can be provided in a xlsx spreadsheet or tsv tables.

### Metadata
- **Docker Image**: quay.io/biocontainers/ena-upload-cli:0.9.0--pyhdfd78af_0
- **Homepage**: https://github.com/usegalaxy-eu/ena-upload-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/ena-upload-cli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ena-upload-cli/overview
- **Total Downloads**: 69.1K
- **Last updated**: 2025-05-19
- **GitHub**: https://github.com/usegalaxy-eu/ena-upload-cli
- **Stars**: N/A
### Original Help Text
```text
usage: ena-upoad-cli [-h] [--version] --action {add,modify,cancel,release}
                     [--study STUDY] [--sample SAMPLE]
                     [--experiment EXPERIMENT] [--run RUN] [--data [FILE ...]]
                     --center CENTER_NAME [--checklist CHECKLIST]
                     [--xlsx XLSX] [--isa_json ISA_JSON]
                     [--isa_assay_stream [ISA_ASSAY_STREAM ...]]
                     [--auto_action] [--tool TOOL_NAME]
                     [--tool_version TOOL_VERSION] [--no_data_upload]
                     [--draft] --secret SECRET [-d]

The program makes submission of data and respective metadata to European
Nucleotide Archive (ENA) easy. The metadata can be provided in a xlsx
spreadsheet or tsv tables.

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --action {add,modify,cancel,release}
                         add: add an object to the archive
                         modify: modify an object in the archive
                         cancel: cancel a private object and its dependent objects
                         release: release a private object immediately to public
  --study STUDY         table of STUDY object
  --sample SAMPLE       table of SAMPLE object
  --experiment EXPERIMENT
                        table of EXPERIMENT object
  --run RUN             table of RUN object
  --data [FILE ...]     data for submission, this can be a list of files
  --center CENTER_NAME  specific to your Webin account
  --checklist CHECKLIST
                        specify the sample checklist with following pattern:
                        ERC0000XX, Default: ERC000011
  --xlsx XLSX           filled in excel template with metadata
  --isa_json ISA_JSON   BETA: ISA json describing describing the ENA objects
  --isa_assay_stream [ISA_ASSAY_STREAM ...]
                        BETA: specify the assay stream(s) that holds the ENA
                        information, this can be a list of assay streams
  --auto_action         BETA: detect automatically which action (add or
                        modify) to apply when the action column is not given
  --tool TOOL_NAME      specify the name of the tool this submission is done
                        with. Default: ena-upload-cli
  --tool_version TOOL_VERSION
                        specify the version of the tool this submission is
                        done with
  --no_data_upload      indicate if no upload should be performed and you like
                        to submit a RUN object (e.g. if uploaded was done
                        separately).
  --draft               indicate if no submission should be performed
  --secret SECRET       .secret.yml file containing the password and Webin ID
                        of your ENA account
  -d, --dev             flag to use the dev/sandbox endpoint of ENA
```

