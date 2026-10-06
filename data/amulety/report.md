# amulety CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| amulety_embed | PASS |  |
| amulety_translate-igblast | PASS |  |

## amulety_translate-igblast

### Tool Description
Translates nucleotide sequences to amino acid sequences using IgBlast.

### Metadata
- **Docker Image**: quay.io/biocontainers/amulety:2.1.2--pyh6d73907_0
- **Homepage**: https://github.com/immcantation/amulety
- **Package**: https://anaconda.org/channels/bioconda/packages/amulety/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amulety/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2026-01-26
- **GitHub**: https://github.com/immcantation/amulety
- **Stars**: N/A
### Original Help Text
```text
█████  ███    ███ ██    ██ ██      ███████ ████████     ██    ██
██   ██ ████  ████ ██    ██ ██      ██         ██         ██  ██
███████ ██ ████ ██ ██    ██ ██      █████      ██          ████
██   ██ ██  ██  ██ ██    ██ ██      ██         ██           ██
██   ██ ██      ██  ██████  ███████ ███████    ██           ██

AMULETY: Adaptive imMUne receptor Language model Embedding tool for TCR and antibodY
 version 2.1.2

                                                                                
 Usage: amulety translate-igblast [OPTIONS]                                     
                                                                                
 Translates nucleotide sequences to amino acid sequences using IgBlast.         
                                                                                
 This function takes a AIRR file in TSV format containing nucleotide sequences  
 and translates them into amino acid sequences using IgBlast, a tool for        
 analyzing                                                                      
 BCR and TCR sequences. It performs the following steps:                        
                                                                                
                                                                                
 1. Reads the input TSV file containing nucleotide sequences.                   
                                                                                
 2. Writes the nucleotide sequences into a FASTA file, required as input for    
 IgBlast.                                                                       
                                                                                
 3. Runs IgBlast on the FASTA file to perform sequence alignment and            
 translation.                                                                   
                                                                                
 4. Reads the IgBlast output, which includes the translated amino acid          
 sequences.                                                                     
                                                                                
 5. Removes gaps introduced by IgBlast from the sequence alignment.             
                                                                                
 6. Saves the translated data into a new TSV file in the specified output       
 directory.                                                                     
                                                                                
                                                                                
                                                                                
 Example usage:                                                                 
                                                                                
     amulety translate-igblast --input-file input.tsv --output-dir ./output     
 --reference-dir /path/to/igblast/references                                    
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --input-file     -i      TEXT     The path to the input data file. The    │
│                                      data file should be in TSV format       │
│                                      following the AIRR specifications.      │
│                                      [required]                              │
│ *  --output-dir     -o      TEXT     The directory where the generated       │
│                                      embeddings will be saved.               │
│                                      [required]                              │
│ *  --reference-dir  -r      TEXT     The directory to the igblast            │
│                                      references.                             │
│                                      [required]                              │
│    --keep-regions   -k               If True, keeps the region translations  │
│                                      in the output airr file. If False, it   │
│                                      removes them.                           │
│    --sequence-col   -s      TEXT     The name of the column containing the   │
│                                      nucleotide sequences to translate.      │
│                                      [default: sequence]                     │
│    --nproc          -n      INTEGER  Number of processors to use for         │
│                                      IgBlast.                                │
│                                      [default: 1]                            │
│    --log-file       -l      TEXT     Path to log file. If not provided, logs │
│                                      will be printed to stdout.              │
│    --verbose        -v               Enable verbose logging (DEBUG level).   │
│    --help                            Show this message and exit.             │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## amulety_embed

### Tool Description
Embeds sequences from an AIRR rearrangement file using the specified model.

### Metadata
- **Docker Image**: quay.io/biocontainers/amulety:2.1.2--pyh6d73907_0
- **Homepage**: https://github.com/immcantation/amulety
- **Package**: https://anaconda.org/channels/bioconda/packages/amulety/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/amulety/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2026-01-26
- **GitHub**: https://github.com/immcantation/amulety
- **Stars**: N/A
### Original Help Text
```text

 █████  ███    ███ ██    ██ ██      ███████ ████████     ██    ██
██   ██ ████  ████ ██    ██ ██      ██         ██         ██  ██
███████ ██ ████ ██ ██    ██ ██      █████      ██          ████
██   ██ ██  ██  ██ ██    ██ ██      ██         ██           ██
██   ██ ██      ██  ██████  ███████ ███████    ██           ██

