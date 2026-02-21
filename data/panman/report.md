# panman CWL Generation Report

## panman

### Tool Description
FAIL to generate CWL: panman not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/panman:0.1.4--hac847a2_0
- **Homepage**: https://github.com/TurakhiaLab/panman
- **Package**: https://anaconda.org/channels/bioconda/packages/panman/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/panman/overview
- **Total Downloads**: 631
- **Last updated**: 2025-07-02
- **GitHub**: https://github.com/TurakhiaLab/panman
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: panman not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: panman not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## panman_panmanUtils

### Tool Description
Utility tool for PanMAN (Pangenome Mutation Adjacency Network) files, supporting construction, conversion, and analysis of pangenome data.

### Metadata
- **Docker Image**: quay.io/biocontainers/panman:0.1.4--hac847a2_0
- **Homepage**: https://github.com/TurakhiaLab/panman
- **Package**: https://anaconda.org/channels/bioconda/packages/panman/overview
- **Validation**: PASS
### Original Help Text
```text
[1;31mError: [0mIncorrect Format
panmanUtils Command Line Arguments:
  -h [ --help ]               Print help messages
  -V [ --version ]            Print panmanUtils version
  -I [ --input-panman ] arg   Input PanMAN file path
  -P [ --input-pangraph ] arg Input PanGraph JSON file to build a PanMAN
  -G [ --input-gfa ] arg      Input GFA file to build a PanMAN
  -M [ --input-msa ] arg      Input MSA file (FASTA format) to build a PanMAN
  -N [ --input-newick ] arg   Input tree topology as Newick string
  -K [ --create-network ] arg Create PanMAN with network of trees from single 
                              or multiple PanMAN files
  --printTips arg             Print PanMAN Tips
  -s [ --summary ]            Print PanMAN summary
  -t [ --newick ]             Print newick string of all trees in a PanMAN
  -f [ --fasta ]              Print tip sequences (FASTA format)
  -m [ --fasta-aligned ]      Print MSA of sequences for each PanMAT in a 
                              PanMAN (FASTA format)
  -b [ --subnet ]             Extract subnet of given PanMAN to a new PanMAN 
                              file based on the list of nodes provided in the 
                              input-file
  -v [ --vcf ]                Print variations of all sequences from any PanMAT
                              in a PanMAN (VCF format)
  -g [ --gfa ]                Convert any PanMAT in a PanMAN to a GFA file
  -w [ --maf ]                Print m-WGA for each PanMAT in a PanMAN (MAF 
                              format)
  -a [ --annotate ]           Annotate nodes of the input PanMAN based on the 
                              list provided in the input-file (TSV)
  -r [ --reroot ]             Reroot a PanMAT in a PanMAN based on the input 
                              sequence id (--reference)
  -v [ --aa-translation ]     Extract amino acid translations in TSV file
  -e [ --extended-newick ]    Print PanMAN's network in extended-newick format
  -p [ --printMutations ]     Print mutations from root to each node
  -q [ --acr ]                ACR method [fitch(default), mppa]
  --index arg                 Generating indexes and print sequence (passed as 
                              reference) between x:y
  --refFile arg               reference sequence file
  --toUsher                   Convert a PanMAT in PanMAN to Usher-MAT
  --low-mem-mode              Perform Fitch Algrorithm in batch to save memory 
                              consumption
  -n [ --reference ] arg      Identifier of reference sequence for PanMAN 
                              construction (optional), VCF extract (required), 
                              or reroot (required)
  -x [ --start ] arg          Start coordinate of protein translation/Start 
                              coordinate for indexing
  -y [ --end ] arg            End coordinate of protein translation/End 
                              coordinate for indexing
  -d [ --treeID ] arg         Tree ID, required for --vcf
  -i [ --input-file ] arg     Path to the input file, required for --subnet, 
                              --annotate, and --create-network
  -o [ --output-file ] arg    Prefix of the output file name
  --threads arg               Number of threads
```

