provider "local" {}

resource "local_file" "example_file" {
  content  = "This is an example file created by Terraform."
  filename = "${path.module}/example.txt"
}

data "archive_file" "example_zip" {
  type        = "zip"
  source_file = local_file.example_file.filename
  output_path = "${path.module}/example.zip"
}

output "zip_file_path" {
  value = data.archive_file.example_zip.output_path
}