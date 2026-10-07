# chemfp CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| chemfp_fpcat | PASS |  |
| chemfp_ob2fps | PASS |  |
| chemfp_rdkit2fps | PASS |  |
| chemfp_sdf2fps | PASS |  |
| chemfp_simsearch | PASS |  |

## Metadata
- **Skill**: generated

## chemfp_rdkit2fps

### Tool Description
Generate FPS fingerprints from a structure file using RDKit

### Metadata
- **Docker Image**: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
- **Homepage**: https://chemfp.com
- **Package**: https://anaconda.org/channels/bioconda/packages/chemfp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rdkit2fps [-h] [--fpSize INT] [--RDK] [--minPath INT] [--maxPath INT]
                 [--nBitsPerHash INT] [--useHs 0|1] [--morgan] [--radius INT]
                 [--useFeatures 0|1] [--useChirality 0|1] [--useBondTypes 0|1]
                 [--torsions] [--targetSize INT] [--pairs] [--minLength INT]
                 [--maxLength INT] [--maccs166] [--avalon] [--isQuery 0|1]
                 [--bitFlags INT] [--pattern] [--substruct] [--rdmaccs]
                 [--rdmaccs/1] [--from-atoms INT,INT,...] [--id-tag NAME]
                 [--in FORMAT] [-o FILENAME] [--out FORMAT]
                 [--errors {strict,report,ignore}] [--version]
                 [filenames [filenames ...]]

Generate FPS fingerprints from a structure file using RDKit

positional arguments:
  filenames             input structure files (default is stdin)

optional arguments:
  -h, --help            show this help message and exit
  --fpSize INT          number of bits in the fingerprint. Default of 2048 for
                        RDK, Morgan, topological torsion, atom pair, and
                        pattern fingerprints, and 512 for Avalon fingerprints
  --from-atoms INT,INT,...
                        fingerprint generation must use these atom indices
                        (out of range indices are ignored)
  --id-tag NAME         tag name containing the record id (SD files only)
  --in FORMAT           input structure format (default guesses from filename)
  -o FILENAME, --output FILENAME
                        save the fingerprints to FILENAME (default=stdout)
  --out FORMAT          output structure format (default guesses from output
                        filename, or is 'fps')
  --errors {strict,report,ignore}
                        how should structure parse errors be handled?
                        (default=ignore)
  --version             show program's version number and exit

RDKit topological fingerprints:
  --RDK                 generate RDK fingerprints (default)
  --minPath INT         minimum number of bonds to include in the subgraph
                        (default=1)
  --maxPath INT         maximum number of bonds to include in the subgraph
                        (default=7)
  --nBitsPerHash INT    number of bits to set per path (default=2)
  --useHs 0|1           include information about the number of hydrogens on
                        each atom (default=1)

RDKit Morgan fingerprints:
  --morgan              generate Morgan fingerprints
  --radius INT          radius for the Morgan algorithm (default=2)
  --useFeatures 0|1     use chemical-feature invariants (default=0)
  --useChirality 0|1    include chirality information (default=0)
  --useBondTypes 0|1    include bond type information (default=1)

RDKit Topological Torsion fingerprints:
  --torsions            generate Topological Torsion fingerprints
  --targetSize INT      number of bits in the fingerprint (default=4)

RDKit Atom Pair fingerprints:
  --pairs               generate Atom Pair fingerprints
  --minLength INT       minimum bond count for a pair (default=1)
  --maxLength INT       maximum bond count for a pair (default=30)

166 bit MACCS substructure keys:
  --maccs166            generate MACCS fingerprints

Avalon fingerprints:
  --avalon              generate Avalon fingerprints
  --isQuery 0|1         is the fingerprint for a query structure? (1 if yes, 0
                        if no) (default=0)
  --bitFlags INT        bit flags, SSSBits are 32767 and similarity bits are
                        15761407 (default=15761407)

RDKit Pattern fingerprints:
  --pattern             generate (substructure) pattern fingerprints

881 bit substructure keys:
  --substruct           generate ChemFP substructure fingerprints

ChemFP version of the 166 bit RDKit/MACCS keys:
  --rdmaccs, --rdmaccs/2
                        generate 166 bit RDKit/MACCS fingerprints (version 2)
  --rdmaccs/1           use the version 1 definition for --rdmaccs

This program guesses the input structure format based on the filename
extension. If the data comes from stdin, or the extension name us
unknown, then use "--in" to change the default input format. The
supported format extensions are:

  File Type      Valid FORMATs (use gz if compressed)
  ---------      ------------------------------------
   SMILES        smi, ism, usm, can, smi.gz, ism.gz, usm.gz, can.gz
   SDF           sdf, mol, sd, mdl, sdf.gz, mol.gz, sd.gz, mdl.gz
