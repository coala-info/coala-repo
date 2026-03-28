Previous: [CDF-2 file format specification](CDF_002d2-file-format-specification.html#CDF_002d2-file-format-specification), Up: [Top](index.html#Top)   [[Index](Combined-Index.html#Combined-Index "Index")]

---

## Appendix G CDF-5 file format specification

The specification of CDF classic file format (referred as CDF-1) is shown in black font.
The new features added in CDF-2 specification are colored in red. CDF-2 backward supports all specification of CDF-1.
The new features added in CDF-5 specification are colored in blue. CDF-5 backward supports all specification of CDF-2.
(Note that "\x" used in this specification indicates the next two characters represent hexadecimal digits. Two hexadecimal digits, each of them 4 bits, make a byte.)

---

|  |  |  |  |
| --- | --- | --- | --- |
| netcdf\_file | = | header data |  |
| header | = | magic numrecs dim\_list gatt\_list var\_list |  |
| magic | = | 'C' 'D' 'F' VERSION |  |
| VERSION | = | \x01 | | //classic format (CDF-1) |
|  |  | \x02 | | //64-bit offset format (CDF-2) |
|  |  | \x05 | //64-bit data format (CDF-5) |
| numrecs | = | NON\_NEG | STREAMING | //length of record dimension |
| dim\_list | = | ABSENT | NC\_DIMENSION nelems [dim ...] |  |
| gatt\_list | = | att\_list | //global attributes |  |
| att\_list | = | ABSENT | NC\_ATTRIBUTE nelems [attr ...] |  |
| var\_list | = | ABSENT | NC\_VARIABLE nelems [var ...] |  |
| ABSENT | = | ZERO ZERO | | //list is not present (CDF-1 and CDF-2) |
|  |  | ZERO ZERO64 | //list is not present (CDF-5) |
| ZERO | = | \x00 \x00 \x00 \x00 | //32-bit zero |
| ZERO64 | = | \x00 \x00 \x00 \x00 \x00 \x00 \x00 \x00 | //64-bit zero (CDF-5) |
| NC\_DIMENSION | = | \x00 \x00 \x00 \x0A | //tag for list of dimensions |
| NC\_VARIABLE | = | \x00 \x00 \x00 \x0B | //tag for list of variables |
| NC\_ATTRIBUTE | = | \x00 \x00 \x00 \x0C | //tag for list of attributes |
| nelems | = | NON\_NEG | //number of elements in following sequence |
| dim | = | name dim\_length |  |
| name | = | nelems namestring |  |
|  |  |  | //Names a dimension, variable, or attribute. |
|  |  |  | //Names should match the regular expression |
|  |  |  | //([a-zA-Z0-9\_]|{MUTF8})([^\x00-\x1F/\x7F-\xFF]|{MUTF8})\* |
|  |  |  | //For other constraints, see ["Note on names"](#NOTENAMES5) below. |
| namestring | = | ID1 [IDN ...] padding |  |
| ID1 | = | alphanumeric | '\_' |  |
| IDN | = | alphanumeric | special1 | special2 |  |
| alphanumeric | = | lowercase | uppercase | numeric | MUTF8 |  |
| lowercase | = | 'a'|'b'|'c'|'d'|'e'|'f'|'g'|'h'|'i'|'j'|'k'|'l'|'m'| |  |
|  |  | 'n'|'o'|'p'|'q'|'r'|'s'|'t'|'u'|'v'|'w'|'x'|'y'|'z' |  |
| uppercase | = | 'A'|'B'|'C'|'D'|'E'|'F'|'G'|'H'|'I'|'J'|'K'|'L'|'M'| |  |
|  |  | 'N'|'O'|'P'|'Q'|'R'|'S'|'T'|'U'|'V'|'W'|'X'|'Y'|'Z' |  |
| numeric | = | '0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9' |  |
| special1 | = | '\_'|'.'|'|''+'|'-' | //special1 chars have traditionally been |
|  |  |  | //permitted in CDF-1. |
| special2 | = | ' ' | '!' | '"' | '#'  | '$' | '%' | '&' | '\'' | | //special2 chars are recently permitted in |
|  |  | '(' | ')' | '\*' | ','  | ':' | ';' | '<' | '='  | | //names (and require escaping in CDL). |
|  |  | '>' | '?' | '[' | '\\' | ']' | '^' | '`' | '{'  | | //Note: '/' is not permitted. |
|  |  | '|' | '}' | '~' |  |
| MUTF8 | = | <multibyte UTF-8 encoded> | //NFC-normalized Unicode character |
| dim\_length | = | NON\_NEG | //If zero, this is the record dimension. |
|  |  |  | //There can be at most one record dimension. |
| attr | = | name nc\_type nelems [values ...] |  |
| nc\_type | = | NC\_BYTE   | |  |
|  |  | NC\_CHAR   | |  |
|  |  | NC\_SHORT  | |  |
|  |  | NC\_INT    | |  |
|  |  | NC\_FLOAT  | |  |
|  |  | NC\_DOUBLE | |  |
|  |  | NC\_UBYTE  | |  |
|  |  | NC\_USHORT | |  |
|  |  | NC\_UINT   | |  |
|  |  | NC\_INT64  | |  |
|  |  | NC\_UINT64 |  |
| var | = | name nelems [dimid ...] vatt\_list nc\_type vsize begin |  |
|  |  |  | //nelems is the dimensionality (rank) of the variable |
|  |  |  | //0 for scalar, 1 for vector, 2 for matrix, ... |
| dimid | = | NON\_NEG | //Dimension ID (index into dim\_list) for variable |
|  |  |  | //shape. We say this is a "record variable" if and only |
|  |  |  | //if the first dimension is the record dimension. |
| vatt\_list | = | att\_list | //Variable-specific attributes |
| vsize | = | NON\_NEG | //Variable size. If not a record variable, the amount |
|  |  |  | //of space in bytes allocated to the variable's data. |
|  |  |  | //For record variables, it is the amount of space per |
|  |  |  | //record. See ["Note on vsize"](#NOTEVSIZE5), below. |
| begin | = | OFFSET | //Variable start location. The offset in bytes (seek |
|  |  |  | //index) in the file of the beginning of data for this. |
|  |  |  | //variable. |
| data | = | non\_recs recs |  |
| non\_recs | = | [vardata ...] | //The data for all non-record variables, stored |
|  |  |  | //contiguously for each variable, in the same order the |
|  |  |  | //variables occur in the header. |
| vardata | = | [values ...] | //All data for a non-record variable, as a block of |
|  |  |  | //values of the same type as the variable, in row-major |
|  |  |  | //order (last dimension varying fastest). |
| recs | = | [record ...] | //The data for all record variables are stored |
|  |  |  | //interleaved at the end of the file. |
| record | = | [varslab ...] | //Each record consists of the n-th slab from each |
|  |  |  | //record variable, for example x[n,...], y[n,...], |
|  |  |  | //z[n,...] where the first index is the record number, |
|  |  |  | //which is the unlimited dimension index. |
| varslab | = | [values ...] | //One record of data for a variable, a block of values |
|  |  |  | //all of the same type as the variable in row-major |
|  |  |  | //order (last index varying fastest). |
| values | = | bytes | chars | shorts | ints | floats | doubles | |  |
|  |  | ubytes | ushorts | uints | int64s | uint64s |  |
| string | = | nelems [chars] |  |
| bytes | = | [BYTE ...] padding |  |
| chars | = | [CHAR ...] padding |  |
| shorts | = | [SHORT ...] padding |  |
| ints | = | [INT ...] |  |
| floats | = | [FLOAT ...] |  |
| doubles | = | [DOUBLE ...] |  |
| ubytes | = | [UBYTE ...] padding |  |
| ushorts | = | [USHORT ...] padding |  |
| uints | = | [UINT ...] |  |
| int64s | = | [INT64 ...] |  |
| uint64s | = | [UINT64 ...] |  |
| padding | = | <0, 1, 2, or 3 bytes to next 4-byte boundary> |  |
|  |  |  | //Header padding uses null (\x00) bytes. In data, padding |
|  |  |  | //uses variable's fill value. See ["Note on padding"](#NOTEPADDING5) below |
|  |  |  | //for a special case. |
| NON\_NEG | = | <non-negative INT> | | //for CDF-1 and CDF-2 formats |
|  |  | <non-negative INT64> | //for 64-bit data format (CDF-5) |
| STREAMING | = | \xFF \xFF \xFF \xFF | | //for CDF-1 and CDF-2 formats |
|  |  | \xFF \xFF \xFF \xFF \xFF \xFF \xFF \xFF | //for CDF-5 format |
|  |  |  | //Indicates indeterminate record count, allows streaming |
|  |  |  | //data |
| OFFSET | = | <non-negative INT> | | //for classic format (CDF-1) |
|  |  | <non-negative INT64> | //for CDF-2 and CDF-5 formats |
| BYTE | = | <8-bit byte> | //See ["Note on byte data"](#NOTEBYTE5) below. |
| CHAR | = | <8-bit byte> | //See ["Note on char data"](#NOTECHAR5) below. |
| SHORT | = | <16-bit signed integer, Bigendian, two's complement> |  |
| INT | = | <32-bit signed integer, Bigendian, two's complement> |  |
| FLOAT | = | <32-bit IEEE single-precision float, Bigendian> |  |
| DOUBLE | = | <64-bit IEEE double-precision float, Bigendian> |  |
| UBYTE | = | <8-bit unsigned byte> |  |
| USHORT | = | <16-bit unsigned integer, Bigendian, two's complement> |  |
| UINT | = | <32-bit unsigned integer, Bigendian, two's complement> |  |
| INT64 | = | <64-bit signed integer, Bigendian, two's complement> |  |
| UINT64 | = | <64-bit unsigned integer, Bigendian, two's complement> |  |
|  |  |  | //following type tags are 32-bit integers |
| NC\_BYTE | = | \x00 \x00 \x00 \x01 | //8-bit signed integers |
| NC\_CHAR | = | \x00 \x00 \x00 \x02 | //text characters |
| NC\_SHORT | = | \x00 \x00 \x00 \x03 | //16-bit signed integers |
| NC\_INT | = | \x00 \x00 \x00 \x04 | //32-bit signed integers |
| NC\_FLOAT | = | \x00 \x00 \x00 \x05 | //IEEE single precision floats |
| NC\_DOUBLE | = | \x00 \x00 \x00 \x06 | //IEEE double precision floats |
| NC\_UBYTE | = | \x00 \x00 \x00 \x07 | //unsigned 1 byte integer |
| NC\_USHORT | = | \x00 \x00 \x00 \x08 | //unsigned 2-byte integer |
| NC\_UINT | = | \x00 \x00 \x00 \x09 | //unsigned 4-byte integer |
| NC\_INT64 | = | \x00 \x00 \x00 \x0A | //signed 8-byte integer |
| NC\_UINT64 | = | \x00 \x00 \x00 \x0B | //unsigned 8-byte integer |
|  |  |  | //Default fill values for each type, may be overridden by |
|  |  |  | //variable attribute named `\_FillValue'. See |
|  |  |  | //["Note on fill values"](#NOTEFILL5) below. |
| FILL\_CHAR | = | \x00 | //((char)0) null byte |
| FILL\_BYTE | = | \x81 | //(signed char) -127 |
| FILL\_SHORT | = | \x80 \x01 | //(short) -32767 |
| FILL\_INT | = | \x80 \x00 \x00 \x01 | //(int) -2147483647 |
| FILL\_FLOAT | = | \x7C \xF0 \x00 \x00 | //(float) 9.9692099683868690e+36 |
| FILL\_DOUBLE | = | \x47 \x9E \x00 \x00 \x00 \x00 \x00 \x00 | //(double)9.9692099683868690e+36 |
| FILL\_UBYTE | = | \xFF | //(255) |
| FILL\_USHORT | = | \xFF \xFF | //(65535) |
| FILL\_UINT | = | \xFF \xFF \xFF \xFF | //(4294967295U) |
| FILL\_INT64 | = | \x80 \x00 \x00 \x00 \x00 \x00 \x00 \x02 | //((long long)-9223372036854775806LL) |
| FILL\_UINT64 | = | \xFF \xFF \xFF \xFF \xFF \xFF \xFF \xFE | //((unsigned long long)18446744073709551614ULL) |

---

### Notes

**Note on vsize**:This number is the product of the dimension lengths
(omitting the record dimension) and the number of bytes per value
(determined from the type), increased to the next multiple of 4, for
each variable. If a record variable, this is the amount of space per
record (except that, for backward compatibility, it always includes
padding to the next multiple of 4 bytes, even in the exceptional case
noted below under "Note on padding"). The netCDF "record size" is
calculated as the sum of the `vsize`’s of all the record variables.

The **vsize** field is actually redundant, because its value may be
computed from other information in the header. The 32-bit **vsize** field
is not large enough to contain the size of variables that require more
than 2^32 - 4 bytes, so 2^32 - 1 is used in the **vsize** field for such
variables.

**Note on names**:CDF-1 enforces a more restricted set of characters in
creating new names, but permits reading names containing arbitrary
bytes. This specification extends the permitted characters in names
to include multi-byte UTF-8 encoded Unicode and additional printing
characters from the US-ASCII alphabet. The first character of a name
must be alphanumeric, a multi-byte UTF-8 character, or ’\_’
(reserved for special names with meaning to implementations,
such as the "\_FillValue" attribute). Subsequent characters may also
include printing special characters, except for ’/’ which is not
allowed in names. Names that have trailing space characters are also
not permitted.

Implementations of all CDF formats must
ensure that names are normalized according to Unicode NFC
normalization rules during encoding as UTF-8 for storing in the file
header. This is necessary to ensure that gratuitous differences in
the representation of Unicode names do not cause anomalies in
comparing files and querying data objects by name.

**Note on streaming data**:The largest possible record count, 2^32
- 1, is reserved to indicate an indeterminate number of records.
This means that the number of records in the file must be determined
by other means, such as reading them or computing the current number
of records from the file length and other information in the header.
It also means that the numrecs field in the header will not be updated
as records are added to the file. [This feature is not yet
implemented].

**Note on padding**:In the special case when there is only one record
variable and it is of type character, byte, or short, no padding is
used between record slabs, so records after the first record do not
necessarily start on four-byte boundaries. However, as noted above
under "Note on **vsize**, the **vsize** field is computed to
include padding to the next multiple of 4 bytes. In this case,
readers should ignore **vsize** and assume no padding. Writers
should store **vsize** as if padding were included.

**Note on byte data**:It is possible to interpret byte data as either
signed (-128 to 127) or unsigned (0 to 255). When reading byte data
through an interface that converts it into another numeric type, the
default interpretation is signed. There are various attribute
conventions for specifying whether bytes represent signed or unsigned
data, but no standard convention has been established. The variable
attribute "\_Unsigned" is reserved for this purpose in future
implementations.

**Note on char data**:Although the characters used in netCDF names must
be encoded as UTF-8, character data may use other encodings. The variable
attribute "\_Encoding" is reserved for this purpose in future implementations.

**Note on fill values**: Because data variables may be created before
their values are written, and because values need not be written
sequentially in a netCDF file, default "fill values" are defined for
each type, for initializing data values before they are explicitly
written. This makes it possible to detect reading values that were
never written. The variable attribute "\_FillValue", if present,
overrides the default fill value for a variable. If \_FillValue is
defined then it should be scalar and of the same type as the variable.

Fill values are not required, however, because netCDF libraries have
traditionally supported a "no fill" mode when writing, omitting the
initialization of variable values with fill values. This makes the
creation of large files faster, but also eliminates the possibility of
detecting the inadvertent reading of values that haven’t been written.

### Notes on Computing File Offsets

The offset (position within the file) of a specified data value in a
CDF-1, CDF-2, or CDF-5 file is determined by
the variable start location (the offset in the `begin` field), the
external type of the variable (the `nc_type` field), and the
dimension indices (one for each of the variable’s dimensions) of the
value desired.

The external size in bytes of one data value for each possible
netCDF type, denoted `extsize` below, is:

|  |  |
| --- | --- |
| `NC_BYTE` | 1 |
| `NC_CHAR` | 1 |
| `NC_SHORT` | 2 |
| `NC_INT` | 4 |
| `NC_FLOAT` | 4 |
| `NC_DOUBLE` | 8 |
| `NC_UBYTE` | 1 |
| `NC_USHORT` | 2 |
| `NC_UINT` | 4 |
| `NC_INT64` | 8 |
| `NC_UINT64` | 8 |

The record size, denoted by `recsize` below, is the sum of the `vsize`
fields of record variables (variables that use the unlimited
dimension), using the actual value determined by