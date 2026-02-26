# ega-cryptor CWL Generation Report

## ega-cryptor

### Tool Description
EgaCryptorApplication v2.0.0

### Metadata
- **Docker Image**: quay.io/biocontainers/ega-cryptor:2.0.0--hdfd78af_0
- **Homepage**: https://ega-archive.org/submission/data/file-preparation/egacryptor/
- **Package**: https://anaconda.org/channels/bioconda/packages/ega-cryptor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ega-cryptor/overview
- **Total Downloads**: 374
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
______    _____                        _____                          _
 |  ____|  / ____|     /\               / ____|                        | |
 | |__    | |  __     /  \     ______  | |       _ __   _   _   _ __   | |_    ___    _ __
 |  __|   | | |_ |   / /\ \   |______| | |      | '__| | | | | | '_ \  | __|  / _ \  | '__|
 | |____  | |__| |  / ____ \           | |____  | |    | |_| | | |_) | | |_  | (_) | | |
 |______|  \_____| /_/    \_\           \_____| |_|     \__, | | .__/   \__|  \___/  |_|
                                                         __/ | | |
                                                        |___/  |_|
2026-02-25 18:37:56.851  INFO 7 --- [           main] u.a.e.e.e.EgaCryptorApplication          : Starting EgaCryptorApplication v2.0.0 on 4a9f6812d25b with PID 7 (/usr/local/share/ega-cryptor-2.0.0-0/ega-cryptor-2.0.0.jar started by root in /)
2026-02-25 18:37:56.852  INFO 7 --- [           main] u.a.e.e.e.EgaCryptorApplication          : No active profile set, falling back to default profiles: default
2026-02-25 18:37:57.573  INFO 7 --- [           main] u.a.e.e.e.EgaCryptorApplication          : Started EgaCryptorApplication in 0.962 seconds (JVM running for 1.379)
2026-02-25 18:37:57.581 ERROR 7 --- [           main] u.a.e.e.e.c.pgp.PGPCryptography          : Passed invalid command line arguments
Option (* = required)  Description                                             
---------------------  -----------                                             
-f                     Set this option to allow application to create maximum  
                         threads to utilize full capacity of cores/processors  
                         available on machine                                  
-h                     Use this option to get help                             
* -i <String>          File(s) to encrypt. Provide file/folder path or comma   
                         separated file path if multiple files in double quotes
-l                     Set this option to allow application to create maximum  
                         threads equals to 50% capacity of cores/processors    
                         available on machine                                  
-m                     Set this option to allow application to create maximum  
                         threads equals to 75% capacity of cores/processors    
                         available on machine                                  
-o <String>            Path of the output file. This is optional. If not       
                         provided then output files will be generated in the   
                         same path as that of source file (default: output-    
                         files)                                                
-t <Integer>           Set this option if user wants to control application to 
                         create maximum threads as specified. Application will 
                         calculate no. of cores/processors available on machine
                         & will create threads accordingly
```

