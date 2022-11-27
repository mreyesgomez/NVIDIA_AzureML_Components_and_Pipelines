## [Training the Model](https://docs.nvidia.com/tao/tao-toolkit/text/object_detection/detectnet_v2.html#training-the-model)
#### This component is a wrapper for the TAO DetectNet_v2 train command

After creating TFRecords ingestible by the TAO training (as outlined in [Preprocessing the Dataset](https://docs.nvidia.com/tao/tao-toolkit/text/object_detection/detectnet_v2.html#conversion-to-tfrecords-detectnet-v2)) and setting up a [spec file](https://docs.nvidia.com/tao/tao-toolkit/text/object_detection/detectnet_v2.html#creating-a-configuration-file-detectnet-v2), you are now ready to start training an object detection network.

The following outlines the DetectNet_v2 training command:

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">tao detectnet_v2 train [-h] -k <key>
                            -r < result directory>
                            -e < spec_file>
                            [-n < name_string_for_the_model>]
                            [--gpus < num GPUs>]
                            [--gpu_index < comma separate gpu indices>]
                            [--use_amp]
                            [--log_file < log_file>]
</pre>

### Required Arguments
* <span style="color:red;font-weight:700;font-size:12px">-r, --results_dir:</span> The path to a folder where experiment outputs should be written.
* <span style="color:red;font-weight:700;font-size:12px">-k, –key:</span> A user-specific encoding key to save or load a .tlt model.
* <span style="color:red;font-weight:700;font-size:12px">-e, --experiment_spec_file:</span> The path to the spec file. The path may be absolute or relative to the working directory. By default, the spec from spec_loader.py is used.

### Optional Arguments
* <span style="color:red;font-weight:700;font-size:12px">-n, --model_name:</span> The name of the final step model saved. If not provided, defaults to the model.
* <span style="color:red;font-weight:700;font-size:12px">--gpus:</span> The number of GPUs to use and processes to launch for training. The default value is 1.
* <span style="color:red;font-weight:700;font-size:12px">--gpu_index:</span> The indices of the GPUs to use for training. The GPUs are referenced as per the indices mentioned in the ./deviceQuery CUDA samples.
* <span style="color:red;font-weight:700;font-size:12px">--use_amp:</span>  When defined, this flag enables Automatic Mixed Precision mode.
* <span style="color:red;font-weight:700;font-size:12px">--log_file:</span>  The path to the log file. Defaults to stdout.
* <span style="color:red;font-weight:700;font-size:12px">-h, --help:</span>  Show this help message and exit.

### Input Requirement
* Input size: C * W * H (where C = 1 or 3, W > =480, H >=272 and W, H are multiples of 16)
* Image format: JPG, JPEG, PNG
* Label format: KITTI detection

### Sample Usage
Here is an example of a command for training with two GPUs:

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">tao detectnet_v2 train -e < path_to_spec_file>
                       -r < path_to_experiment_output>
                       -k < key_to_load_the_model>
                       -n < name_string_for_the_model>
                       --gpus 2
</pre>