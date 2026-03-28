### BDOSE v1.0 file format

* Header

|  |  |
| --- | --- |
| Bytes | Description |
| 8 | Magic number (bdose1.0) |
| 4 | Unsigned integer indicating the length *L*BGEN\_filename in bytes of the BGEN filename used to generate the BDOSE file |
| *L*BGEN\_filename | Name of the BGEN file |
| 8 | Unsigned integer indicating the size *S*BGEN\_file of the BGEN file in bytes |
| Min(1000, *S*BGEN\_file) | First bytes of the BGEN file |
| 8 | Unsigned integer indicating the size *S*BDOSE\_file of the BDOSE file in bytes |
| 4 | Unsigned integer indicating the number of samples *N*Samples in the BDOSE file |
| 4 | Unsigned integer indicating the number of SNPs *N*SNPs in the BDOSE file |

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

* Sample missingness

|  |  |
| --- | --- |
| Bytes | Description |
| 4 × *N*SNPs | Unsigned integers representing the missing data rate for each SNP |

* Dosage data offsets

|  |  |
| --- | --- |
| Bytes | Description |
| 8 × *N*SNPs | Unsigned integers indicating the start position of dosages data for each SNP |

* Dosage data

|  |  |
| --- | --- |
| Bytes | Description |
| 8 × *N*Samples | Floating-point numbers representing standardized dosages with respect to the allele in column allele2 of the Z file |