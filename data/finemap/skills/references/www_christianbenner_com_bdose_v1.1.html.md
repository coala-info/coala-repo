### BDOSE v1.1 file format

* Header

|  |  |
| --- | --- |
| Bytes | Description |
| 8 | Magic number (bdose1.1) |
| 4 | Unsigned integer indicating the length *L*BGEN\_filename in bytes of the BGEN filename used to generate the BDOSE file |
| *L*BGEN\_filename | Name of the BGEN file |
| 8 | Unsigned integer indicating the size *S*BGEN\_file of the BGEN file in bytes |
| Min(1000, *S*BGEN\_file) | First bytes of the BGEN file |
| 8 | Unsigned integer indicating the size *S*BDOSE\_file of the BDOSE file in bytes |
| 4 | Unsigned integer indicating the number of samples *N*Samples in the BDOSE file |
| 4 | Unsigned integer indicating the number of SNPs *N*SNPs in the BDOSE file |
| 1 | Unsigned integer representing the compression level *C*level used in the BDOSE file |
|  | *C*level = 0 indicates 2 bytes |
|  | *C*level = 1 indicates 4 bytes |
|  | *C*level = 2 indicates 8 bytes |
|  | *C*level = 3 indicates 1 byte |
| 8 | Unsigned integer indicating the start position of the sample IDs in the BDOSE file |
| 8 | Unsigned integer indicating the start position of the dosage data offsets in the BDOSE file |
| 8 | Unsigned integer indicating the start position of the dosage data in the BDOSE file |

* SNP identifiers from Z file (sequence of *N*SNPs blocks)

|  |  |
| --- | --- |
| Bytes | Description |
| 4 | Unsigned integer indicating the length *L*Block of the SNP identifier block in bytes |
| 4 | Unsigned integer indicating the line in which the SNP appears in the Z file |
| 2 | Unsigned integer indicating the length *L*rsid of the entry in column rsid of the Z file in bytes |
| *L*rsid | Entry in column rsid of the Z file |
| 4 | Unsigned integer indicating the entry in column position of the Z file |
| 2 | Unsigned integer indicating the length *L*chromosome of the entry in column chromosome of the Z file in bytes |
| *L*chromosome | Entry in column chromosome of the Z file |
| 4 | Unsigned integer indicating the length *L*allele1 of the entry in column allele1 of the Z file in bytes |
| *L*allele1 | Entry in column allele1 of the Z file |
| 4 | Unsigned integer indicating the length *L*allele2 of the entry in column allele2 of the Z file in bytes |
| *L*allele2 | Entry in column allele2 of the Z file |
|  | |
| *L*Block = 20 + *L*rsid + *L*chromosome + *L*allele1 + *L*allele2 number of bytes for the SNP identifier block | |

* Sample IDs (sequence of *N*samples blocks)

|  |  |
| --- | --- |
| Bytes | Description |
| 4 | Unsigned integer indicating the length *L*sample\_ID of the sample ID in bytes |
| *L*sample\_ID | Sample ID |

* Dosage data offsets

|  |  |
| --- | --- |
| Bytes | Description |
| 8 × *N*SNPs | Unsigned integers indicating the start position of compressed dosages data for each SNP |

* Dosage data (sequence of *N*SNPs blocks)

|  |  |
| --- | --- |
| Bytes | Description |
| 4 | Unsigned integer indicating the size *S*compressed of the compressed dosage data in bytes | |
| 4 | Unsigned integer indicating the size *S*uncompressed of the uncompressed dosage data in bytes | |
| *S*compressed - 4 | Zstandard compressed dosage data in integer format | |
|  | Missing values are coded as follows | ||  | *y* = 53248 | if *C*level = 0 |
|  | *y* = 3489660928 | if *C*level = 1 |
|  | *y* = 14987979559889010688 | if *C*level = 2 |
|  | *y* = 208 | if *C*level = 3 |
|  | Convert a dosage value from integer format to floating-point format with the following transformation | ||  | *x* = 2(2 - 8 × *N*bytes ) × *y* | ||  | See *C*level for the number of bytes *N*bytes | |