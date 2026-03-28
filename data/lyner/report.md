# lyner CWL Generation Report

## lyner_astype

### Tool Description
Convert data to a specified type.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tedil/lyner
- **Stars**: N/A
### Original Help Text
```text
Usage: lyner astype [OPTIONS] TYPE
Try "lyner astype --help" for help.

Error: no such option: --h  Did you mean --help?
```


## lyner_autoencode

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Using TensorFlow backend.
Level 1:tensorflow:Registering FakeQuantWithMinMaxArgs (<function _FakeQuantWithMinMaxArgsGradient at 0x7577da7ac840>) in gradient.
Level 1:tensorflow:Registering FakeQuantWithMinMaxVars (<function _FakeQuantWithMinMaxVarsGradient at 0x7577da7ac8c8>) in gradient.
Level 1:tensorflow:Registering FakeQuantWithMinMaxVarsPerChannel (<function _FakeQuantWithMinMaxVarsPerChannelGradient at 0x7577da7ac950>) in gradient.
Level 1:tensorflow:Registering MatMul,flops (<function _calc_mat_mul_flops at 0x7577d4374c80>) in statistical functions.
Level 1:tensorflow:Registering BatchMatMul,flops (<function _calc_batch_mat_mul_flops at 0x7577d4374e18>) in statistical functions.
Level 1:tensorflow:Registering AccumulateNV2 (<function _accumulate_n_grad at 0x7577d4379158>) in gradient.
Level 1:tensorflow:Registering TensorListConcatLists (None) in gradient.
Level 1:tensorflow:Registering TensorListElementShape (None) in gradient.
Level 1:tensorflow:Registering TensorListLength (None) in gradient.
Level 1:tensorflow:Registering TensorListPushBackBatch (None) in gradient.
Level 1:tensorflow:Registering TensorListPushBack (<function _PushBackGrad at 0x7577d42aa400>) in gradient.
Level 1:tensorflow:Registering TensorListPopBack (<function _PopBackGrad at 0x7577d42aa488>) in gradient.
Level 1:tensorflow:Registering TensorListStack (<function _TensorListStackGrad at 0x7577d42aa510>) in gradient.
Level 1:tensorflow:Registering TensorListConcatV2 (<function _TensorListConcatGrad at 0x7577d42aa598>) in gradient.
Level 1:tensorflow:Registering TensorListConcat (<function _TensorListConcatGrad at 0x7577d42aa598>) in gradient.
Level 1:tensorflow:Registering TensorListSplit (<function _TensorListSplitGrad at 0x7577d42aa620>) in gradient.
Level 1:tensorflow:Registering TensorListFromTensor (<function _TensorListFromTensorGrad at 0x7577d42aa6a8>) in gradient.
Level 1:tensorflow:Registering TensorListGetItem (<function _TensorListGetItemGrad at 0x7577d42aa730>) in gradient.
Level 1:tensorflow:Registering TensorListSetItem (<function _TensorListSetItemGrad at 0x7577d42aa7b8>) in gradient.
Level 1:tensorflow:Registering TensorListResize (<function _TensorListResizeGrad at 0x7577d42aa840>) in gradient.
Level 1:tensorflow:Registering TensorListGather (<function _TensorListGatherGrad at 0x7577d42aa8c8>) in gradient.
Level 1:tensorflow:Registering TensorListScatterV2 (<function _TensorListScatterGrad at 0x7577d42aa950>) in gradient.
Level 1:tensorflow:Registering TensorListScatter (<function _TensorListScatterGrad at 0x7577d42aa950>) in gradient.
Level 1:tensorflow:Registering TensorListScatterIntoExistingList (<function _TensorListScatterIntoExistingListGrad at 0x7577d42aa9d8>) in gradient.
Level 1:tensorflow:Registering cond_context ((<class 'tensorflow.core.protobuf.control_flow_pb2.CondContextDef'>, <function CondContext.to_proto at 0x7577d42ba620>, <function CondContext.from_proto at 0x7577d42ba6a8>)) in proto functions.
Level 1:tensorflow:Registering while_context ((<class 'tensorflow.core.protobuf.control_flow_pb2.WhileContextDef'>, <function WhileContext.to_proto at 0x7577d42bd598>, <function WhileContext.from_proto at 0x7577d42bd6a8>)) in proto functions.
Level 1:tensorflow:Registering ReadVariableOp (<function _ReadGrad at 0x7577d4225d08>) in gradient.
Level 1:tensorflow:Registering ResourceGather (<function _GatherGrad at 0x7577d42271e0>) in gradient.
Level 1:tensorflow:Registering variables ((<class 'tensorflow.core.framework.variable_pb2.VariableDef'>, <function _to_proto_fn at 0x7577d4227268>, <function _from_proto_fn at 0x7577d42272f0>)) in proto functions.
Level 1:tensorflow:Registering trainable_variables ((<class 'tensorflow.core.framework.variable_pb2.VariableDef'>, <function _to_proto_fn at 0x7577d4227268>, <function _from_proto_fn at 0x7577d42272f0>)) in proto functions.
Level 1:tensorflow:Registering moving_average_variables ((<class 'tensorflow.core.framework.variable_pb2.VariableDef'>, <function _to_proto_fn at 0x7577d4227268>, <function _from_proto_fn at 0x7577d42272f0>)) in proto functions.
Level 1:tensorflow:Registering local_variables ((<class 'tensorflow.core.framework.variable_pb2.VariableDef'>, <function _to_proto_fn at 0x7577d4227268>, <function _from_proto_fn at 0x7577d42272f0>)) in proto functions.
Level 1:tensorflow:Registering model_variables ((<class 'tensorflow.core.framework.variable_pb2.VariableDef'>, <function _to_proto_fn at 0x7577d4227268>, <function _from_proto_fn at 0x7577d42272f0>)) in proto functions.
Level 1:tensorflow:Registering global_step ((<class 'tensorflow.core.framework.variable_pb2.VariableDef'>, <function _to_proto_fn at 0x7577d4227268>, <function _from_proto_fn at 0x7577d42272f0>)) in proto functions.
Level 1:tensorflow:Registering metric_variables ((<class 'tensorflow.core.framework.variable_pb2.VariableDef'>, <function _to_proto_fn at 0x7577d4227268>, <function _from_proto_fn at 0x7577d42272f0>)) in proto functions.
Level 1:tensorflow:Registering Assert (None) in gradient.
Level 1:tensorflow:Registering VarIsInitializedOp (None) in gradient.
Level 1:tensorflow:Registering VariableShape (None) in gradient.
Level 1:tensorflow:Registering RandomStandardNormal (None) in gradient.
Level 1:tensorflow:Registering ParameterizedTruncatedNormal (None) in gradient.
Level 1:tensorflow:Registering TruncatedNormal (None) in gradient.
Level 1:tensorflow:Registering RandomUniform (None) in gradient.
Level 1:tensorflow:Registering Multinomial (None) in gradient.
Level 1:tensorflow:Registering EnsureShape (<function _ensure_shape_grad at 0x7577d40c70d0>) in gradient.
Level 1:tensorflow:Registering EagerPyFunc (<function _EagerPyFuncGrad at 0x7577d40cb2f0>) in gradient.
Level 1:tensorflow:Registering PyFunc (None) in gradient.
Level 1:tensorflow:Registering PyFuncStateless (None) in gradient.
Level 1:tensorflow:Registering Conv3D,flops (<function _calc_conv3d_flops at 0x7577d3f54510>) in statistical functions.
Level 1:tensorflow:Registering Conv2D,flops (<function _calc_conv_flops at 0x7577d3f54598>) in statistical functions.
Level 1:tensorflow:Registering DepthwiseConv2dNative,flops (<function _calc_depthwise_conv_flops at 0x7577d3f54620>) in statistical functions.
Level 1:tensorflow:Registering BiasAdd,flops (<function _calc_bias_add_flops at 0x7577d3f546a8>) in statistical functions.
Level 1:tensorflow:Registering Dilation2D,flops (<function _calc_dilation2d_flops at 0x7577d3f54f28>) in statistical functions.
Level 1:tensorflow:Registering RaggedTensorToSparse (<function _ragged_tensor_to_sparse_gradient at 0x7577d3f067b8>) in gradient.
Level 1:tensorflow:Registering RaggedTensorToVariant (None) in gradient.
Level 1:tensorflow:Registering RaggedRange (None) in gradient.
Level 1:tensorflow:Registering RaggedGather (<function _ragged_gather_grad at 0x7577d3f11400>) in gradient.
Level 1:tensorflow:Registering DecodeRaw (None) in gradient.
Level 1:tensorflow:Registering DecodePaddedRaw (None) in gradient.
Level 1:tensorflow:Registering ParseTensor (None) in gradient.
Level 1:tensorflow:Registering SerializeTensor (None) in gradient.
Level 1:tensorflow:Registering StringToNumber (None) in gradient.
Level 1:tensorflow:Registering RegexReplace (None) in gradient.
Level 1:tensorflow:Registering StringToHashBucket (None) in gradient.
Level 1:tensorflow:Registering StringToHashBucketFast (None) in gradient.
Level 1:tensorflow:Registering StringToHashBucketStrong (None) in gradient.
Level 1:tensorflow:Registering ReduceJoin (None) in gradient.
Level 1:tensorflow:Registering StringJoin (None) in gradient.
Level 1:tensorflow:Registering StringSplit (None) in gradient.
Level 1:tensorflow:Registering AsString (None) in gradient.
Level 1:tensorflow:Registering EncodeBase64 (None) in gradient.
Level 1:tensorflow:Registering DecodeBase64 (None) in gradient.
Level 1:tensorflow:Registering ReaderRead (None) in gradient.
Level 1:tensorflow:Registering ReaderReadUpTo (None) in gradient.
Level 1:tensorflow:Registering ReaderNumRecordsProduced (None) in gradient.
Level 1:tensorflow:Registering ReaderNumWorkUnitsCompleted (None) in gradient.
Level 1:tensorflow:Registering ReaderSerializeState (None) in gradient.
Level 1:tensorflow:Registering ReaderRestoreState (None) in gradient.
Level 1:tensorflow:Registering ReaderReset (None) in gradient.
Level 1:tensorflow:Registering WholeFileReader (None) in gradient.
Level 1:tensorflow:Registering TextLineReader (None) in gradient.
Level 1:tensorflow:Registering FixedLengthRecordReader (None) in gradient.
Level 1:tensorflow:Registering TFRecordReader (None) in gradient.
Level 1:tensorflow:Registering LMDBReader (None) in gradient.
Level 1:tensorflow:Registering IdentityReader (None) in gradient.
Level 1:tensorflow:Registering savers ((<class 'tensorflow.core.protobuf.saver_pb2.SaverDef'>, <function Saver.to_proto at 0x7577d3d4ca60>, <function Saver.from_proto at 0x7577d3d4cae8>)) in proto functions.
Level 1:tensorflow:Registering ReduceDataset (None) in gradient.
Level 1:tensorflow:Registering Print (<function _PrintGrad at 0x7577d3bc4e18>) in gradient.
Level 1:tensorflow:Registering HistogramSummary (None) in gradient.
Level 1:tensorflow:Registering ImageSummary (None) in gradient.
Level 1:tensorflow:Registering AudioSummary (None) in gradient.
Level 1:tensorflow:Registering AudioSummaryV2 (None) in gradient.
Level 1:tensorflow:Registering MergeSummary (None) in gradient.
Level 1:tensorflow:Registering ScalarSummary (None) in gradient.
Level 1:tensorflow:Registering TensorSummary (None) in gradient.
Level 1:tensorflow:Registering TensorSummaryV2 (None) in gradient.
Level 1:tensorflow:Registering Timestamp (None) in gradient.
Level 1:tensorflow:Registering Pack (<function _PackGrad at 0x7577d416dc80>) in gradient.
Level 1:tensorflow:Registering Unpack (<function _UnpackGrad at 0x7577d3af47b8>) in gradient.
Level 1:tensorflow:Registering Concat (<function _ConcatGrad at 0x7577d3af48c8>) in gradient.
Level 1:tensorflow:Registering ConcatV2 (<function _ConcatGradV2 at 0x7577d3af4950>) in gradient.
Level 1:tensorflow:Registering ConcatOffset (None) in gradient.
Level 1:tensorflow:Registering Slice (<function _SliceGrad at 0x7577d3af49d8>) in gradient.
Level 1:tensorflow:Registering StridedSlice (<function _StridedSliceGrad at 0x7577d3af4a60>) in gradient.
Level 1:tensorflow:Registering StridedSliceGrad (<function _StridedSliceGradGrad at 0x7577d3af4ae8>) in gradient.
Level 1:tensorflow:Registering Split (<function _SplitGrad at 0x7577d3af4b70>) in gradient.
Level 1:tensorflow:Registering SplitV (<function _SplitVGrad at 0x7577d3af4bf8>) in gradient.
Level 1:tensorflow:Registering Const (None) in gradient.
Level 1:tensorflow:Registering Diag (<function _DiagGrad at 0x7577d3af4c80>) in gradient.
Level 1:tensorflow:Registering DiagPart (<function _DiagPartGrad at 0x7577d3af4d08>) in gradient.
Level 1:tensorflow:Registering MatrixDiag (<function _MatrixDiagGrad at 0x7577d3af4d90>) in gradient.
Level 1:tensorflow:Registering MatrixDiagV2 (<function _MatrixDiagV2Grad at 0x7577d3af4e18>) in gradient.
Level 1:tensorflow:Registering MatrixDiagPart (<function _MatrixDiagPartGrad at 0x7577d3af4ea0>) in gradient.
Level 1:tensorflow:Registering MatrixDiagPartV2 (<function _MatrixDiagPartV2Grad at 0x7577d3af4f28>) in gradient.
Level 1:tensorflow:Registering MatrixSetDiag (<function _MatrixSetDiagGrad at 0x7577d3aff048>) in gradient.
Level 1:tensorflow:Registering MatrixSetDiagV2 (<function _MatrixSetDiagGradV2 at 0x7577d3aff0d0>) in gradient.
Level 1:tensorflow:Registering MatrixBandPart (<function _MatrixBandPartGrad at 0x7577d3aff158>) in gradient.
Level 1:tensorflow:Registering EditDistance (None) in gradient.
Level 1:tensorflow:Registering Fill (<function _FillGrad at 0x7577d3aff1e0>) in gradient.
Level 1:tensorflow:Registering ZerosLike (None) in gradient.
Level 1:tensorflow:Registering OnesLike (None) in gradient.
Level 1:tensorflow:Registering PreventGradient (<function _PreventGradientGrad at 0x7577d3aff268>) in gradient.
Level 1:tensorflow:Registering Gather (<function _GatherGrad at 0x7577d3aff2f0>) in gradient.
Level 1:tensorflow:Registering GatherV2 (<function _GatherV2Grad at 0x7577d3aff378>) in gradient.
Level 1:tensorflow:Registering GatherNd (<function _GatherNdGrad at 0x7577d3aff400>) in gradient.
Level 1:tensorflow:Registering ResourceGatherNd (<function _ResourceGatherNdGrad at 0x7577d3aff488>) in gradient.
Level 1:tensorflow:Registering CheckNumerics (<function _CheckNumericsGrad at 0x7577d3aff510>) in gradient.
Level 1:tensorflow:Registering Identity (<function _IdGrad at 0x7577d3aff598>) in gradient.
Level 1:tensorflow:Registering PlaceholderWithDefault (<function _IdGrad at 0x7577d3aff598>) in gradient.
Level 1:tensorflow:Registering RefIdentity (<function _RefIdGrad at 0x7577d3aff620>) in gradient.
Level 1:tensorflow:Registering IdentityN (<function _IdNGrad at 0x7577d3aff6a8>) in gradient.
Level 1:tensorflow:Registering StopGradient (None) in gradient.
Level 1:tensorflow:Registering Reshape (<function _ReshapeGrad at 0x7577d3aff730>) in gradient.
Level 1:tensorflow:Registering InvertPermutation (None) in gradient.
Level 1:tensorflow:Registering ExpandDims (<function _ExpandDimsGrad at 0x7577d3aff840>) in gradient.
Level 1:tensorflow:Registering Squeeze (<function _SqueezeGrad at 0x7577d3aff8c8>) in gradient.
Level 1:tensorflow:Registering Transpose (<function _TransposeGrad at 0x7577d3aff950>) in gradient.
Level 1:tensorflow:Registering ConjugateTranspose (<function _ConjugateTransposeGrad at 0x7577d3aff9d8>) in gradient.
Level 1:tensorflow:Registering Shape (None) in gradient.
Level 1:tensorflow:Registering ShapeN (None) in gradient.
Level 1:tensorflow:Registering Rank (None) in gradient.
Level 1:tensorflow:Registering Size (None) in gradient.
Level 1:tensorflow:Registering Tile (<function _TileGrad at 0x7577d3affa60>) in gradient.
Level 1:tensorflow:Registering BroadcastGradientArgs (None) in gradient.
Level 1:tensorflow:Registering Pad (<function _PadGrad at 0x7577d3affae8>) in gradient.
Level 1:tensorflow:Registering PadV2 (<function _PadGrad at 0x7577d3affae8>) in gradient.
Level 1:tensorflow:Registering ReverseSequence (<function _ReverseSequenceGrad at 0x7577d3affb70>) in gradient.
Level 1:tensorflow:Registering Reverse (<function _ReverseGrad at 0x7577d3affbf8>) in gradient.
Level 1:tensorflow:Registering ReverseV2 (<function _ReverseV2Grad at 0x7577d3affc80>) in gradient.
Level 1:tensorflow:Registering SpaceToBatch (<function _SpaceToBatchGrad at 0x7577d3affd08>) in gradient.
Level 1:tensorflow:Registering SpaceToBatchND (<function _SpaceToBatchNDGrad at 0x7577d3affd90>) in gradient.
Level 1:tensorflow:Registering BatchToSpace (<function _BatchToSpaceGrad at 0x7577d3affe18>) in gradient.
Level 1:tensorflow:Registering BatchToSpaceND (<function _BatchToSpaceNDGrad at 0x7577d3affea0>) in gradient.
Level 1:tensorflow:Registering SpaceToDepth (<function _SpaceToDepthGrad at 0x7577d3afff28>) in gradient.
Level 1:tensorflow:Registering DepthToSpace (<function _DepthToSpaceGrad at 0x7577d3a83048>) in gradient.
Level 1:tensorflow:Registering OneHot (None) in gradient.
Level 1:tensorflow:Registering MirrorPad (<function _MirrorPadGrad at 0x7577d3a830d0>) in gradient.
Level 1:tensorflow:Registering MirrorPadGrad (<function _MirrorPadGradGrad at 0x7577d3a83158>) in gradient.
Level 1:tensorflow:Registering QuantizeAndDequantize (<function _QuantizeAndDequantizeGrad at 0x7577d3a831e0>) in gradient.
Level 1:tensorflow:Registering QuantizeAndDequantizeV2 (<function _QuantizeAndDequantizeV2Grad at 0x7577d3a83268>) in gradient.
Level 1:tensorflow:Registering QuantizeAndDequantizeV3 (<function _QuantizeAndDequantizeV3Grad at 0x7577d3a832f0>) in gradient.
Level 1:tensorflow:Registering ExtractImagePatches (<function _ExtractImagePatchesGrad at 0x7577d3a83378>) in gradient.
Level 1:tensorflow:Registering ExtractVolumePatches (<function _ExtractVolumePatchesGrad at 0x7577d3a83400>) in gradient.
Level 1:tensorflow:Registering ScatterNd (<function _ScatterNdGrad at 0x7577d3a83488>) in gradient.
Level 1:tensorflow:Registering TensorScatterUpdate (<function _TensorScatterUpdateGrad at 0x7577d3a83510>) in gradient.
Level 1:tensorflow:Registering TensorScatterAdd (<function _TensorScatterAddGrad at 0x7577d3a83598>) in gradient.
Level 1:tensorflow:Registering TensorScatterSub (<function _TensorScatterSubGrad at 0x7577d3a83620>) in gradient.
Level 1:tensorflow:Registering ScatterNdNonAliasingAdd (<function _ScatterNdNonAliasingAddGrad at 0x7577d3a836a8>) in gradient.
Level 1:tensorflow:Registering BroadcastTo (<function _BroadcastToGrad at 0x7577d3a83730>) in gradient.
Level 1:tensorflow:Registering CudnnRNN (<function _cudnn_rnn_backward at 0x7577d3a837b8>) in gradient.
Level 1:tensorflow:Registering CudnnRNNV2 (<function _cudnn_rnn_backward_v2 at 0x7577d3a9eb70>) in gradient.
Level 1:tensorflow:Registering CudnnRNNV3 (<function _cudnn_rnn_backwardv3 at 0x7577d3a9ebf8>) in gradient.
Level 1:tensorflow:Registering DynamicPartition (<function _DynamicPartitionGrads at 0x7577d3a9ec80>) in gradient.
Level 1:tensorflow:Registering ParallelDynamicStitch (<function _DynamicStitchGrads at 0x7577d3a9ed90>) in gradient.
Level 1:tensorflow:Registering DynamicStitch (<function _DynamicStitchGrads at 0x7577d3a9ed90>) in gradient.
Level 1:tensorflow:Registering Queue (None) in gradient.
Level 1:tensorflow:Registering QueueEnqueue (None) in gradient.
Level 1:tensorflow:Registering QueueEnqueueMany (None) in gradient.
Level 1:tensorflow:Registering QueueDequeue (None) in gradient.
Level 1:tensorflow:Registering QueueDequeueMany (None) in gradient.
Level 1:tensorflow:Registering QueueDequeueUpTo (None) in gradient.
Level 1:tensorflow:Registering QueueClose (None) in gradient.
Level 1:tensorflow:Registering QueueSize (None) in gradient.
Level 1:tensorflow:Registering Stack (None) in gradient.
Level 1:tensorflow:Registering StackPush (None) in gradient.
Level 1:tensorflow:Registering StackPop (None) in gradient.
Level 1:tensorflow:Registering StackClose (None) in gradient.
Level 1:tensorflow:Registering GetSessionHandle (None) in gradient.
Level 1:tensorflow:Registering GetSessionHandleV2 (None) in gradient.
Level 1:tensorflow:Registering GetSessionTensor (None) in gradient.
Level 1:tensorflow:Registering DeleteSessionTensor (None) in gradient.
Level 1:tensorflow:Registering Roll (<function _RollGrad at 0x7577d3a9ee18>) in gradient.
Level 1:tensorflow:Registering ArgMax (<function _ArgMaxGrad at 0x7577d3aa9d08>) in gradient.
Level 1:tensorflow:Registering ArgMin (<function _ArgMinGrad at 0x7577d3aa9d90>) in gradient.
Level 1:tensorflow:Registering EuclideanNorm (None) in gradient.
Level 1:tensorflow:Registering Sum (<function _SumGrad at 0x7577d3aa9f28>) in gradient.
Level 1:tensorflow:Registering Max (<function _MaxGrad at 0x7577d3a410d0>) in gradient.
Level 1:tensorflow:Registering Min (<function _MinGrad at 0x7577d3a41158>) in gradient.
Level 1:tensorflow:Registering Mean (<function _MeanGrad at 0x7577d3a411e0>) in gradient.
Level 1:tensorflow:Registering Prod (<function _ProdGrad at 0x7577d3a41268>) in gradient.
Level 1:tensorflow:Registering SegmentSum (<function _SegmentSumGrad at 0x7577d3a412f0>) in gradient.
Level 1:tensorflow:Registering SegmentMean (<function _SegmentMeanGrad at 0x7577d3a41378>) in gradient.
Level 1:tensorflow:Registering SparseSegmentSum (<function _SparseSegmentSumGrad at 0x7577d3a41400>) in gradient.
Level 1:tensorflow:Registering SparseSegmentSumWithNumSegments (<function _SparseSegmentSumWithNumSegmentsGrad at 0x7577d3a41488>) in gradient.
Level 1:tensorflow:Registering SparseSegmentMean (<function _SparseSegmentMeanGrad at 0x7577d3a41510>) in gradient.
Level 1:tensorflow:Registering SparseSegmentMeanWithNumSegments (<function _SparseSegmentMeanWithNumSegmentsGrad at 0x7577d3a41598>) in gradient.
Level 1:tensorflow:Registering SparseSegmentSqrtN (<function _SparseSegmentSqrtNGrad at 0x7577d3a41620>) in gradient.
Level 1:tensorflow:Registering SparseSegmentSqrtNWithNumSegments (<function _SparseSegmentSqrtNWithNumSegmentsGrad at 0x7577d3a416a8>) in gradient.
Level 1:tensorflow:Registering SegmentMin (<function _SegmentMinGrad at 0x7577d3a417b8>) in gradient.
Level 1:tensorflow:Registering SegmentMax (<function _SegmentMaxGrad at 0x7577d3a41840>) in gradient.
Level 1:tensorflow:Registering UnsortedSegmentSum (<function _UnsortedSegmentSumGrad at 0x7577d3a419d8>) in gradient.
Level 1:tensorflow:Registering UnsortedSegmentMax (<function _UnsortedSegmentMaxGrad at 0x7577d3a41a60>) in gradient.
Level 1:tensorflow:Registering UnsortedSegmentMin (<function _UnsortedSegmentMinGrad at 0x7577d3a41ae8>) in gradient.
Level 1:tensorflow:Registering UnsortedSegmentProd (<function _UnsortedSegmentProdGrad at 0x7577d3a41b70>) in gradient.
Level 1:tensorflow:Registering Abs (<function _AbsGrad at 0x7577d3a41bf8>) in gradient.
Level 1:tensorflow:Registering Neg (<function _NegGrad at 0x7577d3a41c80>) in gradient.
Level 1:tensorflow:Registering Inv (<function _InvGrad at 0x7577d3a41d08>) in gradient.
Level 1:tensorflow:Registering Reciprocal (<function _ReciprocalGrad at 0x7577d3a41d90>) in gradient.
Level 1:tensorflow:Registering InvGrad (<function _InvGradGrad at 0x7577d3a41e18>) in gradient.
Level 1:tensorflow:Registering ReciprocalGrad (<function _ReciprocalGradGrad at 0x7577d3a41ea0>) in gradient.
Level 1:tensorflow:Registering Square (<function _SquareGrad at 0x7577d3a41f28>) in gradient.
Level 1:tensorflow:Registering Sqrt (<function _SqrtGrad at 0x7577d3a44048>) in gradient.
Level 1:tensorflow:Registering SqrtGrad (<function _SqrtGradGrad at 0x7577d3a440d0>) in gradient.
Level 1:tensorflow:Registering Rsqrt (<function _RsqrtGrad at 0x7577d3a44158>) in gradient.
Level 1:tensorflow:Registering RsqrtGrad (<function _RsqrtGradGrad at 0x7577d3a441e0>) in gradient.
Level 1:tensorflow:Registering Exp (<function _ExpGrad at 0x7577d3a44268>) in gradient.
Level 1:tensorflow:Registering Expm1 (<function _Expm1Grad at 0x7577d3a442f0>) in gradient.
Level 1:tensorflow:Registering Log (<function _LogGrad at 0x7577d3a44378>) in gradient.
Level 1:tensorflow:Registering Log1p (<function _Log1pGrad at 0x7577d3a44400>) in gradient.
Level 1:tensorflow:Registering Xlogy (<function _XLogyGrad at 0x7577d3a44488>) in gradient.
Level 1:tensorflow:Registering Xdivy (<function _XDivyGrad at 0x7577d3a44510>) in gradient.
Level 1:tensorflow:Registering Sinh (<function _SinhGrad at 0x7577d3a44598>) in gradient.
Level 1:tensorflow:Registering Cosh (<function _CoshGrad at 0x7577d3a44620>) in gradient.
Level 1:tensorflow:Registering Tanh (<function _TanhGrad at 0x7577d3a446a8>) in gradient.
Level 1:tensorflow:Registering Asinh (<function _AsinhGrad at 0x7577d3a44730>) in gradient.
Level 1:tensorflow:Registering Acosh (<function _AcoshGrad at 0x7577d3a447b8>) in gradient.
Level 1:tensorflow:Registering Atanh (<function _AtanhGrad at 0x7577d3a44840>) in gradient.
Level 1:tensorflow:Registering TanhGrad (<function _TanhGradGrad at 0x7577d3a448c8>) in gradient.
Level 1:tensorflow:Registering Erf (<function _ErfGrad at 0x7577d3a44950>) in gradient.
Level 1:tensorflow:Registering Erfc (<function _ErfcGrad at 0x7577d3a449d8>) in gradient.
Level 1:tensorflow:Registering Lgamma (<function _LgammaGrad at 0x7577d3a44a60>) in gradient.
Level 1:tensorflow:Registering Digamma (<function _DigammaGrad at 0x7577d3a44ae8>) in gradient.
Level 1:tensorflow:Registering BesselI0e (<function _BesselI0eGrad at 0x7577d3a44b70>) in gradient.
Level 1:tensorflow:Registering BesselI1e (<function _BesselI1eGrad at 0x7577d3a44bf8>) in gradient.
Level 1:tensorflow:Registering Igamma (<function _IgammaGrad at 0x7577d3a44c80>) in gradient.
Level 1:tensorflow:Registering Igammac (<function _IgammacGrad at 0x7577d3a44d08>) in gradient.
Level 1:tensorflow:Registering Betainc (<function _BetaincGrad at 0x7577d3a44d90>) in gradient.
Level 1:tensorflow:Registering Zeta (<function _ZetaGrad at 0x7577d3a44e18>) in gradient.
Level 1:tensorflow:Registering Polygamma (<function _PolygammaGrad at 0x7577d3a44ea0>) in gradient.
Level 1:tensorflow:Registering Sigmoid (<function _SigmoidGrad at 0x7577d3a44f28>) in gradient.
Level 1:tensorflow:Registering SigmoidGrad (<function _SigmoidGradGrad at 0x7577d3a48048>) in gradient.
Level 1:tensorflow:Registering Sign (<function _SignGrad at 0x7577d3a480d0>) in gradient.
Level 1:tensorflow:Registering Sin (<function _SinGrad at 0x7577d3a48158>) in gradient.
Level 1:tensorflow:Registering Cos (<function _CosGrad at 0x7577d3a481e0>) in gradient.
Level 1:tensorflow:Registering Tan (<function _TanGrad at 0x7577d3a48268>) in gradient.
Level 1:tensorflow:Registering Asin (<function _AsinGrad at 0x7577d3a482f0>) in gradient.
Level 1:tensorflow:Registering Acos (<function _AcosGrad at 0x7577d3a48378>) in gradient.
Level 1:tensorflow:Registering Atan (<function _AtanGrad at 0x7577d3a48400>) in gradient.
Level 1:tensorflow:Registering Atan2 (<function _Atan2Grad at 0x7577d3a48488>) in gradient.
Level 1:tensorflow:Registering AddN (<function _AddNGrad at 0x7577d3a48510>) in gradient.
Level 1:tensorflow:Registering AddV2 (<function _AddGrad at 0x7577d3a48620>) in gradient.
Level 1:tensorflow:Registering Add (<function _AddGrad at 0x7577d3a48620>) in gradient.
Level 1:tensorflow:Registering Sub (<function _SubGrad at 0x7577d3a486a8>) in gradient.
Level 1:tensorflow:Registering Mul (<function _MulGrad at 0x7577d3a48730>) in gradient.
Level 1:tensorflow:Registering MulNoNan (<function _MulNoNanGrad at 0x7577d3a487b8>) in gradient.
Level 1:tensorflow:Registering Div (<function _DivGrad at 0x7577d3a48840>) in gradient.
Level 1:tensorflow:Registering FloorDiv (<function _FloorDivGrad at 0x7577d3a488c8>) in gradient.
Level 1:tensorflow:Registering FloorMod (<function _FloorModGrad at 0x7577d3a48950>) in gradient.
Level 1:tensorflow:Registering TruncateDiv (<function _TruncateDivGrad at 0x7577d3a489d8>) in gradient.
Level 1:tensorflow:Registering RealDiv (<function _RealDivGrad at 0x7577d3a48a60>) in gradient.
Level 1:tensorflow:Registering DivNoNan (<function _DivNoNanGrad at 0x7577d3a48ae8>) in gradient.
Level 1:tensorflow:Registering Pow (<function _PowGrad at 0x7577d3a48b70>) in gradient.
Level 1:tensorflow:Registering Maximum (<function _MaximumGrad at 0x7577d3a48d08>) in gradient.
Level 1:tensorflow:Registering Minimum (<function _MinimumGrad at 0x7577d3a48d90>) in gradient.
Level 1:tensorflow:Registering SquaredDifference (<function _SquaredDifferenceGrad at 0x7577d3a48e18>) in gradient.
Level 1:tensorflow:Registering Less (None) in gradient.
Level 1:tensorflow:Registering LessEqual (None) in gradient.
Level 1:tensorflow:Registering Greater (None) in gradient.
Level 1:tensorflow:Registering GreaterEqual (None) in gradient.
Level 1:tensorflow:Registering Equal (None) in gradient.
Level 1:tensorflow:Registering ApproximateEqual (None) in gradient.
Level 1:tensorflow:Registering NotEqual (None) in gradient.
Level 1:tensorflow:Registering LogicalAnd (None) in gradient.
Level 1:tensorflow:Registering LogicalOr (None) in gradient.
Level 1:tensorflow:Registering LogicalNot (None) in gradient.
Level 1:tensorflow:Registering Select (<function _SelectGrad at 0x7577d3a48ea0>) in gradient.
Level 1:tensorflow:Registering SelectV2 (<function _SelectGradV2 at 0x7577d3a48f28>) in gradient.
Level 1:tensorflow:Registering MatMul (<function _MatMulGrad at 0x7577d3a4c158>) in gradient.
Level 1:tensorflow:Registering SparseMatMul (<function _SparseMatMulGrad at 0x7577d3a4c1e0>) in gradient.
Level 1:tensorflow:Registering Floor (<function _FloorGrad at 0x7577d3a4c268>) in gradient.
Level 1:tensorflow:Registering Ceil (<function _CeilGrad at 0x7577d3a4c2f0>) in gradient.
Level 1:tensorflow:Registering Round (<function _RoundGrad at 0x7577d3a4c378>) in gradient.
Level 1:tensorflow:Registering Rint (<function _RintGrad at 0x7577d3a4c400>) in gradient.
Level 1:tensorflow:Registering BatchMatMul (<function _BatchMatMul at 0x7577d3a4c488>) in gradient.
Level 1:tensorflow:Registering BatchMatMulV2 (<function _BatchMatMulV2 at 0x7577d3a4c510>) in gradient.
Level 1:tensorflow:Registering Range (None) in gradient.
Level 1:tensorflow:Registering LinSpace (None) in gradient.
Level 1:tensorflow:Registering Complex (<function _ComplexGrad at 0x7577d3a4c598>) in gradient.
Level 1:tensorflow:Registering Real (<function _RealGrad at 0x7577d3a4c620>) in gradient.
Level 1:tensorflow:Registering Imag (<function _ImagGrad at 0x7577d3a4c6a8>) in gradient.
Level 1:tensorflow:Registering Angle (<function _AngleGrad at 0x7577d3a4c730>) in gradient.
Level 1:tensorflow:Registering Conj (<function _ConjGrad at 0x7577d3a4c7b8>) in gradient.
Level 1:tensorflow:Registering ComplexAbs (<function _ComplexAbsGrad at 0x7577d3a4c840>) in gradient.
Level 1:tensorflow:Registering Cast (<function _CastGrad at 0x7577d3a4c8c8>) in gradient.
Level 1:tensorflow:Registering Cross (<function _CrossGrad at 0x7577d3a4c950>) in gradient.
Level 1:tensorflow:Registering Cumsum (<function _CumsumGrad at 0x7577d3a4c9d8>) in gradient.
Level 1:tensorflow:Registering Cumprod (<function _CumprodGrad at 0x7577d3a4ca60>) in gradient.
Level 1:tensorflow:Registering CumulativeLogsumexp (<function _CumulativeLogsumexpGrad at 0x7577d3a4cae8>) in gradient.
Level 1:tensorflow:Registering NextAfter (<function _NextAfterGrad at 0x7577d3a4cb70>) in gradient.
Level 1:tensorflow:Registering RandomGamma (<function _RandomGammaGrad at 0x7577d3a4cd08>) in gradient.
Level 1:tensorflow:Registering BlockLSTM (<function _block_lstm_grad at 0x7577d3a4cd90>) in gradient.
Level 1:tensorflow:Registering SparseAddGrad (None) in gradient.
Level 1:tensorflow:Registering SparseConcat (None) in gradient.
Level 1:tensorflow:Registering SparseReorder (<function _SparseReorderGrad at 0x7577d3a626a8>) in gradient.
Level 1:tensorflow:Registering SparseAdd (<function _SparseAddGrad at 0x7577d3a627b8>) in gradient.
Level 1:tensorflow:Registering SparseTensorDenseAdd (<function _SparseTensorDenseAddGrad at 0x7577d3a62840>) in gradient.
Level 1:tensorflow:Registering SparseReduceSum (<function _SparseReduceSumGrad at 0x7577d3a628c8>) in gradient.
Level 1:tensorflow:Registering SparseSlice (<function _SparseSliceGrad at 0x7577d3a62950>) in gradient.
Level 1:tensorflow:Registering SparseTensorDenseMatMul (<function _SparseTensorDenseMatMulGrad at 0x7577d3a629d8>) in gradient.
Level 1:tensorflow:Registering SparseDenseCwiseAdd (<function _SparseDenseCwiseAddGrad at 0x7577d3a62a60>) in gradient.
Level 1:tensorflow:Registering SparseDenseCwiseMul (<function _SparseDenseCwiseMulGrad at 0x7577d3a62b70>) in gradient.
Level 1:tensorflow:Registering SparseDenseCwiseDiv (<function _SparseDenseCwiseDivGrad at 0x7577d3a62bf8>) in gradient.
Level 1:tensorflow:Registering SparseSoftmax (<function _SparseSoftmaxGrad at 0x7577d3a62c80>) in gradient.
Level 1:tensorflow:Registering SparseSparseMaximum (<function _SparseSparseMaximumGrad at 0x7577d3a62d08>) in gradient.
Level 1:tensorflow:Registering SparseSparseMinimum (<function _SparseSparseMinimumGrad at 0x7577d3a62d90>) in gradient.
Level 1:tensorflow:Registering SparseFillEmptyRows (<function _SparseFillEmptyRowsGrad at 0x7577d3a62e18>) in gradient.
Level 1:tensorflow:Registering SparseToDense (<function _SparseToDenseGrad at 0x7577d3a62ea0>) in gradient.
Level 1:tensorflow:Registering Assign (None) in gradient.
Level 1:tensorflow:Registering AssignAdd (None) in gradient.
Level 1:tensorflow:Registering AssignSub (None) in gradient.
Level 1:tensorflow:Registering ScatterAdd (None) in gradient.
Level 1:tensorflow:Registering ScatterSub (None) in gradient.
Level 1:tensorflow:Registering ScatterMul (None) in gradient.
Level 1:tensorflow:Registering ScatterDiv (None) in gradient.
Level 1:tensorflow:Registering ScatterNdUpdate (None) in gradient.
Level 1:tensorflow:Registering ScatterNdAdd (None) in gradient.
Level 1:tensorflow:Registering ScatterNdSub (None) in gradient.
Level 1:tensorflow:Registering ScatterNdMul (None) in gradient.
Level 1:tensorflow:Registering ScatterNdDiv (None) in gradient.
Level 1:tensorflow:Registering TensorArray (None) in gradient.
Level 1:tensorflow:Registering TensorArrayGrad (None) in gradient.
Level 1:tensorflow:Registering TensorArraySize (None) in gradient.
Level 1:tensorflow:Registering TensorArrayClose (None) in gradient.
Level 1:tensorflow:Registering TensorArrayV2 (None) in gradient.
Level 1:tensorflow:Registering TensorArrayGradV2 (None) in gradient.
Level 1:tensorflow:Registering TensorArraySizeV2 (None) in gradient.
Level 1:tensorflow:Registering TensorArrayCloseV2 (None) in gradient.
Level 1:tensorflow:Registering TensorArrayV3 (None) in gradient.
Level 1:tensorflow:Registering TensorArrayGradV3 (None) in gradient.
Level 1:tensorflow:Registering TensorArrayGradWithShape (None) in gradient.
Level 1:tensorflow:Registering TensorArraySizeV3 (None) in gradient.
Level 1:tensorflow:Registering TensorArrayCloseV3 (None) in gradient.
Level 1:tensorflow:Registering TensorArrayReadV3 (<function _TensorArrayReadGrad at 0x7577d3a68268>) in gradient.
Level 1:tensorflow:Registering TensorArrayReadV2 (<function _TensorArrayReadGrad at 0x7577d3a68268>) in gradient.
Level 1:tensorflow:Registering TensorArrayRead (<function _TensorArrayReadGrad at 0x7577d3a68268>) in gradient.
Level 1:tensorflow:Registering TensorArrayWriteV3 (<function _TensorArrayWriteGrad at 0x7577d3a682f0>) in gradient.
Level 1:tensorflow:Registering TensorArrayWriteV2 (<function _TensorArrayWriteGrad at 0x7577d3a682f0>) in gradient.
Level 1:tensorflow:Registering TensorArrayWrite (<function _TensorArrayWriteGrad at 0x7577d3a682f0>) in gradient.
Level 1:tensorflow:Registering TensorArrayGatherV3 (<function _TensorArrayGatherGrad at 0x7577d3a68378>) in gradient.
Level 1:tensorflow:Registering TensorArrayGatherV2 (<function _TensorArrayGatherGrad at 0x7577d3a68378>) in gradient.
Level 1:tensorflow:Registering TensorArrayGather (<function _TensorArrayGatherGrad at 0x7577d3a68378>) in gradient.
Level 1:tensorflow:Registering TensorArrayScatterV3 (<function _TensorArrayScatterGrad at 0x7577d3a68400>) in gradient.
Level 1:tensorflow:Registering TensorArrayScatterV2 (<function _TensorArrayScatterGrad at 0x7577d3a68400>) in gradient.
Level 1:tensorflow:Registering TensorArrayScatter (<function _TensorArrayScatterGrad at 0x7577d3a68400>) in gradient.
Level 1:tensorflow:Registering TensorArrayConcatV3 (<function _TensorArrayConcatGrad at 0x7577d3a68488>) in gradient.
Level 1:tensorflow:Registering TensorArrayConcatV2 (<function _TensorArrayConcatGrad at 0x7577d3a68488>) in gradient.
Level 1:tensorflow:Registering TensorArrayConcat (<function _TensorArrayConcatGrad at 0x7577d3a68488>) in gradient.
Level 1:tensorflow:Registering TensorArraySplitV3 (<function _TensorArraySplitGrad at 0x7577d3a68510>) in gradient.
Level 1:tensorflow:Registering TensorArraySplitV2 (<function _TensorArraySplitGrad at 0x7577d3a68510>) in gradient.
Level 1:tensorflow:Registering TensorArraySplit (<function _TensorArraySplitGrad at 0x7577d3a68510>) in gradient.
Level 1:tensorflow:Registering XlaBroadcastHelper (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaConv (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaDequantize (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaDot (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaDynamicSlice (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaDynamicUpdateSlice (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaEinsum (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaIf (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaKeyValueSort (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaPad (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaRecv (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaReduce (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaReduceWindow (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaReplicaId (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaSelectAndScatter (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaSelfAdjointEig (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaSend (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaSort (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaSvd (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaWhile (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaEinsum (<function _einsum_grad at 0x7577d3a1b2f0>) in gradient.
Level 1:tensorflow:Registering Switch (<function _SwitchGrad at 0x7577d3a37730>) in gradient.
Level 1:tensorflow:Registering RefSwitch (<function _SwitchGrad at 0x7577d3a37730>) in gradient.
Level 1:tensorflow:Registering Merge (<function _MergeGrad at 0x7577d3a37840>) in gradient.
Level 1:tensorflow:Registering RefMerge (<function _RefMergeGrad at 0x7577d3a378c8>) in gradient.
Level 1:tensorflow:Registering Exit (<function _ExitGrad at 0x7577d3a37950>) in gradient.
Level 1:tensorflow:Registering RefExit (<function _ExitGrad at 0x7577d3a37950>) in gradient.
Level 1:tensorflow:Registering NextIteration (<function _NextIterationGrad at 0x7577d3a379d8>) in gradient.
Level 1:tensorflow:Registering RefNextIteration (<function _RefNextIterationGrad at 0x7577d3a37a60>) in gradient.
Level 1:tensorflow:Registering Enter (<function _EnterGrad at 0x7577d3a37ae8>) in gradient.
Level 1:tensorflow:Registering RefEnter (<function _RefEnterGrad at 0x7577d3a37b70>) in gradient.
Level 1:tensorflow:Registering LoopCond (<function _LoopCondGrad at 0x7577d3a37bf8>) in gradient.
Level 1:tensorflow:Registering ResizeNearestNeighbor (<function _ResizeNearestNeighborGrad at 0x7577d3a37c80>) in gradient.
Level 1:tensorflow:Registering ResizeBilinear (<function _ResizeBilinearGrad at 0x7577d39870d0>) in gradient.
Level 1:tensorflow:Registering ScaleAndTranslate (<function _ScaleAndTranslateGrad at 0x7577d3987158>) in gradient.
Level 1:tensorflow:Registering ResizeBicubic (<function _ResizeBicubicGrad at 0x7577d39871e0>) in gradient.
Level 1:tensorflow:Registering CropAndResize (<function _CropAndResizeGrad at 0x7577d3987268>) in gradient.
Level 1:tensorflow:Registering RGBToHSV (<function _RGBToHSVGrad at 0x7577d3987378>) in gradient.
Level 1:tensorflow:Registering MatrixInverse (<function _MatrixInverseGrad at 0x7577d3987488>) in gradient.
Level 1:tensorflow:Registering MatrixDeterminant (<function _MatrixDeterminantGrad at 0x7577d39a0840>) in gradient.
Level 1:tensorflow:Registering MatrixSquareRoot (<function _MatrixSquareRootGrad at 0x7577d39a08c8>) in gradient.
Level 1:tensorflow:Registering LogMatrixDeterminant (<function _LogMatrixDeterminantGrad at 0x7577d39a0950>) in gradient.
Level 1:tensorflow:Registering Cholesky (<function _CholeskyGrad at 0x7577d39a09d8>) in gradient.
Level 1:tensorflow:Registering Qr (<function _QrGrad at 0x7577d39a0a60>) in gradient.
Level 1:tensorflow:Registering MatrixSolve (<function _MatrixSolveGrad at 0x7577d39a0ae8>) in gradient.
Level 1:tensorflow:Registering MatrixSolveLs (<function _MatrixSolveLsGrad at 0x7577d39a0b70>) in gradient.
Level 1:tensorflow:Registering MatrixTriangularSolve (<function _MatrixTriangularSolveGrad at 0x7577d39a0bf8>) in gradient.
Level 1:tensorflow:Registering SelfAdjointEigV2 (<function _SelfAdjointEigV2Grad at 0x7577d39a0c80>) in gradient.
Level 1:tensorflow:Registering Svd (<function _SvdGrad at 0x7577d39a0d08>) in gradient.
Level 1:tensorflow:Registering TridiagonalMatMul (<function _TridiagonalMatMulGrad at 0x7577d39a0ea0>) in gradient.
Level 1:tensorflow:Registering TridiagonalSolve (<function _TridiagonalSolveGrad at 0x7577d39a0f28>) in gradient.
Level 1:tensorflow:Registering OptionalFromValue (<function _OptionalFromValueGrad at 0x7577d39a61e0>) in gradient.
Level 1:tensorflow:Registering OptionalGetValue (<function _OptionalGetValueGrad at 0x7577d39a6268>) in gradient.
Level 1:tensorflow:Registering LookupTableFind (None) in gradient.
Level 1:tensorflow:Registering LookupTableFindV2 (None) in gradient.
Level 1:tensorflow:Registering LookupTableInsert (None) in gradient.
Level 1:tensorflow:Registering LookupTableInsertV2 (None) in gradient.
Level 1:tensorflow:Registering LookupTableSize (None) in gradient.
Level 1:tensorflow:Registering LookupTableSizeV2 (None) in gradient.
Level 1:tensorflow:Registering HashTable (None) in gradient.
Level 1:tensorflow:Registering HashTableV2 (None) in gradient.
Level 1:tensorflow:Registering InitializeTable (None) in gradient.
Level 1:tensorflow:Registering InitializeTableV2 (None) in gradient.
Level 1:tensorflow:Registering InitializeTableFromTextFile (None) in gradient.
Level 1:tensorflow:Registering InitializeTableFromTextFileV2 (None) in gradient.
Level 1:tensorflow:Registering MutableDenseHashTable (None) in gradient.
Level 1:tensorflow:Registering MutableDenseHashTableV2 (None) in gradient.
Level 1:tensorflow:Registering MutableHashTable (None) in gradient.
Level 1:tensorflow:Registering MutableHashTableV2 (None) in gradient.
Level 1:tensorflow:Registering MutableHashTableOfTensors (None) in gradient.
Level 1:tensorflow:Registering MutableHashTableOfTensorsV2 (None) in gradient.
Level 1:tensorflow:Registering DecodeProtoV2 (None) in gradient.
Level 1:tensorflow:Registering EncodeProto (None) in gradient.
Level 1:tensorflow:Registering StatelessMultinomial (None) in gradient.
Level 1:tensorflow:Registering StatelessRandomNormal (None) in gradient.
Level 1:tensorflow:Registering StatelessRandomUniform (None) in gradient.
Level 1:tensorflow:Registering StatelessRandomUniformInt (None) in gradient.
Level 1:tensorflow:Registering StatelessTruncatedNormal (None) in gradient.
Level 1:tensorflow:Registering NcclAllReduce (<function _all_sum_grad at 0x7577d38ad840>) in gradient.
Level 1:tensorflow:Registering NcclReduce (<function _reduce_sum_grad at 0x7577d38adae8>) in gradient.
Level 1:tensorflow:Registering NcclBroadcast (<function _broadcast_grad at 0x7577d38adbf8>) in gradient.
Level 1:tensorflow:Registering Conv2DBackpropInput (<function _Conv2DBackpropInputGrad at 0x7577d3328d90>) in gradient.
Level 1:tensorflow:Registering Conv2DBackpropFilter (<function _Conv2DBackpropFilterGrad at 0x7577d332b400>) in gradient.
Level 1:tensorflow:Registering DepthwiseConv2dNativeBackpropInput (<function _DepthwiseConv2dNativeBackpropInputGrad at 0x7577d332b488>) in gradient.
Level 1:tensorflow:Registering DepthwiseConv2dNativeBackpropFilter (<function _DepthwiseConv2dNativeBackpropFilterGrad at 0x7577d332b510>) in gradient.
Level 1:tensorflow:Registering Conv3D (<function _Conv3DGrad at 0x7577d332b598>) in gradient.
Level 1:tensorflow:Registering Conv3DBackpropInputV2 (<function _Conv3DBackpropInputGrad at 0x7577d332b620>) in gradient.
Level 1:tensorflow:Registering Conv3DBackpropFilterV2 (<function _Conv3DBackpropFilterGrad at 0x7577d332b6a8>) in gradient.
Level 1:tensorflow:Registering AvgPool3D (<function _AvgPool3DGrad at 0x7577d332b730>) in gradient.
Level 1:tensorflow:Registering AvgPool3DGrad (<function _AvgPool3DGradGrad at 0x7577d332b7b8>) in gradient.
Level 1:tensorflow:Registering MaxPool3D (<function _MaxPool3DGrad at 0x7577d332b840>) in gradient.
Level 1:tensorflow:Registering MaxPool3DGrad (<function _MaxPool3DGradGrad at 0x7577d332b8c8>) in gradient.
Level 1:tensorflow:Registering MaxPool3DGradGrad (<function _MaxPool3DGradGradGrad at 0x7577d332b950>) in gradient.
Level 1:tensorflow:Registering Softmax (<function _SoftmaxGrad at 0x7577d332b9d8>) in gradient.
Level 1:tensorflow:Registering LogSoftmax (<function _LogSoftmaxGrad at 0x7577d332ba60>) in gradient.
Level 1:tensorflow:Registering BiasAdd (<function _BiasAddGrad at 0x7577d332bae8>) in gradient.
Level 1:tensorflow:Registering BiasAddGrad (<function _BiasAddGradGrad at 0x7577d332bb70>) in gradient.
Level 1:tensorflow:Registering BiasAddV1 (<function _BiasAddGradV1 at 0x7577d332bbf8>) in gradient.
Level 1:tensorflow:Registering Relu (<function _ReluGrad at 0x7577d332bc80>) in gradient.
Level 1:tensorflow:Registering EluGrad (<function _EluGradGrad at 0x7577d332bd08>) in gradient.
Level 1:tensorflow:Registering SeluGrad (<function _SeluGradGrad at 0x7577d332bd90>) in gradient.
Level 1:tensorflow:Registering Relu6 (<function _Relu6Grad at 0x7577d332be18>) in gradient.
Level 1:tensorflow:Registering Relu6Grad (<function _Relu6GradGrad at 0x7577d332bea0>) in gradient.
Level 1:tensorflow:Registering LeakyRelu (<function _LeakyReluGrad at 0x7577d332bf28>) in gradient.
Level 1:tensorflow:Registering LeakyReluGrad (<function _LeakyReluGradGrad at 0x7577d3339048>) in gradient.
Level 1:tensorflow:Registering Elu (<function _EluGrad at 0x7577d33390d0>) in gradient.
Level 1:tensorflow:Registering Selu (<function _SeluGrad at 0x7577d3339158>) in gradient.
Level 1:tensorflow:Registering Softplus (<function _SoftplusGrad at 0x7577d33391e0>) in gradient.
Level 1:tensorflow:Registering SoftplusGrad (<function _SoftplusGradGrad at 0x7577d3339268>) in gradient.
Level 1:tensorflow:Registering Softsign (<function _SoftsignGrad at 0x7577d33392f0>) in gradient.
Level 1:tensorflow:Registering ReluGrad (<function _ReluGradGrad at 0x7577d3339378>) in gradient.
Level 1:tensorflow:Registering SoftmaxCrossEntropyWithLogits (<function _SoftmaxCrossEntropyWithLogitsGrad at 0x7577d3339488>) in gradient.
Level 1:tensorflow:Registering SparseSoftmaxCrossEntropyWithLogits (<function _SparseSoftmaxCrossEntropyWithLogitsGrad at 0x7577d3339510>) in gradient.
Level 1:tensorflow:Registering Conv2D (<function _Conv2DGrad at 0x7577d3339598>) in gradient.
Level 1:tensorflow:Registering DepthwiseConv2dNative (<function _DepthwiseConv2dNativeGrad at 0x7577d3339620>) in gradient.
Level 1:tensorflow:Registering Dilation2D (<function _Dilation2DGrad at 0x7577d33396a8>) in gradient.
Level 1:tensorflow:Registering LRN (<function _LRNGrad at 0x7577d3339730>) in gradient.
Level 1:tensorflow:Registering AvgPool (<function _AvgPoolGrad at 0x7577d33397b8>) in gradient.
Level 1:tensorflow:Registering AvgPoolGrad (<function _AvgPoolGradGrad at 0x7577d3339840>) in gradient.
Level 1:tensorflow:Registering MaxPool (<function _MaxPoolGrad at 0x7577d33398c8>) in gradient.
Level 1:tensorflow:Registering MaxPoolV2 (<function _MaxPoolGradV2 at 0x7577d3339950>) in gradient.
Level 1:tensorflow:Registering MaxPoolWithArgmax (<function _MaxPoolGradWithArgmax at 0x7577d33399d8>) in gradient.
Level 1:tensorflow:Registering MaxPoolGrad (<function _MaxPoolGradGrad at 0x7577d3339a60>) in gradient.
Level 1:tensorflow:Registering MaxPoolGradV2 (<function _MaxPoolGradGradV2 at 0x7577d3339ae8>) in gradient.
Level 1:tensorflow:Registering MaxPoolGradGrad (<function _MaxPoolGradGradGrad at 0x7577d3339b70>) in gradient.
Level 1:tensorflow:Registering FractionalMaxPool (<function _FractionalMaxPoolGrad at 0x7577d3339bf8>) in gradient.
Level 1:tensorflow:Registering FractionalAvgPool (<function _FractionalAvgPoolGrad at 0x7577d3339c80>) in gradient.
Level 1:tensorflow:Registering BatchNormWithGlobalNormalization (<function _BatchNormWithGlobalNormalizationGrad at 0x7577d3339d08>) in gradient.
Level 1:tensorflow:Registering FusedBatchNorm (<function _FusedBatchNormGrad at 0x7577d3339e18>) in gradient.
Level 1:tensorflow:Registering FusedBatchNormV2 (<function _FusedBatchNormV2Grad at 0x7577d3339ea0>) in gradient.
Level 1:tensorflow:Registering FusedBatchNormV3 (<function _FusedBatchNormV3Grad at 0x7577d3339f28>) in gradient.
Level 1:tensorflow:Registering FusedBatchNormGrad (<function _FusedBatchNormGradGrad at 0x7577d333c0d0>) in gradient.
Level 1:tensorflow:Registering FusedBatchNormGradV2 (<function _FusedBatchNormGradGradV2 at 0x7577d333c158>) in gradient.
Level 1:tensorflow:Registering FusedBatchNormGradV3 (<function _FusedBatchNormGradGradV3 at 0x7577d333c1e0>) in gradient.
Level 1:tensorflow:Registering L2Loss (<function _L2LossGrad at 0x7577d333c268>) in gradient.
Level 1:tensorflow:Registering TopKV2 (<function _TopKGrad at 0x7577d333c2f0>) in gradient.
Level 1:tensorflow:Registering TopK (<function _TopKGrad at 0x7577d333c2f0>) in gradient.
Level 1:tensorflow:Registering NthElement (<function _NthElementGrad at 0x7577d333c378>) in gradient.
Level 1:tensorflow:Registering CTCLoss (<function _CTCLossGrad at 0x7577d333c400>) in gradient.
Level 1:tensorflow:Registering CTCGreedyDecoder (None) in gradient.
Level 1:tensorflow:Registering CTCBeamSearchDecoder (None) in gradient.
Level 1:tensorflow:Registering SetSize (None) in gradient.
Level 1:tensorflow:Registering DenseToDenseSetOperation (None) in gradient.
Level 1:tensorflow:Registering DenseToSparseSetOperation (None) in gradient.
Level 1:tensorflow:Registering SparseToSparseSetOperation (None) in gradient.
Level 1:tensorflow:Registering XlaClusterOutput (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaLaunch (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering XlaClusterOutput (<function _XlaClusterOutputGrad at 0x7577d31cb268>) in gradient.
Level 1:tensorflow:Registering AllToAll (<function _all_to_all_grad at 0x7577d314e0d0>) in gradient.
Level 1:tensorflow:Registering CollectivePermute (<function _collective_permute_grad at 0x7577d314e268>) in gradient.
Level 1:tensorflow:Registering CrossReplicaSum (<function _cross_replica_sum_grad at 0x7577d314e2f0>) in gradient.
Level 1:tensorflow:Registering TPUEmbeddingActivations (<function _embedding_activations_grad at 0x7577d314e378>) in gradient.
Level 1:tensorflow:Registering TPUReplicatedInput (None) in gradient.
Level 1:tensorflow:Registering BitwiseAnd (None) in gradient.
Level 1:tensorflow:Registering BitwiseOr (None) in gradient.
Level 1:tensorflow:Registering BitwiseXor (None) in gradient.
Level 1:tensorflow:Registering Invert (None) in gradient.
Level 1:tensorflow:Registering PopulationCount (None) in gradient.
Level 1:tensorflow:Registering LeftShift (None) in gradient.
Level 1:tensorflow:Registering RightShift (None) in gradient.
Level 1:tensorflow:Registering queue_runners ((<class 'tensorflow.core.protobuf.queue_runner_pb2.QueueRunnerDef'>, <function QueueRunner.to_proto at 0x7577d3055268>, <function QueueRunner.from_proto at 0x7577d30552f0>)) in proto functions.
Level 1:tensorflow:Registering RandomCrop (None) in gradient.
Level 1:tensorflow:Registering HSVToRGB (None) in gradient.
Level 1:tensorflow:Registering DrawBoundingBoxes (None) in gradient.
Level 1:tensorflow:Registering SampleDistortedBoundingBox (None) in gradient.
Level 1:tensorflow:Registering SampleDistortedBoundingBoxV2 (None) in gradient.
Level 1:tensorflow:Registering ExtractGlimpse (None) in gradient.
Level 1:tensorflow:Registering NonMaxSuppression (None) in gradient.
Level 1:tensorflow:Registering NonMaxSuppressionV2 (None) in gradient.
Level 1:tensorflow:Registering NonMaxSuppressionWithOverlaps (None) in gradient.
Level 1:tensorflow:Registering FFT (<function _fft_grad at 0x7577bc231c80>) in gradient.
Level 1:tensorflow:Registering IFFT (<function _ifft_grad at 0x7577bc231d08>) in gradient.
Level 1:tensorflow:Registering FFT2D (<function _fft2d_grad at 0x7577bc231d90>) in gradient.
Level 1:tensorflow:Registering IFFT2D (<function _ifft2d_grad at 0x7577bc231e18>) in gradient.
Level 1:tensorflow:Registering FFT3D (<function _fft3d_grad at 0x7577bc231ea0>) in gradient.
Level 1:tensorflow:Registering IFFT3D (<function _ifft3d_grad at 0x7577bc231f28>) in gradient.
Level 1:tensorflow:Registering RFFT (<function _rfft_grad_helper.<locals>._grad at 0x7577bc237268>) in gradient.
Level 1:tensorflow:Registering IRFFT (<function _irfft_grad_helper.<locals>._grad at 0x7577bc2372f0>) in gradient.
Level 1:tensorflow:Registering RFFT2D (<function _rfft_grad_helper.<locals>._grad at 0x7577bc237378>) in gradient.
Level 1:tensorflow:Registering IRFFT2D (<function _irfft_grad_helper.<locals>._grad at 0x7577bc237400>) in gradient.
Level 1:tensorflow:Registering Reciprocal,flops (<function _reciprocal_flops at 0x7577bc21f0d0>) in statistical functions.
Level 1:tensorflow:Registering Square,flops (<function _square_flops at 0x7577bc21f158>) in statistical functions.
Level 1:tensorflow:Registering Rsqrt,flops (<function _rsqrt_flops at 0x7577bc21f1e0>) in statistical functions.
Level 1:tensorflow:Registering Log,flops (<function _log_flops at 0x7577bc21f268>) in statistical functions.
Level 1:tensorflow:Registering Neg,flops (<function _neg_flops at 0x7577bc21f2f0>) in statistical functions.
Level 1:tensorflow:Registering AssignSub,flops (<function _assign_sub_flops at 0x7577bc21f378>) in statistical functions.
Level 1:tensorflow:Registering AssignAdd,flops (<function _assign_add_flops at 0x7577bc21f400>) in statistical functions.
Level 1:tensorflow:Registering L2Loss,flops (<function _l2_loss_flops at 0x7577bc21f488>) in statistical functions.
Level 1:tensorflow:Registering Softmax,flops (<function _softmax_flops at 0x7577bc21f510>) in statistical functions.
Level 1:tensorflow:Registering Add,flops (<function _add_flops at 0x7577bc21f620>) in statistical functions.
Level 1:tensorflow:Registering Sub,flops (<function _sub_flops at 0x7577bc21f6a8>) in statistical functions.
Level 1:tensorflow:Registering Mul,flops (<function _mul_flops at 0x7577bc21f730>) in statistical functions.
Level 1:tensorflow:Registering RealDiv,flops (<function _real_div_flops at 0x7577bc21f7b8>) in statistical functions.
Level 1:tensorflow:Registering Maximum,flops (<function _maximum_flops at 0x7577bc21f840>) in statistical functions.
Level 1:tensorflow:Registering Minimum,flops (<function _minimum_flops at 0x7577bc21f8c8>) in statistical functions.
Level 1:tensorflow:Registering Pow,flops (<function _pow_flops at 0x7577bc21f950>) in statistical functions.
Level 1:tensorflow:Registering RsqrtGrad,flops (<function _rsqrt_grad_flops at 0x7577bc21f9d8>) in statistical functions.
Level 1:tensorflow:Registering GreaterEqual,flops (<function _greater_equal_flops at 0x7577bc21fa60>) in statistical functions.
Level 1:tensorflow:Registering Greater,flops (<function _greater_flops at 0x7577bc21fae8>) in statistical functions.
Level 1:tensorflow:Registering LessEqual,flops (<function _less_equal_flops at 0x7577bc21fb70>) in statistical functions.
Level 1:tensorflow:Registering Less,flops (<function _less_flops at 0x7577bc21fbf8>) in statistical functions.
Level 1:tensorflow:Registering Equal,flops (<function _equal_flops at 0x7577bc21fc80>) in statistical functions.
Level 1:tensorflow:Registering NotEqual,flops (<function _not_equal_flops at 0x7577bc21fd08>) in statistical functions.
Level 1:tensorflow:Registering SquaredDifference,flops (<function _squared_difference_flops at 0x7577bc21fd90>) in statistical functions.
Level 1:tensorflow:Registering Mean,flops (<function _mean_flops at 0x7577bc21fea0>) in statistical functions.
Level 1:tensorflow:Registering Sum,flops (<function _sum_flops at 0x7577bc21ff28>) in statistical functions.
Level 1:tensorflow:Registering ArgMax,flops (<function _arg_max_flops at 0x7577bc229048>) in statistical functions.
Level 1:tensorflow:Registering ArgMin,flops (<function _arg_min_flops at 0x7577bc2290d0>) in statistical functions.
Level 1:tensorflow:Registering BiasAddGrad,flops (<function _bias_add_grad_flops at 0x7577bc229158>) in statistical functions.
Level 1:tensorflow:Registering AvgPool,flops (<function _avg_pool_flops at 0x7577bc2292f0>) in statistical functions.
Level 1:tensorflow:Registering MaxPool,flops (<function _max_pool_flops at 0x7577bc229378>) in statistical functions.
Level 1:tensorflow:Registering AvgPoolGrad,flops (<function _avg_pool_grad_flops at 0x7577bc229400>) in statistical functions.
Level 1:tensorflow:Registering MaxPoolGrad,flops (<function _max_pool_grad_flops at 0x7577bc229488>) in statistical functions.
Level 1:tensorflow:Registering Conv2DBackpropInput,flops (<function _conv_2d_backprop_input_flops at 0x7577bc229510>) in statistical functions.
Level 1:tensorflow:Registering Conv2DBackpropFilter,flops (<function _conv_2d_backprop_filter_flops at 0x7577bc229598>) in statistical functions.
Level 1:tensorflow:Registering AddN,flops (<function _add_n_flops at 0x7577bc229620>) in statistical functions.
Level 1:tensorflow:Registering Fact (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering SdcaFprint (None) in gradient.
Level 1:tensorflow:Registering SdcaOptimizer (None) in gradient.
Level 1:tensorflow:Registering SdcaOptimizerV2 (None) in gradient.
Level 1:tensorflow:Registering SdcaShrinkL1 (None) in gradient.
Level 1:tensorflow:Registering GenerateVocabRemapping (None) in gradient.
Level 1:tensorflow:Registering LoadAndRemapMatrix (None) in gradient.
Level 1:tensorflow:Registering AudioMicrofrontend (<function _set_call_cpp_shape_fn.<locals>.call_without_requiring at 0x7577daa41a60>) in default shape functions.
Level 1:tensorflow:Registering AudioMicrofrontend (None) in gradient.
Level 1:tensorflow:Registering tpu_estimator_iterations_per_loop ((<class 'tensorflow.core.framework.variable_pb2.VariableDef'>, <function _to_proto_fn at 0x7577d4227268>, <function _from_proto_fn at 0x7577d328c598>)) in proto functions.
Level 1:tensorflow:Registering If (<function _IfGrad at 0x7577a0971400>) in gradient.
Level 1:tensorflow:Registering StatelessIf (<function _IfGrad at 0x7577a0971400>) in gradient.
Level 1:tensorflow:Registering Case (<function _CaseGrad at 0x7577a0981158>) in gradient.
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/keras.py", line 54, in autoencode
    from tensorflow import set_random_seed
ImportError: cannot import name 'set_random_seed' from 'tensorflow' (/usr/local/lib/python3.7/site-packages/tensorflow/__init__.py)
```


## lyner_center

### Tool Description
Center the matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 66, in center
    data = getattr(pipe, pipe.selection, pipe.matrix)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: selection
```


## lyner_changes

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 37, in changes
    matrix = pipe.matrix
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_cluster

### Tool Description
Cluster cells based on their expression profiles.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/cluster.py", line 36, in cluster
    centroids, labels, *_ = clustering(pipe.matrix.values, **mode_config)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_cluster-agglomerative

### Tool Description
Agglomerative clustering of cells

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/cluster.py", line 60, in cluster_agglomerative
    matrix = pipe.matrix
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_cluster-from

### Tool Description
Cluster sequences from a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner cluster-from [OPTIONS] FILE
Try "lyner cluster-from --help" for help.

Error: no such option: --h  Did you mean --help?
```


## lyner_cluster-hierarchical

### Tool Description
Hierarchical clustering of samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/cluster.py", line 110, in cluster_hierarchical
    l = linkage(pipe.matrix.values, method=method, metric=distance_metric)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_compose

### Tool Description
Compose a pipeline from a list of transformations.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 354, in compose
    assert hasattr(pipe, 'decomposition')
AssertionError
```


## lyner_correlate

### Tool Description
Calculate pairwise Pearson correlation coefficients between columns of a matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 79, in correlate
    pipe.matrix = pipe.matrix.corr(method=method)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_decompose

### Tool Description
Decompose a matrix into its constituent parts.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 91, in decompose
    matrix = pipe.matrix.copy()
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_dendro

### Tool Description
Plot a dendrogram from a distance matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/plot.py", line 44, in dendro
    matrix = pipe.matrix
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_design

### Tool Description
Description of the experiment. Expects 2-column tsv (Sample, Class).

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner design [OPTIONS] DESIGN

  Description of the experiment. Expects 2-column tsv (Sample, Class).

Options:
  --help  Show this message and exit.
```


## lyner_dist-graph

### Tool Description
Generates a distance graph from a distance matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/cluster.py", line 197, in dist_graph
    assert pipe.matrix.index.values.shape == pipe.matrix.columns.values.shape, "call pdist first"
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_estimate

### Tool Description
Estimate gene expression levels from RNA-Seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/stats.py", line 27, in estimate
    matrix = pipe.matrix
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_filter

### Tool Description
Filter data according to selected option.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner filter [OPTIONS]

  Filter data according to selected option.

Options:
  -s, --sum INTEGER               Drops rows with sum smaller than or equal to
                                  given value.
  -z, --zeros INTEGER             Drop rows with up to the given amount of
                                  zeros.
  -i, --identical                 Drop rows consisting of only one single
                                  value.
  -n, --negative                  Drop rows with negative entries.
  -e, --drop-na                   Drop rows with NA/nan/empty entries.
  -d, --drop-duplicates           Drop duplicate rows.
  -p, --prefix LIST
  --suffix LIST
  -v, --variance-relative FLOAT   Keep the top n% most variant rows, drop the
                                  rest.
  -k, --variance-absolute INTEGER
                                  Keep the top k most variant rows, drop the
                                  rest.
  --help                          Show this message and exit.
```


## lyner_frequent-sets

### Tool Description
Find frequent itemsets in a binary matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/cluster.py", line 166, in frequent_sets
    df = pipe.matrix.astype(np.bool)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_mmr

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 145, in mmr
    df: pd.DataFrame = pipe.matrix
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_normalise

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 271, in normalise
    data = getattr(pipe, pipe.selection, pipe.matrix)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: selection
```


## lyner_pairwise-distances

### Tool Description
Compute pairwise distances between samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/cluster.py", line 183, in pairwise_distances
    d = squareform(pdist(pipe.matrix.values, metric=metric))
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_plot

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/plot.py", line 241, in plot
    matrix = pipe.matrix
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_read

### Tool Description
Read abundance/count matrix from MATRIX (tsv format).

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner read [OPTIONS] MATRIX

  Read abundance/count matrix from `MATRIX` (tsv format).

Options:
  --help  Show this message and exit.
```


## lyner_read-annotation

### Tool Description
Reads annotation from given file and stores it in `annotation`.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner read-annotation [OPTIONS] FILE

  Reads annotation from given file and stores it in `annotation`.

Options:
  --help  Show this message and exit.
```


## lyner_reindex

### Tool Description
Reindex the matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 324, in reindex
    pipe.matrix = pipe.matrix.reindex(index=natsorted(pipe.matrix.index))
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_seed

### Tool Description
Try "lyner seed --help" for help.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner seed [OPTIONS] SEED
Try "lyner seed --help" for help.

Error: no such option: -h
```


## lyner_select

### Tool Description
Select a datum based on its name (e.g. 'matrix' or 'estimate'), making it the target of commands such as `show`, `save` and `plot`.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner select [OPTIONS] WHAT

  Select a datum based on its name (e.g. 'matrix' or 'estimate'), making it
  the target of commands such as `show`, `save` and `plot`.

Options:
  --help  Show this message and exit.
```


## lyner_show

### Tool Description
Show the content of a lyner pipe.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/io.py", line 40, in show
    data = getattr(pipe, pipe.selection, pipe.matrix)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: selection
```


## lyner_sort

### Tool Description
Sorts the matrix by columns.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 308, in sort
    pipe.matrix.sort_values(by=pipe.matrix.columns.values.tolist(), axis=0, inplace=True)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_sort-index

### Tool Description
Sorts and indexes a matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 316, in sort_index
    pipe.matrix.sort_index(kind='mergesort', inplace=True)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_store

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/io.py", line 52, in store
    data = getattr(pipe, pipe.selection, pipe.matrix)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: selection
```


## lyner_summarise

### Tool Description
Summarise a lyner matrix

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 371, in summarise
    m: pd.DataFrame = pipe.matrix
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: matrix
```


## lyner_supplement

### Tool Description
Supply additional data which may be used for plot colors, for example.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner supplement [OPTIONS] SUPPLEMENTARY_DATA

  Supply additional data which may be used for plot colors, for example.

Options:
  --help  Show this message and exit.
```


## lyner_targets

### Tool Description
Specify targets for lyner

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/io.py", line 97, in targets
    raise ValueError("No targets specified.")
ValueError: No targets specified.
```


## lyner_threshold

### Tool Description
Set |data| < value to 0, data >= value to 1, -data >= value to -1.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lyner threshold [OPTIONS] VALUE

  Set |data| < value to 0, data >= value to 1, -data >= value to -1.

Options:
  --help  Show this message and exit.
```


## lyner_transform

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 334, in transform
    data = getattr(pipe, pipe.selection, pipe.matrix)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: selection
```


## lyner_transpose

### Tool Description
Transpose a matrix or a selection of columns from a matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/transform.py", line 345, in transpose
    data = getattr(pipe, pipe.selection, pipe.matrix)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: selection
```


## lyner_uncluster

### Tool Description
Uncluster sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/lyner:0.4.3--py_0
- **Homepage**: https://github.com/tedil/lyner
- **Package**: https://anaconda.org/channels/bioconda/packages/lyner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/lyner", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.7/site-packages/lyner/main.py", line 109, in main
    rnax()
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 764, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 717, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 1163, in invoke
    rv.append(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 956, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/decorators.py", line 64, in new_func
    return ctx.invoke(f, obj, *args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 213, in new_func
    return ctx.invoke(f, pipe, *args[1:], **kwargs)
  File "/usr/local/lib/python3.7/site-packages/click/core.py", line 555, in invoke
    return callback(*args, **kwargs)
  File "/usr/local/lib/python3.7/site-packages/lyner/commands/cluster.py", line 238, in uncluster
    if pipe.is_clustered:
  File "/usr/local/lib/python3.7/site-packages/lyner/click_extras.py", line 189, in __getattr__
    raise AttributeError(f"No such attribute: {name}")
AttributeError: No such attribute: is_clustered
```


## Metadata
- **Skill**: generated
