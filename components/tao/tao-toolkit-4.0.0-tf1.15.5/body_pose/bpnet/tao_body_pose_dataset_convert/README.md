## Pre-processing the Dataset
#### This component is a wrapper for the TAO bpnet dataset_convert command
#### Excerpt from the [TAO BodyPoseNet Documentation](https://docs.nvidia.com/tao/tao-toolkit/text/bodypose_estimation/bodyposenet.html)
The BodyPoseNet app requires the data in a specific JSON format to be converted to TFRecords using the <span style="color:red;font-weight:700;font-size:12px"> dataset_convert </span> subtask under the bpnet tool, which requires a configuration file as input.

The dataset_convert tool requires a configuration file as input. Details of the configuration file and examples are included in the [TAO BodyPoseNet Documentation](https://docs.nvidia.com/tao/tao-toolkit/text/bodypose_estimation/bodyposenet.html). While COCO format is the accepted dataset format for object detection, the BodyPoseNet trainer requires this data to be converted to TFRecord files for ingestion.

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">tao bpnet dataset_convert -d <path/to/dataset_spec>
                                -o < path_to_output_tfrecords >
                                -m <' train'/'test' >
                                --generate_masks
</pre>

### Required Arguments
* <span style="color:red;font-weight:700;font-size:12px">-d, --dataset_spec</span>: The path to the JSON dataset spec containing the config for exporting <span style="color:red;font-weight:700;font-size:12px">.tfrecords</span>.
* <span style="color:red;font-weight:700;font-size:12px">--o, --output_filename</span> The output file name. Note that this will be appended with <span style="color:red;font-weight:700;font-size:12px"> -fold-< num >-of-< total ></span>.

### Required Arguments to be used for spec file substitution
* <span style="color:red;font-weight:700;font-size:12px">specs directory path:</span> The hardcoded location of the specs file.
* <span style="color:red;font-weight:700;font-size:12px">data directory:</span> The AzureML location of the data used to generate the TFRecords.
* <span style="color:red;font-weight:700;font-size:12px">training data folder path:</span> The AzureML location of the data to be used to evaluate the model.
* <span style="color:red;font-weight:700;font-size:12px">training data folder reference:</span> The hard coded training data folder location on the spec file
* <span style="color:red;font-weight:700;font-size:12px">tf records training data folder path:</span> The AzureML location of the TF records data required to evaluate the model.
* <span style="color:red;font-weight:700;font-size:12px">tf records training data folder reference:</span> The hard coded TF records training data folder location on the spec file

### Optional Arguments to be used for spec file substitution
* <span style="color:red;font-weight:700;font-size:12px">validation data folder path:</span> The AzureML location of the validation data to be used to evaluate the model.
* <span style="color:red;font-weight:700;font-size:12px">validation data folder reference:</span> The hard coded validation data folder location on the spec file
* <span style="color:red;font-weight:700;font-size:12px">tf records validation data folder path:</span> The AzureML location of the TF records validation data required to evaluate the model.
* <span style="color:red;font-weight:700;font-size:12px">tf records validation data folder reference:</span> The hard coded TF records validation data folder location on the spec file

### Optional Arguments
* <span style="color:red;font-weight:700;font-size:12px">-h, --help:</span> Show this help message and exit.
* <span style="color:red;font-weight:700;font-size:12px">-f, --framework:</span> The framework to use when running evaluation (choices: “tlt”, “tensorrt”). By default the framework is set to TensorRT.
* <span style="color:red;font-weight:700;font-size:12px">--use_training_set:</span> Set this flag to run evaluation on the training dataset.
* <span style="color:red;font-weight:700;font-size:12px">--gpu_index:</span> The index of the GPU to run evaluation on.

You can use the following arguments:

* <span style="color:red;font-weight:700;font-size:12px"> -d, --dataset-export-spec:</span> The path to the detection dataset spec containing the config for exporting `.tfrecord` files

* <span style="color:red;font-weight:700;font-size:12px"> -o output_filename:</span> The output filename. Note that this will be appended with `-fold-<num>-of-<total>`

* <span style="color:red;font-weight:700;font-size:12px"> --generate_masks</span> Optional: Generate and save masks of regions with unlabeled people. This is used for training.

The required spec file contains many other arguments, so please refer to the [configuration file documentation](https://docs.nvidia.com/tao/tao-toolkit/text/bodypose_estimation/bodyposenet.html#dataset-preparation) to learn more about them. Some of the parameters in the spec file refer to the specific location of data folders, which have hard coded values. However, in the case of an AzureML Job Run, the root directories are unknown in advance. Folder locations are assigned dynamically during execution. Therefore, the Component requires to know both the dynamic location during run time and the hard coded location on the spec file to do the substitution on the fly before executing the TAO bpnet dataset conversion. The Component first updates the paths within spec files and then passes that updated spec file to the TAO command during execution.

### Required Arguments to be used for spec file substitution
* <span style="color:red;font-weight:700;font-size:12px">dataset full path:</span> The AzureML location of the dataset to be converted.
* <span style="color:red;font-weight:700;font-size:12px">dataset reference:</span> The hard coded dataset location on the spec file.

### Sample Usage of the Dataset Converter Tool
The <span style="color:red;font-weight:700;font-size:12px"> dataset_convert </span> tool is described below:

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">
tao bpnet dataset_convert -d <path/to/dataset_spec>
                          -o <path_to_output_tfrecords>
                          -m <'train'/'test'>
                          --generate_masks
</pre>

### Components Inputs and Outputs
* inputs:
    * specs_dir
    * data_dir
    * dataset_export_spec
    * output_filename
    * specfile_reference_data_dir:
    * validation_fold
* outputs:
    * tf_records_dir

### Components Inputs and Outputs Mapping to TAO Command Parameters

* <span style="color:red;font-weight:700;font-size:12px"> -d, --dataset-export-spec:</span> ${specs_dir}/${dataset_export_spec}
* <span style="color:red;font-weight:700;font-size:12px"> -o output_filename:</span> ${tf_records_dir}/data/${output_filename}
* <span style="color:red;font-weight:700;font-size:12px"> -f, –validation-fold:</span> ${validation_fold}
* <span style="color:red;font-weight:700;font-size:12px">dataset full path:</span> ${data_dir}/data
* <span style="color:red;font-weight:700;font-size:12px">dataset reference:</span> ${specfile_reference_data_dir}