```

## chemfp_simsearch

### Tool Description
Search an FPS or FPB file for similar fingerprints

### Metadata
- **Docker Image**: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
- **Homepage**: https://chemfp.com
- **Package**: https://anaconda.org/channels/bioconda/packages/chemfp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: simsearch [-h] [-k INT] [-t FLOAT] [--queries FILENAME] [--NxN]
                 [--query STRING] [--hex-query HEX] [--query-id ID]
                 [--query-structures FILENAME] [--query-format FORMAT]
                 [--target-format FORMAT] [--id-tag NAME]
                 [--errors {strict,report,ignore}] [-o FILENAME] [-c] [-b INT]
                 [--scan] [--memory] [--times] [--version]
                 target_filename

Search an FPS or FPB file for similar fingerprints

positional arguments:
  target_filename       target filename

optional arguments:
  -h, --help            show this help message and exit
  -k INT, --k-nearest INT
                        select the k nearest neighbors (use 'all' for all
                        neighbors)
  -t FLOAT, --threshold FLOAT
                        minimum similarity score threshold
  --queries FILENAME, -q FILENAME
                        filename containing the query fingerprints
  --NxN                 use the targets as the queries, and exclude the self-
                        similarity term
  --query STRING        query as a structure record (default format: 'smi')
  --hex-query HEX       query in hex
  --query-id ID         id for the query or hex-query (default: 'Query1'
  --query-structures FILENAME, -S FILENAME
                        read strutures
  --query-format FORMAT, --in FORMAT
                        input query format (default uses the file extension,
                        else 'fps' for --queries and 'smi' for query
                        structures)
  --target-format FORMAT
                        input target format (default uses the file extension,
                        else 'fps')
  --id-tag NAME         tag containing the record id if --query-structures is
                        an SD file)
  --errors {strict,report,ignore}
                        how should structure parse errors be handled?
                        (default=ignore)
  -o FILENAME, --output FILENAME
                        output filename (default is stdout)
  -c, --count           report counts
  -b INT, --batch-size INT
                        batch size
  --scan                scan the file to find matches (low memory overhead)
  --memory              build and search an in-memory data structure (faster
                        for multiple queries)
  --times               report load and execution times to stderr
  --version             show program's version number and exit
```

## chemfp_fpcat

### Tool Description
Combine multiple fingerprint files into a single file.

### Metadata
- **Docker Image**: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
- **Homepage**: https://chemfp.com
- **Package**: https://anaconda.org/channels/bioconda/packages/chemfp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fpcat [-h] [--in FORMAT] [--merge] [-o FILENAME] [--out FORMAT]
             [--reorder] [--preserve-order] [--show-progress] [--version]
             [filename [filename ...]]

Combine multiple fingerprint files into a single file.

positional arguments:
  filename              input fingerprint filenames (default: use stdin)

optional arguments:
  -h, --help            show this help message and exit
  --in FORMAT           input fingerprint format. One of fps or fps.gz.
                        (default guesses from filename or is fps)
  --merge               assume the input fingerprint files are in popcount
                        order and do a merge sort
  -o FILENAME, --output FILENAME
                        save the fingerprints to FILENAME (default=stdout)
  --out FORMAT          output fingerprint format. One of fps or fps.gz.
                        (default guesses from output filename, or is 'fps')
  --reorder             reorder the output fingerprints by popcount
  --preserve-order      save the output fingerprints in the same order as the
                        input (default for FPS output)
  --show-progress       show progress
  --version             show program's version number and exit

Examples:

fpcat can be used to merge multiple FPS files. For example, you might
have used GNU parallel to generate FPS files for each of the PubChem
files, which you want to merge into a single file.:

    fpcat Compound_*.fps -o pubchem.fps

