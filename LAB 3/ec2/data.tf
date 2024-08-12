data "aws_ebs_volume" "test_instance_root_volume"{
    most_recent = true

    filter {
        name = "volume-id"
        values = aws_instance.test_instances.root_block_device[*].volume_id
    }
}