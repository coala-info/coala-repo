# relecov-tools CWL Generation Report

## relecov-tools_download

### Tool Description
Download files located in sftp server.

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-12-15
- **GitHub**: https://github.com/BU-ISCIII/relecov-tools
- **Stars**: N/A
### Original Help Text
```text
Usage: relecov-tools download [OPTIONS]

  Download files located in sftp server.

Options:
  -u, --user TEXT                 User name for login to sftp server
  -p, --password TEXT             password for the user to login
  -f, --conf_file TEXT            Configuration file (not params file)
  -d, --download_option TEXT      Select the download option: [download_only,
                                  download_clean, delete_only].
                                  download_only will only download the files
                                  download_clean will remove files from sftp
                                  after download         delete_only will only
                                  delete the files
  -o, --output_dir, --output-dir, --output_folder, --out-folder, --output_location, --output_path, --out_dir, --output DIRECTORY
                                  Directory where the generated output will be
                                  saved
  -t, --target_folders TEXT       Flag: Select which folders will be targeted
                                  giving [paths] or via prompt. For multiple
                                  folders use ["folder1", "folder2"]
  -s, --subfolder TEXT            Flag: Specify which subfolder to process
  --help                          Show this message and exit.
```


## relecov-tools_read-lab-metadata

### Tool Description
Create the json compliant to the relecov schema from the Metadata file.

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: relecov-tools read-lab-metadata [OPTIONS]

  Create the json compliant to the relecov schema from the Metadata file.

Options:
  -m, --metadata_file PATH        file containing metadata
  -s, --sample_list_file PATH     Json with the additional metadata to add to
                                  the received user metadata
  -o, --output_dir, --output-dir, --output_folder, --out-folder, --output_location, --output_path, --out_dir, --output DIRECTORY
                                  Directory where the generated output will be
                                  saved
  -f, --files-folder PATH         Path to folder where samples files are
                                  located
  -p, --project TEXT              Project configuration key defined under
                                  read_lab_metadata.projects
  --help                          Show this message and exit.
```


## relecov-tools_send-mail

### Tool Description
Send a sample validation report by mail.

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: relecov-tools send-mail [OPTIONS]

  Send a sample validation report by mail.

Options:
  -v, --validate_file PATH     Path to the validation summary json file
                               (validate_log_summary.json)  [required]
  -r, --receiver_email TEXT    Recipient's e-mail address (optional). If not
                               provided, it will be extracted from the
                               institutions guide.
  -a, --attachments PATH       Path to file
  -t, --template_path PATH     Path to relecov-tools templates folder
                               (optional)
  -p, --email_psswd TEXT       Password for bioinformatica@isciii.es
  -n, --additional_notes PATH  Path to a .txt file with additional notes to
                               include in the email (optional).
  --help                       Show this message and exit.
```


## relecov-tools_validate

### Tool Description
Validate json file against schema.

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: relecov-tools validate [OPTIONS]

  Validate json file against schema.

Options:
  -j, --json_file TEXT            Json file to validate
  -s, --json_schema_file TEXT     Path to the JSON Schema file used for
                                  validation
  -m, --metadata PATH             Origin file containing metadata
  -o, --output_dir, --output-dir, --output_folder, --out-folder, --output_location, --output_path, --out_dir, --output DIRECTORY
                                  Directory where the generated output will be
                                  saved
  -e, --excel_sheet TEXT          Optional: Name of the sheet in excel file to
                                  validate.
  -u, --upload_files              Wether to upload the resulting files from
                                  validation process or not.
  -l, --logsum_file TEXT          Required if --upload_files. Path to the
                                  log_summary.json file merged from all
                                  previous processes, used to check for
                                  invalid samples.
  -s, --samples_json FILE         Optional: Path to samples_data*.json to
                                  auto-detect corrupted files.
  -c, --check_db                  Check if the processed samples are already
                                  uploaded to platform database and make
                                  invalid those that are already there
  --help                          Show this message and exit.
```


## relecov-tools_map

### Tool Description
Convert data between phage plus schema to ENA, GISAID, or any other schema

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: relecov-tools map [OPTIONS]

  Convert data between phage plus schema to ENA, GISAID, or any other schema

Options:
  -p, --origin_schema TEXT        File with the origin (relecov) schema
  -j, --json_data TEXT            File with the json data to convert
  -d, --destination_schema [ENA|GISAID|other]
                                  schema to be mapped
  -f, --schema_file TEXT          file with the custom schema
  -o, --output_dir, --output-dir, --output_folder, --out-folder, --output_location, --output_path, --out_dir, --output DIRECTORY
                                  Directory where the generated output will be
                                  saved
  --help                          Show this message and exit.
```


## relecov-tools_upload-to-ena

### Tool Description
parse data to create xml files to upload to ena

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: relecov-tools upload-to-ena [OPTIONS]

  parse data to create xml files to upload to ena