The --merge option is experimental. Use it if the input fingerprints
are in popcount order, because sorted output is a simple merge sort of
the individual sorted inputs. However, this option opens all input
files at the same time, which may exceed your resource limit on file
descriptors. The current implementation also requires a lot of disk
seeks so is slow for many files.
```

## chemfp_ob2fps

### Tool Description
Generate FPS fingerprints from a structure file using Open Babel

### Metadata
- **Docker Image**: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
- **Homepage**: https://chemfp.com
- **Package**: https://anaconda.org/channels/bioconda/packages/chemfp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ob2fps [-h]
              [--FP2 | --FP3 | --FP4 | --MACCS | --substruct | --rdmaccs | --rdmaccs/1]
              [--id-tag NAME] [--in FORMAT] [-o FILENAME] [--out FORMAT]
              [--errors {strict,report,ignore}] [--version]
              [filenames [filenames ...]]

Generate FPS fingerprints from a structure file using Open Babel

positional arguments:
  filenames             input structure files (default is stdin)

optional arguments:
  -h, --help            show this help message and exit
  --FP2                 linear fragments up to 7 atoms
  --FP3                 SMARTS patterns specified in the file patterns.txt
  --FP4                 SMARTS patterns specified in the file
                        SMARTS_InteLigand.txt
  --MACCS               Open Babel's implementation of the MACCS 166 keys
  --substruct           generate ChemFP substructure fingerprints
  --rdmaccs, --rdmaccs/2
                        166 bit RDKit/MACCS fingerprints (version 2)
  --rdmaccs/1           use the version 1 definition for --rdmaccs
  --id-tag NAME         tag name containing the record id (SD files only)
  --in FORMAT           input structure format (default autodetects from the
                        filename extension)
  -o FILENAME, --output FILENAME
                        save the fingerprints to FILENAME (default=stdout)
  --out FORMAT          output structure format (default guesses from output
                        filename, or is 'fps')
  --errors {strict,report,ignore}
                        how should structure parse errors be handled?
                        (default=ignore)
  --version             show program's version number and exit
/usr/local/lib/python2.7/site-packages/openbabel/__init__.py:14: UserWarning: "import openbabel" is deprecated, instead use "from openbabel import openbabel"
  warnings.warn('"import openbabel" is deprecated, instead use "from openbabel import openbabel"')
```

## chemfp_sdf2fps

### Tool Description
Extract a fingerprint tag from an SD file and generate FPS fingerprints

### Metadata
- **Docker Image**: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
- **Homepage**: https://chemfp.com
- **Package**: https://anaconda.org/channels/bioconda/packages/chemfp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sdf2fps [-h] [--id-tag TAG] [--fp-tag TAG] [--in FORMAT]
               [--num-bits INT] [--errors {strict,report,ignore}]
               [-o FILENAME] [--out FORMAT] [--software TEXT] [--type TEXT]
               [--version] [--binary] [--binary-msb] [--hex] [--hex-lsb]
               [--hex-msb] [--base64] [--cactvs] [--daylight]
               [--decoder DECODER] [--pubchem]
               [filenames [filenames ...]]

Extract a fingerprint tag from an SD file and generate FPS fingerprints

positional arguments:
  filenames             input SD files (default is stdin)

optional arguments:
  -h, --help            show this help message and exit
  --id-tag TAG          get the record id from TAG instead of the first line
                        of the record
  --fp-tag TAG          get the fingerprint from tag TAG (required)
  --in FORMAT           Specify if the input SD file is uncompressed or gzip
                        compressed
  --num-bits INT        use the first INT bits of the input. Use only when the
                        last 1-7 bits of the last byte are not part of the
                        fingerprint. Unexpected errors will occur if these
                        bits are not all zero.
  --errors {strict,report,ignore}
                        how should structure parse errors be handled?
                        (default=strict)
  -o FILENAME, --output FILENAME
                        save the fingerprints to FILENAME (default=stdout)
  --out FORMAT          output structure format (default guesses from output
                        filename, or is 'fps')
  --software TEXT       use TEXT as the software description
  --type TEXT           use TEXT as the fingerprint type description
  --version             show program's version number and exit

Fingerprint decoding options:
  --binary              Encoded with the characters '0' and '1'. Bit #0 comes
                        first. Example: 00100000 encodes the value 4
  --binary-msb          Encoded with the characters '0' and '1'. Bit #0 comes
                        last. Example: 00000100 encodes the value 4
  --hex                 Hex encoded. Bit #0 is the first bit (1<<0) of the
                        first byte. Example: 01f2 encodes the value \x01\xf2 =
                        498
  --hex-lsb             Hex encoded. Bit #0 is the eigth bit (1<<7) of the
                        first byte. Example: 804f encodes the value \x01\xf2 =
                        498
  --hex-msb             Hex encoded. Bit #0 is the first bit (1<<0) of the
                        last byte. Example: f201 encodes the value \x01\xf2 =
                        498
  --base64              Base-64 encoded. Bit #0 is first bit (1<<0) of first
                        byte. Example: AfI= encodes value \x01\xf2 = 498
  --cactvs              CACTVS encoding, based on base64 and includes a
                        version and bit length
  --daylight            Daylight encoding, which is is base64 variant
  --decoder DECODER     import and use the DECODER function to decode the
                        fingerprint

shortcuts:
  --pubchem             decode CACTVS substructure keys used in PubChem. Same
                        as --software=CACTVS/unknown --type 'CACTVS-
                        E_SCREEN/1.0 extended=2' --fp-
                        tag=PUBCHEM_CACTVS_SUBSKEYS --cactvs
```

