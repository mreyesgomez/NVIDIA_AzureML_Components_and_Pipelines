## Pre-processing the Dataset
#### This component is a wrapper for the TAO DetectNet_v2 dataset_convert command
#### Excerpt from the [DetectNet_v2 Documentation](https://docs.nvidia.com/tao/tao-toolkit/text/object_detection/detectnet_v2.html)
The DetectNet_v2 app requires the raw input data to be converted to TFRecords for optimized iteration across the data batches. This can be done using the <span style="color:red;font-weight:700;font-size:12px"> dataset_convert </span> subtask under DetectNet_v2. Currently, the KITTI and COCO formats are supported.

The dataset_convert tool requires a configuration file as input. Details of the configuration file and examples are included in the [DetectNet_v2 Documentation](https://docs.nvidia.com/tao/tao-toolkit/text/object_detection/detectnet_v2.html).

### Sample Usage of the Dataset Converter Tool
While KITTI is the accepted dataset format for object detection, the DetectNet_v2 trainer requires this data to be converted to TFRecord files for ingestion. The <span style="color:red;font-weight:700;font-size:12px"> dataset_convert </span> tool is described below:

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">tao detectnet_v2 dataset-convert -d DATASET_EXPORT_SPEC -o OUTPUT_FILENAME
                 [-f VALIDATION_FOLD]
</pre>

You can use the following arguments:

<span style="color:red;font-weight:700;font-size:12px"> -d, --dataset-export-spec:</span> The path to the detection dataset spec containing the config for exporting .tfrecord files

<span style="color:red;font-weight:700;font-size:12px"> -o output_filename:</span> The output filename

<span style="color:red;font-weight:700;font-size:12px"> -f, –validation-fold:</span> The validation fold in 0-based indexing. This is required when modifying the training set, but otherwise optional.

The following example shows how to use the command with the dataset:

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">tao detectnet_v2 dataset_convert  -d < path_to_tfrecords_conversion_spec>
                                       -o < path_to_output_tfrecords>
</pre>