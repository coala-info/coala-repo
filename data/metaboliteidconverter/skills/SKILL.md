---
name: metaboliteidconverter
description: MetaboliteIDConverter is a post-processing tool that leverages the Chemical Translation Service (CTS) to standardize and enrich metabolite data.
homepage: https://github.com/phnmnl/container-MetaboliteIDConverter
---

# metaboliteidconverter

## Overview
MetaboliteIDConverter is a post-processing tool that leverages the Chemical Translation Service (CTS) to standardize and enrich metabolite data. It takes a tab-separated (TSV) file containing one type of identifier and produces an output file populated with a wide array of cross-referenced database IDs. This is essential for researchers needing to map experimental results to metabolic networks or various chemical databases.

## Command Line Usage
The tool is primarily distributed as a Docker container. The core execution pattern follows this structure:

```bash
docker run [image_name] -inDB <inputDB> -inFile <inputfile> -outFile <file_out> [-headers]
```

### Parameters
- `-inDB`: Specifies the source identifier type. Must be one of: `InChIKey`, `KEGG`, `ChEBI`, or `Chemical Name`.
- `-inFile`: The path to the input TSV file containing the metabolites to be converted.
- `-outFile`: The desired path for the generated output file.
- `-headers`: An optional flag. Use this if your input TSV file contains a header row. This allows the tool to correctly identify the column containing the source IDs.

## Best Practices and Tips
- **Input Format**: Ensure your input file is strictly tab-separated. If using chemical names, ensure they are standardized as much as possible to improve the hit rate from the CTS web service.
- **Header Handling**: Always include the `-headers` flag if your file has a top row of labels; otherwise, the tool may attempt to convert the header text itself, leading to errors or missing data for the first entry.
- **Output Scope**: The tool automatically attempts to retrieve a fixed set of identifiers for every input: InChiKey, InChI, ChEBI, KEGG ID, PubChem CID, HMDB ID, ChemSpider, and CAS. You do not need to specify which output IDs you want; it provides all available matches.
- **Network Integration**: The resulting identifiers are compatible with metabolic reconstruction databases such as MetExplore and Recon2, making this tool a standard step before performing metabolic network analysis.

## Reference documentation
- [MetaboliteIDConverter Main Repository](./references/github_com_phnmnl_container-MetaboliteIDConverter.md)