AMULETY: Adaptive imMUne receptor Language model Embedding tool for TCR and antibodY
 version 2.1.2

                                                                                
 Usage: amulety embed [OPTIONS]                                                 
                                                                                
 Embeds sequences from an AIRR rearrangement file using the specified model. It 
 returns the embeddings in the specified output format along with the filtered  
 input AIRR data.                                                               
                                                                                
 Example usage:                                                                 
                                                                                
 amulety embed --input-airr airr_rearrangement.tsv --chain HL --model           
 antiberta2 --output-file-path out.tsv                                          
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --input-airr           -i      TEXT     The path to the input data file.  │
│                                            The data file should be in AIRR   │
│                                            format.                           │
│                                            [required]                        │
│ *  --chain                -c      TEXT     Input chain to embed. For BCR:    │
│                                            H=Heavy, L=Light, HL=Heavy-Light  │
│                                            pairs, LH=Light-Heavy pairs,      │
│                                            H+L=Both chains separately. For   │
│                                            TCR: H=Beta/Delta, L=Alpha/Gamma, │
│                                            HL=Beta-Alpha/Delta-Gamma pairs,  │
│                                            LH=Alpha-Beta/Gamma-Delta pairs,  │
│                                            H+L=Both chains separately.       │
│                                            [required]                        │
│ *  --model                -m      TEXT     The embedding model to use. BCR:  │
│                                            ['ablang', 'antiberta2',          │
│                                            'antiberty', 'balm-paired']. TCR: │
│                                            ['tcr-bert', 'tcrt5']. Immune     │
│                                            (BCR & TCR): ['immune2vec'].      │
│                                            Protein: ['esm2', 'prott5',       │
│                                            'custom']. Use 'custom' for       │
│                                            fine-tuned models with            │
│                                            --model-path,                     │
│                                            --embedding-dimension, and        │
│                                            --max-length parameters.          │
│                                            [required]                        │
│ *  --output-file-path     -o      TEXT     The path where the generated      │
│                                            embeddings will be saved. The     │
│                                            file extension should be .csv, or │
│                                            .tsv. for a dataframe, .pt for a  │
│                                            pickled torch object, or .h5ad    │
│                                            for an anndata object.            │
│                                            [required]                        │
│    --cache-dir            -d      TEXT     Cache dir for storing the         │
│                                            pre-trained model weights.        │
│                                            [default: /tmp/amulety-cache]     │
│    --sequence-col         -s      TEXT     The name of the column containing │
│                                            the amino acid sequences to       │
│                                            embed.                            │
│                                            [default: sequence_vdj_aa]        │
│    --cell-id-col          -u      TEXT     The name of the column containing │
│                                            the single-cell barcode.          │
│                                            [default: cell_id]                │
│    --batch-size           -b      INTEGER  The batch size of sequences to    │
│                                            embed.                            │
│                                            [default: 50]                     │
│    --model-path           -p      TEXT     Path to custom model (HuggingFace │
│                                            model name or local path).        │
│                                            Required for 'custom' model.      │
│    --embedding-dimension  -e      INTEGER  Embedding dimension for custom    │
│                                            model. Required for 'custom'      │
│                                            model.                            │
│    --max-length           -x      INTEGER  Maximum sequence length for       │
│                                            custom model. Required for        │
│                                            'custom' model.                   │
│    --duplicate-col        -z      TEXT     The name of the numeric column    │
│                                            used to select the best chain     │
│                                            when multiple chains of the same  │
│                                            type exist per cell. Default:     │
│                                            'duplicate_count'. Custom columns │
│                                            must be numeric and user-defined. │
│                                            [default: duplicate_count]        │
│    --installation-path    -j      TEXT     Custom path to model installation │
│                                            directory. Currently applies to   │
│                                            'immune2vec' model.               │
│    --residue-level        -r               If True, returns residue-level    │
│                                            embeddings of dimension sequence  │
│                                            length x embedding dimension (L x │
│                                            D) instead of sequence-level (1 x │
│                                            D).                               │
│    --log-file             -l      TEXT     Path to log file. If not          │
│                                            provided, logs will be printed to │
│                                            stdout.                           │
│    --verbose              -v               Enable verbose logging (DEBUG     │
│                                            level).                           │
│    --help                                  Show this message and exit.       │
╰──────────────────────────────────────────────────────────────────────────────╯
```


