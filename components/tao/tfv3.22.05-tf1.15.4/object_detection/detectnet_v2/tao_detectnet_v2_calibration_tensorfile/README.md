## [Generating an INT8 tensorfile Using the calibration_tensorfile Command](https://docs.nvidia.com/tao/tao-toolkit/text/object_detection/detectnet_v2.html#generating-an-int8-tensorfile-using-the-calibration-tensorfile-command)
## This component is a wrapper for the TAO DetectNet_v2 calibration_tensorfile command

The INT8 tensorfile is a binary file that contains the preprocessed training samples, which may be used to calibrate the model. In this release, TAO Toolkit only supports calibration tensorfile generation for SSD, DSSD, DetectNet_v2, and classification models.

The sample usage for the <span style="color:red;font-weight:700;font-size:12px">calibration_tensorfile</span> command to generate a calibration tensorfile is defined below:

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">tao detectnet_v2 calibration_tensorfile [-h] -e < path to training experiment spec file>
                                             -o < path to output tensorfile>
                                             -m < maximum number of batches to serialize>
                                            [--use_validation_set]
</pre>

#### Required Arguments
* <span style="color:red;font-weight:700;font-size:12px">-e, --experiment_spec_file</span>: The path to the experiment spec file (only required for SSD and FasterRCNN).

* <span style="color:red;font-weight:700;font-size:12px">-o, --output_path</span>: The path to the output tensorfile that will be created.

* <span style="color:red;font-weight:700;font-size:12px">-m, --max_batches</span>: The number of batches of input data to be serialized.

#### Optional Argument
* <span style="color:red;font-weight:700;font-size:12px">--use_validation_set</span>: A flag specifying whether to use the validation dataset instead of the training set.

The following is a sample command to invoke the calibration_tensorfile command for a classification model:

<pre style="background-color:rgba(0, 0, 0, 0.0470588)"><font size="2">tao detectnet_v2 calibration_tensorfile
                  -e $SPECS_DIR/classification_retrain_spec.cfg
                  -m 10
                  -o $USER_EXPERIMENT_DIR/export/calibration.tensor
</pre>
