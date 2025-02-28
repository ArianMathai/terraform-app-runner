resource "random_string" "suffix" {
  length  = 8
  special = false
}

resource "aws_apprunner_service" "service" {
  service_name = "${var.prefix}-${random_string.suffix.result}"
  source_configuration {

    authentication_configuration {
      access_role_arn = "arn:aws:iam::244530008913:role/service-role/AppRunnerECRAccessRole"
    }

    image_repository {
      image_configuration {
        port = "8080"
      }
      image_identifier      = var.image
      image_repository_type = "ECR"
    }
    auto_deployments_enabled = true
  }
}
