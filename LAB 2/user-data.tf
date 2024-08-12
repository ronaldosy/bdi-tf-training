data "template_file" "php-install" {
  template = file("${path.module}/templates/install-php.sh")
}