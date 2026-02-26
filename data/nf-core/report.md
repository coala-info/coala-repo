# nf-core CWL Generation Report

## nf-core_interface

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
- **Homepage**: http://nf-co.re/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-core/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/nf-core/overview
- **Total Downloads**: 136.6K
- **Last updated**: 2026-02-02
- **GitHub**: https://github.com/nf-core/tools
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
,--./,-.
          ___     __   __   __   ___     /,-._.--~\ 
    |\ | |__  __ /  ` /  \ |__) |__         }  {
    | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                          `._,._,'

    nf-core/tools version 3.5.2 - https://nf-co.re


 Usage: nf-core interface [OPTIONS]                                             
                                                                                
 Try 'nf-core interface -h' for help                                            
╭─ Error ──────────────────────────────────────────────────────────────────────╮
│ No such option: --h Did you mean --help?                                     │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## nf-core_modules

### Tool Description
Commands to manage Nextflow DSL2 modules (tool wrappers).

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
- **Homepage**: http://nf-co.re/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-core/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nf-core modules [OPTIONS] COMMAND [ARGS]...                             
                                                                                
 Commands to manage Nextflow DSL2 modules (tool wrappers).                      
 Aliases: m, module                                                             
                                                                                
 ═ For pipeline development ═══════════════════════════════════════════════════ 
 list     List modules in a local pipeline or remote repository.                
 info     Show developer usage information about a given module.                
 install  Install DSL2 modules within a pipeline.                               
 update   Update DSL2 modules within a pipeline.                                
 remove   Remove a module from a pipeline.                                      
 patch    Create a patch file for minor changes in a module                     
                                                                                
 ═ For module development ═════════════════════════════════════════════════════ 
 create         Create a new DSL2 module from the nf-core template.             
 lint           Lint one or more modules in a directory.                        
 test           Run nf-test for a module.                                       
 bump-versions  Bump versions for one or more modules in a clone of the         
                nf-core/modules repo.                                           
                                                                                
 ═ Options ════════════════════════════════════════════════════════════════════ 
 --git-remote  -g  Remote git repo to fetch files from [TEXT]                   
 --branch      -b  Branch of git repository hosting modules. [TEXT]             
 --no-pull     -N  Do not pull in latest changes to local clone of modules      
                   repository.                                                  
 --help        -h  Show this message and exit.
```


## nf-core_pipelines

### Tool Description
Commands to manage nf-core pipelines.

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
- **Homepage**: http://nf-co.re/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-core/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nf-core pipelines [OPTIONS] COMMAND [ARGS]...                           
                                                                                
 Commands to manage nf-core pipelines.                                          
 Aliases: p, pipeline                                                           
                                                                                
 ═ For users ══════════════════════════════════════════════════════════════════ 
 download            Download a pipeline, nf-core/configs and pipeline          
                     singularity images.                                        
 create-params-file  Build a parameter file for a pipeline.                     
 launch              Launch a pipeline using a web GUI or command line prompts. 
 list                List available nf-core pipelines with local info.          
                                                                                
 ═ For developers ═════════════════════════════════════════════════════════════ 
 bump-version  Update nf-core pipeline version number with `nf-core pipelines   
               bump-version`.                                                   
 create        Create a new pipeline using the nf-core template.                
 create-logo   Generate a logo with the nf-core logo template.                  
 lint          Check pipeline code against nf-core guidelines.                  
 rocrate       Make an Research Object Crate                                    
 schema        Suite of tools for developers to manage pipeline schema.         
 sync          Sync a pipeline TEMPLATE branch with the nf-core template.       
                                                                                
 ═ Options ════════════════════════════════════════════════════════════════════ 
 --help  -h  Show this message and exit.
```


## nf-core_subworkflows

### Tool Description
Commands to manage Nextflow DSL2 subworkflows (tool wrappers).

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
- **Homepage**: http://nf-co.re/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-core/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nf-core subworkflows [OPTIONS] COMMAND [ARGS]...                        
                                                                                
 Commands to manage Nextflow DSL2 subworkflows (tool wrappers).                 
 Aliases: s, swf, subworkflow                                                   
                                                                                
 ═ For pipeline development ═══════════════════════════════════════════════════ 
 list     List subworkflows in a local pipeline or remote repository.           
 info     Show developer usage information about a given subworkflow.           
 install  Install DSL2 subworkflow within a pipeline.                           
 update   Update DSL2 subworkflow within a pipeline.                            
 remove   Remove a subworkflow from a pipeline.                                 
 patch    Create a patch file for minor changes in a subworkflow                
                                                                                
 ═ For module development ═════════════════════════════════════════════════════ 
 create  Create a new subworkflow from the nf-core template.                    
 lint    Lint one or more subworkflows in a directory.                          
 test    Run nf-test for a subworkflow.                                         
                                                                                
 ═ Options ════════════════════════════════════════════════════════════════════ 
 --git-remote  -g  Remote git repo to fetch files from [TEXT]                   
 --branch      -b  Branch of git repository hosting modules. [TEXT]             
 --no-pull     -N  Do not pull in latest changes to local clone of modules      
                   repository.                                                  
 --help        -h  Show this message and exit.
```


## nf-core_test-datasets

### Tool Description
Commands to manage nf-core test datasets.

### Metadata
- **Docker Image**: quay.io/biocontainers/nf-core:3.5.2--pyhdfd78af_0
- **Homepage**: http://nf-co.re/
- **Package**: https://anaconda.org/channels/bioconda/packages/nf-core/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nf-core test-datasets [OPTIONS] COMMAND [ARGS]...                       
                                                                                
 Commands to manage nf-core test datasets.                                      
 Aliases: tds                                                                   
                                                                                
 ═ Commands ═══════════════════════════════════════════════════════════════════ 
 list           List files on a specified branch in the nf-core/test-datasets   
                repository.                                                     
 list-branches  List remote branches with test data in the nf-core/test-dataset 
                repository.                                                     
 search         Search files in the nf-core/test-datasets repository            
                                                                                
 ═ Options ════════════════════════════════════════════════════════════════════ 
 --help  -h  Show this message and exit.
```

