# ena-webin-cli CWL Generation Report

## ena-webin-cli

### Tool Description
Validate and submit files to ENA using the Webin submission service. Use the -fields option to see supported manifest fields for all contexts or for a specific -context. Detailed instructions are available from: https://ena-docs.readthedocs.io/en/latest/cli.html

### Metadata
- **Docker Image**: quay.io/biocontainers/ena-webin-cli:9.0.3--hdfd78af_0
- **Homepage**: https://github.com/enasequence/webin-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/ena-webin-cli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ena-webin-cli/overview
- **Total Downloads**: 146.3K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/enasequence/webin-cli
- **Stars**: N/A
### Original Help Text
```text
Usage: java -jar webin-cli-9.0.3.jar [-ascp] [-fields] [-help] [-sampleUpdate]
                                     [-submit] [-test] [-validate]
                                     [-validateFiles] [-version]
                                     [-centerName=CENTER] -context=TYPE
                                     [-inputDir=DIRECTORY] -manifest=FILE
                                     [-outputDir=DIRECTORY]
                                     [-password=PASSWORD] [-passwordEnv=VAR]
                                     [-passwordFile=FILE] -userName=USER

Description:

Validate and submit files to ENA using the Webin submission service. Use the
-fields option to see supported manifest fields for all contexts or for a
specific -context. Detailed instructions are available from:
https://ena-docs.readthedocs.io/en/latest/cli.html

Options:
      -context=TYPE        Submission type: genome, transcriptome, sequence,
                             polysample, reads, taxrefset
      -manifest=FILE       Manifest text file containing file and metadata
                             fields.
      -userName, -username=USER
                           Webin submission account name or e-mail address.
      -password=PASSWORD   Webin submission account password.
      -passwordFile=FILE   File containing the Webin submission account
                             password.
      -passwordEnv=VAR     Environment variable containing the Webin submission
                             account password.
      -inputDir, -inputdir=DIRECTORY
                           Root directory for the files declared in the
                             manifest file. By default the current working
                             directory is used as the input directory.
      -outputDir, -outputdir=DIRECTORY
                           Root directory for any output files written in
                             <context>/<name>/<validate,process,submit>
                             directory structure. By default the manifest file
                             directory is used as the output directory. The
                             <name> is the unique name from the manifest file.
                             The validation reports are written in the
                             <validate> sub-directory.
      -centerName, -centername=CENTER
                           Mandatory center name for broker accounts.
      -validate            Validate files without uploading or submitting them.
      -validateFiles       All manifest fields become optional to allow read
                             file validation without having to provide metadata.
      -submit              Validate, upload and submit files.
      -test                Use the test submission service.
      -ascp                Use Aspera (if Aspera Cli is available) instead of
                             FTP when uploading files. The path to the
                             installed "ascp" program must be in the PATH
                             variable.
      -help                Show this help message and exit.
      -fields              Show manifest fields for all contexts or for the
                             given -context.
      -version             Print version information and exit.
      -sampleUpdate        Update the submitted sample if it already exists.
 Exit codes: 0=SUCCESS, 1=INTERNAL ERROR, 2=USER ERROR, 3=VALIDATION ERROR
```