Options:
  -u, --user TEXT                 user name for login to ena
  -p, --password TEXT             password for the user to login
  -c, --center TEXT               center name
  -e, --ena_json TEXT             where the validated json is
  -t, --template_path TEXT        Path to ENA templates folder
  -a, --action [add|modify|cancel|release]
                                  select one of the available options
  --dev                           Test submission
  --upload_fastq                  Upload fastq files
  -m, --metadata_types TEXT       List of metadata xml types to submit
  -o, --output_dir, --output-dir, --output_folder, --out-folder, --output_location, --output_path, --out_dir, --output DIRECTORY
                                  Directory where the generated output will be
                                  saved
  --help                          Show this message and exit.
```


## relecov-tools_upload-to-gisaid

### Tool Description
parsed data to create files to upload to gisaid

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: relecov-tools upload-to-gisaid [OPTIONS]

  parsed data to create files to upload to gisaid

Options:
  -u, --user TEXT                 user name for login
  -p, --password TEXT             password for the user to login
  -c, --client_id TEXT            client-ID provided by clisupport@gisaid.org
  -t, --token TEXT                path to athentication token
  -e, --gisaid_json TEXT          path to validated json mapped to GISAID
  -i, --input_path TEXT           path to fastas folder or multifasta file
  -o, --output_dir, --output-dir, --output_folder, --out-folder, --output_location, --output_path, --out_dir, --output DIRECTORY
                                  Directory where the generated output will be
                                  saved
  -f, --frameshift [catch_all|catch_none|catch_novel]
                                  frameshift notification
  -x, --proxy_config TEXT         introduce your proxy credentials as:
                                  username:password@proxy:port
  --single                        input is a folder with several fasta files.
                                  Default: False
  --gzip                          input fasta is gziped. Default: False
  --help                          Show this message and exit.
```


## relecov-tools_update-db

### Tool Description
upload the information included in json file to the database

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: relecov-tools update-db [OPTIONS]

  upload the information included in json file to the database

Options:
  -j, --json TEXT                 data in json format
  -t, --type TEXT                 Select the upload target. Without
                                  --full_update choose one of
                                  [sample|bioinfodata|variantdata]. With
                                  --full_update provide the step numbers to
                                  run in order: 1=sample->iSkyLIMS,
                                  2=sample->relecov, 3=bioinfodata->relecov,
                                  4=variantdata->relecov.
  -plat, --platform [iskylims|relecov]
                                  name of the platform where data is uploaded
  -u, --user TEXT                 user name for login
  -p, --password TEXT             password for the user to login
  -s, --server_url TEXT           url of the platform server
  -f, --full_update TEXT          Run the full update. Use without value to
                                  run all steps. Optionally pass a comma-
                                  separated list of step numbers to run only
                                  those: 1=sample->iSkyLIMS,
                                  2=sample->relecov, 3=bioinfodata->relecov,
                                  4=variantdata->relecov.
  -l, --long_table TEXT           Long_table.json file from read-bioinfo-
                                  metadata + viralrecon
  --help                          Show this message and exit.
```


## relecov-tools_read-bioinfo-metadata

### Tool Description
Create the json compliant from the Bioinfo Metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: relecov-tools read-bioinfo-metadata [OPTIONS]

  Create the json compliant  from the Bioinfo Metadata.

Options:
  -j, --json_file PATH            json file containing lab metadata
  -s, --json_schema_file TEXT     Path to the JSON Schema file used for
                                  validation
  -i, --input_folder PATH         Path to input files
  -o, --output_dir, --output-dir, --output_folder, --out-folder, --output_location, --output_path, --out_dir, --output DIRECTORY
                                  Directory where the generated output will be
                                  saved
  -p, --software_name TEXT        Name of the software/pipeline used.
  --update                        If the output file already exists, ask if
                                  you want to update it.
  --soft_validation               If the module should continue even if any
                                  sample does not validate.
  --help                          Show this message and exit.
```


## relecov-tools_metadata-homogeneizer

### Tool Description
Parse institution metadata lab to the one used in relecov

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: relecov-tools metadata-homogeneizer [OPTIONS]

  Parse institution metadata lab to the one used in relecov

Options:
  -i, --institution [isciii|hugtip|hunsc-iter]
                                  select one of the available institution
                                  options
  -d, --directory PATH            Folder where are located the additional
                                  files
  -o, --output_dir, --output-dir, --output_folder, --out-folder, --output_location, --output_path, --out_dir, --output DIRECTORY
                                  Directory where the generated output will be
                                  saved
  --help                          Show this message and exit.
```


## relecov-tools_pipeline-manager

### Tool Description
Create the symbolic links for the samples which are validated to prepare for bioinformatics pipeline execution.

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: relecov-tools pipeline-manager [OPTIONS]

  Create the symbolic links for the samples which are validated to prepare for
  bioinformatics pipeline execution.

Options:
  -i, --input PATH                select input folder where are located the
                                  sample files
  -t, --templates_root PATH       Path to folder containing the pipeline
                                  templates from buisciii-tools
  -o, --output_dir, --output-dir, --output_folder, --out-folder, --output_location, --output_path, --out_dir, --output DIRECTORY
                                  Directory where the generated output will be
                                  saved
  -f, --folder_names TEXT         Folder basenames to process. Target folders
                                  names should match the given dates. E.g. ...
                                  -f folder1 -f folder2 -f folder3
  -s, --skip_db_upload BOOLEAN    Skip the database upload step. This is
                                  useful for testing purposes.
  --help                          Show this message and exit.
```


