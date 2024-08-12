output  "ebs_id"{
    value = aws_instance.test_instances.root_block_device[*].volume_id

    precondition {
      condition = data.aws_ebs_volume.test_instance_root_volume.encrypted
      error_message = "The server's root volume not encrupted"
    }
}