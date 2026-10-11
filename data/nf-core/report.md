# nf-core CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| nf-core_modules_create | PASS |  |
| nf-core_modules_lint | PASS |  |
| nf-core_pipelines_create | PASS |  |
| nf-core_pipelines_lint | PASS |  |
| nf-core_subworkflows_create | PASS |  |
| nf-core_subworkflows_lint | PASS |  |

## nf-core_pipelines_create

### Tool Description
Create a new pipeline using the nf-core template

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
- **Homepage**: https://nf-co.re/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-core/overview
- **Validation**: PASS

### Original Help Text
```text


                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\ 
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 3.5.2 - https://nf-co.re
    There is a new version of nf-core/tools available! (4.1.0)


 Usage: nf-core pipelines create [OPTIONS]                                                          
                                                                                                    
 Create a new pipeline using the nf-core template.                                                  
                                                                                                    
 ═ Options ════════════════════════════════════════════════════════════════════════════════════════ 
 --name           -n  The name of your new pipeline [TEXT]                                          
 --description    -d  A short description of your pipeline [TEXT]                                   
 --author         -a  Name of the main author(s) [TEXT]                                             
 --version            The initial version number to use [TEXT]                                      
 --force          -f  Overwrite output directory if it already exists                               
 --outdir         -o  Output directory for new pipeline (default: pipeline name) [TEXT]             
 --template-yaml  -t  Pass a YAML file to customize the template [TEXT]                             
 --organisation       The name of the GitHub organisation where the pipeline will be hosted         
                      (default: nf-core) [TEXT]                                                     
 --help           -h  Show this message and exit.
```

## nf-core_pipelines_lint

### Tool Description
Check pipeline code against nf-core guidelines

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
- **Homepage**: https://nf-co.re/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-core/overview
- **Validation**: PASS

### Original Help Text
```text


                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\ 
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 3.5.2 - https://nf-co.re
    There is a new version of nf-core/tools available! (4.1.0)


 Usage: nf-core pipelines lint [OPTIONS]                                                            
                                                                                                    
 Check pipeline code against nf-core guidelines.                                                    
                                                                                                    
 ═ Options ════════════════════════════════════════════════════════════════════════════════════════ 
 --dir           -d  Pipeline directory [default: current working directory] [PATH]                 
 --release           Execute additional checks for release-ready workflows.                         
 --fix           -f  Attempt to automatically fix specified lint test [<test>]                      
 --key           -k  Run only these lint tests [<test>]                                             
 --show-passed   -p  Show passing tests on the command line                                         
 --fail-ignored  -i  Convert ignored tests to failures                                              
 --fail-warned   -w  Convert warn tests to failures                                                 
 --markdown          File to write linting results to (Markdown) [<filename>]                       
 --json              File to write linting results to (JSON) [<filename>]                           
 --sort-by           Sort lint output by module or test name. [module|test] (Default: test)         
 --plain-text        Print results in plain text format without Rich formatting (easier to copy).   
                     Can also be enabled with env var NF_CORE_LINT_OUTPUT.                          
 --help          -h  Show this message and exit.
```

## nf-core_modules_create

### Tool Description
Create a new DSL2 module from the nf-core template

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
- **Homepage**: https://nf-co.re/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-core/overview
- **Validation**: PASS

### Original Help Text
```text


                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\ 
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 3.5.2 - https://nf-co.re
    There is a new version of nf-core/tools available! (4.1.0)


 Usage: nf-core modules create [OPTIONS] <tool> or <tool/subtool>                                   
                                                                                                    
 Create a new DSL2 module from the nf-core template.                                                
                                                                                                    
 ═ Options ════════════════════════════════════════════════════════════════════════════════════════ 
 --dir                    -d  [<directory>]                                                         
 --author                 -a  Module author's GitHub username prefixed with '@' [<author>]          
 --label                  -l  Standard resource label for process [<process label>]                 
 --meta                   -m  Use Groovy meta map for sample information                            
 --no-meta                -n  Don't use meta map for sample information                             
 --force                  -f  Overwrite any files if they already exist                             
 --conda-name             -c  Name of the conda package to use [TEXT]                               
 --conda-package-version  -p  Version of conda package to use [TEXT]                                
 --empty-template         -i  Create a module from the template without TODOs or examples           
 --migrate-pytest             Migrate a module with pytest tests to nf-test                         
 --help                   -h  Show this message and exit.
```

