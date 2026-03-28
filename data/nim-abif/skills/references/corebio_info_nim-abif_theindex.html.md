# Index

Modules: [abi2fq](abi2fq.html), [abichromatogram](abichromatogram.html), [abif](abif.html), [abimerge](abimerge.html), [abimetadata](abimetadata.html).

## API symbols

[A:](#A)
:   * [abichromatogram: Channel.A](abichromatogram.html#A)

[ABIFTrace:](#ABIFTrace)
:   * [abif: type ABIFTrace](abif.html#ABIFTrace)

[abifVersion:](#abifVersion)
:   * [abif: proc abifVersion(): string](abif.html#abifVersion)

[C:](#C)
:   * [abichromatogram: Channel.C](abichromatogram.html#C)

[canDisplayTag:](#canDisplayTag)
:   * [abimetadata: proc canDisplayTag(tagName: string; entry: DirectoryEntry): bool](abimetadata.html#canDisplayTag%2Cstring%2CDirectoryEntry)

[Channel:](#Channel)
:   * [abichromatogram: enum Channel](abichromatogram.html#Channel)

[close:](#close)
:   * [abif: proc close(trace: ABIFTrace)](abif.html#close%2CABIFTrace)

[Config:](#Config)
:   * [abi2fq: object Config](abi2fq.html#Config)
    * [abimerge: object Config](abimerge.html#Config)
    * [abimetadata: object Config](abimetadata.html#Config)

[DirectoryEntry:](#DirectoryEntry)
:   * [abif: object DirectoryEntry](abif.html#DirectoryEntry)

[displaySingleTag:](#displaySingleTag)
:   * [abimetadata: proc displaySingleTag(trace: ABIFTrace; tagName: string; debug: bool)](abimetadata.html#displaySingleTag%2CABIFTrace%2Cstring%2Cbool)

[ElementType:](#ElementType)
:   * [abif: enum ElementType](abif.html#ElementType)

[etBool:](#etBool)
:   * [abif: ElementType.etBool](abif.html#etBool)

[etByte:](#etByte)
:   * [abif: ElementType.etByte](abif.html#etByte)

[etChar:](#etChar)
:   * [abif: ElementType.etChar](abif.html#etChar)

[etCString:](#etCString)
:   * [abif: ElementType.etCString](abif.html#etCString)

[etDate:](#etDate)
:   * [abif: ElementType.etDate](abif.html#etDate)

[etDouble:](#etDouble)
:   * [abif: ElementType.etDouble](abif.html#etDouble)

[etFloat:](#etFloat)
:   * [abif: ElementType.etFloat](abif.html#etFloat)

[etLong:](#etLong)
:   * [abif: ElementType.etLong](abif.html#etLong)

[etPoint:](#etPoint)
:   * [abif: ElementType.etPoint](abif.html#etPoint)

[etPString:](#etPString)
:   * [abif: ElementType.etPString](abif.html#etPString)

[etRational:](#etRational)
:   * [abif: ElementType.etRational](abif.html#etRational)

[etRect:](#etRect)
:   * [abif: ElementType.etRect](abif.html#etRect)

[etShort:](#etShort)
:   * [abif: ElementType.etShort](abif.html#etShort)

[etTag:](#etTag)
:   * [abif: ElementType.etTag](abif.html#etTag)

[etThumb:](#etThumb)
:   * [abif: ElementType.etThumb](abif.html#etThumb)

[etTime:](#etTime)
:   * [abif: ElementType.etTime](abif.html#etTime)

[etVPoint:](#etVPoint)
:   * [abif: ElementType.etVPoint](abif.html#etVPoint)

[etVRect:](#etVRect)
:   * [abif: ElementType.etVRect](abif.html#etVRect)

[etWord:](#etWord)
:   * [abif: ElementType.etWord](abif.html#etWord)

[exportFasta:](#exportFasta)
:   * [abif: proc exportFasta(trace: ABIFTrace; outFile: string = "")](abif.html#exportFasta%2CABIFTrace%2Cstring)

[exportFastq:](#exportFastq)
:   * [abif: proc exportFastq(trace: ABIFTrace; outFile: string = "")](abif.html#exportFastq%2CABIFTrace%2Cstring)

[formatTagValue:](#formatTagValue)
:   * [abimetadata: proc formatTagValue(tagName: string; entry: DirectoryEntry; trace: ABIFTrace): string](abimetadata.html#formatTagValue%2Cstring%2CDirectoryEntry%2CABIFTrace)

[G:](#G)
:   * [abichromatogram: Channel.G](abichromatogram.html#G)

[getData:](#getData)
:   * [abif: proc getData(trace: ABIFTrace; tag: string): string](abif.html#getData%2CABIFTrace%2Cstring)

[getFullTagValue:](#getFullTagValue)
:   * [abimetadata: proc getFullTagValue(tagName: string; entry: DirectoryEntry; trace: ABIFTrace): string](abimetadata.html#getFullTagValue%2Cstring%2CDirectoryEntry%2CABIFTrace)

[getQualityValues:](#getQualityValues)
:   * [abif: proc getQualityValues(trace: ABIFTrace): seq[int]](abif.html#getQualityValues%2CABIFTrace)

[getSampleName:](#getSampleName)
:   * [abif: proc getSampleName(trace: ABIFTrace): string](abif.html#getSampleName%2CABIFTrace)

[getSequence:](#getSequence)
:   * [abif: proc getSequence(trace: ABIFTrace): string](abif.html#getSequence%2CABIFTrace)

[getTagNames:](#getTagNames)
:   * [abif: proc getTagNames(trace: ABIFTrace): seq[string]](abif.html#getTagNames%2CABIFTrace)

[isHumanReadableType:](#isHumanReadableType)
:   * [abimetadata: proc isHumanReadableType(tagType: ElementType): bool](abimetadata.html#isHumanReadableType%2CElementType)

[listMetadata:](#listMetadata)
:   * [abimetadata: proc listMetadata(trace: ABIFTrace; debug: bool; limit: int = 0)](abimetadata.html#listMetadata%2CABIFTrace%2Cbool%2Cint)

[main:](#main)
:   * [abi2fq: proc main()](abi2fq.html#main)
    * [abimetadata: proc main()](abimetadata.html#main)

[makeMatrix:](#makeMatrix)
:   * [abimerge: proc makeMatrix[T](rows, cols: int; initValue: T): seq[seq[T]]](abimerge.html#makeMatrix%2Cint%2Cint%2CT)

[matchIUPAC:](#matchIUPAC)
:   * [abimerge: proc matchIUPAC(a, b: char): bool](abimerge.html#matchIUPAC%2Cchar%2Cchar)

[mergeSequences:](#mergeSequences)
:   * [abimerge: proc mergeSequences(forwardSeq: string; forwardQual: seq[int]; reverseSeq: string;
      reverseQual: seq[int]; config: Config): tuple[seq: string,
      qual: seq[int]]](abimerge.html#mergeSequences%2Cstring%2Cseq%5Bint%5D%2Cstring%2Cseq%5Bint%5D%2CConfig)

[modifyTag:](#modifyTag)
:   * [abimetadata: proc modifyTag(trace: ABIFTrace; tagName: string; newValue: string;
      outputFile: string): bool](abimetadata.html#modifyTag%2CABIFTrace%2Cstring%2Cstring%2Cstring)

[newABIFTrace:](#newABIFTrace)
:   * [abif: proc newABIFTrace(filename: string; trimming: bool = false): ABIFTrace](abif.html#newABIFTrace%2Cstring%2Cbool)

[parseCommandLine:](#parseCommandLine)
:   * [abi2fq: proc parseCommandLine(): Config](abi2fq.html#parseCommandLine)
    * [abimetadata: proc parseCommandLine(): Config](abimetadata.html#parseCommandLine)

[printHelp:](#printHelp)
:   * [abi2fq: proc printHelp()](abi2fq.html#printHelp)
    * [abimetadata: proc printHelp()](abimetadata.html#printHelp)

[revcompl:](#revcompl)
:   * [abimerge: proc revcompl(s: string): string](abimerge.html#revcompl%2Cstring)

[reverseString:](#reverseString)
:   * [abimerge: proc reverseString(str: string): string](abimerge.html#reverseString%2Cstring)

[simpleSmithWaterman:](#simpleSmithWaterman)
:   * [abimerge: proc simpleSmithWaterman(alpha, beta: string; weights: swWeights): swAlignment](abimerge.html#simpleSmithWaterman%2Cstring%2Cstring%2CswWeights)

[splitAmbiguousBases:](#splitAmbiguousBases)
:   * [abi2fq: proc splitAmbiguousBases(sequence: string): tuple[seq1: string, seq2: string]](abi2fq.html#splitAmbiguousBases%2Cstring)

[swAlignment:](#swAlignment)
:   * [abimerge: object swAlignment](abimerge.html#swAlignment)

[swDefaults:](#swDefaults)
:   * [abimerge: let swDefaults](abimerge.html#swDefaults)

[swWeights:](#swWeights)
:   * [abimerge: object swWeights](abimerge.html#swWeights)

[T:](#T)
:   * [abichromatogram: Channel.T](abichromatogram.html#T)

[TraceData:](#TraceData)
:   * [abichromatogram: object TraceData](abichromatogram.html#TraceData)

[TraceDataPoint:](#TraceDataPoint)
:   * [abichromatogram: object TraceDataPoint](abichromatogram.html#TraceDataPoint)

[translateIUPAC:](#translateIUPAC)
:   * [abimerge: proc translateIUPAC(c: char): char](abimerge.html#translateIUPAC%2Cchar)

[trimSequence:](#trimSequence)
:   * [abi2fq: proc trimSequence(sequence: string; qualities: seq[int]; windowSize: int;
      threshold: int): tuple[seq: string, qual: seq[int]]](abi2fq.html#trimSequence%2Cstring%2Cseq%5Bint%5D%2Cint%2Cint)

[verifyTagUpdate:](#verifyTagUpdate)
:   * [abimetadata: proc verifyTagUpdate(inputFile, outputFile, tagName: string): bool](abimetadata.html#verifyTagUpdate%2Cstring%2Cstring%2Cstring)

[verifyTagUpdateBasic:](#verifyTagUpdateBasic)
:   * [abimetadata: proc verifyTagUpdateBasic(inputFile, outputFile, tagName: string; newValue: string;
      offset: int): bool](abimetadata.html#verifyTagUpdateBasic%2Cstring%2Cstring%2Cstring%2Cstring%2Cint)

[writeFastq:](#writeFastq)
:   * [abi2fq: proc writeFastq(sequence: string; qualities: seq[int]; name: string;
      outFile: string = ""; fasta: bool = false; splitSeq1: string = "";
      splitSeq2: string = "")](abi2fq.html#writeFastq%2Cstring%2Cseq%5Bint%5D%2Cstring%2Cstring%2Cbool%2Cstring%2Cstring)

Made with Nim. Generated: 2025-07-23 15:08:19 UTC