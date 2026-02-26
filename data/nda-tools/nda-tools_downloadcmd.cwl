cwlVersion: v1.2
class: CommandLineTool
baseCommand: downloadcmd
label: nda-tools_downloadcmd
doc: "This application allows you to download files from an NDA package. Tutorials
  for creating packages can be found on the website (links provided below). Information
  for packages, including package-ids, are displayed on the packages dashboard page
  (https://nda.nih.gov/user/dashboard/packages.html). Users can only download data
  from \"personal\" type packages. To download files from a \"shared\" package you
  need to convert it to a \"personal\" package first, which can be done by clicking
  the \"Add to my data packages\" button in the actions dropdown. \nLinks:\n\tvideo
  tutorial - https://nda.nih.gov/tutorials/nda/accessing_files_in_the_cloud.html?chapter=creating-a-package\
  \ \npdf - https://ndar.nih.gov/ndarpublicweb/Documents/Accessing+Shared+Data+Sept_2021-1.pdf\n\
  \nTool homepage: https://github.com/NDAR/nda-tools"
inputs:
  - id: s3_path_list
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional. When provided, the program will download only the specified 
      files from the package. The specified files must exist in the package 
      indicated by the -dp argument and the paths must be valid s3 urls.
    inputBinding:
      position: 1
  - id: download_directory
    type:
      - 'null'
      - Directory
    doc: Enter an alternate full directory path where you would like your files 
      to be saved. The default is ~/NDA/nda-tools/<package-id>
    inputBinding:
      position: 102
      prefix: --directory
  - id: file_regex
    type:
      - 'null'
      - string
    doc: "Option can be used to download only a subset of the files in a package.\
      \  This command line arg can be used with\n                        the -ds,
      -dp or -t flags. \n                        \n                        Examples
      - \n                        1) To download all files with a \".txt\" extension,
      you can use the regular expression .*.txt\n                            downloadcmd
      -dp 12345 --file-regex .*.txt\n                        2) To download all files
      that contain \"NDARINVZLHFUAF0\" in the name, you can use the regular expression
      NDARINVZLHFUAF0 \n                            downloadcmd -dp 12345 -ds image03
      --file-regex NDARINVZLHFUAF0  \n                        3) Finally to download
      all files underneath a folder called \"T1w\" you can use the regular expression
      .*/T1w/.* \n                            downloadcmd -dp 12345 -t s3-links.txt
      --file-regex .*/T1w/.*"
    inputBinding:
      position: 102
      prefix: --file-regex
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: Customize the file directory of logs. If this value is not provided or 
      the provided directory does not exist, logs will be saved to 
      NDA/nda-tools/downloadcmd/logs inside your root folder.
    inputBinding:
      position: 102
      prefix: --log-dir
  - id: package_id
    type: string
    doc: The package_id containing the files you wish to download. If no other 
      command-line options are provided, the program will download all files 
      from the specified package.
    inputBinding:
      position: 102
      prefix: --package
  - id: s3_links_file
    type:
      - 'null'
      - File
    doc: Flags that a text file has been entered from where to download S3 
      files. For more details, check the information on the README page.
    inputBinding:
      position: 102
      prefix: --txt
  - id: structure_short_name
    type:
      - 'null'
      - string
    doc: "Downloads all the files in a package from the specified data-structure.\
      \ \n                        For example, to download all the image03 files from
      your package 12345, you should enter:\n                            downloadcmd
      -dp 12345 -ds image03\n                        Note - the program only recognizes
      the short-names of the data-structures. The short-name is listed on the data-structures
      page \n                        and always ends in a 2 digit number. (For example,
      see the data-structure page for image03 at https://nda.nih.gov/data_structure.html?short_name=image03)"
    inputBinding:
      position: 102
      prefix: --datastructure
  - id: thread_count
    type:
      - 'null'
      - int
    doc: "Specifies the number of downloads to attempt in parallel. For example, running
      'downloadcmd -dp 12345 -wt 10' will \n                        cause the program
      to download a maximum of 10 files simultaneously until all of the files from
      package 12345 have been downloaded. \n                        A default value
      is calculated based on the number of cpus found on the machine, however a higher
      value can be chosen to decrease download times. \n                        If
      this value is set too high the download will slow. With 32 GB of RAM, a value
      of '10' is probably close to the maximum number of \n                      \
      \  parallel downloads that the computer can handle"
    inputBinding:
      position: 102
      prefix: --workerThreads
  - id: username
    type:
      - 'null'
      - string
    doc: NDA username
    inputBinding:
      position: 102
      prefix: --username
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enables debug logging.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: verify
    type:
      - 'null'
      - boolean
    doc: "When this option is provided a download is not initiated. Instead, a csv
      file is produced that contains a record of \n                        the files
      in the download, along with information about the file-size if the file could
      be found on the computer. For large packages containing millions of files, \n\
      \                        this verification step can take hours (this can be
      even longer if files are stored on a network drive). When the program finishes,
      a few new files/folders \n                        will be created (if they don't
      already exist):\n                        1) verification_report folder in the
      NDA/nda-tools/downloadcmd/packages/<package-id> directory\n                \
      \        2) .download_progress folder (hidden) in the NDA/nda-tools/downloadcmd/packages/<package-id>,
      which is used to values between command invocations.\n                     \
      \       a. .download_progress/download-job-manifest.csv file - contains entries
      mapping \n                            b. UUID folders inside .download_progress
      (with names like '6a056ac4-2dd9-48f2-b921-44b29c883578')\n                 \
      \       3) download-verification-report.csv in the NDA/nda-tools/downloadcmd/packages/<package-id>
      directory\n                        4) download-verification-retry-s3-links.csv
      in the NDA/nda-tools/downloadcmd/packages/<package-id> directory\n         \
      \               \n                        The hidden folder listed in 2 contains
      special files used by the program to avoid re-running expensive, time-consuming
      processes. This folder should not be deleted. \n                        \n \
      \                       The download-verification-report.csv file will contain
      a record for each file in the download and contain 6 columns :\n           \
      \             1) 'package_file_id'\n                        2) 'package_file_expected_location'
      - base path is the value provided for the -d/--directory arg\n             \
      \           3) 'nda_s3_url'\n                        4) 'exists' - value for
      column will be ('Y'/'N')\n                        5) 'expected_size'\n     \
      \                   6) 'actual_file_size' - value for columnw will be '0' if
      file doesn't exist\n                        \n                        In addition,
      the file will contain 1 header line which will provide the parameters used for
      the download (more information below). \n                        \n        \
      \                If this file is opened in Excel or Google Docs, the user can
      easily find information on specific files that they are interested in. \n  \
      \                      \n                        This file can be useful but
      may contain more information than is needed. The download-verification-retry-s3-links.csv
      file contains the s3 links for all of the files \n                        in
      the download-verification-report.csv where EXISTS = 'N' or EXPECTED-SIZE does
      not equal ACTUAL-FILE-SIZE. If the user is only interested in re-initiating
      the download \n                        for the files that failed they can do
      so by using the  download-verification-retry-s3-links.csv as the value for the
      -t argument. i.e. \n                        \n                        downloadcmd
      -dp <package-id> -t NDA/nda-tools/downloadcmd/packages/<package-id>/download-verification-retry-s3-links.csv\
      \ \n                        \n                        When the --verify option
      is provided, the rest of the arguments provided to the command are used to determine
      what files are supposed to be included in the download. \n                 \
      \       \n                        For example, if the user runs:  \n       \
      \                    downloadcmd -dp 12345 --verify\n                      \
      \  The download-verification-report.csv file will contain a record for each
      file in the package 12345. Since no -d/--directory argument is provided, the
      program \n                        will check for the existance of the files
      in the default download location. \n                        \n             \
      \           If the user runs:\n                           downloadcmd -dp 12345
      -d /home/myuser/customdirectory --verify\n                        The download-verification-report.csv
      file will contain a record for each file in the package 12345 and will check
      for the existance of files in the /foo/bar\n                        \n     \
      \                   If the user runs:\n                           downloadcmd
      -dp 12345 -d /home/myuser/customdirectory -t file-with-s3-links.csv --verify\n\
      \                        The download-verification-report.csv file will contain
      a record for each file listed in the file-with-s3-links.csv and will check for
      the existance of files in /foo/bar\n                        \n             \
      \           If the user runs:\n                           downloadcmd -dp 12345
      -d /home/myuser/customdirectory -ds image03 --verify\n                     \
      \   The download-verification-report.csv file will contain a record for each
      file in the package's image03 data-structure and will check for the existance
      of files in /foo/bar\n                        \n                        If the
      user runs:\n                           downloadcmd -dp 12345 -d /home/myuser/customdirectory
      -ds image03 --file-regex --verify\n                        The download-verification-report.csv
      file will contain a record for each file in the package's image03 data-structure
      which also matches the file-regex and will check \n                        for
      the existance of files in /foo/bar\n                        \n             \
      \           NOTE - at the moment, this option cannot be used to verify downloads
      to s3 locations (see -s3 option below). That will be implemented in the near\n\
      \                        future."
    inputBinding:
      position: 102
      prefix: --verify