## relecov-tools_build-schema

### Tool Description
Generates and updates JSON Schema files from Excel-based database definitions.

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: relecov-tools build-schema [OPTIONS]

  Generates and updates JSON Schema files from Excel-based database
  definitions.

Options:
  -i, --input_file PATH           Path to the Excel document containing the
                                  database definition. This file must have a
                                  .xlsx extension.  [required]
  -s, --schema_base PATH          Path to the base schema file. This file is
                                  used as a reference to compare it with the
                                  schema generated using this module.
                                  (Default: installed schema in 'relecov-tools
                                  /relecov_tools/schema/relecov_schema.json')
  -e, --excel_template PATH       Path to the excel template file. This file
                                  is used to get version history of the excel
                                  template (stored in
                                  assets/Relecov_metadata_*.xlsx)
  -v, --draft_version TEXT        Version of the JSON schema specification to
                                  be used. Example: '2020-12'. See:
                                  https://json-schema.org/specification-links
  -d, --diff                      Prints a changelog/diff between the base and
                                  incoming versions of the schema.
  --version TEXT                  Specify the schema version.
  -p, --project TEXT              Specficy the project to build the metadata
                                  template.
  --non-interactive               Run the script without user interaction,
                                  using default values.
  -o, --output_dir, --output-dir, --output_folder, --out-folder, --output_location, --output_path, --out_dir, --output DIRECTORY
                                  Directory where the generated output will be
                                  saved
  --help                          Show this message and exit.
```


## relecov-tools_logs-to-excel

### Tool Description
Creates a merged xlsx and Json report from all the log summary jsons given as input

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: relecov-tools logs-to-excel [OPTIONS]

  Creates a merged xlsx and Json report from all the log summary jsons given
  as input

Options:
  -l, --lab_code PATH             Only merge logs from target laboratory in
                                  log-summary.json files
  -o, --output_dir, --output-dir, --output_folder, --out-folder, --output_location, --output_path, --out_dir, --output DIRECTORY
                                  Directory where the generated output will be
                                  saved
  -f, --files TEXT                Paths to log_summary.json files to merge
                                  into xlsx file, called once per file
                                  [required]
  --help                          Show this message and exit.
```


## relecov-tools_wrapper

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/lib/python3.12/site-packages/relecov_tools/utils.py:165: SyntaxWarning: invalid escape sequence '\d'
  new_reg = sep + "\d{2}"  # Each date param occupies 2 digits (4 for year)
                ___   ___       ___  ___  ___                           
   \    |--|   |   \ |    |    |    |    |   | \      /  
    \   \  /   |__ / |__  |    |___ |    |   |  \    /   
    /   /  \   |  \  |    |    |    |    |   |   \  /    
   /    |--|   |   \ |___ |___ |___ |___ |___|    \/     

    RELECOV-tools version 1.7.4
Usage: relecov-tools wrapper [OPTIONS]
Try 'relecov-tools wrapper --help' for help.

Error: No such option: --h Did you mean --help?
```


## relecov-tools_upload-results

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/lib/python3.12/site-packages/relecov_tools/utils.py:165: SyntaxWarning: invalid escape sequence '\d'
  new_reg = sep + "\d{2}"  # Each date param occupies 2 digits (4 for year)
                ___   ___       ___  ___  ___                           
   \    |--|   |   \ |    |    |    |    |   | \      /  
    \   \  /   |__ / |__  |    |___ |    |   |  \    /   
    /   /  \   |  \  |    |    |    |    |   |   \  /    
   /    |--|   |   \ |___ |___ |___ |___ |___|    \/     

    RELECOV-tools version 1.7.4
Usage: relecov-tools upload-results [OPTIONS]
Try 'relecov-tools upload-results --help' for help.

Error: No such option: --h Did you mean --help?
```


## relecov-tools_add-extra-config

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/relecov-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/relecov-tools/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/lib/python3.12/site-packages/relecov_tools/utils.py:165: SyntaxWarning: invalid escape sequence '\d'
  new_reg = sep + "\d{2}"  # Each date param occupies 2 digits (4 for year)
                ___   ___       ___  ___  ___                           
   \    |--|   |   \ |    |    |    |    |   | \      /  
    \   \  /   |__ / |__  |    |___ |    |   |  \    /   
    /   /  \   |  \  |    |    |    |    |   |   \  /    
   /    |--|   |   \ |___ |___ |___ |___ |___|    \/     

    RELECOV-tools version 1.7.4
Usage: relecov-tools add-extra-config [OPTIONS]
Try 'relecov-tools add-extra-config --help' for help.

Error: No such option: --h Did you mean --help?
```


## Metadata
- **Skill**: generated
