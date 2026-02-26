# instanovo CWL Generation Report

## instanovo_predict

### Tool Description
Run predictions with InstaNovo and optionally refine with InstaNovo+.
First with the transformer-based InstaNovo model and then optionally refine
them with the diffusion based InstaNovo+ model.

### Metadata
- **Docker Image**: quay.io/biocontainers/instanovo:1.2.2--pyhdfd78af_1
- **Homepage**: https://github.com/instadeepai/instanovo
- **Package**: https://anaconda.org/channels/bioconda/packages/instanovo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/instanovo/overview
- **Total Downloads**: 808
- **Last updated**: 2025-12-15
- **GitHub**: https://github.com/instadeepai/instanovo
- **Stars**: N/A
### Original Help Text
```text
Usage: instanovo predict [OPTIONS] [OVERRIDES]...                              
                                                                                
 Run predictions with InstaNovo and optionally refine with InstaNovo+.          
                                                                                
 First with the transformer-based InstaNovo model and then optionally refine    
 them with the diffusion based InstaNovo+ model.                                
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --data-path             -d                      TEXT  Path to input data     │
│                                                       file                   │
│ --output-path           -o                      FILE  Path to output file.   │
│ --instanovo-model       -i                      TEXT  Either a model ID or a │
│                                                       path to an Instanovo   │
│                                                       checkpoint file (.ckpt │
│                                                       format)                │
│ --instanovo-plus-model  -p                      TEXT  Either a model ID or a │
│                                                       path to an Instanovo+  │
│                                                       checkpoint file (.ckpt │
│                                                       format)                │
│ --denovo                     --evaluation             Do de novo predictions │
│                                                       or evaluate an         │
│                                                       annotated file with    │
│                                                       peptide sequences?     │
│ --with-refinement            --no-refinement          Refine the predictions │
│                                                       of the                 │
│                                                       transformer-based      │
│                                                       InstaNovo model with   │
│                                                       the diffusion-based    │
│                                                       InstaNovo+ model?      │
│                                                       [default:              │
│                                                       with-refinement]       │
│ --config-path           -cp                     TEXT  Relative path to       │
│                                                       config directory.      │
│ --config-name           -cn                     TEXT  The name of the config │
│                                                       (usually the file name │
│                                                       without the .yaml      │
│                                                       extension).            │
│ --help                                                Show this message and  │
│                                                       exit.                  │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## instanovo_version

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/instanovo:1.2.2--pyhdfd78af_1
- **Homepage**: https://github.com/instadeepai/instanovo
- **Package**: https://anaconda.org/channels/bioconda/packages/instanovo/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: instanovo version [OPTIONS]                                             
                                                                                
 Display version information for InstaNovo, Instanovo+ and its dependencies.    
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## instanovo_transformer

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/instanovo:1.2.2--pyhdfd78af_1
- **Homepage**: https://github.com/instadeepai/instanovo
- **Package**: https://anaconda.org/channels/bioconda/packages/instanovo/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: instanovo transformer [OPTIONS] COMMAND [ARGS]...                       
                                                                                
 Run predictions or train with only the transformer-based InstaNovo model.      
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ───────────────────────────────────────────────────────────────────╮
│ train     Train the InstaNovo model.                                         │
│ predict   Run predictions with InstaNovo.                                    │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## instanovo_diffusion

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/instanovo:1.2.2--pyhdfd78af_1
- **Homepage**: https://github.com/instadeepai/instanovo
- **Package**: https://anaconda.org/channels/bioconda/packages/instanovo/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: instanovo diffusion [OPTIONS] COMMAND [ARGS]...                         
                                                                                
 Run predictions or train with only the diffusion-based InstaNovo+ model.       
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ───────────────────────────────────────────────────────────────────╮
│ train     Train the InstaNovo+ model.                                        │
│ predict   Run predictions with InstaNovo+.                                   │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## instanovo_convert

### Tool Description
Convert data to SpectrumDataFrame and save as *.parquet file(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/instanovo:1.2.2--pyhdfd78af_1
- **Homepage**: https://github.com/instadeepai/instanovo
- **Package**: https://anaconda.org/channels/bioconda/packages/instanovo/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: instanovo convert [OPTIONS] SOURCE TARGET                               
                                                                                
 Convert data to SpectrumDataFrame and save as *.parquet file(s).               
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    source      TEXT       Source file(s) [required]                        │
│ *    target      DIRECTORY  Target folder to save data shards [required]     │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --name                   TEXT                Name of saved dataset        │
│                                                 [required]                   │
│ *  --partition              [train|valid|test]  Partition of saved dataset   │
│                                                 [required]                   │
│    --max-charge             INTEGER             Maximum charge to filter out │
│                                                 [default: 10]                │
│    --shard-size             INTEGER             Length of saved data shards  │
│                                                 [default: 1000000]           │
│    --is-annotated                               whether dataset is annotated │
│    --add-spectrum-id                            Add spectrum id column       │
│    --help                                       Show this message and exit.  │
╰──────────────────────────────────────────────────────────────────────────────╯
```

