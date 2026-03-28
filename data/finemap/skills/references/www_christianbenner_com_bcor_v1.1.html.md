### BCOR v1.1 file format

* Header

|  |  |
| --- | --- |
| Bytes | Description |
| 7 | Magic number (bcor1.1) |
| 8 | Unsigned integer indicating the size *S*BCOR\_file of the BCOR file in bytes |
| 4 | Unsigned integer indicating the number of samples *N*Samples used to compute SNP correlations in the BCOR file |
| 4 | Unsigned integer indicating the number of SNPs *N*SNPs for which correlations are available in the BCOR file |
| 1 | Unsigned integer representing the compression level *C*level used in the BCOR file |
|  | *C*level = 0 indicates 2 bytes |
|  | *C*level = 1 indicates 4 bytes |
|  | *C*level = 2 indicates 8 bytes |
|  | *C*level = 3 indicates 1 byte |
| 8 | Unsigned integer indicating the start position of the SNP correlations in the BCOR file |

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

* SNP correlations (sequence of *N*SNPs × (1 + *N*SNPs) / 2 - *N*SNPs values)

|  |  |  |
| --- | --- | --- |
| Bytes | Description | |
| See *C*level for the number of bytes *N*bytes | Unsigned integer *y* representing a correlation value in integer format | |
|  | Missing values are coded as follows | ||  | *y* = 53248 | if *C*level = 0 |
|  | *y* = 3489660928 | if *C*level = 1 |
|  | *y* = 14987979559889010688 | if *C*level = 2 |
|  | *y* = 208 | if *C*level = 3 |
|  | Convert a correlation value from integer format to floating-point format with the following transformation | ||  | *x* = 2(2 - 8 × *N*bytes ) × *y* - 1 | |