## nf-core_modules_lint

### Tool Description
Lint one or more modules in a directory

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
- **Homepage**: https://nf-co.re/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-core/overview
- **Validation**: PASS

### Original Help Text
```text


                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\ 
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 3.5.2 - https://nf-co.re
    There is a new version of nf-core/tools available! (4.1.0)


 Usage: nf-core modules lint [OPTIONS] <tool> or <tool/subtool>                                     
                                                                                                    
 Lint one or more modules in a directory.                                                           
                                                                                                    
 ═ Options ════════════════════════════════════════════════════════════════════════════════════════ 
 --dir          -d  [<pipeline/modules directory>]                                                  
 --registry     -r  Registry to use for containers. If not specified it will use docker.registry    
                    value in the nextflow.config file [<registry>]                                  
 --key          -k  Run only these lint tests [<test>]                                              
 --all          -a  Run on all modules                                                              
 --fail-warned  -w  Convert warn tests to failures                                                  
 --local            Run additional lint tests for local modules                                     
 --passed           Show passed tests                                                               
 --sort-by          Sort lint output by module or test name. [module|test] (Default: test)          
 --fix-version      Fix the module version if a newer version is available                          
 --fix              Fix all linting tests if possible.                                              
 --plain-text       Print results in plain text format without Rich formatting (easier to copy).    
                    Can also be enabled with env var NF_CORE_LINT_OUTPUT.                           
 --help         -h  Show this message and exit.
```

## nf-core_subworkflows_create

### Tool Description
Create a new subworkflow from the nf-core template

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
- **Homepage**: https://nf-co.re/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-core/overview
- **Validation**: PASS

### Original Help Text
```text


                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\ 
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 3.5.2 - https://nf-co.re
    There is a new version of nf-core/tools available! (4.1.0)


 Usage: nf-core subworkflows create [OPTIONS] subworkflow name                                      
                                                                                                    
 Create a new subworkflow from the nf-core template.                                                
                                                                                                    
 ═ Options ════════════════════════════════════════════════════════════════════════════════════════ 
 --dir             -d  [<directory>]                                                                
 --author          -a  Module author's GitHub username prefixed with '@' [<author>]                 
 --force           -f  Overwrite any files if they already exist                                    
 --migrate-pytest      Migrate a module with pytest tests to nf-test                                
 --help            -h  Show this message and exit.
```

## nf-core_subworkflows_lint

### Tool Description
Lint one or more subworkflows in a directory

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
- **Homepage**: https://nf-co.re/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-core/overview
- **Validation**: PASS

### Original Help Text
```text


                                          ,--./,-.
          ___     __   __   __   ___     /,-._.--~\ 
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 3.5.2 - https://nf-co.re
    There is a new version of nf-core/tools available! (4.1.0)


 Usage: nf-core subworkflows lint [OPTIONS] subworkflow name                                        
                                                                                                    
 Lint one or more subworkflows in a directory.                                                      
                                                                                                    
 ═ Options ════════════════════════════════════════════════════════════════════════════════════════ 
 --dir          -d  [<pipeline/modules directory>]                                                  
 --registry     -r  Registry to use for containers. If not specified it will use docker.registry    
                    value in the nextflow.config file [<registry>]                                  
 --key          -k  Run only these lint tests [<test>]                                              
 --all          -a  Run on all subworkflows                                                         
 --fail-warned  -w  Convert warn tests to failures                                                  
 --local            Run additional lint tests for local subworkflows                                
 --passed           Show passed tests                                                               
 --sort-by          Sort lint output by subworkflow or test name. [subworkflow|test] (Default:      
                    test)                                                                           
 --fix              Fix all linting tests if possible.                                              
 --plain-text       Print results in plain text format without Rich formatting (easier to copy).    
                    Can also be enabled with env var NF_CORE_LINT_OUTPUT.                           
 --help         -h  Show this message and exit.
```