outputs:
  - id: s3_destination
    type:
      - 'null'
      - File
    doc: "Specify s3 location which you would like to download your files to. When
      this option is specified, an attempt will be made\n                        to
      copy the files from your package, which are stored in NDA's own S3 repository,
      to the S3 bucket provided. \n                        \n                    \
      \    For s3-to-s3 copy operations to be successful, the s3 bucket supplied as
      the program argument must be configured to allow PUT object \n             \
      \           operations  for 'arn:aws:sts::618523879050:federated-user/<username>'
      where <username> is your nda username. \n                        For non-public
      buckets, this will require an update to your bucket's policy. The following
      statement should be sufficient to grant the uploading privileges necessary \n\
      \                        to run this program using the s3 argument after replacing
      <your-s3-bucket> with the bucket name: \n                                 {\n\
      \                                    \"Sid\": \"AllowNDAUpload\",\n        \
      \                            \"Effect\": \"Allow\",\n                      \
      \              \"Principal\": {\n                                        \"\
      AWS\": \"arn:aws:iam::618523879050:federated-user/<username>\"\t\t\n       \
      \                             },\n                                    \"Action\"\
      : \"s3:PutObject*\",\n                                    \"Resource\": \"arn:aws:s3:::<your-s3-bucket>/*\"\
      \n                                }\n                                \n    \
      \                    You may need to email your company/institution IT department
      to have this added for you.\n                        Note: If your bucket is
      encrypted with a customer-managed KMS key, then additional configuration is
      needed. \n                        For more details, check the information on
      the README page."
    outputBinding:
      glob: $(inputs.s3_destination)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nda-tools:0.6.0--pyh7e72e81_0
