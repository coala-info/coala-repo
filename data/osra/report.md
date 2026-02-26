# osra CWL Generation Report

## osra

### Tool Description
OSRA: Optical Structure Recognition Application, created by Igor Filippov, 2013

### Metadata
- **Docker Image**: quay.io/biocontainers/osra:2.1.0--0
- **Homepage**: http://cactus.nci.nih.gov/osra/
- **Package**: https://anaconda.org/channels/bioconda/packages/osra/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/osra/overview
- **Total Downloads**: 18.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
USAGE: 

   osra  [--learn] [-w <filename>] [--preview <filename>] [-s <dimensions,
         300x400>] [-o <filename prefix>] [-v] [-d] [-a <configfile>] [-l
         <configfile>] [-b] [-c] [-e] [-g] [-p] [--embedded-format
         <inchi/smi/can>] [-f <can/smi/sdf>] [-i] [-j] [-u <default: 0
         rounds>] [-t <0.2..0.8>] [-r <default: auto>] [-n] [-R <0..360>]
         [--] [--version] [-h] <filename>


Where: 

   --learn
     Print out all structure guesses with confidence parameters

   -w <filename>,  --write <filename>
     Write recognized structures to text file

   --preview <filename>
     Preview Image

   -s <dimensions, 300x400>,  --size <dimensions, 300x400>
     Resize image on output

   -o <filename prefix>,  --output <filename prefix>
     Write recognized structures to image files with given prefix

   -v,  --verbose
     Be verbose and print the program flow

   -d,  --debug
     Print out debug information on spelling corrections

   -a <configfile>,  --superatom <configfile>
     Superatom label map to SMILES

   -l <configfile>,  --spelling <configfile>
     Spelling correction dictionary

   -b,  --bond
     Show average bond length in pixels (only for SDF/SMI/CAN output
     format)

   -c,  --coordinates
     Show surrounding box coordinates (only for SDF/SMI/CAN output format)

   -e,  --page
     Show page number for PDF/PS/TIFF documents (only for SDF/SMI/CAN
     output format)

   -g,  --guess
     Print out resolution guess

   -p,  --print
     Print out confidence estimate

   --embedded-format <inchi/smi/can>
     Embedded format

   -f <can/smi/sdf>,  --format <can/smi/sdf>
     Output format

   -i,  --adaptive
     Adaptive thresholding pre-processing, useful for low light/low
     contrast images

   -j,  --jaggy
     Additional thinning/scaling down of low quality documents

   -u <default: 0 rounds>,  --unpaper <default: 0 rounds>
     Pre-process image with unpaper algorithm, rounds

   -t <0.2..0.8>,  --threshold <0.2..0.8>
     Gray level threshold

   -r <default: auto>,  --resolution <default: auto>
     Resolution in dots per inch

   -n,  --negate
     Invert color (white on black)

   -R <0..360>,  --rotate <0..360>
     Rotate image clockwise by specified number of degrees

   --,  --ignore_rest
     Ignores the rest of the labeled arguments following this flag.

   --version
     Displays version information and exits.

   -h,  --help
     Displays usage information and exits.

   <filename>
     (required)  input file


   OSRA: Optical Structure Recognition Application, created by Igor
   Filippov, 2013
```

